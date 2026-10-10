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

## RAM, VRAM, and context: three separate budgets

The model download needs **disk space**. Running it needs **working
memory**. CPU inference uses system RAM; a dedicated GPU uses its own
VRAM. Unified-memory systems share a pool with the OS and apps.
See the [8, 16, and 32 GB examples](choosing-a-model.md#starting-points-for-a-computer-without-dedicated-gpu-memory).

Budget for **weights + KV cache + runtime buffers**, with room for the
operating system and other programs. A model file that barely fits in
your free memory may fail once a conversation starts.

The **KV cache** saves attention information for the tokens being used.
For conventional full-attention models, its memory grows roughly with
context length and concurrent requests. The actual amount depends on
the architecture, cache precision, and runtime; sliding-window models
can behave differently. Weight quantization and cache quantization are
separate settings. A Q4 download does not mean its cache is also Q4.

Increasing context from 4K to 32K can greatly increase cache memory.
It does not multiply the model's weight memory by eight. A model's
advertised maximum context is a capability limit, not a recommended
setting for every computer. Start modestly and measure before enlarging it.

Ollama can use compatible GPUs and can split a model between CPU and
GPU. Partial offloading may help, but speed depends on the split and
transfer overhead; it is not guaranteed to beat every CPU-only setup.
GPU compatibility, memory bandwidth, and available VRAM all matter.

After a reply, run:

```powershell
ollama ps
```

The **PROCESSOR** column reports CPU, GPU, or a split. Compare system
memory and dedicated GPU memory in your OS monitor as you increase
context. Disk paging is different from intentional CPU offloading:
paging under memory pressure can make replies painfully slow.

**MoE models:** budget weights using total parameters, even when only
a smaller number is active per token. Active count describes computation,
not a shortcut to fitting all weights into that amount of RAM.

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
for an hour so the next question avoids reloading the weights. Costs RAM while
idle — worth it on a dedicated box, less so on a laptop.

**Temperature.** As in [How LLMs Work](how-llms-work.md): lower values reduce sampling variation; higher values allow more
variation. Try 0.2 for consistent summaries, but check the source:
a low-temperature answer can still be confidently false.

## Thinking models

Some models (qwen3, deepseek-r1) "think" — they generate internal
reasoning before answering. Great for hard problems, slow for simple
ones, and the thinking burns tokens you'd rather spend on the answer.
For everyday Q&A, turn thinking off if your tool allows it. (In
Ollama's API, that's `"think": false`.)

## Multiple models at once

Ollama can keep several models loaded, sharing available RAM and VRAM.
Each needs weight memory, and concurrent requests need additional cache
and buffers. Separate embedding models and the front end also add usage. With a 1-hour
keep-alive it's easy to end up with a crowd squatting in RAM —
`ollama ps` shows what's loaded, and `ollama stop <model>` evicts one.

## When it's slow, check this order

1. **Prompt length** — thousands of tokens of context? That can delay the first token. (See [Tokens](tokens.md).)
2. **Thinking on** — disable it for simple questions.
3. **Model too big** — check disk paging and CPU/GPU placement.
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

Hardware guidance also uses [Ollama's FAQ](https://docs.ollama.com/faq),
[context guidance](https://docs.ollama.com/context-length), and
[cache documentation](https://huggingface.co/docs/transformers/main/en/kv_cache).
Memory estimates have not been benchmarked on specific hardware.

For one measured small-model example, see the [Windows validation
report](windows-validation.md). It records Gemma 3 1B CPU inference at
three context settings; the broader hardware estimates remain unverified.
