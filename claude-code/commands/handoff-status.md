---
description: Show the current state of the OpenCode-Claude Code handoff
---

# Handoff Status

Read and display the current state of the project handoff.

## Steps

1. Read `.handoff/handoff.json` for metadata
2. Read frontmatter from each handoff document:
   - `001-scope.md`
   - `002-research.md`
   - `003-plan.md`
   - `004-feedback.md`
3. Present a status dashboard:

```
## Handoff Status

| Phase          | Status   | Owner      | Last Updated |
|----------------|----------|------------|--------------|
| Scope          | ...      | opencode   | ...          |
| Research       | ...      | opencode   | ...          |
| Plan           | ...      | opencode   | ...          |
| Feedback       | ...      | ...        | ...          |
| Implementation | ...      | claude-code| ...          |
| Review         | ...      | claude-code| ...          |

**Current Phase:** ...
**Current Owner:** ...
```

4. If there are open questions in feedback, highlight them
5. Suggest the appropriate next action based on current state

$ARGUMENTS
