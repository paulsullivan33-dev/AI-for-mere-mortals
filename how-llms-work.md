# How LLMs Work (the one-page version)

A large language model (LLM) is a **next-word prediction machine**.
That's the whole trick. Everything else is details.

## The core idea

Give a model the start of a sentence — "The cat sat on the" — and it
predicts what word probably comes next ("mat"). Then it adds that word
and predicts the next one, over and over, until it stops. Every answer
you've ever gotten from ChatGPT, Claude, or a local model was built
this way, one word-piece at a time.

It doesn't "know" things the way you do. It absorbed patterns from
enormous amounts of text during training, and it's replaying the most
plausible continuation. Plausible text can be correct or false; fluent wording is not evidence.
A fabricated or incorrect assertion is often called a **hallucination**.

## Training vs. using

- **Training** is the expensive part: the model reads a huge slice of
  the internet and adjusts billions of internal numbers (parameters)
  until its predictions get good. Costs millions of dollars. You will
  never do this at home, and you don't need to.
- **Inference** is just *using* the model: you give it a prompt, it
  predicts the answer. This is what happens on your computer when you
  run Ollama. Inference is cheap — that's why home AI is possible.

## Why it sometimes makes things up

Pretraining teaches prediction; later training can encourage accuracy
and admitting uncertainty. Neither guarantees truth. A model can give
a confident false answer, especially when the needed evidence is absent.
Provide sources through [RAG](rag-and-embeddings.md) or tools when
appropriate, and check that those sources support the answer.

## The three knobs you'll actually touch

- **The prompt.** The biggest lever. Clear, specific instructions beat
  clever settings every time.
- **Temperature.** Lower values usually reduce sampling variation;
  higher values allow more varied wording. Defaults and useful ranges
  depend on the model. Low temperature does not make facts more reliable:
  a model can repeat the same wrong answer consistently.
- **Context.** Everything the model can "see" for one answer: your
  question plus any documents you attached. Bigger context = more it
  can consider at once, but slower and hungrier for memory. See
  [Tokens](tokens.md).

## Fine-tuning (so you know the term)

Training a model a little bit *more*, on your own examples, to specialize
it. Powerful, fiddly, and almost never what a home user needs — RAG or
a better prompt usually gets you there with far less work.

## The one-sentence summary

An LLM is a very fancy autocomplete that got so good at predicting
words it started to look like thinking.

## Sources and review

Reviewed October 10, 2026.

- [Text generation and sampling](https://huggingface.co/docs/transformers/main/en/llm_tutorial)
- [Retrieval and document context](https://docs.openwebui.com/features/chat-conversations/rag/)
