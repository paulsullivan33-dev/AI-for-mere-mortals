# Reading a Hugging Face Model Page

[Hugging Face](https://huggingface.co) is like GitHub, but for AI
models. A model page looks intimidating — here's what the labels mean.

## The name: "llama-3.1-8B-Instruct"

Read it in pieces:

- **llama-3.1** — the model family and version. Like software versions:
  newer is usually better.
- **8B** — **8 billion parameters**. Parameters are the adjustable
  numbers inside the model (see [How LLMs Work](how-llms-work.md)).
  Larger dense models generally need more weight memory and computation;
  quality also depends on training and task. For MoE models, distinguish
  total parameters (weight budget) from active parameters (work per token). Common sizes:
  1B, 3B, 7B/8B, 13B/14B, 32B, 70B.
- **Instruct** — tuned to follow instructions and chat. This is what
  you want for asking questions. A *base* model (no "instruct") just
  continues text and is awkward to talk to — skip those unless you
  know why you want one.

## Quantization: "Q4_K_M"

Many original releases use 16-bit weights, though precision varies. A
**quantized** model squeezes each parameter into fewer bits: smaller
file and lower weight-memory use, with a possible quality tradeoff.

- **Q8_0** — roughly half the raw weight size of a 16-bit version,
  plus format overhead. Often preserves quality well.
- **Q6_K / Q5_K_M** — good middle ground.
- **Q4_K_M** — a common compromise for local use. Raw 4-bit weights
  are one quarter the size of 16-bit weights; actual files include
  overhead and mixed precisions. Test quality on your tasks.
- **Q3 / Q2** — tiny, but noticeably dumber. Only if you're desperate
  for RAM.

The letters after the number are the exact recipe; don't sweat them.
For the same base model, higher precision generally uses more memory
and reduces quantization error; it doesn't guarantee better answers.

## GGUF

The file format for running models on your own computer (`.gguf`
files). Ollama and llama.cpp support many GGUF models, but the model's
architecture and quantization must be supported by your runtime version.
Other formats, including safetensors, can also be used locally with
compatible software; GGUF is a common choice for this guide's workflow.

A file named `qwen3-8b-q4_k_m.gguf` is: the qwen3 8B model, quantized
to Q4_K_M. Confirm runtime compatibility and available memory before
downloading.

## Context length: "128K"

How many [tokens](tokens.md) the model can consider at once. 4K is
small, 32K is comfortable, 128K is generous. Bigger context needs more
RAM or VRAM *at runtime* — a 70B model with 128K context can need far more
memory than the model file alone suggests.

## License

Who's allowed to use it for what. Common ones:

- **Apache 2.0 / MIT** — do anything, including commercial use.
- **Llama license, Gemma license** — free to use with some conditions
  (usually fine for personal/home use, read the terms for business).
- **Research-only / non-commercial** — personal experiments okay,
  selling things built on it is not.

For home use, almost everything is fine. It matters when money is
involved.

## Popularity signals

- **Downloads** — how many people grabbed it. High = battle-tested.
- **Likes** — community approval.
- A model with 500K downloads and an active discussion tab is a safer
  bet than a 3-day-old upload with 12 downloads, even if the specs
  look better on paper.

## The 30-second evaluation

1. Fits my available RAM/VRAM, including context and runtime overhead? (see [Choosing a Model](choosing-a-model.md))
2. Instruct version?
3. GGUF available, Q4 or Q5?
4. Context length big enough for my use?
5. Lots of downloads?

Five yeses: download it and try it.
