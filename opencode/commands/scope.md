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

Project: $ARGUMENTS
