# Reading a Hugging Face Model Page

[Hugging Face](https://huggingface.co) is like GitHub, but for AI
models. A model page looks intimidating — here's what the labels mean.

## The name: "llama-3.1-8B-Instruct"

Read it in pieces:

- **llama-3.1** — the model family and version. Like software versions:
  newer is usually better.
- **8B** — **8 billion parameters**. Parameters are the adjustable
  numbers inside the model (see [How LLMs Work](how-llms-work.md)).
  Bigger = more capable, but also more RAM and slower. Common sizes:
  1B, 3B, 7B/8B, 13B/14B, 32B, 70B.
- **Instruct** — tuned to follow instructions and chat. This is what
  you want for asking questions. A *base* model (no "instruct") just
  continues text and is awkward to talk to — skip those unless you
  know why you want one.

## Quantization: "Q4_K_M"

The original model uses 16 bits per parameter — precise but huge. A
**quantized** model squeezes each parameter into fewer bits: smaller
file, less RAM, slightly less smart.

- **Q8_0** — barely smaller than original, barely dumber. The safe
  choice if you have RAM to spare.
- **Q6_K / Q5_K_M** — good middle ground.
- **Q4_K_M** — the sweet spot for most people: roughly 4x smaller
  than original, and you'd struggle to notice the difference in
  normal use.
- **Q3 / Q2** — tiny, but noticeably dumber. Only if you're desperate
  for RAM.

The letters after the number are the exact recipe; don't sweat them.
Just remember: **bigger number = bigger file = slightly smarter**.

## GGUF

The file format for running models on your own computer (`.gguf`
files). If you see GGUF, it works with Ollama, llama.cpp, and friends.
Other formats (safetensors, PyTorch) are for training and servers —
ignore them for home use.

A file named `qwen3-8b-q4_k_m.gguf` is: the qwen3 8B model, quantized
to Q4_K_M, in the format your computer can run. That's the one you
download.

## Context length: "128K"

How many [tokens](tokens.md) the model can consider at once. 4K is
small, 32K is comfortable, 128K is generous. Bigger context needs more
RAM *at runtime* — a 70B model with 128K context can need far more
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

1. Right size for my RAM? (see [Choosing a Model](choosing-a-model.md))
2. Instruct version?
3. GGUF available, Q4 or Q5?
4. Context length big enough for my use?
5. Lots of downloads?

Five yeses: download it and try it.
