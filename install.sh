#!/bin/bash
# install.sh — Install OpenCode ↔ Claude Code collaborative workflow
#
# Usage:
#   ./install.sh              # Install both OpenCode and Claude Code components
#   ./install.sh opencode     # Install OpenCode components only
#   ./install.sh claude       # Install Claude Code components only

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect OS paths
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    OPENCODE_CONFIG="$USERPROFILE/.config/opencode"
    CLAUDE_CONFIG="$USERPROFILE/.claude"
else
    OPENCODE_CONFIG="$HOME/.config/opencode"
    CLAUDE_CONFIG="$HOME/.claude"
fi

install_opencode() {
    echo "=== Installing OpenCode components ==="

    mkdir -p "$OPENCODE_CONFIG/agents"
    mkdir -p "$OPENCODE_CONFIG/commands"

    # Agents
    echo "  Installing agents..."
    cp "$SCRIPT_DIR/opencode/agents/the-architect.md" "$OPENCODE_CONFIG/agents/"
    cp "$SCRIPT_DIR/opencode/agents/handoff-agent.md" "$OPENCODE_CONFIG/agents/"
    echo "    + the-architect.md"
    echo "    + handoff-agent.md"

    # Commands
    echo "  Installing commands..."
    cp "$SCRIPT_DIR/opencode/commands/scope.md" "$OPENCODE_CONFIG/commands/"
    cp "$SCRIPT_DIR/opencode/commands/research.md" "$OPENCODE_CONFIG/commands/"
    cp "$SCRIPT_DIR/opencode/commands/handoff.md" "$OPENCODE_CONFIG/commands/"
    cp "$SCRIPT_DIR/opencode/commands/plan-handoff.md" "$OPENCODE_CONFIG/commands/"
    cp "$SCRIPT_DIR/opencode/commands/review-feedback.md" "$OPENCODE_CONFIG/commands/"
    cp "$SCRIPT_DIR/opencode/commands/handoff-status.md" "$OPENCODE_CONFIG/commands/"
    cp "$SCRIPT_DIR/opencode/commands/init-handoff.md" "$OPENCODE_CONFIG/commands/"
    echo "    + /scope"
    echo "    + /research"
    echo "    + /handoff"
    echo "    + /plan-handoff"
    echo "    + /review-feedback"
    echo "    + /handoff-status"
    echo "    + /init-handoff"

    # Enhance deep-research-agent
    # Enhance deep-research-agent (idempotent)
    RESEARCH_AGENT="$OPENCODE_CONFIG/agents/deep-research-agent.md"
    if [ -f "$RESEARCH_AGENT" ]; then
        if ! grep -q "Handoff Integration" "$RESEARCH_AGENT" 2>/dev/null; then
            echo "  Appending handoff integration to deep-research-agent..."
            # Extract only the content section (skip the instruction header)
            sed -n '/^## Handoff Integration$/,$p' "$SCRIPT_DIR/opencode/agents/deep-research-agent-additions.md" >> "$RESEARCH_AGENT"
            echo "    + deep-research-agent handoff integration"
        else
            echo "  deep-research-agent already has handoff integration (skipped)"
        fi
    else
        echo ""
        echo "  NOTE: deep-research-agent.md not found at $RESEARCH_AGENT"
        echo "  Create it first, then re-run install to add handoff support."
        echo ""
    fi

    echo "  OpenCode installation complete."
}

install_claude_code() {
    echo "=== Installing Claude Code components ==="

    # Agent
    mkdir -p "$CLAUDE_CONFIG/agents"
    echo "  Installing agents..."
    cp "$SCRIPT_DIR/claude-code/agents/handoff-receiver.md" "$CLAUDE_CONFIG/agents/"
    echo "    + handoff-receiver.md"

    # Commands
    mkdir -p "$CLAUDE_CONFIG/commands"
    echo "  Installing commands..."
    cp "$SCRIPT_DIR/claude-code/commands/receive-handoff.md" "$CLAUDE_CONFIG/commands/"
    cp "$SCRIPT_DIR/claude-code/commands/send-feedback.md" "$CLAUDE_CONFIG/commands/"
    cp "$SCRIPT_DIR/claude-code/commands/handoff-status.md" "$CLAUDE_CONFIG/commands/"
    echo "    + /receive-handoff"
    echo "    + /send-feedback"
    echo "    + /handoff-status"

    echo "  Claude Code installation complete."
}

install_templates() {
    echo "=== Installing handoff templates ==="
    echo "  Templates are in: $SCRIPT_DIR/handoff/templates/"
    echo "  Copy .handoff/ to your project root to start a new handoff:"
    echo ""
    echo "    cp -r $SCRIPT_DIR/handoff/templates/ ./your-project/.handoff/"
    echo "    cp $SCRIPT_DIR/handoff/handoff.json ./your-project/.handoff/"
    echo ""
}

# Main
echo ""
echo "OpenCode <-> Claude Code Collaborative Workflow Installer"
echo "========================================================="
echo ""

case "${1:-all}" in
    opencode)
        install_opencode
        ;;
    claude-code|claude)
        install_claude_code
        ;;
    all)
        install_opencode
        echo ""
        install_claude_code
        echo ""
        install_templates
        ;;
    *)
        echo "Usage: $0 [opencode|claude-code|all]"
        exit 1
        ;;
esac

echo ""
echo "Done! See README.md for workflow usage."
echo ""
