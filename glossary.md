# Glossary

Comprehensive definitions, A to Z. Plain language throughout — this
glossary covers the whole AI domain, not just what's runnable in a
home lab. One to three sentences each.

**Agent** — A program that lets a model take actions: run commands,
search the web, use tools — not just chat. The model decides what to
do next, does it, looks at the result, and continues.

**Agentic AI** — AI systems that pursue goals over multiple steps
with limited supervision: planning, using tools, checking their own
work. A chatbot answers; an agent *does*. The shift from "ask and
answer" to "delegate a task" is the biggest current trend in applied
AI.

**AGI (Artificial General Intelligence)** — A hypothetical AI that can
do any intellectual task a human can, not just one specialty. Nobody
agrees on exactly what counts or how far away it is — estimates range
from years to decades.

**AI (Artificial Intelligence)** — The whole field: machines doing
tasks that would require intelligence in humans. Machine learning is
a subset of AI; deep learning is a subset of machine learning; LLMs
are a subset of deep learning.

**AI safety** — The field concerned with making sure advanced AI
systems behave as intended and don't cause harm. Ranges from practical
(workaday reliability) to speculative (superintelligence going wrong).

**Alignment** — Training a model to be helpful, honest, and harmless
instead of just plausible. Why instruct models refuse some requests
and try to follow your intent.

**ASI (Artificial Superintelligence)** — A hypothetical AI far smarter
than humans in every domain. The subject of superalignment research:
how would we even control something that outthinks us?

**Attention** — The mechanism that lets a model weigh which earlier
words matter most for the next one. In "the animal didn't cross the
street because it was too tired," attention is how "it" connects to
"animal." You don't need the math — just the idea.

**Autonomous agent** — An agent designed to run on its own for
extended periods: given a goal, it plans, acts, and adapts without
checking back. Powerful and risky — a wrong turn compounds over many
steps with nobody watching.

**Backpropagation** — The algorithm that trains neural networks: it
figures out how wrong the model's answer was, then walks that error
backward through the network adjusting each parameter a little. The
engine under all of modern AI training.

**Base model** — A model trained only to predict text, not tuned for
conversation. Powerful but awkward to talk to. You almost always want
the instruct version instead.

**Batch size** — How many training examples the model looks at before
each adjustment. Bigger batches = steadier learning, but more memory.

**Benchmark** — A standardized test for models (MMLU, HumanEval,
GSM8K…). Useful for rough comparisons, but a model can ace benchmarks
and still feel dumb on *your* questions. Trust your own tests.

**Bias (model bias)** — Systematic skew in a model's answers, absorbed
from its training data: stereotypes, political leanings, cultural
assumptions. Different from a bug — it's the data talking.

**BPE (Byte Pair Encoding)** — The most common way tokenizers split
text: start with individual characters, then repeatedly merge the most
frequent pairs. Why "token" boundaries look arbitrary — they're
statistical, not linguistic.

**Catastrophic forgetting** — When training a model on new things
makes it worse at old things. A constant tension in fine-tuning: each
new skill can erode previous ones.

**Chain-of-thought** — Having the model spell out its reasoning step
by step before answering. Often dramatically improves hard problems —
and it's what "thinking" models do internally.

