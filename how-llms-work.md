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
plausible continuation. Most of the time, plausible and correct are
the same thing. Sometimes they aren't — that's a **hallucination**.

## Training vs. using

- **Training** is the expensive part: the model reads a huge slice of
  the internet and adjusts billions of internal numbers (parameters)
  until its predictions get good. Costs millions of dollars. You will
  never do this at home, and you don't need to.
- **Inference** is just *using* the model: you give it a prompt, it
  predicts the answer. This is what happens on your computer when you
  run Ollama. Inference is cheap — that's why home AI is possible.

## Why it sometimes makes things up

The model optimizes for *plausible*, not *true*. If you ask about
something rare or something past its training cutoff, it will still
produce a confident-sounding answer — because "I don't know" was rare
in its training data. Treat confident answers about obscure facts with
suspicion, and give it your own documents to work from (see
[RAG and Embeddings](rag-and-embeddings.md)) when accuracy matters.

## The three knobs you'll actually touch

- **The prompt.** The biggest lever. Clear, specific instructions beat
  clever settings every time.
- **Temperature.** Low (0.1–0.3) = focused, consistent, boring — good
  for factual work. High (0.8–1.2) = creative, varied, weird — good
  for brainstorming. Default is usually around 0.7.
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
