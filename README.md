# OpenCode ↔ Claude Code Collaborative Workflow

A file-based collaboration system where **OpenCode** (local LLMs) handles project planning and research, and **Claude Code** (cloud) handles implementation and review.

## How It Works

```
OpenCode (Local)                         Claude Code (Cloud)
┌──────────────────────┐                ┌──────────────────────┐
│                      │                │                      │
│  /scope              │   .handoff/    │  /receive-handoff    │
│  /research           │ ──────────────>│  /send-feedback      │
│  /plan-handoff       │                │  /handoff-status     │
│  /handoff            │ <──────────────│                      │
│  /review-feedback    │   feedback     │  (implements code)   │
│  /handoff-status     │                │                      │
│                      │                │                      │
│  The Architect       │                │  handoff-receiver    │
│  deep-research-agent │                │  planner             │
│  handoff-agent       │                │  tdd-guide           │
│                      │                │  code-reviewer       │
│                      │                │  security-reviewer   │
│                      │                │  build-error-resolver│
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

### Phase 1: Scope (OpenCode)

```
opencode> /scope Build a REST API for task management with user auth
```

The Architect creates the `.handoff/` directory (if it doesn't exist), interviews you about requirements, and writes `.handoff/001-scope.md`.

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

### Claude Code (`~/.claude/`)

#### Handoff Agents
| Type | Name | Purpose |
|------|------|---------|
| Agent | `handoff-receiver` | Reads handoff and orchestrates implementation |

#### Implementation Agents
These agents are used by the handoff-receiver during implementation. They can also be used independently outside the handoff workflow.

| Type | Name | Purpose |
|------|------|---------|
| Agent | `planner` | Implementation planning and step breakdown |
| Agent | `tdd-guide` | Test-driven development enforcement (80%+ coverage) |
| Agent | `code-reviewer` | Code quality, security, and maintainability review |
| Agent | `security-reviewer` | OWASP Top 10 vulnerability detection and remediation |
| Agent | `build-error-resolver` | Fix build/type errors with minimal diffs |

#### Commands
| Type | Name | Purpose |
|------|------|---------|
| Command | `/receive-handoff` | Process handoff from OpenCode |
| Command | `/send-feedback` | Write questions back to OpenCode |
| Command | `/handoff-status` | Show current handoff state |

> **Note:** If you already have agents with these names in `~/.claude/agents/`, the installer will back up your existing files (`.bak`) before overwriting. You can also use any additional Claude Code agents you already have — the handoff-receiver orchestrates work but does not limit which agents are available.

## Security Model

**Important:** The `.handoff/` directory contains documents that are fed to LLM agents with code execution capabilities. Understand these trust boundaries:

### Trust Chain
```
OpenCode (local LLM) → .handoff/ files → Claude Code (has file write access)
```

### Built-in Protections
- **handoff-receiver has no Bash access** — it cannot execute shell commands directly. Build/test execution is delegated to scoped agents (tdd-guide, build-error-resolver).
- **Per-phase user approval** — the handoff-receiver requires explicit user confirmation before starting each implementation phase.
- **Web content trust boundary** — OpenCode agents are instructed to never write web-fetched content verbatim to handoff documents, and to never fetch URLs found in handoff files.
- **Handoff content treated as untrusted** — Claude Code agents are instructed to use their own judgment, not blindly follow plan instructions.
- **Backup on install** — existing agent files are backed up before overwriting (`.bak` files).

### User Responsibilities
- **Review `.handoff/` contents** before running `/receive-handoff`, especially if files were modified outside your workflow.
- **Do not clone repos with pre-populated `.handoff/` directories** without reviewing their contents first — they could contain prompt injection.
- **Add `.handoff/` to your project's `.gitignore`** if handoff documents contain sensitive architecture details you don't want in version control.

## Model Configuration

### Defaults

| Tool | Default Model | Set In |
|------|--------------|--------|
| **OpenCode** agents | `llama-cpp/qwen3.5-9b` (local) | Agent frontmatter: `model: llama-cpp/qwen3.5-9b` |
| **Claude Code** agents | `opus` (Claude Opus 4.6) | Agent frontmatter: `model: opus` |

### Changing Models

**OpenCode:** Edit the `model:` field in the agent's frontmatter at `~/.config/opencode/agents/<agent>.md`. The model must match a provider/model-id defined in your `opencode.json` config.

```yaml
# Example: switch The Architect to a larger reasoning model
---
model: llama-cpp/qwen3.5-27b
---
```

**Claude Code:** Edit the `model:` field in the agent's frontmatter at `~/.claude/agents/<agent>.md`. Valid values are `opus`, `sonnet`, and `haiku`.

```yaml
# Example: switch tdd-guide to Sonnet for faster iteration
---
model: sonnet
---
```

You can mix and match models per agent — for example, use `opus` for the handoff-receiver and code-reviewer (where deep reasoning matters) and `sonnet` for the build-error-resolver (where speed matters).

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