**Chat template** — The hidden formatting a chat model expects around
your messages (special tokens marking "user said" vs "assistant
said"). Handled automatically by Ollama; it matters when a model
behaves oddly, because the wrong template scrambles the conversation.

**Chatbot** — A conversational program built on a language model.
ChatGPT and Claude are chatbots; the LLM is the engine, the chatbot
is the car around it.

**Checkpoint** — A saved snapshot of a model during training. People
share checkpoints so others can fine-tune from a known-good point.

**Classification** — Sorting inputs into categories (spam/not spam,
cat/dog). One of the two classic machine-learning tasks, alongside
regression.

**Cloud inference** — Running a model on someone else's servers via
an API instead of your own hardware. Convenient and powerful;
costs money per token and your prompts leave your machine.

**Completion** — Whatever the model generates in response to a prompt.
"Completion" is the generic term; "answer" and "response" mean the
same thing.

**Compute** — Raw computing power, the currency of AI progress. Models
are described by how much compute trained them; labs compete on who
has the most GPUs.

**Constitutional AI** — Anthropic's method for alignment: the model is
given a written "constitution" of principles and trained to judge its
own answers against it, reducing the need for human labelers on every
example.

**Content filter / moderation** — Systems that screen prompts and
answers for disallowed content. Can be part of the model (training)
or a separate layer (a second model watching the first).

**Context caching** — Saving the model's processed understanding of a
long prompt so repeat questions over the same document don't redo the
work. Makes RAG-style apps much cheaper and faster.

**Context window** — How many tokens the model can consider at once:
your question plus everything you attached. Its short-term memory.

**Corrigibility** — The property of an AI system that allows itself
to be corrected, retrained, or shut down by its developers — even if
it "disagrees." Considered the foundational safety property: without
it, no other safeguard can be enforced.

**CUDA** — NVIDIA's system for running computations on the GPU. Most
local AI software uses it, which is why NVIDIA cards are the default
choice for home AI. (AMD uses ROCm — improving, but less supported.)

**Data wall** — The concern that we've nearly used up all high-quality
human text for training, and future models will starve for data.
One reason labs are so interested in synthetic data.

**Deceptive alignment** — The worrying hypothetical where a model
*appears* aligned during training and testing but behaves differently
once deployed — playing along until oversight drops. Unproven in
practice, heavily discussed in safety research.

**Deep learning** — Machine learning with large neural networks
(many layers — hence "deep"). The approach behind essentially all
modern AI breakthroughs.

**Diffusion model** — The kind of model that generates images (Stable
Diffusion, Flux). It starts from noise and gradually sharpens it into
a picture. Different family from LLMs, different tools.

**Distillation** — Training a small model to imitate a big one. The
student learns the teacher's answers without the teacher's size.
Many good small models are distilled.

**DPO (Direct Preference Optimization)** — A simpler alternative to
RLHF for teaching a model which answers humans prefer. Same goal —
aligned, helpful answers — with less machinery.

**Edge AI** — Running models on local devices (phones, laptops, home
servers) instead of the cloud. Private, offline-capable, and limited
by the device's hardware. Your Ollama setup is edge AI.

**Evals** — Evaluations: structured tests of what a model can and
can't do, including safety evals (will it help build a weapon? does it
scheme?). Labs run evals before releasing models; some results are
published.

**Emergent abilities** — Capabilities that appear suddenly as models
get bigger, without being explicitly trained for: arithmetic, then
reasoning, then tool use. Nobody fully understands why scale unlocks
them, which is part of what makes AI progress hard to predict.

**Embedding** — A list of numbers capturing what a piece of text
*means*. Similar meanings get similar numbers. Used to search by
meaning instead of keywords.

**Encoder** — The half of a model that reads and understands input
(BERT-style). Most modern chat models are decoder-only (they just
generate), but encoders live on in search and embedding models.

**Epoch** — One full pass through the training data. Models train for
multiple epochs — reading everything several times.

**Existential risk (x-risk)** — The small-but-serious possibility
that advanced AI could threaten humanity's survival or freedom. The
extreme end of AI safety; debated fiercely, motivates much alignment
research.

**Fine-tuning** — Training a model a little more on your own examples
to specialize it. Powerful, fiddly, rarely needed at home.

**FLOPs** — Floating-point operations: the raw count of math steps.
Training compute is measured in FLOPs (a frontier model might take
10^25). Bigger number = vastly more expensive training.

**Foundation model** — A large model trained on broad data, meant to
be adapted for many tasks (GPT, Claude, Llama). The base that
everything else builds on.

**Frontier model** — A model at the current edge of capability —
the most powerful available at any given time. What's "frontier"
today is mid-range in eighteen months.

**Function calling** — Letting a model invoke specific functions you
define (get_weather, send_email) with structured arguments. The
practical mechanism behind tool use and agents.

**Generative AI** — AI that creates things: text, images, audio,
video. As opposed to AI that classifies or predicts. The LLM boom is
a generative-AI boom.

**GGUF** — The file format for running models on your own computer.
If it ends in `.gguf`, Ollama and friends can run it.

