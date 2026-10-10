# When Should You Trust an AI Answer?

An AI answer can be useful without being correct in every detail.
The amount of checking it needs depends on what you will do with it
and what a mistake would cost.

## Confidence is a writing style

A language model can produce a smooth explanation of something that
never happened. Incorrect or fabricated assertions are often called
**hallucinations** or **confabulations**. They can include citations as
well as ordinary facts. NIST discusses these risks in its
[Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf).

“I'm certain,” a detailed explanation, and a confidence percentage are
all parts of the generated answer. None establishes that the answer
was checked. A model saying “95% confident” is not automatically a
measured 95% chance of being right.

Lower [temperature](how-llms-work.md#the-three-knobs-youll-actually-touch)
doesn't turn the model into a fact checker, either. It can make the
same mistake more consistently.

## Match the check to the task

| What you're doing | A useful check |
| --- | --- |
| Brainstorming names or story ideas | Decide whether they suit your purpose; check factual claims if you use them. |
| Rewriting your own text | Compare the original and revision for changed meaning, promises, names, and dates. |
| Summarizing a document | Find the passages supporting the main claims and look for important omissions. |
| Getting a factual explanation | Check the important claims against reliable sources, including dates and scope. |
| Calculating or writing code | Recalculate with a suitable tool; run code in an appropriate test environment. |
| Making a consequential decision | Use authoritative evidence and qualified human judgment appropriate to the decision. |

For an invitation draft, checking the date and wording may be enough.
For a command that deletes files, understand its target and effects
before running it. The cost of a wrong answer sets the checking effort.

## Open the source

A citation gives you somewhere to look. Open it and ask:

1. Does the source exist, and is it the document the answer describes?
2. Does it actually support this claim, including the conditions or exceptions?
3. Is it current enough and relevant to my version, place, or situation?

For example, an answer says a club allows guests at every meeting.
The cited bylaws might allow guests only at public meetings. The source
exists, but the answer lost the qualification.

Prefer the original manual, research paper, dataset, or responsible
organization when available. A summary can help you find it; read the
relevant part yourself before relying on it.

## Documents and search help, but still need checking

Giving a model your document supplies evidence it may otherwise lack.
[RAG](rag-and-embeddings.md) retrieves passages for the same purpose.
The system can retrieve the wrong passage, miss an important one, or
misstate what it found. Web search can supply current information, but
the selected page can itself be wrong or outdated.

Try this when asking about a document:

> Answer from the supplied document. Identify the section supporting
> each main claim. If it doesn't contain the answer, say what's missing.

Then check those sections. This request makes the answer easier to
inspect; it doesn't guarantee that the model will obey it.

## Watch for agreement without evidence

A leading question can carry an unsupported premise. Instead of
“Explain why our plan is best,” ask “Compare these plans against these
criteria; include disadvantages and missing information.”

If you challenge an answer, a changed response isn't proof of a correction.
Ask what evidence supports the change. Likewise, agreement from a second
model is a clue to investigate, not an independent source: both may
repeat the same mistaken claim.

You can still get value from an uncertain answer. Use it to generate
questions, identify assumptions, or locate things to check. Make your
decision from the evidence you can verify.

Related: [Getting Useful Help from AI](getting-useful-help.md) and
[How LLMs Work](how-llms-work.md).

## Sources and review

Reviewed October 10, 2026. The club example is fictional. The checking
suggestions are practical guidance, not a reliability score for any model.

- [NIST: Generative AI Profile, especially confabulation and information integrity](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf)
- [Hugging Face: text generation and sampling](https://huggingface.co/docs/transformers/main/en/llm_tutorial)
- [Open WebUI: retrieval and document context](https://docs.openwebui.com/features/chat-conversations/rag/)
