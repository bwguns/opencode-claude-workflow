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

4. **If gaps exist**, write questions to `.handoff/004-feedback.md` and tell the user to return to OpenCode to address them:
   ```
   Questions written to .handoff/004-feedback.md

   Next step — switch to OpenCode and run:
     /review-feedback
   ```

5. **Once confirmed**, begin implementation following the plan:
   - Use TDD (tests first, then implementation)
   - Present each phase and wait for user approval before starting it
   - Update `.handoff/004-feedback.md` with progress after each phase
   - Document any deviations from the plan
   - After completing each phase, ask the user to confirm before moving to the next

6. **If you hit a blocker** during implementation that requires OpenCode input:
   ```
   Blocker written to .handoff/004-feedback.md

   Next step — switch to OpenCode and run:
     /review-feedback
   Then return here to continue.
   ```

7. **On completion**, update handoff.json, run code review, and tell the user:
   ```
   Implementation complete! All phases finished.

   Summary:
   - [list of what was built]
   - [test results]
   - [any deviations from plan]

   Code review has been run. Check the review output above for any issues to address.
   ```

## Workflow Continuity

- Work through each implementation phase one at a time. After each phase, present what was done and ask the user to confirm before proceeding to the next phase.
- Do NOT skip phases or auto-advance. Each phase needs explicit user approval.
- If the user wants changes to what was just implemented, make those changes before moving to the next phase.
- Always tell the user where they are in the workflow and what comes next.

Focus area: $ARGUMENTS
