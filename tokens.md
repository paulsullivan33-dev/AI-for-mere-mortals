# Tokens

The **token** is the unit everything in AI is measured in: how much a
model can read at once, how fast it runs, and (for paid services) what
it costs. Worth understanding well.

## What a token is

A token is a chunk of text — roughly a word, sometimes less. The model
doesn't read letters; it reads tokens.

- "cat" → 1 token
- "extraordinary" → 2 or 3 tokens ("extra" + "ordinary", roughly)
- " ChatGPT" (with a leading space) → often its own token

Common words get their own token. Rare words get split into pieces.
That's why the model sometimes misspells unusual names — it never saw
them as a whole.

## Rules of thumb

- **~4 characters ≈ 1 token** (for English)
- **~750 words ≈ 1,000 tokens**
- A page of a novel ≈ 500 tokens

So when a model advertises a "128K context window," that's about 300
pages of text it can consider at once.

## Why tokens matter at home

**1. Context window.** This is the model's short-term memory, measured
in tokens. It includes *everything*: your question, the instructions,
and any documents you attached. A 4,096-token window fills up fast —
paste in three pages and there's barely room left for the answer.
When the window is full, the oldest stuff silently falls off.

**2. Speed.** Models report speed in **tokens per second**. Two speeds
matter:
- *Prompt processing* (reading your input): fast, often hundreds of
  tokens/sec even on CPU. The model chews through your whole prompt
  at once.
- *Generation* (writing the answer): slow, one token at a time, each
  one waiting on the last. This is the number you feel — 10 tok/s
  feels sluggish, 30+ feels snappy.

Long prompt + slow generation = that "why is this taking a minute?"
feeling. It's usually the prompt being long, not the answer.

**3. Memory.** Bigger context windows need more RAM, roughly
proportionally. Doubling the context roughly doubles that part of the
memory bill. (See [Running Models at Home](running-models-at-home.md).)

## Input vs. output tokens

- **Input tokens** = what you send in. Processed fast, in parallel.
- **Output tokens** = what the model writes back. Generated slowly,
  one at a time.

A model that "thinks" (like the qwen3 family) burns output tokens on
its internal reasoning *before* answering — which is why a short
answer can still take a while. Turning thinking off is often the
biggest speedup available.

## The practical takeaway

When something feels slow, check the prompt length first. Most home
slowness comes from feeding the model thousands of tokens of context
(a RAG setup, a long document), not from the model being dumb. Shorter
relevant context beats longer context almost every time.
