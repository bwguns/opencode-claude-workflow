---
description: Write feedback or questions back to OpenCode via .handoff/004-feedback.md
---

# Send Feedback to OpenCode

Write implementation feedback, questions, or blockers to `.handoff/004-feedback.md` so OpenCode can review and respond.

## Steps

1. Read the current `.handoff/004-feedback.md` if it exists (preserve existing content)
2. Append new feedback under the appropriate section:
   - **Questions** — things that need clarification from OpenCode
   - **Decisions Made** — implementation choices you made and why
   - **Deviations** — where you departed from the plan
   - **Blockers** — anything preventing progress
   - **Progress** — what's been completed
3. Update the frontmatter:
   - Set `author: claude-code`
   - Set `status` to `needs-clarification` (if questions) or `in-progress` (if just updates)
   - Update the `updated` timestamp
4. Update `.handoff/handoff.json` timestamp

## Workflow Continuity

- After writing the feedback, tell the user:

```
Feedback written to .handoff/004-feedback.md

Next step — switch to OpenCode and run:
  /review-feedback

Once feedback is addressed, return here to continue implementation.
```

Feedback: $ARGUMENTS
