#!/bin/bash
# Log every user prompt to the active session's monitor.log
# Triggered by: UserPromptSubmit hook
#
# IMPORTANT: UserPromptSubmit stdout is injected into Claude's context
# as tokens. This script must produce ZERO stdout to avoid wasting tokens
# on every single interaction. All output goes to files or stderr.

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

# Read stdin JSON
INPUT=$(cat)
[ -z "$INPUT" ] && exit 0

# Extract prompt — try jq first (fast, ~5ms), fall back to python3 (~50ms)
if command -v jq >/dev/null 2>&1; then
    PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty' 2>/dev/null)
elif command -v python3 >/dev/null 2>&1; then
    PROMPT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('prompt', ''))
except (json.JSONDecodeError, ValueError, KeyError, EOFError):
    pass
" 2>/dev/null)
else
    exit 0
fi

[ -z "$PROMPT" ] && exit 0

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] PROMPT: $PROMPT" >> "$SESSION_DIR/monitor.log"
exit 0
