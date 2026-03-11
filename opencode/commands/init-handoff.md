---
description: Initialize the .handoff directory in the current project
---

Initialize the `.handoff/` directory for a new OpenCode → Claude Code workflow.

1. Create the `.handoff/` directory if it doesn't exist
2. Copy the handoff templates:
   - `.handoff/handoff.json` (metadata)
   - `.handoff/001-scope.md` (scope template)
   - `.handoff/002-research.md` (research template)
   - `.handoff/003-plan.md` (plan template)
   - `.handoff/004-feedback.md` (feedback template)
3. Set the project name in handoff.json to the current directory name
4. Set created/updated timestamps to now

After initialization, run `/scope` to begin the scoping phase.

$ARGUMENTS
