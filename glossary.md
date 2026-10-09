# Glossary

Quick definitions, A to Z. One or two sentences each.

**Base model** — A model trained only to predict text, not tuned for
conversation. Powerful but awkward to talk to. You almost always want
the instruct version instead.

**Context window** — How many tokens the model can consider at once:
your question plus everything you attached. Its short-term memory.

**Embedding** — A list of numbers capturing what a piece of text
*means*. Similar meanings get similar numbers. Used to search by
meaning instead of keywords.

**Fine-tuning** — Training a model a little more on your own examples
to specialize it. Powerful, fiddly, rarely needed at home.

**GGUF** — The file format for running models on your own computer.
If it ends in `.gguf`, Ollama and friends can run it.

**Hallucination** — When the model states something false with full
confidence. It predicts plausible text, not true text.

**Inference** — Using a model (as opposed to training it). The cheap
part. What your computer does when you ask a question.

**Instruct model** — A model tuned to follow instructions and hold a
conversation. The kind you want for chat and Q&A.

**Ollama** — The easiest way to run models locally. Handles
downloading, loading, and serving models on Windows/Mac/Linux.

**Parameters** — The billions of adjustable numbers inside a model
(7B = 7 billion). More usually means more capable — and more RAM.

**Prompt** — Everything you send the model: instructions, context,
and your question. The biggest lever you have.

**Quantization** — Shrinking a model by storing each parameter in
fewer bits (Q4, Q5, Q8). Much smaller, slightly less capable. Q4 is
the usual sweet spot.

**RAG (Retrieval-Augmented Generation)** — Searching your documents
for relevant chunks, then asking the model to answer from them. How
to make a model knowledgeable about *your* stuff.

**System prompt** — Hidden instructions that shape how the model
behaves ("You are a helpful assistant…"). Set once per conversation.

**Temperature** — How random the model's word choices are. Low
(0.1–0.3) = focused and consistent. High (0.8+) = creative and
unpredictable.

**Token** — A chunk of text the model reads — roughly a word. Speed,
memory, and cost are all measured in tokens.

**Top-p** — Another randomness knob: limits word choices to the most
likely candidates. Lower = safer. Most people can leave it alone.

**Training** — The enormously expensive process of teaching a model
by having it read vast amounts of text. You will never do this; you
don't need to.

**VRAM** — Memory on your graphics card. Models run fastest here.
Bigger GPU = bigger models at usable speed.