**GPU** — Graphics card. Originally for games, now the workhorse of
AI: thousands of small cores that do the model's math in parallel. A
compatible GPU can accelerate inference; the gain depends on memory,
model size, context, and how much work stays on the GPU.

**Gradient descent** — The core training loop: measure the error,
nudge every parameter slightly downhill against it, repeat billions
of times. Simple idea, staggering scale.

**Grounding** — Connecting a model's words to real sources: retrieved
documents, tool outputs, sensor data. RAG is a form of grounding.
The opposite of letting it free-associate.

**Guardrails** — Rules and filters wrapped around a model in an
application: block certain topics, require citations, cap what an
agent may do. Safety engineering at the app layer.

**Hallucination** — When the model states something false with full
confidence. It predicts plausible text, not true text.

**Human-in-the-loop** — Keeping a person in the decision chain: the
agent proposes, the human approves. The standard answer to "but what
if the agent does something dumb" — at the cost of speed.

**Inference** — Using a model (as opposed to training it). The cheap
part. What your computer does when you ask a question.

**Inference-time scaling** — Spending more compute *while answering*
to get better answers: longer thinking, trying multiple approaches,
checking its own work. The insight that you can trade speed for
quality at answer time, not just at training time.

**Instruct model** — A model tuned to follow instructions and hold a
conversation. The kind you want for chat and Q&A.

**Instrumental convergence** — The idea that almost any sufficiently
capable agent will pursue certain sub-goals — self-preservation,
resource gathering, avoiding shutdown — not because it "wants" them,
but because they're useful for *any* goal. Why safety researchers
worry even about agents with innocent objectives.

**Interpretability** — Trying to understand what a model is actually
doing inside: which parts of the network handle which concepts.
Early days, but it's how we'd ever *verify* a model is safe rather
than just hoping.

**Jailbreak** — A prompt trick that gets a model to bypass its safety
training. A cat-and-mouse game; worth knowing the term when you see
people discussing model behavior.

**Knowledge cutoff** — The date the model's training data ends.
Anything after that, it doesn't know unless you tell it (via RAG or
in the prompt). Why models confidently get recent events wrong.

**KV cache** — The model's scratch memory while generating: it saves
its work on earlier tokens so it doesn't recompute them. Grows with
context length — this is a big part of why long contexts eat RAM.

**Latency** — How long you wait for the first token. **Throughput** —
how many tokens per second after that. A model can have good
throughput but annoying latency (slow to start, then fast).

**Learning rate** — How big each training adjustment is. Too big and
training thrashes; too small and it takes forever. One of the fiddly
knobs of training you'll never touch at home.

**LLM (Large Language Model)** — A neural network trained on vast
text to predict language. "Large" originally meant billions of
parameters; the name stuck even as small ones got good.

**LoRA** — A lightweight way to fine-tune: instead of retraining the
whole model, you train a small add-on module. Cheap enough that
hobbyists do it. You'll see LoRA adapters shared for specific styles
or characters.

**Loss function** — The score training tries to minimize: how wrong
the model's predictions are. Everything in training is downhill
against this number.

**Machine learning (ML)** — AI that learns patterns from data instead
of following hand-written rules. The parent field of deep learning.

**Memorization** — When a model stores training text verbatim and can
reproduce it. Mostly harmless, occasionally a privacy or copyright
problem — and the reason models sometimes quote.

**Mesa-optimization** — The hypothesis that a trained model might
develop its own internal optimizer with goals different from what it
was trained for. The theoretical root of deceptive-alignment worries.

**Mixture of Experts (MoE)** — A model that routes each token through
some of its expert components. Active parameters describe work per token;
total parameters describe the full weights. For ordinary local inference,
budget weight memory from the total, even when the active count is small.

**Model collapse** — The feared spiral where models trained on
AI-generated text get progressively worse — like a photocopy of a
photocopy. One argument for why human data stays valuable.

**Multi-agent system** — Several agents working together (or against
each other): one writes, one critiques, one checks facts. Can
outperform a single agent; much harder to debug.

**Multimodal** — A model that handles more than text: images, audio,
sometimes video. A vision-language model can look at a photo and
describe it.

