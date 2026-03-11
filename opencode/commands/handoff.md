---
description: Finalize and validate the handoff package for Claude Code
agent: handoff-agent
---

Validate and finalize the `.handoff/` directory for Claude Code pickup.

1. Read all handoff documents (001-scope.md, 002-research.md, 003-plan.md)
2. Validate completeness — check for gaps, missing info, ambiguity
3. Verify all frontmatter is correct
4. Update statuses to "ready" if everything checks out
5. Update handoff.json with current_phase: "implementation" and owner: "claude-code"
6. Present the handoff summary to me

If $ARGUMENTS contains "force", skip gap warnings and finalize anyway.
If $ARGUMENTS contains "status", just show current handoff state without finalizing.

$ARGUMENTS
