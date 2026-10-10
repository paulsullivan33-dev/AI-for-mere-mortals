# RAG and Embeddings

RAG (Retrieval-Augmented Generation) is how you get a model to answer
using passages retrieved from *your* documents alongside what it learned
during training. It adds evidence to the prompt; it does not retrain the
model or guarantee that it will stick to the evidence.

## The problem it solves

A model cannot reliably answer about private documents it has never
been given. It can use new information supplied in a prompt or by tools,
including information newer than its training. Pasting a document works
when it fits within the usable context; larger collections need a way
to select relevant material.

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

Separate collections can make searches easier to control: your private
notes and novels may belong in different collections. Systems can also
use metadata filters or permissions within one index. Semantic similarity
alone doesn't enforce those boundaries; choose the collection and filters
appropriate to the question.

## What RAG doesn't fix

- **Bad retrieval.** If the embedding model can't tell your chunks
  apart, the model gets the wrong context and confidently answers
  from it. Garbage in, garbage out.
- **The model still predicts.** RAG grounds the answer, but the model
  can still misread or overstate what's in the chunks. For important
  things, check the cited passage.
- **It doesn't train the model.** Ordinary RAG leaves its weights
  unchanged. The application may save documents, indexes, chats, or
  cached results and reuse them later. Those are application storage,
  not new knowledge trained into the model.
- **A citation isn't proof.** Ask it to say when the passages lack the
  answer, then read the cited passage to verify the claim.

## The one-sentence summary

RAG = search your stuff first, then let the model talk about what it
found. It's a search engine and a summarizer holding hands.

## Sources and review

Reviewed October 10, 2026.

- [Text generation and sampling](https://huggingface.co/docs/transformers/main/en/llm_tutorial)
- [Retrieval and document context](https://docs.openwebui.com/features/chat-conversations/rag/)
