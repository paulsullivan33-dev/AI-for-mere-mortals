# Windows validation: October 10, 2026

Local CLI and API inference passed on the machine below using **Gemma 3 1B**.
This is a partial validation of the Windows workflow, not a completed test
of the walkthrough's `llama3.2:1b` model or a fresh installation.

## Tested environment

- Windows 11 Home, build 10.0.26300.
- Windows PowerShell **5.1.26100.9444**.
- Ollama client and server **0.40.2**. The installed client initially
  reported 0.35.1; an automatic update interrupted the first attempt.
- Intel Core Ultra 9 288V; approximately 31.6 GiB usable system RAM.
- Intel Arc 140V integrated GPU present; Ollama reported **100% CPU**
  placement for these tests. This is not a GPU benchmark.
- `gemma3:1b`, Q4_K_M, 815,319,323 bytes on disk, model digest
  `83be9dbf9dd6ea077de84d4fbaeb094dae9f266ca1b302f04e1c803bea566a79`.

## What passed

- Version query and installed-model listing.
- `ollama run gemma3:1b` with the walkthrough's two-sentence prompt,
  supplied as a command argument; readable output appeared.
- PowerShell `Invoke-RestMethod` chat requests returned nonempty greetings
  and `done: true` in all six measured requests.
- `ollama ps` reported the requested context and CPU placement.
- `ollama stop gemma3:1b` unloaded the model. Unloading is asynchronous:
  an immediate check initially failed, but a subsequent check was empty.
  The repeatable script waits up to 15 seconds and passed.
- The Ollama guide's `/api/embed` request with the already installed
  `nomic-embed-text` returned a vector of **768 elements**. This separate
  smoke check is not included in the chat measurement JSON.

## Measurements

The prompt was “Reply with a short greeting.” Each context setting had
one request after unloading, followed by a second request while loaded.
Requests used `num_predict: 64` and `temperature: 0.2`.

| Requested context | Ollama reported loaded size | Combined process working set, second request | First request | Second request |
| --- | --- | --- | --- | --- |
| 4,096 | 880 MB | 907.5 MiB | 1,517 ms | 125 ms |
| 8,192 | 958 MB | 934.8 MiB | 1,546 ms | 104 ms |
| 32,768 | 1.0 GB | 1,032.4 MiB | 1,568 ms | 271 ms |

The working set sums `ollama` and `llama-server` processes, including
the service and inference worker. It is an after-response snapshot, not
peak allocation or dedicated VRAM. Ollama's loaded-size estimate and OS
working set measure different things and use different units.
The baseline combined working set after unloading was about 39.8 MiB.

These short prompts do **not** fill the context window. They test context
configuration and short-answer operation, not long-document accuracy,
full-context memory requirements, or sustained throughput. Responses
contained 3–11 generated tokens; timing differences also reflect varying
output lengths. Two requests per setting are insufficient for a general
performance claim. Other apps were running.

## What remains unverified

- Fresh installation, PATH changes, interactive follow-ups and `/bye`.
- Download and execution of `llama3.2:1b`: its download stalled and was
  interrupted. The existing Gemma model was used instead.
- The walkthrough's exact API block with Llama, and the larger Llama/Qwen
  chat and thinking examples in the in-depth guide.
- Open WebUI installation: Docker client 29.8.2 was installed, but its
  desktop engine was unavailable. No container installation was attempted.
- Hardware recommendations for 8/16 GB machines, larger models, GPU
  offloading, full-context workloads, concurrency, or offline isolation.

## Reproduce

From the repository directory in Windows PowerShell:

```powershell
.\scripts\validate-windows.ps1 -Model gemma3:1b -OutputPath gemma3-validation.json
```

Omit `-Model` to test `llama3.2:1b`. The script downloads the selected model
only if absent, runs local inference, and stops that model afterward.
Avoid running it against a model someone else is currently using.
Existing downloads remain on disk. Inspect results before sharing: the
report includes machine specifications and model output.

[Recorded chat measurements](validation/windows-gemma3-2026-10-10.json)
include the version, exact model metadata, API results, durations,
placement, and memory snapshots. No general claim of AI accuracy follows
from these checks.
