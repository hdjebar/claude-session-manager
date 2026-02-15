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
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage:${NC} ./new-session.sh <session-name>"
    echo ""
    echo -e "${BLUE}Examples:${NC}"
    echo "  ./new-session.sh resume-update"
    echo "  ./new-session.sh ai-chatbot-audit"
    echo "  ./new-session.sh quarterly-report"
    echo "  ./new-session.sh my-cool-project"
    exit 1
fi

SESSION_NAME="$1"
SESSION_DIR="sessions/${DATE}_${SESSION_NAME}"

mkdir -p "$SESSION_DIR/input"

echo ""
echo -e "${GREEN}✓ Session created:${NC} $SESSION_DIR"
echo ""
echo -e "${YELLOW}Tip:${NC} Use /init-session in Claude Code when ready to document"
echo -e "${BLUE}Next:${NC} cd $SESSION_DIR && claude"