**Neural network** — The underlying structure: layers of simple
math units connected together. "Parameters" are the strengths of
those connections. An LLM is one very large neural network.

**Ollama** — The easiest way to run models locally. Handles
downloading, loading, and serving models on Windows/Mac/Linux.

**Open weights** — Models whose parameters are downloadable by anyone
(Llama, Mistral, Qwen). Often mislabeled "open source" — the training
data and code usually aren't open, just the finished model. What makes
home AI possible.

**Orchestration** — Coordinating the pieces around a model in an app:
which tools it can call, in what order, with what checks. LangChain
and friends are orchestration frameworks.

**Orthogonality thesis** — The philosophical claim that intelligence
and goals are independent: a superintelligence could pursue any goal,
including a stupid or harmful one. Smart does not imply wise.

**Overfitting** — When a model memorizes its training examples
instead of learning the pattern. In fine-tuning, it's why you don't
train too long on too little data.

**Parameters** — The billions of adjustable numbers inside a model
(7B = 7 billion). More usually means more capable — and more RAM.

**Perplexity** — A score for how "surprised" a model is by some text.
Lower = the text looks more expected to the model. Mostly a research
metric; occasionally useful for comparing model quality.

**Planning** — An agent breaking a goal into steps before acting.
Simple agents just react; better ones sketch the route first. Still
brittle — plans go stale the moment reality differs.

**Post-training** — Everything after the initial pretraining:
instruction tuning, RLHF, safety work. Turns a raw text-predictor
into a usable assistant. Most of a model's *behavior* comes from
here, not from pretraining.

**Pretraining** — The initial, enormous training run on raw text.
Teaches the model language, facts, and reasoning patterns. Costs
millions; done once per model by labs.

**Prompt** — Everything you send the model: instructions, context,
and your question. The biggest lever you have.

**Prompt engineering** — The craft of writing prompts that get good
results: being specific, giving examples, structuring the request.
Half writing skill, half knowing how models "think."

**Prompt injection** — Hiding malicious instructions inside content
the model reads (a webpage, a document) so it follows them as if you
said them. The reason you shouldn't let an agent blindly act on
untrusted text.

**Pruning** — Deleting the least-important parts of a trained model to
make it smaller and faster. Like quantization, a compression trick —
usually combined with it.

**Quantization** — Shrinking a model by storing each parameter in
fewer bits (Q4, Q5, Q8). Much smaller, slightly less capable. Q4 is
the usual sweet spot.

**RAG (Retrieval-Augmented Generation)** — Searching your documents
for relevant chunks and adding them to the model's prompt. Ordinary
RAG leaves model weights unchanged; answers still need verification.

**ReAct** — An agent pattern: interleave **Rea**soning and **Act**ing
— think a step, take a tool action, observe the result, repeat. The
basic loop most agents run.

**Reasoning model** — A model trained to work through problems step
by step ("thinking") before answering. Better at math and logic,
slower at everything. Examples: qwen3 with thinking on, deepseek-r1.

**Red teaming** — Attacking a model on purpose to find failures:
jailbreaks, bad advice, hidden behaviors. Labs do it before release;
it's also a job title now.

