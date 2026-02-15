# Claude Session Manager — Project Instructions

## Overview
This workspace provides persistent session memory + interaction monitoring for Claude Code. Sessions live under `sessions/` and use two files:
- **SESSION.md** — persistent memory (what, why, decisions, plan)
- **MONITOR.md** — interaction audit trail (every prompt/response, timing, stats)

## Session Workflow

### Lifecycle
1. **Create**: `./new-session.sh <n>` or `/new-session` — creates empty folder
2. **Work**: Drop files in `input/`, start exploring, experimenting
3. **Init**: `/init-session` — generates SESSION.md + MONITOR.md, activates monitoring hooks
4. **Save**: `/save-session` — checkpoints progress + summarizes interactions (status → `paused`)
5. **Resume**: `/resume-session` — restores context, shows changes since last save, reactivates hooks
6. **Finalize**: `/finalize-session` — documents results + generates full monitoring report

Steps 4-5 can repeat as many times as needed.

### Session Statuses
| Status | Meaning |
|--------|---------|
| `active` | Currently being worked on, hooks logging |
| `paused` | Saved checkpoint, hooks deactivated |
| `completed` | Done, results + monitoring report documented |

## Monitoring

### How It Works
Three hooks in `.claude/settings.json` provide automatic monitoring:
- **UserPromptSubmit** → logs every prompt with timestamp to `monitor.log`
- **Stop** → logs response completion marker to `monitor.log`
- **SessionEnd** → cleans up `.active-session` file

Hooks only log when a session is active (`.active-session` file exists pointing to a session folder).

### Files
| File | Purpose | Written by |
|------|---------|------------|
| `.active-session` | Points hooks to current session | `/init-session`, `/resume-session` |
| `monitor.log` | Raw timestamped prompts + markers | Hooks (automatic) |
| `MONITOR.md` | Human-readable interaction summaries | `/save-session`, `/finalize-session` |

### Flow
```
Hooks log prompts → monitor.log (raw, continuous)
/save-session reads monitor.log + conversation context → MONITOR.md (summarized)
/resume-session reads MONITOR.md → reports history + changes
/finalize-session → MONITOR.md final report with totals
```

## Skills
Skills in `.claude/skills/` are auto-discovered. Skills used are recorded in each session's SESSION.md as work progresses.

## Conventions
- Sessions live in `sessions/<date>_<n>/`
- Keep session folders self-contained (inputs + outputs together)
- **SESSION.md is the single source of truth** for session state
- **MONITOR.md is the single source of truth** for interaction history
- `monitor.log` is a temporary buffer — consumed and cleared on each save
- Skills used are tracked in SESSION.md, not decided upfront
- Final deliverables go to `outputs/` with clear naming
- Prefer Mermaid for diagrams (renders on GitHub)
