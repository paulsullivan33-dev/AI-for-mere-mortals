# RAG and Embeddings

RAG (Retrieval-Augmented Generation) is how you get a model to answer
from *your* documents instead of its training data. It's the single
most useful technique for home AI.

## The problem it solves

A model knows what it was trained on — and nothing else. It doesn't
know your notes, your novels, your manuals, or anything written after
its training cutoff. You could paste a document into the chat, but
that only works for short things.

RAG is the general solution: **find the relevant pieces, then ask.**

## How it works, in four steps

**1. Split your documents into chunks.**
Long documents get cut into pieces — a few hundred words each, with
some overlap so ideas spanning a boundary aren't cut in half. Chunks
are the unit of retrieval.

**2. Turn each chunk into an embedding.**
An **embedding** is a list of numbers (usually a few hundred) that
captures what the text *means*. Similar meanings → similar numbers.
A small special-purpose model does this; it doesn't need to be smart,
just consistent. (Popular one: `nomic-embed-text`.)

**3. At question time, retrieve.**
Your question gets embedded the same way. Then it's just math: find
the chunks whose numbers are closest to the question's numbers. Those
are (probably) the relevant passages.

**4. Stuff them into the prompt.**
The retrieved chunks go into the model's context along with your
question: "Here's some context. Answer the question using it." The
model does what it's good at — reading and summarizing — over text
you supplied.

## Why chunk size matters

- **Too big:** each chunk covers many topics, retrieval gets vague.
- **Too small:** chunks lack context, answers get fragmented.
- **~200–300 words** with ~50 words of overlap is a good starting
  point for prose. Experiment — it depends on your documents.

## Keep separate things separate

One index per *kind* of thing. Your private notes and your novel
collection should be different indexes — otherwise a question about
your notes retrieves novel passages and vice versa. Retrieval can't
tell "kinds" apart; only you can, by separating the indexes.

## What RAG doesn't fix

- **Bad retrieval.** If the embedding model can't tell your chunks
  apart, the model gets the wrong context and confidently answers
  from it. Garbage in, garbage out.
- **The model still predicts.** RAG grounds the answer, but the model
  can still misread or overstate what's in the chunks. For important
  things, check the cited passage.
- **It's not memory.** The model doesn't *learn* your documents. Each
  question re-retrieves from scratch.

## The one-sentence summary

RAG = search your stuff first, then let the model talk about what it
found. It's a search engine and a summarizer holding hands.
