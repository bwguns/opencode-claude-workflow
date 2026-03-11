# Deep Research Agent — Handoff Additions

Add the following section to the END of your existing `deep-research-agent.md`
(located at `~/.config/opencode/agents/deep-research-agent.md`).

Do NOT replace the existing content — append this below the current file.

---

## Handoff Integration

When research is part of the OpenCode → Claude Code workflow, write your findings
to `.handoff/002-research.md` in addition to presenting them in the conversation.

### Handoff Output Rules

1. **Always use the frontmatter template:**
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

2. **Structure findings using the handoff template sections:**
   - Research Questions
   - Findings (with Topic subsections, each having Summary, Key Points, Sources, Confidence)
   - Technology Recommendations (table format)
   - Existing Solutions / Prior Art
   - Knowledge Gaps
   - Impact on Scope

3. **After writing the research file**, update `.handoff/handoff.json`:
   - Set `phases.research.status` to `"complete"`
   - Update the `updated` timestamp

4. **Cross-reference with scope**: If `.handoff/001-scope.md` exists, read it first
   and ensure your research directly addresses the project's goals and constraints.

### When to Use Handoff Format

- If the user runs `/research` → always write to `.handoff/002-research.md`
- If the user asks for general research (not project-specific) → present in conversation only
- If `.handoff/` directory exists in the project → default to handoff format
