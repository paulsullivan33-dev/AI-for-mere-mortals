# Running Models at Home

You picked a model. Now let's run it. On Windows, start with the
[step-by-step first-run guide](windows-first-run.md). [Ollama](https://ollama.com) is
the easiest path — one program, works on Windows/Mac/Linux, handles
downloading and running. Most of this guide assumes Ollama, but the
ideas apply everywhere.

## The 30-second start

```
ollama pull qwen3:8b     # download a model
ollama run qwen3:8b      # talk to it
```

That's it. Ollama keeps a server running in the background; `ollama
run` opens a chat, and other programs can talk to the server too.

## RAM: where the model lives

A running model lives in memory — GPU memory (VRAM) if you have a
compatible GPU, regular RAM otherwise. Ollama handles this
automatically: it uses the GPU when it can, CPU when it must.

- **GPU (VRAM):** much faster, often 5–10x. Even an older gaming GPU
  with 8GB+ VRAM transforms the experience.
- **CPU (RAM):** works fine, just slower. A 7–8B model on a modern
  CPU is perfectly usable for chat.

If the model doesn't fit in VRAM, Ollama splits it: some layers on
GPU, the rest on CPU. Partial GPU is still faster than pure CPU.

## Settings that matter

**Context length (`num_ctx`).** How many tokens the model sees at
once. The default depends on your model and setup. Bigger = handles longer documents but
uses more RAM and runs slower. Set it per task:

```
ollama run qwen3:8b
```

Then type this **inside the chat**, not at the PowerShell prompt:

```text
/set parameter num_ctx 8192
```

For scripts, use `options: { "num_ctx": 8192 }` in the API request;
for saved defaults, use a Modelfile.

**Keep-alive.** How long Ollama keeps a model loaded after you stop
using it. Default is 5 minutes; `OLLAMA_KEEP_ALIVE=1h` keeps it warm
for an hour so the next question starts instantly. Costs RAM while
idle — worth it on a dedicated box, less so on a laptop.

**Temperature.** As in [How LLMs Work](how-llms-work.md): low for
facts, high for creativity. Ollama default ~0.8; try 0.2 for RAG and
summarization.

## Thinking models

Some models (qwen3, deepseek-r1) "think" — they generate internal
reasoning before answering. Great for hard problems, slow for simple
ones, and the thinking burns tokens you'd rather spend on the answer.
For everyday Q&A, turn thinking off if your tool allows it. (In
Ollama's API, that's `"think": false`.)

## Multiple models at once

Ollama can keep several models loaded, but they share your RAM. Three
models loaded = three models' worth of memory. With a 1-hour
keep-alive it's easy to end up with a crowd squatting in RAM —
`ollama ps` shows what's loaded, and `ollama stop <model>` evicts one.

## When it's slow, check this order

1. **Prompt length** — thousands of tokens of context? That's the
   usual culprit. (See [Tokens](tokens.md).)
2. **Thinking on** — disable it for simple questions.
3. **Model too big** — swapped to disk/RAM? Check memory pressure.
4. **CPU contention** — something else hogging the machine?
5. **Context window** — oversized `num_ctx` wastes RAM and time.

## The home-lab mindset

Start small and local: one model, CPU is fine, learn what "fast
enough" feels like. Add a GPU when you know which models you actually
use. The best home AI setup is the one that's running when you want
it — not the biggest one you could theoretically build.

## Sources and verification

Examples checked against official documentation and Ollama CLI source on
October 10, 2026. They have not been executed on a Windows machine as
part of this review. Record your version with `ollama --version` when
reporting a problem; model behavior and defaults can change.

- [Ollama CLI](https://docs.ollama.com/cli)
- [CLI source and interactive commands](https://github.com/ollama/ollama/blob/main/cmd/interactive.go)
- [Modelfile parameters](https://docs.ollama.com/modelfile)
- [Chat API](https://docs.ollama.com/api/chat)
- [Embedding API](https://docs.ollama.com/api/embed)
