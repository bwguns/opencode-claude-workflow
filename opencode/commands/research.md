---
description: Research technologies, patterns, and solutions for the current project
agent: deep-research-agent
---

Research the following topic for the current project. Your findings will be used by Claude Code during implementation.

Follow your full research process and write findings to `.handoff/002-research.md`.

Use this frontmatter at the top of the file:
```yaml
---
id: "002"
type: research
author: opencode
status: ready
created: <current datetime>
updated: <current datetime>
---
```

Include:
1. Research questions investigated
2. Findings with sources and citations
3. Technology recommendations with rationale
4. Existing solutions / prior art
5. Knowledge gaps that need further investigation
6. How findings impact the project scope

After writing the research file, update `.handoff/handoff.json` to set the research phase status to "complete".

IMPORTANT: Follow all hallucination prevention rules. Only report what you actually find. Cite every source.

## Workflow Continuity

- If I ask follow-up questions or want deeper research on a subtopic, continue researching and update the research document.
- Do NOT consider this phase done until I confirm the research is sufficient.
- Once I confirm, tell me:

```
Research complete! Next step:
  /plan-handoff   — Create the implementation plan based on scope and research
```

Research topic: $ARGUMENTS

If no topic given, read `.handoff/001-scope.md` and research the technologies and approaches needed for that scope.
