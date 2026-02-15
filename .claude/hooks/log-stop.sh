#!/bin/bash
# Mark response completion in the active session's monitor.log
# Triggered by: Stop hook

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ACTIVE_FILE="$PROJECT_DIR/.active-session"

# No active session? Exit silently.
[ ! -f "$ACTIVE_FILE" ] && exit 0

SESSION_DIR=$(cat "$ACTIVE_FILE" 2>/dev/null | tr -d '[:space:]')
[ -z "$SESSION_DIR" ] && exit 0

[[ "$SESSION_DIR" != /* ]] && SESSION_DIR="$PROJECT_DIR/$SESSION_DIR"
[ ! -d "$SESSION_DIR" ] && exit 0

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] RESPONSE_COMPLETE" >> "$SESSION_DIR/monitor.log"
exit 0
