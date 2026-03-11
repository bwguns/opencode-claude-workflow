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
    OPENCODE_CONFIG="${USERPROFILE:?USERPROFILE not set}/.config/opencode"
    CLAUDE_CONFIG="${USERPROFILE}/.claude"
else
    OPENCODE_CONFIG="${HOME:?HOME not set}/.config/opencode"
    CLAUDE_CONFIG="${HOME}/.claude"
fi

# Back up a file before overwriting (only if it exists and differs)
safe_copy() {
    local src="$1" dest="$2"
    if [[ -f "$dest" ]] && ! cmp -s "$src" "$dest" 2>/dev/null; then
        cp "$dest" "$dest.bak"
        echo "    (backed up existing $(basename "$dest"))"
    fi
    cp "$src" "$dest"
}

install_opencode() {
    echo "=== Installing OpenCode components ==="

    mkdir -p "$OPENCODE_CONFIG/agents"
    mkdir -p "$OPENCODE_CONFIG/commands"

    # Agents
    echo "  Installing agents..."
    for agent in "$SCRIPT_DIR"/opencode/agents/*.md; do
        safe_copy "$agent" "$OPENCODE_CONFIG/agents/$(basename "$agent")"
        echo "    + $(basename "$agent")"
    done

    # Commands
    echo "  Installing commands..."
    for cmd in "$SCRIPT_DIR"/opencode/commands/*.md; do
        safe_copy "$cmd" "$OPENCODE_CONFIG/commands/$(basename "$cmd")"
        echo "    + /$(basename "$cmd" .md)"
    done

    echo "  OpenCode installation complete."
}

install_claude_code() {
    echo "=== Installing Claude Code components ==="

    # Agents
    mkdir -p "$CLAUDE_CONFIG/agents"
    echo "  Installing agents..."
    for agent in "$SCRIPT_DIR"/claude-code/agents/*.md; do
        safe_copy "$agent" "$CLAUDE_CONFIG/agents/$(basename "$agent")"
        echo "    + $(basename "$agent")"
    done

    # Commands
    mkdir -p "$CLAUDE_CONFIG/commands"
    echo "  Installing commands..."
    for cmd in "$SCRIPT_DIR"/claude-code/commands/*.md; do
        safe_copy "$cmd" "$CLAUDE_CONFIG/commands/$(basename "$cmd")"
        echo "    + /$(basename "$cmd" .md)"
    done

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
