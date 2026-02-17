#!/bin/bash
# ============================================================
# New Session Creator
# Usage: ./new-session.sh <session-name>
# ============================================================

set -e

DATE=$(date +%Y-%m-%d)
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage:${NC} ./new-session.sh <session-name>"
    echo ""
    echo -e "${BLUE}Examples:${NC}"
    echo "  ./new-session.sh resume-update"
    echo "  ./new-session.sh ai-chatbot-audit"
    echo "  ./new-session.sh quarterly-report"
    echo "  ./new-session.sh my-cool-project"
    echo ""
    echo "  Session names may contain letters, numbers, hyphens, and underscores."
    exit 1
fi

SESSION_NAME="$1"

# Validate session name: only allow alphanumeric, hyphens, and underscores
if [[ ! "$SESSION_NAME" =~ ^[a-zA-Z0-9][a-zA-Z0-9_-]*$ ]]; then
    echo -e "${RED}Error:${NC} Invalid session name '${SESSION_NAME}'"
    echo "  Session names must start with a letter or number and contain"
    echo "  only letters, numbers, hyphens (-), and underscores (_)."
    exit 1
fi

SESSION_DIR="sessions/${DATE}_${SESSION_NAME}"

# Check for duplicate session name (same date)
if [ -d "$SESSION_DIR" ]; then
    echo -e "${RED}Error:${NC} Session already exists: ${SESSION_DIR}"
    echo "  Choose a different name or remove the existing session first."
    exit 1
fi

mkdir -p "$SESSION_DIR/input"

echo ""
echo -e "${GREEN}Session created:${NC} $SESSION_DIR"
echo ""
echo -e "${YELLOW}Tip:${NC} Use /init-session in Claude Code when ready to document"
echo -e "${BLUE}Next:${NC} cd $SESSION_DIR && claude"
