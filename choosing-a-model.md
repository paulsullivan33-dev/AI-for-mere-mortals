# Choosing a Model

There are thousands of models. Start with what fits your computer, then
compare candidates on the work you actually want done.

## Step 1: Know which memory you have

**System RAM** is the computer's working memory. **VRAM** is dedicated
memory on a graphics card. CPU inference uses system RAM; GPU inference
needs enough compatible GPU memory for the work assigned to it.
A PC with 32 GB RAM and an 8 GB graphics card does not have 40 GB of
interchangeable fast GPU memory. Some runtimes can split the work, with
a performance cost.

On Apple silicon and some integrated graphics systems, CPU and GPU
share memory. That pool also serves the operating system and other apps.

### Estimate weights first, then runtime memory

For raw 4-bit weights, **billions of parameters ÷ 2 ≈ decimal GB**.
An 8B model is about 4 GB by that arithmetic. Actual Q4 files are larger
because of quantization metadata and tensors stored at other precisions.
Use the download size for the exact model tag as a better starting point.

The file is only part of the budget. Allow additional memory for the
runtime, temporary buffers, and the **KV cache** used for context.
Your operating system, browser, and front end also need room.
There is no universal “plus 2 GB” that covers every setup.

### Starting points for a computer without dedicated GPU memory

These are conservative suggestions for **total installed system RAM**,
one dense Q4 model, one chat at a time, and a modest context such as 4K.
They are estimates, not measurements or guarantees.

| Installed RAM | Start with | What to watch |
| --- | --- | --- |
| 8 GB | 1–3B Q4 | Leave several GB for the OS and apps. A 7–8B model may cause memory pressure. |
| 16 GB | 7–8B Q4 | Often a useful starting point. Check available memory before increasing context or trying 13–14B. |
| 32 GB | 13–14B Q4; consider 7–8B for speed | A 32B Q4 model may fit with modest context, but check its actual size and runtime use first. |

For a dedicated GPU, budget against **available VRAM**, not the RAM table.
For example, an 8 GB card may fit an 8B Q4 model with modest context, while
a long context or another GPU app can push it over the limit.
Check compatibility before buying hardware.

### Mixture-of-experts models: read both numbers

A model marked “30B total, 3B active” uses only part of its network per
token, reducing computation. Ordinary local inference still needs the
full set of weights available. Size its weight budget from **30B total**,
not 3B active. Specialized offloading can change where weights live, at
a cost in transfers and speed. See [Running Models at Home](running-models-at-home.md).

## Step 2: Match the model to the job

- **Chat and Q&A:** an instruct model in the 3–8B range is a reasonable
  first experiment. Check its answers against known facts.
- **Coding:** compare a code-focused model with a general instruct model
  on your own language and tasks.
- **Reasoning and math:** reasoning models can help, but extra thinking
  costs time and doesn't guarantee correct reasoning.
- **Quick replies or voice:** try smaller models first, then measure.
- **RAG over documents:** start with a model that fits comfortably.
  Test retrieval and answer quality separately; a larger model cannot
  reliably recover facts missing from the retrieved passages.

## Step 3: Try two and compare

Ask both candidates the same factual, creative, and document-based
questions. For factual work, use questions whose answers you can check.
For documents, include one question the source cannot answer and see
whether the model admits that. Judge accuracy, useful wording, and speed.

## Speed: measure your own setup

Parameter count alone cannot predict tokens per second. CPU memory
bandwidth, GPU compatibility, quantization, context length, and
offloading all matter. Separate the wait for the first token from the
speed of writing the reply; try the same prompt twice to see the effect
of loading the model.

A compatible GPU can help substantially when the workload fits in VRAM.
There is no dependable universal “5–10x” multiplier. CPU inference may
be sufficient for your needs; try it before buying a graphics card.

## The “good enough” principle

Start with a model that fits comfortably and answers at a tolerable
speed. Increase size when you can name a task it fails, and compare
again. Newer training, specialization, and retrieval quality can matter
as much as parameter count.

## Sources and verification

Reviewed October 10, 2026. Memory examples are planning estimates, not
benchmarks; no hardware measurements were performed for this guide.

- [Ollama: CPU/GPU placement and concurrency](https://docs.ollama.com/faq)
- [Ollama: context length](https://docs.ollama.com/context-length)
- [Hugging Face: cache memory strategies](https://huggingface.co/docs/transformers/main/en/kv_cache)
- [Hugging Face: MoE compute and memory](https://huggingface.co/blog/moe)
