---
description: Receive and process a project handoff from OpenCode. Reads .handoff/ directory, validates completeness, and begins implementation.
---

# Receive Handoff

Read the `.handoff/` directory in this project and process the handoff from OpenCode.

## Steps

1. **Read all handoff documents** in `.handoff/`:
   - `handoff.json` — metadata and current phase
   - `001-scope.md` — project requirements and acceptance criteria
   - `002-research.md` — research findings and technology decisions
   - `003-plan.md` — implementation plan with phases and steps
   - `004-feedback.md` — any prior feedback or questions

2. **Validate** the handoff is complete and ownership is transferred to claude-code

3. **Present a summary** of what was planned and ask for confirmation before implementing

4. **If gaps exist**, write questions to `.handoff/004-feedback.md` and tell the user to return to OpenCode to address them

5. **Once confirmed**, begin implementation following the plan:
   - Use TDD (tests first, then implementation)
   - Follow the phases in order
   - Update `.handoff/004-feedback.md` with progress after each phase
   - Document any deviations from the plan

6. **On completion**, update handoff.json and run code review

Focus area: $ARGUMENTS
