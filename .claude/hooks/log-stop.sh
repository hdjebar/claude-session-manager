#!/bin/bash
# Mark response completion in the active session's monitor.log
# Triggered by: Stop hook

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ACTIVE_FILE="$PROJECT_DIR/.active-session"

# No active session? Exit silently.
[ ! -f "$ACTIVE_FILE" ] && exit 0

# Read session path, trimming only leading/trailing whitespace
SESSION_DIR=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' "$ACTIVE_FILE" 2>/dev/null)
[ -z "$SESSION_DIR" ] && exit 0

# Make absolute if relative
[[ "$SESSION_DIR" != /* ]] && SESSION_DIR="$PROJECT_DIR/$SESSION_DIR"

# Validate session directory exists and is within the project
REAL_SESSION=$(realpath "$SESSION_DIR" 2>/dev/null) || exit 0
REAL_PROJECT=$(realpath "$PROJECT_DIR" 2>/dev/null) || exit 0
[[ "$REAL_SESSION" != "$REAL_PROJECT"/sessions/* ]] && exit 0
[ ! -d "$SESSION_DIR" ] && exit 0

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] RESPONSE_COMPLETE" >> "$SESSION_DIR/monitor.log"
exit 0
