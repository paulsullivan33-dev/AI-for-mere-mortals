# Ollama, In Depth

[Ollama](https://ollama.com) is the program most home users run their
models with. The [Running Models at Home](running-models-at-home.md)
guide introduced it in 30 seconds. This guide covers the rest: every
command, every useful setting, the programs that sit on top of it, and
what people actually use it for.

## What Ollama is, in one paragraph

Ollama is two things in one box. First, a **server**: a program that
runs in the background, loads models into memory, and answers
questions. Second, a **command-line tool**: the `ollama` commands you
type to download models, chat with them, and manage them. Other
programs — web pages, phone apps, your own scripts — talk to the
server, so one Ollama can feed many front ends at once.

Install it from [ollama.com](https://ollama.com). Windows, Mac, and
Linux are all supported. On Linux the server starts automatically;
on Mac/Windows it starts with the desktop app.

## The commands

Type `ollama help` any time for the short list. Here is the full set,
in plain words:

```
ollama pull llama3.2:3b     # download a model (like installing an app)
ollama run llama3.2:3b      # open a chat with a model in your terminal
ollama list                 # show every model you have downloaded
ollama ps                   # show which models are loaded right now
ollama show llama3.2:3b     # details: size, settings, license
ollama stop llama3.2:3b     # unload a model, freeing its memory
ollama rm llama3.2:3b       # delete a model from your disk
ollama cp old-name new-name # copy a model under a new name
ollama serve                # start the server by hand (rarely needed)
ollama create my-model -f ./Modelfile   # build a custom model (see below)
ollama push my-model        # share your model on Ollama's website
```

A few notes on the everyday ones:

- **`pull`** downloads from Ollama's library — the same place the
  [model chooser](choosing-a-model.md) points you to. Models are
  versioned with tags (`:3b`, `:8b`, `:latest`), just like the guide
  describes.
- **`run`** does two jobs: if the model isn't downloaded yet, it
  pulls it first, then opens a chat. Inside the chat, `/bye` quits,
  `/show info` prints the model's settings, and `/?` lists chat
  commands.
- **`list`** vs **`ps`**: `list` is what's on your *disk* (your
  library). `ps` is what's in *memory* right now (your desk). A model
  can be downloaded but not loaded, and that's the normal state.
- **`show`** is how you answer "what exactly is this model?" — its
  parameter count, quantization, context length, and the system
  prompt it ships with.

## The server and its API

Ollama's server listens on port **11434** on your machine. Any program
on that machine can ask it things over plain HTTP — no special
software needed. This is called an **API** (application programming
interface): a door other programs knock on.

The two doors you will use most:

- **`/api/chat`** — send messages, get a reply. This is what chat
  apps use.
- **`/api/embed`** — turn text into number-lists for search.
  This is what [RAG](rag-and-embeddings.md) uses.

A quick taste with `curl` in Bash (Linux/macOS). For Windows PowerShell,
use the example immediately below it:

```
curl http://localhost:11434/api/chat -d '{
  "model": "llama3.2:3b",
  "messages": [{"role": "user", "content": "Say hi in five words."}],
  "stream": false
}'
```

In **Windows PowerShell**, use its built-in HTTP tool instead of `curl`
(which is an alias in Windows PowerShell 5.1):

```powershell
$chatBody = @{
  model = 'llama3.2:3b'
  messages = @(@{ role = 'user'; content = 'Say hi in five words.' })
  stream = $false
} | ConvertTo-Json -Depth 5
$chatReply = Invoke-RestMethod -Uri 'http://localhost:11434/api/chat' -Method Post -ContentType 'application/json' -Body $chatBody
$chatReply.message.content
```

You get back a JSON reply with the model's answer. `"stream": false`
means "wait for the whole answer, then reply at once" — easier for
scripts. Leave it out (or set `true`) and the answer arrives
word-by-word, which is what chat apps prefer.

**Talking to another machine.** By default only your own computer can
reach the server. To let the whole house use one Ollama box, set
`OLLAMA_HOST=0.0.0.0` before starting it — then any device on your
network can reach `http://<that-computer>:11434`. (Only do this on a
network you trust, like your home.)

## Settings that change how a model behaves

Every request can carry an `options` block that tunes the model. The
useful ones, in plain words:

- **`temperature`** (0 to 2, default ~0.8): how wild the answers get.
  Low (0.2) usually gives less varied wording, useful for consistent
  summaries. It does not verify facts or guarantee identical answers.
  High (1.2+) = creative and surprising, good for stories and
  brainstorming.
- **`num_ctx`** (default depends on your model and setup): how many tokens the model can see at
  once. Bigger handles longer documents but eats RAM and slows down.
  (See [Running Models at Home](running-models-at-home.md).)
- **`num_predict`** (default: no limit): the longest answer allowed,
  in tokens. Set it to 200 for short summaries and quick replies.
- **`top_p`** (default 0.9): another creativity knob — lower means
  the model only picks from its safest guesses. Most people leave
  this alone and just use temperature.
- **`repeat_penalty`**: how hard the model tries not
  to repeat itself. Raise it if a model loops the same phrase.
- **`seed`**: a fixed starting number makes answers repeatable —
  same prompt, same answer. Handy for testing.
- **`stop`**: words that tell the model "end your answer here."

In an interactive chat started with `ollama run llama3.2:3b`, enter:

```text
/set parameter temperature 0.2
/set parameter num_ctx 8192
```

These are chat commands, not PowerShell commands. For saved defaults,
use `PARAMETER` lines in a [Modelfile](#custom-models-the-modelfile).
For API requests, place generation settings in `options`.

**Thinking is different:** `think` is a top-level request field, alongside
`model` and `messages`, not inside `options`. Supported values depend on
the model; `false` requests no thinking for models that support it.
Here is a Windows PowerShell example with a Qwen3 model:

```powershell
ollama pull qwen3:8b
$thinkingBody = @{
  model = 'qwen3:8b'
  messages = @(@{ role = 'user'; content = 'Explain rain in one sentence.' })
  stream = $false
  think = $false
  options = @{ temperature = 0.2; num_ctx = 8192 }
} | ConvertTo-Json -Depth 5
$thinkingReply = Invoke-RestMethod -Uri 'http://localhost:11434/api/chat' -Method Post -ContentType 'application/json' -Body $thinkingBody
$thinkingReply.message.content
```

For embeddings, pull the separate embedding model, then call `/api/embed`:

```powershell
ollama pull nomic-embed-text
$embeddingBody = @{ model = 'nomic-embed-text'; input = 'The cat sat on the mat.' } | ConvertTo-Json
$embeddingReply = Invoke-RestMethod -Uri 'http://localhost:11434/api/embed' -Method Post -ContentType 'application/json' -Body $embeddingBody
$embeddingReply.embeddings[0].Count
```

The last line should print a positive vector length. The older
`/api/embeddings` endpoint uses a different request/response shape;
don't mix examples from the two.

## Settings that change how Ollama itself behaves

These are **environment variables**: settings you put in place
*before* starting Ollama, usually in your terminal or a config file.

- **`OLLAMA_KEEP_ALIVE`** (default `5m`): how long a model stays
  loaded after you stop using it. `1h` keeps it warm for an hour —
  instant answers, at the cost of RAM sitting used. `0` unloads
  immediately — slowest to start, lightest on memory. Match it to
  the machine: generous on a dedicated box, stingy on a laptop.
- **`OLLAMA_HOST`** (default `127.0.0.1:11434`): which address the
  server listens on. `0.0.0.0` opens it to your local network (see
  above).
- **`OLLAMA_MODELS`**: where downloaded models are stored. Point it
  at a big drive if your main disk is small.
- **`OLLAMA_NUM_PARALLEL`**: how many chats can run at once. More
  = slower each, but nobody waits in line.
- **`OLLAMA_MAX_LOADED_MODELS`**: cap on how many models sit in
  memory at once. Ollama unloads the least-recently-used past this.
- **`OLLAMA_FLASH_ATTENTION`** (`1` to enable): a faster way of
  doing attention math. Speeds up long documents on most hardware.
- **`OLLAMA_DEBUG`** (`1` to enable): verbose logs, for when
  something breaks and you want to see why.

## Custom models: the Modelfile

A **Modelfile** is a small recipe that builds your own model variant
from an existing one: a different system prompt, different defaults,
a baked-in personality. Example:

```
FROM llama3.2:3b
PARAMETER temperature 0.2
SYSTEM "You are a terse shop assistant. Answer in ten words or less."
```

```
ollama create shop-helper -f ./Modelfile
ollama run shop-helper
```

Now `shop-helper` is a model in your library that always answers
short, with a cool head — no need to repeat the instructions every
chat. `ollama show shop-helper --modelfile` prints the recipe back.

## Front ends and utilities

Ollama's own terminal chat is fine, but most people put something
prettier in front of it. These all talk to the same Ollama server:

**Web chat (self-hosted, for the house):**

- **Open WebUI** — the most popular one. A ChatGPT-style page you
  run yourself: multiple chats, file uploads, image support, user
  accounts. If you want "ChatGPT but private and mine," start here.
- **LibreChat** — similar idea, also speaks to many model
  providers at once, not just Ollama.
- **AnythingLLM** — built around asking questions about *your*
  documents (RAG with a friendly face).

**Desktop apps:**

- **Ollama's own app** (Mac/Windows) — the official one, simple
  chat window.
- **Msty** — a polished desktop chat with prompt libraries and
  conversation branching.
- **Jan** — desktop chat that can also run models without Ollama.
- **Enchanted** (Mac/iPhone) — a native Apple-style chat for your
  Ollama server.
- **Alpaca** (Linux) — a simple GNOME chat app.

**For builders:**

- **`curl`** — raw API calls from scripts and the terminal (see
  the example above).
- **Ollama's Python and JavaScript libraries** — `pip install
  ollama`, then chat from a dozen lines of Python. Made for the
  API above.
- **The `/api/ps` endpoint** — shows loaded models as JSON, handy
  for status dashboards and monitoring scripts.

Pick the front end that matches the user: terminal for you, Open
WebUI for the family, the API for your own programs. They can all
share one Ollama server.

## Common use cases, and how each is done

**1. Chatting in the terminal.**
The 30-second start: `ollama pull` a model, `ollama run` it, type.
Best for quick questions while you work.

**2. A private ChatGPT for the household.**
Run Ollama on one always-on computer with `OLLAMA_HOST=0.0.0.0`,
install Open WebUI (it runs in Docker with one command), and point
it at the Ollama box. Everyone on the network gets a chat page; no
cloud subscription required for local inference. Use downloaded local
models and local integrations to keep prompts at home; cloud models,
search, or other external services can send data outside.

**3. Your own programs asking the model.**
Any script that can make a web request can use `/api/chat` — a
Python script that summarizes files, a dashboard that explains
alerts, a game with talking characters. Start from the `curl`
example and grow.

**4. Asking questions about your documents.**
That's [RAG](rag-and-embeddings.md): Ollama serves the embedding
model (`/api/embed`) and the chat model (`/api/chat`), and a
small program glues them to your files. AnythingLLM does the whole
thing with buttons instead of code.

**5. Code help without the cloud.**
Pull a coder model (`qwen2.5-coder`, `deepseek-coder-v2`,
`starcoder2`), `ollama run` it, and paste code in. Nothing you paste
needs to leave your machine when inference and all integrations are
local. Verify the selected model and front end before using private code.

**6. Trying many models cheaply.**
`ollama pull` five candidates, chat with each for ten minutes,
`ollama rm` the losers. Downloading is free and deleting is one
command, so experimenting costs nothing but disk space and time.

**7. One model, one job (Modelfiles).**
Bake the instructions into the model itself (see above): a
shop-helper that answers short, a summarizer locked to low
temperature, a character for a game. Then every chat starts
correctly with no setup.

## Where this fits

- [Running Models at Home](running-models-at-home.md) — hardware
  and performance: the other half of the Ollama story.
- [Choosing a Model](choosing-a-model.md) — which model to pull
  in the first place.
- [RAG and Embeddings](rag-and-embeddings.md) — your documents,
  answered by your models.
- [Glossary](glossary.md) — API, context window, quantization, and
  the rest, A to Z.

## Sources and verification

Examples checked against official documentation and Ollama CLI source on
October 10, 2026. They have not been executed on a Windows machine as
part of this review. Record your version with `ollama --version` when
reporting a problem; model behavior and defaults can change.

- [Ollama CLI](https://docs.ollama.com/cli)
- [CLI source and interactive commands](https://github.com/ollama/ollama/blob/main/cmd/interactive.go)
- [Modelfile parameters](https://docs.ollama.com/modelfile)
- [Chat API](https://docs.ollama.com/api/chat)
- [Embedding API](https://docs.ollama.com/api/embed)
