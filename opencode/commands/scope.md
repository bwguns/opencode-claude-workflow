---
description: Scope a new project with The Architect before any implementation
agent: the-architect
---

I need to scope a new project before handing it off to Claude Code for implementation.

Follow your full scoping process:

1. Create the `.handoff/` directory if it doesn't exist, along with `handoff.json` and all template files (001-scope.md, 002-research.md, 003-plan.md, 004-feedback.md)
2. Interview me about the requirements — ask clarifying questions
3. Analyze the existing codebase if applicable
4. Define goals, non-goals, constraints, and acceptance criteria
5. Write the scope document to `.handoff/001-scope.md`
6. Update `.handoff/handoff.json` with the project name and timestamps
7. Present the scope for my review

Do NOT write any code. Focus entirely on understanding and documenting what needs to be built.

## Workflow Continuity

- Keep working on scoping until I confirm the scope is complete. If I have changes or additions, incorporate them and present the updated scope again.
- Do NOT consider this phase done until I explicitly approve the scope.
- Once I approve, tell me:

```
Scope complete! Next steps:
  /research <topic>   — Research technologies and approaches for this project
  /plan-handoff       — Skip research and go straight to planning (for simpler projects)
```

Project: $ARGUMENTS
