---
description: Create an implementation plan based on scope and research for Claude Code
agent: the-architect
---

Create a detailed implementation plan based on the existing scope and research.

1. Read `.handoff/001-scope.md` for requirements and acceptance criteria
2. Read `.handoff/002-research.md` for technology decisions and findings (if it exists)
3. Analyze the existing codebase for patterns, conventions, and integration points
4. Create a phased implementation plan with:
   - Concrete steps with file paths where possible
   - Dependencies between phases
   - Testing strategy (unit, integration, E2E)
   - Risks and mitigations
   - Notes for Claude Code (gotchas, conventions to follow)
5. Write the plan to `.handoff/003-plan.md`
6. Update `.handoff/handoff.json` to set plan status to "complete"
7. Present the plan for my review

Use this frontmatter:
```yaml
---
id: "003"
type: plan
author: opencode
status: ready
created: <current datetime>
updated: <current datetime>
---
```

Do NOT write any implementation code. Focus on planning.

## Workflow Continuity

- If I want changes to the plan (different phases, different approach, add/remove steps), update the plan and present it again.
- Do NOT consider this phase done until I explicitly approve the plan.
- Once I approve, tell me:

```
Plan complete! Next step:
  /handoff   — Validate and finalize the handoff package for Claude Code
```

Additional context: $ARGUMENTS
