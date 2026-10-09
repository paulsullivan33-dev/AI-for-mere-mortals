# Choosing a Model

There are thousands of models. Here's how to pick without drowning.

## Step 1: Know your RAM

This decides everything. Rough rule for a Q4-quantized model
(the normal download):

> **Gigabytes of RAM needed ≈ billions of parameters ÷ 2, plus 2**

- 1–3B model → ~2–4 GB. Runs on anything, even a Raspberry Pi (slowly).
- 7–8B model → ~5–6 GB. The sweet spot for most home computers.
- 13–14B model → ~8–9 GB. Needs a decent machine.
- 32B model → ~18–20 GB. Needs a beefy machine or a good GPU.
- 70B model → ~40 GB. Serious hardware only.

Add ~2 GB headroom for the operating system and the context window.
If you're short, go one size smaller or drop to Q3 — a fast small
model beats a big one that doesn't fit.

## Step 2: Match the model to the job

- **Chat and Q&A** — any decent instruct model. 8B is plenty.
- **Coding help** — coder-specific models (qwen2.5-coder, deepseek-coder,
  starcoder). They punch above their size on code.
- **Reasoning and math** — reasoning models (qwen3 with thinking on,
  deepseek-r1). Slower, but they work through problems step by step.
- **Speed matters** (voice chat, quick answers) — smaller models, 1–4B.
- **RAG over your documents** — 4–8B is the sweet spot. Retrieval does
  the hard work of finding facts; the model just needs to summarize
  clearly. A 70B model won't fix bad retrieval.

## Step 3: Try two and compare

Specs only go so far. Download two candidates in your size range, ask
them the same three questions — one factual, one creative, one from
your own documents — and keep the one you like. "Vibes" are a valid
benchmark for personal use.

## Speed expectations (CPU, no GPU)

Rough generation speeds on a mid-range desktop CPU:

- 1–3B: 15–40 tokens/sec — feels fine
- 7–8B: 5–15 tokens/sec — usable, slightly patient
- 13B+: 1–5 tokens/sec — only for when quality matters most

A GPU changes everything — even a modest one can 5–10x these numbers.
But plenty of people happily run 8B models on CPU.

## The "good enough" principle

The jump from 1B to 8B is enormous. The jump from 8B to 70B is real
but much smaller — and costs 10x the hardware. For home use, an 8B
model that answers in seconds beats a 70B model you can't afford to
run. Start at 8B. Only go bigger if you hit a wall you can name.
