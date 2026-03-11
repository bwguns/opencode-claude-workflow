# OpenCode ↔ Claude Code Collaborative Workflow

A file-based collaboration system where **OpenCode** (local LLMs) handles project planning and research, and **Claude Code** (cloud) handles implementation and review.

## How It Works

```
OpenCode (Local)                         Claude Code (Cloud)
┌──────────────────────┐                ┌──────────────────────┐
│                      │                │                      │
│  /init-handoff       │   .handoff/    │  /receive-handoff    │
│  /scope              │ ──────────────>│  /send-feedback      │
│  /research           │                │  /handoff-status     │
│  /plan-handoff       │ <──────────────│                      │
│  /handoff            │   feedback     │  (implements code)   │
│  /review-feedback    │                │                      │
│  /handoff-status     │                │                      │
│                      │                │                      │
│  The Architect       │                │  handoff-receiver    │
│  deep-research-agent │                │  + existing agents   │
│  handoff-agent       │                │                      │
└──────────────────────┘                └──────────────────────┘
```

## Installation

```bash
git clone https://github.com/bwguns/opencode-claude-workflow.git
cd opencode-claude-workflow
./install.sh          # Install both sides
./install.sh opencode # OpenCode only
./install.sh claude   # Claude Code only
```

The installer copies all agents and commands to the correct config directories. No additional configuration required.

## Workflow

### Phase 0: Initialize (OpenCode)

```
opencode> /init-handoff
```

Creates the `.handoff/` directory with templates in your project root.

### Phase 1: Scope (OpenCode)

```
opencode> /scope Build a REST API for task management with user auth
```

The Architect interviews you, analyzes the codebase, and writes `.handoff/001-scope.md`.

### Phase 2: Research (OpenCode)

```
opencode> /research Best auth libraries for Node.js, database options, API patterns
```

The deep-research-agent investigates and writes `.handoff/002-research.md` with cited sources.

### Phase 3: Plan (OpenCode)

```
opencode> /plan-handoff
```

The Architect reads scope + research, designs the architecture, and writes `.handoff/003-plan.md`.

### Phase 4: Validate & Handoff (OpenCode)

```
opencode> /handoff
```

The handoff-agent validates all documents are complete, updates statuses, and tells you to switch to Claude Code.

### Phase 5: Implement (Claude Code)

```
claude> /receive-handoff
```

Claude Code reads all `.handoff/` documents, presents a summary, and implements the plan using TDD.

### Phase 6: Feedback Loop (if needed)

If Claude Code has questions:
```
claude> /send-feedback Need clarification on auth token refresh strategy
```

Switch back to OpenCode:
```
opencode> /review-feedback
```

Then return to Claude Code to continue.

### Phase 7: Check Status (either tool)

```
opencode> /handoff-status
claude> /handoff-status
```

## File Structure

```
your-project/
├── .handoff/
│   ├── handoff.json          # Metadata: phase, owner, timestamps
│   ├── 001-scope.md          # Requirements and acceptance criteria
│   ├── 002-research.md       # Research findings with sources
│   ├── 003-plan.md           # Implementation plan with phases
│   └── 004-feedback.md       # Questions and progress updates
├── src/                      # Your project code
└── ...
```

## Handoff Document Lifecycle

| Phase | Author | Status Flow |
|-------|--------|-------------|
| Scope | OpenCode | draft → ready |
| Research | OpenCode | draft → ready |
| Plan | OpenCode | draft → ready |
| Implementation | Claude Code | ready → in-progress → complete |
| Feedback | Either | draft → needs-clarification → ready |

## What Gets Installed

### OpenCode (`~/.config/opencode/`)

| Type | Name | Purpose |
|------|------|---------|
| Agent | `the-architect` | Project scoping and architecture |
| Agent | `handoff-agent` | Validates and finalizes handoff |
| Agent | `deep-research-agent` | Web research with handoff integration |
| Command | `/scope` | Start project scoping |
| Command | `/research` | Investigate technologies and patterns |
| Command | `/plan-handoff` | Create implementation plan |
| Command | `/handoff` | Validate and finalize for Claude Code |
| Command | `/review-feedback` | Address Claude Code's questions |
| Command | `/handoff-status` | Check current handoff state |
| Command | `/init-handoff` | Initialize .handoff/ in project |

### Claude Code (`~/.claude/`)

| Type | Name | Purpose |
|------|------|---------|
| Agent | `handoff-receiver` | Reads handoff and orchestrates implementation |
| Agent | `planner` | Implementation planning and step breakdown |
| Agent | `tdd-guide` | Test-driven development enforcement |
| Agent | `code-reviewer` | Code quality and security review |
| Agent | `security-reviewer` | OWASP Top 10 vulnerability detection |
| Agent | `build-error-resolver` | Fix build/type errors with minimal diffs |
| Command | `/receive-handoff` | Process handoff from OpenCode |
| Command | `/send-feedback` | Write questions back to OpenCode |
| Command | `/handoff-status` | Show current handoff state |

## Requirements

- **OpenCode** with a local LLM (llama.cpp, Ollama, LM Studio, etc.)
- **Claude Code** CLI installed and authenticated
- Both tools must have access to the same project directory

## Tips

- Run `/handoff-status` before switching tools to check current state
- The `.handoff/` directory should be committed to git for history tracking
- Add `.handoff/` to your PR description so reviewers have context
- Research is optional — skip directly to `/plan-handoff` for simpler projects

## License

MIT
