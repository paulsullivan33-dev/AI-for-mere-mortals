param(
    [string]$Model = 'llama3.2:1b',
    [string]$OutputPath = 'windows-validation.json'
)

# Run in PowerShell on the Ollama machine. Downloads the selected model if needed.
# Stops only the selected model after testing; leaves its download on disk.
$ErrorActionPreference = 'Stop'
function Invoke-OllamaCli {
    param([string[]]$CliArgs)
    # Windows PowerShell treats native progress on stderr as error records.
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    $result = & ollama @CliArgs 2>&1
    $exitCode = $LASTEXITCODE
    $ErrorActionPreference = $previousPreference
    if ($exitCode -ne 0) { throw ($result -join "`n") }
    return ($result -join "`n")
}
function Get-MemorySnapshot {
    $os = Get-CimInstance Win32_OperatingSystem
    $runners = @(Get-Process -Name ollama,llama-server -ErrorAction SilentlyContinue)
    [ordered]@{
        available_system_bytes = [long]$os.FreePhysicalMemory * 1KB
        ollama_working_set_bytes = ($runners | Measure-Object WorkingSet64 -Sum).Sum
        ollama_private_bytes = ($runners | Measure-Object PrivateMemorySize64 -Sum).Sum
    }
}
function Stop-TestModel {
    $null = Invoke-OllamaCli -CliArgs @('stop', $Model)
    $deadline = (Get-Date).AddSeconds(15)
    do {
        $loaded = (Invoke-RestMethod 'http://localhost:11434/api/ps').models
        if (@($loaded | Where-Object name -EQ $Model).Count -eq 0) { return }
        Start-Sleep -Milliseconds 250
    } while ((Get-Date) -lt $deadline)
    throw 'Selected model remained loaded 15 seconds after stop.'
}

$osInfo = Get-CimInstance Win32_OperatingSystem
$report = [ordered]@{
    recorded_at = (Get-Date).ToString('o')
    powershell = $PSVersionTable.PSVersion.ToString()
    os = $osInfo.Caption
    os_version = $osInfo.Version
    usable_system_ram_bytes = [long]$osInfo.TotalVisibleMemorySize * 1KB
    cpu = @(Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name)
    gpu = @(Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name)
    ollama_client = Invoke-OllamaCli -CliArgs @('--version')
    ollama_server = (Invoke-RestMethod 'http://localhost:11434/api/version').version
    model = $Model
    samples = @()
}
try {
    $installed = (Invoke-RestMethod 'http://localhost:11434/api/tags').models | Where-Object name -EQ $Model
    $report.download_attempted = -not [bool]$installed
    if (-not $installed) { $null = Invoke-OllamaCli -CliArgs @('pull', $Model) }
    $modelList = Invoke-OllamaCli -CliArgs @('list')
    if ($modelList -notmatch [regex]::Escape($Model)) { throw 'Model missing from CLI list.' }
    $tag = (Invoke-RestMethod 'http://localhost:11434/api/tags').models | Where-Object name -EQ $Model
    if (-not $tag) { throw 'Selected model missing after pull.' }
    # Store only the tested model's metadata, not the user's entire model inventory.
    $report.model_metadata = $tag
    $report.cli_answer = Invoke-OllamaCli -CliArgs @('run', $Model, 'Explain what a language model is in two short sentences.')
    if ([string]::IsNullOrWhiteSpace($report.cli_answer)) { throw 'CLI returned no text.' }
    Stop-TestModel
    $report.baseline = Get-MemorySnapshot
    foreach ($context in @(4096, 8192, 32768)) {
        foreach ($run in @(1, 2)) {
            $body = @{
                model = $Model
                messages = @(@{ role = 'user'; content = 'Reply with a short greeting.' })
                stream = $false
                options = @{ num_predict = 64; num_ctx = $context; temperature = 0.2 }
            } | ConvertTo-Json -Depth 5
            $timer = [Diagnostics.Stopwatch]::StartNew()
            $reply = Invoke-RestMethod -Uri 'http://localhost:11434/api/chat' -Method Post -ContentType 'application/json' -Body $body -TimeoutSec 300
            $timer.Stop()
            if (-not $reply.done -or [string]::IsNullOrWhiteSpace($reply.message.content)) { throw 'API returned incomplete or empty answer.' }
            $report.samples += [ordered]@{
                requested_context = $context
                run = $run
                answer = $reply.message.content
                done = $reply.done
                elapsed_ms = $timer.ElapsedMilliseconds
                load_duration_ns = $reply.load_duration
                prompt_eval_count = $reply.prompt_eval_count
                eval_count = $reply.eval_count
                eval_duration_ns = $reply.eval_duration
                memory = Get-MemorySnapshot
                loaded_models = Invoke-OllamaCli -CliArgs @('ps')
            }
        }
        Stop-TestModel
    }
    $loaded = (Invoke-RestMethod 'http://localhost:11434/api/ps').models
    if (@($loaded | Where-Object name -EQ $Model).Count -ne 0) { throw 'Selected model remained loaded after stop.' }
    $report.unload_passed = $true
    $report.status = 'passed'
} catch {
    $report.status = 'failed'
    $report.error = $_.Exception.Message
    throw
} finally {
    try { $null = Invoke-OllamaCli -CliArgs @('stop', $Model) } catch { }
    $report | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $OutputPath -Encoding UTF8
}