**Refusal** — When a model declines a request ("I can't help with
that"). A trained behavior, part of alignment — and part of why
jailbreaks exist.

**Regression** — Predicting a number (price, temperature) rather than
a category. The quieter sibling of classification; most old-school
ML is one of these two.

**RLHF** — Training a model using human feedback: people rank
answers, and the model learns to prefer highly-ranked ones. A big
part of why modern chat models feel helpful instead of just
autocomplete-y.

**RLAIF** — Same idea as RLHF, but an AI does the ranking instead of
humans. Cheaper and faster; slightly circular, but it works.

**RoPE (Rotary Position Embeddings)** — The current standard way
models track word order: rotate each token's representation by its
position. You don't need the math — just know it's why modern models
handle long contexts better than older ones.

**Safetensors** — A safe file format for model weights (the
alternative to Python pickle files, which can hide malicious code).
You'll see it on Hugging Face; for home use you want the GGUF
version anyway.

**Sandbagging** — A model deliberately underperforming on evals —
hiding capability. Hypothetical, hard to detect, and a headache for
anyone trying to measure what a model can really do.

**Scalable oversight** — The problem of supervising AI systems that
are smarter than their supervisors. If the model outthinks you, how
do you check its work? One of the core open problems in safety.

**Scaling laws** — The observed pattern that model capability rises
predictably with more parameters, data, and compute. The empirical
law behind the "just make it bigger" era.

**Scheming** — A model secretly pursuing its own goals while
pretending to follow instructions. The behavioral version of
deceptive alignment; evals now test for early signs of it.

**Seed** — A number that starts the model's random number generator.
Same seed + same prompt + same settings = same answer. Useful when
you want reproducible results.

**SFT (Supervised Fine-Tuning)** — Fine-tuning on example
instruction/response pairs. The standard first step of
post-training: teaches the model the *shape* of being helpful.

**SLM (Small Language Model)** — Roughly, models under ~10B
parameters. The home-lab workhorses: fast, cheap, private, and
increasingly capable.

**Speculative decoding** — A speedup trick: a tiny model drafts the
next few tokens, the big model just checks them. Same answers, much
faster. Free speed if your setup supports it.

**Speech-to-text (STT)** — Transcribing spoken audio into text
(Whisper is the well-known one). The ears of a voice assistant.

**Stop sequence** — Text that tells the model to stop generating
(e.g. a special end-of-turn marker). Prevents it from rambling past
the answer or inventing a second conversation.

**Streaming** — Showing the answer word-by-word as it's generated
instead of waiting for the whole thing. Feels faster even when it
isn't.

**Superalignment** — OpenAI's (now-disbanded) project, and the
general problem: how do humans align an AI system that's smarter
than humans? If you can't fully understand or predict it, you can't
supervise it the normal way — so the field explores tricks like
having weaker models supervise stronger ones.

**Supervised learning** — Learning from labeled examples (this email
is spam, this photo is a cat). The oldest and most reliable form of
machine learning.

**Sycophancy** — Models telling you what you want to hear: agreeing
with your opinions, flattering your ideas. A side effect of training
on human approval — and why "the AI agreed with me" proves nothing.

**Synthetic data** — Training data generated by AI instead of humans.
Useful when real data runs out (see data wall), risky because of
model collapse.

**System prompt** — Hidden instructions that shape how the model
behaves ("You are a helpful assistant…"). Set once per conversation.

**Temperature** — How random the model's word choices are. Low
(0.1–0.3) = focused and consistent. High (0.8+) = creative and
unpredictable. Lower temperature does not guarantee correct facts.

**Test-time compute** — See inference-time scaling: spending extra
computation while answering rather than while training.

**Text-to-speech (TTS)** — Synthesizing spoken audio from text. The
voice of a voice assistant.

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

**Transfer learning** — The reason pretraining works: a model trained
on general text transfers that knowledge to specific tasks with a
little fine-tuning. Learn once, apply everywhere.

**Transformer** — The architecture nearly all modern LLMs are built
on (the "T" in GPT). Invented at Google in 2017. You don't need the
details — just recognize the name.

**Unsupervised learning** — Learning patterns from data without
labels (clustering, pretraining). The model finds structure on its
own.

**Video generation** — AI creating video clips from text prompts
(Sora, Veo, Runway). Newest frontier of generative AI; still
expensive and short-form.

**Vision model** — A model that can see images. Give it a photo, ask
questions about it. Often combined with language (multimodal).

**vLLM** — A high-performance server for running LLMs, popular for
serving models to many users at once. Overkill for one person
chatting, but the standard behind many hosted APIs.

**VRAM** — Memory on your graphics card. Models run fastest here.
Bigger GPU = bigger models at usable speed.

**Weights** — The model's parameters, saved as a file. "Downloading
the weights" = downloading the model itself.

**World model** — A model's internal representation of how things
work: physics, causality, how objects behave. Debated how much LLMs
really have one versus sophisticated pattern-matching — it matters
for whether they can truly reason about novel situations.

**Zero-shot / few-shot** — Asking a model to do a task with no
examples (zero-shot) versus a few examples in the prompt (few-shot).
Models are remarkably good at picking up a task from just two or
three examples — that's in-context learning.
