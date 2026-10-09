# Glossary

Quick definitions, A to Z. One to three sentences each, plain language.

**Agent** — A program that lets a model take actions: run commands,
search the web, use tools — not just chat. The model decides what to
do next, does it, looks at the result, and continues.

**Alignment** — Training a model to be helpful, honest, and harmless
instead of just plausible. Why instruct models refuse some requests
and try to follow your intent.

**Attention** — The mechanism that lets a model weigh which earlier
words matter most for the next one. In "the animal didn't cross the
street because it was too tired," attention is how "it" connects to
"animal." You don't need the math — just the idea.

**Base model** — A model trained only to predict text, not tuned for
conversation. Powerful but awkward to talk to. You almost always want
the instruct version instead.

**Benchmark** — A standardized test for models (MMLU, HumanEval,
GSM8K…). Useful for rough comparisons, but a model can ace benchmarks
and still feel dumb on *your* questions. Trust your own tests.

**Chat template** — The hidden formatting a chat model expects around
your messages (special tokens marking "user said" vs "assistant
said"). Handled automatically by Ollama; it matters when a model
behaves oddly, because the wrong template scrambles the conversation.

**Checkpoint** — A saved snapshot of a model during training. People
share checkpoints so others can fine-tune from a known-good point.

**Completion** — Whatever the model generates in response to a prompt.
"Completion" is the generic term; "answer" and "response" mean the
same thing.

**Context window** — How many tokens the model can consider at once:
your question plus everything you attached. Its short-term memory.

**CUDA** — NVIDIA's system for running computations on the GPU. Most
local AI software uses it, which is why NVIDIA cards are the default
choice for home AI. (AMD uses ROCm — improving, but less supported.)

**Diffusion model** — The kind of model that generates images (Stable
Diffusion, Flux). It starts from noise and gradually sharpens it into
a picture. Different family from LLMs, different tools.

**Distillation** — Training a small model to imitate a big one. The
student learns the teacher's answers without the teacher's size.
Many good small models are distilled.

**Embedding** — A list of numbers capturing what a piece of text
*means*. Similar meanings get similar numbers. Used to search by
meaning instead of keywords.

**Epoch** — One full pass through the training data. Models train for
multiple epochs — reading everything several times.

**Fine-tuning** — Training a model a little more on your own examples
to specialize it. Powerful, fiddly, rarely needed at home.

**GGUF** — The file format for running models on your own computer.
If it ends in `.gguf`, Ollama and friends can run it.

**GPU** — Graphics card. Originally for games, now the workhorse of
AI: thousands of small cores that do the model's math in parallel. A
model on GPU can run 5–10x faster than the same model on CPU.

**Hallucination** — When the model states something false with full
confidence. It predicts plausible text, not true text.

**Inference** — Using a model (as opposed to training it). The cheap
part. What your computer does when you ask a question.

**Instruct model** — A model tuned to follow instructions and hold a
conversation. The kind you want for chat and Q&A.

**Jailbreak** — A prompt trick that gets a model to bypass its safety
training. A cat-and-mouse game; worth knowing the term when you see
people discussing model behavior.

**KV cache** — The model's scratch memory while generating: it saves
its work on earlier tokens so it doesn't recompute them. Grows with
context length — this is a big part of why long contexts eat RAM.

**Latency** — How long you wait for the first token. **Throughput** —
how many tokens per second after that. A model can have good
throughput but annoying latency (slow to start, then fast).

**LoRA** — A lightweight way to fine-tune: instead of retraining the
whole model, you train a small add-on module. Cheap enough that
hobbyists do it. You'll see LoRA adapters shared for specific styles
or characters.

**Mixture of Experts (MoE)** — A model made of smaller specialist
sub-models ("experts"), where only a few activate per token. Acts
bigger than its active size — e.g. a 47B MoE that only uses 13B at a
time. More capability per gigabyte of active RAM.

**Multimodal** — A model that handles more than text: images, audio,
sometimes video. A vision-language model can look at a photo and
describe it.

**Neural network** — The underlying structure: layers of simple
math units connected together. "Parameters" are the strengths of
those connections. An LLM is one very large neural network.

**Ollama** — The easiest way to run models locally. Handles
downloading, loading, and serving models on Windows/Mac/Linux.

**Overfitting** — When a model memorizes its training examples
instead of learning the pattern. In fine-tuning, it's why you don't
train too long on too little data.

**Parameters** — The billions of adjustable numbers inside a model
(7B = 7 billion). More usually means more capable — and more RAM.

**Perplexity** — A score for how "surprised" a model is by some text.
Lower = the text looks more expected to the model. Mostly a research
metric; occasionally useful for comparing model quality.

**Prompt** — Everything you send the model: instructions, context,
and your question. The biggest lever you have.

**Prompt injection** — Hiding malicious instructions inside content
the model reads (a webpage, a document) so it follows them as if you
said them. The reason you shouldn't let an agent blindly act on
untrusted text.

**Quantization** — Shrinking a model by storing each parameter in
fewer bits (Q4, Q5, Q8). Much smaller, slightly less capable. Q4 is
the usual sweet spot.

**RAG (Retrieval-Augmented Generation)** — Searching your documents
for relevant chunks, then asking the model to answer from them. How
to make a model knowledgeable about *your* stuff.

**Reasoning model** — A model trained to work through problems step
by step ("thinking") before answering. Better at math and logic,
slower at everything. Examples: qwen3 with thinking on, deepseek-r1.

**RLHF** — Training a model using human feedback: people rank
answers, and the model learns to prefer highly-ranked ones. A big
part of why modern chat models feel helpful instead of just
autocomplete-y.

**Safetensors** — A safe file format for model weights (the
alternative to Python pickle files, which can hide malicious code).
You'll see it on Hugging Face; for home use you want the GGUF
version anyway.

**Seed** — A number that starts the model's random number generator.
Same seed + same prompt + same settings = same answer. Useful when
you want reproducible results.

**Stop sequence** — Text that tells the model to stop generating
(e.g. a special end-of-turn marker). Prevents it from rambling past
the answer or inventing a second conversation.

**Streaming** — Showing the answer word-by-word as it's generated
instead of waiting for the whole thing. Feels faster even when it
isn't.

**System prompt** — Hidden instructions that shape how the model
behaves ("You are a helpful assistant…"). Set once per conversation.

**Temperature** — How random the model's word choices are. Low
(0.1–0.3) = focused and consistent. High (0.8+) = creative and
unpredictable.

**Token** — A chunk of text the model reads — roughly a word. Speed,
memory, and cost are all measured in tokens.

**Tokenizer** — The tool that splits text into tokens. Different
models split differently, which is why token counts vary between
models for the same text.

**Top-k** — A randomness knob: the model only considers the k most
likely next tokens. Smaller k = safer and more predictable.

**Top-p** — Another randomness knob: limits word choices to the most
likely candidates adding up to probability p. Lower = safer. Most
people can leave it alone.

**Training** — The enormously expensive process of teaching a model
by having it read vast amounts of text. You will never do this; you
don't need to.

**Transformer** — The architecture nearly all modern LLMs are built
on (the "T" in GPT). Invented at Google in 2017. You don't need the
details — just recognize the name.

**Vision model** — A model that can see images. Give it a photo, ask
questions about it. Often combined with language (multimodal).

**VRAM** — Memory on your graphics card. Models run fastest here.
Bigger GPU = bigger models at usable speed.

**Weights** — The model's parameters, saved as a file. "Downloading
the weights" = downloading the model itself.
