# Claude Session Manager — Project Instructions

## Overview
This workspace provides persistent session memory for Claude Code. Sessions live under `sessions/` and use SESSION.md as their context restoration file.

## Session Workflow
SESSION.md is the **persistent memory** of each session. It stores everything Claude needs to resume work later without prior context.

### Lifecycle
1. **Create**: `./new-session.sh <name>` or `/new-session` — creates empty folder
2. **Work**: Drop files in `input/`, start exploring, experimenting
3. **Init**: `/init-session` — when ready, Claude generates SESSION.md with objective, context, and plan
4. **Save**: `/save-session` — checkpoint progress before ending a conversation (status → `paused`)
5. **Resume**: `/resume-session` — Claude reads SESSION.md, restores full context, continues where you left off
6. **Finalize**: `/finalize-session` — documents results, copies deliverables to `outputs/`, marks `completed`

Steps 4-5 can repeat as many times as needed. You can skip step 3 — `/save-session` and `/finalize-session` will create SESSION.md on the fly.

### Session Statuses
| Status | Meaning |
|--------|---------|
| `active` | Currently being worked on |
| `paused` | Saved checkpoint, ready to resume |
| `completed` | Done, results documented |

## Skills
Skills in `.claude/skills/` are auto-discovered. Skills used are recorded in each session's SESSION.md as work progresses.

## Conventions
- Sessions live in `sessions/<date>_<name>/`
- Keep session folders self-contained (inputs + outputs together)
- **SESSION.md is the single source of truth** — always read it first when entering a session
- Skills used are tracked in SESSION.md, not decided upfront
- Final deliverables go to `outputs/` with clear naming
- Prefer Mermaid for diagrams (renders on GitHub)
