# Your first local model on Windows

Go from a fresh Ollama installation to a working answer, using Windows
PowerShell. No Docker or graphics card is needed for this first run.

## Before you start

Use Windows 10 22H2 or newer (including Windows 11). Have internet access
for installation and the model download, several gigabytes of free disk
space beyond the installer, and available RAM. Start with the small
`llama3.2:1b` model; it is a learning example, not a promise of accuracy.
Close memory-heavy apps if your computer is short on RAM.

## 1. Install Ollama

Download the Windows installer from [ollama.com/download/windows](https://ollama.com/download/windows)
and run it. Launch Ollama from the Start menu if it isn't already running.

Open a **new PowerShell window** after installation. Paste:

```powershell
ollama --version
```

**Check:** you should see a version number. Record it if you need help.
If Windows says the command isn't recognized, close PowerShell, open it
again, and retry. If that fails, check that installation completed.

## 2. Download a small model

```powershell
ollama pull llama3.2:1b
ollama list
```

The first command downloads the model; wait for it to finish.
**Check:** the list should contain `llama3.2:1b`. A download error usually
means you should check your connection, available disk space, and the
exact model name before retrying.

## 3. Get your first answer

```powershell
ollama run llama3.2:1b
```

At the chat prompt, type:

```text
Explain what a language model is in two short sentences.
```

**Check:** readable text should appear. The wording varies; there isn't
one exact correct output. The first reply can take longer while the model
loads. Ask a follow-up, then type `/bye` to return to PowerShell.

## 4. Check the local API

This confirms that other programs can use the same local model. Paste
this whole block into PowerShell:

```powershell
$firstChatBody = @{
  model = 'llama3.2:1b'
  messages = @(@{ role = 'user'; content = 'Reply with a short greeting.' })
  stream = $false
  options = @{ num_predict = 64 }
} | ConvertTo-Json -Depth 5
$firstChatReply = Invoke-RestMethod -Uri 'http://localhost:11434/api/chat' -Method Post -ContentType 'application/json' -Body $firstChatBody
$firstChatReply.message.content
$firstChatReply.done
```

**Check:** a greeting and `True` should print. This uses PowerShell's
HTTP command, avoiding the `curl` alias and shell quoting differences.

If the connection is refused, open Ollama from the Start menu and retry.
If it says the model wasn't found, repeat step 2. If you see an
out-of-memory error, close other apps and retry; fitting a model on disk
doesn't guarantee it fits in available memory.

## 5. See what is loaded, then free the memory

```powershell
ollama ps
ollama stop llama3.2:1b
ollama ps
```

**Check:** immediately after a reply, the first list normally shows the
loaded model. After `stop`, it should disappear. If enough time has
passed, Ollama may already have unloaded it automatically.
The download stays on disk, ready for your next `ollama run`.

## What to try next

- [Choosing a Model](choosing-a-model.md): select a more capable model
  once you know this setup works.
- [Ollama, In Depth](ollama-guide.md): settings, API calls, and embeddings.
- [Open WebUI](open-webui-guide.md): add a browser chat interface later.

For this walkthrough, inference uses a downloaded local model through
`localhost`. Downloads require internet access. Cloud models, web search,
and external services have different data flows; review those separately
before sending private documents.

## Verification status and sources

Reviewed against official documentation and CLI source on October 10,
2026. **Not executed on Windows as part of this review.** The checks above
let you verify each step on your own machine; they are expected results,
not recorded test results. No tested Ollama version is claimed.

- [Windows requirements and installation](https://docs.ollama.com/windows)
- [CLI reference](https://docs.ollama.com/cli)
- [Chat API request and response](https://docs.ollama.com/api/chat)
- [Llama 3.2 model library](https://ollama.com/library/llama3.2)
