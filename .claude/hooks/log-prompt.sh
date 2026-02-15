#!/bin/bash
# Log every user prompt to the active session's monitor.log
# Triggered by: UserPromptSubmit hook

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ACTIVE_FILE="$PROJECT_DIR/.active-session"

# No active session? Exit silently.
[ ! -f "$ACTIVE_FILE" ] && exit 0

SESSION_DIR=$(cat "$ACTIVE_FILE" 2>/dev/null | tr -d '[:space:]')
[ -z "$SESSION_DIR" ] && exit 0

# Make absolute if relative
[[ "$SESSION_DIR" != /* ]] && SESSION_DIR="$PROJECT_DIR/$SESSION_DIR"
[ ! -d "$SESSION_DIR" ] && exit 0

# Extract prompt from stdin JSON
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('prompt', ''))
except:
    pass
" 2>/dev/null)

[ -z "$PROMPT" ] && exit 0

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] PROMPT: $PROMPT" >> "$SESSION_DIR/monitor.log"
exit 0
