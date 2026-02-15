#!/bin/bash
# Safety net: clear .active-session when Claude Code exits
# Triggered by: SessionEnd hook

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ACTIVE_FILE="$PROJECT_DIR/.active-session"

[ -f "$ACTIVE_FILE" ] && rm -f "$ACTIVE_FILE"
exit 0
