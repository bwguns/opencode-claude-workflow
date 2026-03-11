---
description: Show the current state of the OpenCode-Claude Code handoff
agent: handoff-agent
---

Read and display the current state of the project handoff.

1. Read `.handoff/handoff.json` for metadata
2. Read frontmatter from each handoff document (001-scope.md, 002-research.md, 003-plan.md, 004-feedback.md)
3. Present a status dashboard showing each phase, its status, owner, and last update
4. If there are open questions in feedback, highlight them
5. Suggest the appropriate next action based on current state

$ARGUMENTS
