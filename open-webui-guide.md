# Open WebUI, In Depth

[Open WebUI](https://openwebui.com) is the pretty face most people
put in front of [Ollama](ollama-guide.md). It gives you a
ChatGPT-style web page — chats, file uploads, voice, user accounts —
while the models themselves run on your own machines. This guide
covers installing it, everything it can do, the settings that matter,
and what people actually use it for.

## What Open WebUI is, in one paragraph

Ollama is the engine; Open WebUI is the dashboard. Ollama runs the
models and answers questions through its API. Open WebUI is a web
site you run yourself that talks to that API and gives you (and your
family, or your team) a friendly chat page. One Open WebUI can talk
to one Ollama, several Ollamas, or even paid services like OpenAI —
and it adds things Ollama alone doesn't have: saved chats, document
libraries, user accounts, and add-ons.

## Installing it

The normal way is **Docker** — a tool that runs programs in sealed
boxes called containers, so installation is one command and cleanup
is easy. Install Docker first (from [docker.com](https://docker.com)),
then pick your situation. Commands below are single lines that work in
PowerShell or Bash; paste each entire line. Start Docker Desktop first on
Windows and check `docker version` shows both Client and Server.

Before starting the container, generate a secret in PowerShell:

```powershell
$webuiSecretBytes = New-Object byte[] 32
$webuiSecretGenerator = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$webuiSecretGenerator.GetBytes($webuiSecretBytes)
$webuiSecretGenerator.Dispose()
$webuiSecret = [System.BitConverter]::ToString($webuiSecretBytes).Replace('-', '').ToLowerInvariant()
```

Keep this value private and reuse it when recreating the container. In
Bash, set `webuiSecret=$(openssl rand -hex 32)` instead. Both shells expand
`$webuiSecret` in the commands below.

**Ollama is on the same computer:**

```powershell
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data -e WEBUI_SECRET_KEY=$webuiSecret --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

**Ollama is on another computer** (your home server, say):

```powershell
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://192.168.1.50:11434 -v open-webui:/app/backend/data -e WEBUI_SECRET_KEY=$webuiSecret --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

(Replace the address with your Ollama machine's. The `-e` part sets
an environment variable — a setting handed to the program at
startup.)

**Everything in one box** (Open WebUI *and* Ollama together):

```powershell
docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data -e WEBUI_SECRET_KEY=$webuiSecret --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
```

Then open `http://localhost:3000` in your browser (or
`http://<that-computer>:3000` from another device). The first account
you create becomes the **admin** — the boss account that manages
everyone else.

What the flags mean, briefly: `-d` runs it in the background, `-p
3000:8080` maps the web page to port 3000, `-v` saves its data so it
survives restarts, and `--restart always` brings it back up if the
computer reboots.

## First run: connecting to Ollama

If Ollama wasn't auto-detected: click your profile icon (bottom
left), go to **Admin Panel → Settings → Connections**, and add your
Ollama's address (for example `http://192.168.1.50:11434`). Click the
refresh icon and your models appear. From then on, the model picker
at the top of every chat lists everything Ollama has.

## Everyday chatting

It works like you'd expect: type, get an answer. The extras worth
knowing:

- **Model picker** — switch models mid-conversation from the
  dropdown at the top. Good for "ask the small fast one first, the
  big smart one when it matters."
- **Multiple models at once** — pick two or more and each answers
  side by side. Handy for comparing.
- **Chat controls** (the sliders icon) — temperature, context
  length, and the other [model options](ollama-guide.md#settings-that-change-how-a-model-behaves),
  per conversation, no command line needed.
- **Branching** — edit any of your messages and the chat forks from
  there; the original stays intact. Great for "what if I'd asked it
  differently."
- **File upload** (the **+** button) — attach PDFs, text files, or
  images to a chat and ask about them.
- **Voice** — the microphone button talks, the speaker button reads
  answers aloud.
- **Chat history** — every conversation is saved and searchable,
  including *semantic* search: "find the chat where we discussed
  the water heater" works even if those exact words never appeared.
- **Share** — turn any chat into a link others can read.

## The Workspace: your reusable pieces

The **Workspace** (left sidebar) holds things you build once and
reuse. Four kinds:

- **Models** — saved assistants: a model plus a fixed system prompt
  and settings. "Shop Helper: answers in ten words or less, always
  polite." One click to create, then it sits in your model picker
  like any other. (Same idea as Ollama's
  [Modelfile](ollama-guide.md#custom-models-the-modelfile), with
  buttons instead of a text file.)
- **Prompts** — reusable text snippets. Type `/` in any chat and
  pick one: your standard "summarize this meeting" instruction, for
  example. No more retyping.
- **Documents** — your file library: PDFs, manuals, notes. Upload
  once here instead of attaching to every chat. (More below.)
- **Knowledge** — bundles of documents treated as one unit: "all
  the appliance manuals," "the club's bylaws and minutes." Attach a
  knowledge base to a chat or a Workspace Model and the model can
  pull answers from it.

## Asking about your documents (RAG)

This is the feature that sells Open WebUI: chat with your own files.
The plain-words version of [RAG](rag-and-embeddings.md):

1. **Workspace → Documents → upload** your files (PDF, TXT, DOCX,
   Markdown, and more).
2. Open WebUI automatically chops them up and files them for
   search, using a small embedding model. If it asks you to pull
   one first, run `ollama pull nomic-embed-text` on your Ollama
   machine — it's the good default.
3. In any chat, click **+** and choose your documents (or a whole
   Knowledge base).
4. Ask. The model reads the relevant pages and answers from them,
   usually quoting which file each fact came from.

For better answers on technical documents: **Admin Panel →
Settings → Documents** lets you tune the chunk size (how big each
file piece is) and pick the embedding model. Smaller chunks =
precise answers; larger chunks = more context per answer.

## Web search

Models only know what they were trained on — nothing after their
cutoff date. Open WebUI can let them **search the web** mid-chat:
**Admin Panel → Settings → Web Search** turns it on (it uses a
search engine of your choice; some need a free API key). Then the
model can check today's weather, look up a price, or read a fresh
article before answering. You'll see it pause, search, and then
answer with the new facts included.

## Functions: the add-on system

**Functions** are small Python programs that plug into Open WebUI
and change what it can do. Three kinds:

- **Pipes** — whole new model entries that run custom code: a
  "model" that is really a multi-step workflow (search the web,
  then summarize, then answer), or a bridge to another service.
- **Filters** — code that runs before or after every message:
  logging chats to a file, counting tokens, blocking certain words,
  adding the current date to every prompt.
- **Actions** — buttons under a message: "summarize this,"
  "translate to Spanish," "save to notes."

Install them from **Admin Panel → Functions** (paste the code, set
any needed keys, turn it on). There's a community library of shared
functions — web search tools, token counters, integrations with
automation tools. You don't need to write code to use them; you only
need code if you want to build your own.

## Admin: users, models, and settings

The first account is the admin. **Admin Panel** covers:

- **Users** — invite people, approve sign-ups, set roles (admin,
  user, pending). Each person's chats are private to them.
- **Settings → Models** — which models appear, their default
  options, and pull new Ollama models straight from the web UI (no
  terminal needed).
- **Settings → Documents** — the RAG tuning mentioned above.
- **Settings → Web Search** — search providers and keys.
- **Settings → Audio** — voice input/output options.
- **Functions** — the add-ons above.
- **Evaluations** — run test prompts against models and compare
  scores, for the curious.

**Sign-ups:** by default anyone who reaches the page can create an
account and land in your lap as "pending." For a family server that's
fine; for anything facing the internet, turn off open registration
(**Admin Panel → Settings → General**) or require admin approval.

## Settings that matter (environment variables)

Like Ollama, Open WebUI takes settings at startup with `-e`:

- **`OLLAMA_BASE_URL`** — where your Ollama lives. The single most
  important one when they're on different machines.
- **`WEBUI_AUTH`** (`True`/`False`, default `True`) — the login
  page. Turning it off means anyone with the address walks in; only
  do that behind your own locked-down network, if ever.
- **`WEBUI_SECRET_KEY`** — a persistent secret used for authentication and
  encryption. Set it before the first start and retain it for updates.
- **`DATA_DIR`** — where Open WebUI keeps its database and uploads.
  Point it at a big disk if you'll store many documents.
- **`PORT`** — the inside-the-container port (default 8080); you
  almost always leave this and just remap with `-p`.

## Its own API

Open WebUI also speaks the **OpenAI API format**: other programs can
treat it as a backend. Point any OpenAI-compatible tool at
`http://<open-webui>:3000/api` with an API key from **Settings →
Account**, and it can use your local models through Open WebUI's
front door — including its RAG and functions. One key detail this
buys you: tools that only know how to talk to OpenAI can now talk to
your home models.

## Common use cases, and how each is done

**1. A private ChatGPT for the house.**
Ollama on the always-on computer, Open WebUI in Docker on the same
or another box, everyone bookmarks `http://<computer>:3000`. No
accounts elsewhere, no subscription, nothing leaves the house.

**2. Asking about your own files.**
Upload the appliance manuals / club bylaws / tax records to
Workspace → Documents (or bundle them as Knowledge), attach them in
chat, ask away. The classic "where did I put that fact" solver.

**3. A safe sandbox for kids or guests.**
User accounts with no admin rights, a small fast model as the
default, web search off. They get AI help; you get no surprise cloud
bills and no data leaving home.

**4. A writing and brainstorming desk.**
Branching chats + saved Prompts (`/summarize`, `/formal-email`,
`/story-idea`) + voice input. The workflow people pay monthly for,
running on your shelf.

**5. A research assistant with fresh facts.**
Web search on + a big context model: "compare these three laptops
using current prices." The model searches, reads, and cites.

**6. Automations through Functions.**
A Filter that appends today's date to every prompt; an Action button
that files a chat summary to your notes; a Pipe that routes simple
questions to the fast model and hard ones to the big one.

**7. A backend for your own tools.**
Anything that speaks OpenAI's API format can point at Open WebUI
instead — your scripts, your phone apps — and ride on your local
models, RAG included.

## Where this fits

- [Ollama, In Depth](ollama-guide.md) — the engine underneath:
  commands, settings, and its own API.
- [Running Models at Home](running-models-at-home.md) — hardware
  and performance.
- [RAG and Embeddings](rag-and-embeddings.md) — the technique
  behind "chat with your documents."
- [Choosing a Model](choosing-a-model.md) — which model to pull
  for each job.
- [Glossary](glossary.md) — API, RAG, Docker, and the rest, A to Z.

## Sources and verification

Docker examples checked against the [official quick start](https://docs.openwebui.com/getting-started/quick-start/)
on October 10, 2026; not executed in this review. The `:main` and
`:ollama` tags change over time. For repeatable deployments, select a
release tag from the official project and record it with your setup.
