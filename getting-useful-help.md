# Getting Useful Help from AI

You don't need a secret phrase to get useful help from a chatbot.
Start by explaining what you're trying to accomplish, then work with
the answer. This applies whether you use a hosted service or a model
running on your own computer.

## Give it a useful brief

A **prompt** is the request you give the AI. Clear instructions and
examples can help it produce the kind of answer you want. See
[Anthropic's prompting guidance](https://www.anthropic.com/news/prompt-engineering-for-business-performance)
for the same principle in practice.

For everyday tasks, include whatever matters from these four things:

- **Goal:** what you want to accomplish.
- **Context:** facts the answer needs, including who it's for.
- **Constraints:** limits such as length, budget, tone, or available tools.
- **Result:** the form you want back, such as a draft, comparison, or explanation.

You can start small. “Explain this paragraph in everyday language” is
a perfectly useful request when you supply the paragraph.

## A before-and-after example

“Write an email” leaves most of the decisions to the model. Try:

> Draft a friendly email to our book club. We're moving the meeting
> from Tuesday to Thursday, still at 7 p.m. at the library. Keep it
> under 100 words. Ask members to reply if they can't attend. Leave
> out the calendar date because I haven't confirmed it yet.

That brief gives you something you can judge. Did it preserve the time
and place? Did it invent a date? Would you actually send it?

An example of your own writing can also help when tone matters. Remove
private information before sharing it, and explain what you like about
the example: “Use short sentences and this friendly opening.”

## Work in small rounds

Treat the first answer as something to work with. Useful follow-ups are
specific: “Keep the opening, shorten the middle, and remove the sales
language” gives a clearer direction than “Make it better.”

For a complicated task, ask for an outline before a full draft. For a
decision, explain your criteria and ask for tradeoffs. If essential
information is missing, invite a question:

> Before suggesting a plan, ask me about anything that would materially
> change your recommendation. Otherwise, state your assumptions.

Read those assumptions. An answer built around the wrong audience or
budget can be polished and still be useless.

## Supply the material it needs

If you're asking about a letter, manual, or spreadsheet, give it the
relevant material rather than expecting it to guess. Make the boundary
clear: “Summarize the attached letter; flag anything it doesn't specify.”
For larger collections, see [RAG and Embeddings](rag-and-embeddings.md).

Check what your app can actually access. A pasted filename doesn't
necessarily give it the file. A request to search the web doesn't ensure
that browsing is available or that a search happened. Look for the
sources, tool results, or attached content the app provides.

Avoid including passwords or unnecessary personal details. If you use
private documents, check where the selected model and integrations send
them; [Open WebUI's privacy explanation](open-webui-guide.md#when-does-data-stay-at-home)
also applies to the idea of connecting a local interface to outside services.

## Know when to change approach

If repeated revisions aren't helping, identify the failure. Does the
model lack a source? Is the task too broad? Does the calculation belong
in a spreadsheet? Would an ordinary search get you to the original answer?
More elaborate wording won't supply missing evidence.

Save prompts that work, then adjust them for the next task. Compare
results against your goal. Asking the AI to critique its answer can
suggest revisions, but checking its own work is not independent verification.

Next: [When Should You Trust an AI Answer?](trusting-ai-answers.md)

## Sources and review

Reviewed October 10, 2026. Examples are illustrative prompts, not measured
comparisons of models or promises of a particular response.

- [Anthropic: clear instructions, examples, and iteration](https://www.anthropic.com/news/prompt-engineering-for-business-performance)
- [RAG and document context in Open WebUI](https://docs.openwebui.com/features/chat-conversations/rag/)
