# 🧠 Claude Session Manager

**A KISS approach to persistent memory + interaction monitoring for Claude Code.** No plugins, no databases, no dependencies — markdown files, bash hooks, and slash commands.

## Why

Claude Code loses conversation context between sessions. Your files stay, but what you discussed, decided, and planned is gone. There are [dozens of tools](https://github.com/topics/claude-code) solving this — vector databases, MCP servers, auto-capture plugins, funded startups.

This isn't any of that. This is markdown files, 3 bash hooks, and 6 slash commands. 

**What's different:** most session managers save *what you decided*. This also saves *what you asked and what Claude did* — every prompt timestamped, every response summarized. SESSION.md is your memory. MONITOR.md is your audit trail.

## How

```
SESSION.md  = what you're doing, why, what's next     (memory)
MONITOR.md  = every prompt/response, timing, stats     (audit trail)
monitor.log = raw hook output, consumed on each save   (buffer)
```

Three Claude Code hooks log every prompt and response completion automatically. When you `/save-session`, Claude reads the raw log plus its own conversation context and writes a human-readable summary to MONITOR.md. When you `/resume-session`, Claude shows you exactly what happened last time and what changed since.

No install. No config. No `npm install`. No API keys. Copy the files and go.

## Quick Start

```bash
# Option 1: Clone as workspace
git clone https://github.com/hdjebar/claude-session-manager.git my-project
cd my-project && claude

# Option 2: Add to existing project
cp -r claude-session-manager/.claude your-project/
cp claude-session-manager/CLAUDE.md your-project/
cp claude-session-manager/new-session.sh your-project/
mkdir -p your-project/sessions your-project/outputs
```

Claude Code will detect the hooks in `.claude/settings.json` and the slash commands in `.claude/commands/` automatically.

## 6 Commands

| Command | When | What it does |
|---------|------|-------------|
| `/new-session` | Starting | Creates empty session folder |
| `/init-session` | Ready to plan | Creates SESSION.md + MONITOR.md, **activates hooks** |
| `/save-session` | Before leaving | Checkpoints progress + **summarizes all interactions** |
| `/resume-session` | Coming back | Restores context + **shows what changed**, reactivates hooks |
| `/list-sessions` | Anytime | Shows all sessions with status + monitoring stats |
| `/finalize-session` | Done | Documents results + **generates full monitoring report** |

## Monitoring: What Gets Captured

**Continuously (hooks):**
Every prompt you type → timestamped in `monitor.log`  
Every Claude response completion → marked in `monitor.log`

**On `/save-session`:**
Claude reads the raw log, recalls its responses from conversation context, and writes:

```markdown
### Save #2 — 2026-02-15 14:30
- **Interactions this period:** 11
- **Duration:** ~1h 20m
- **Files changed:** auth.ts (new), tests/auth.test.ts (new)
- **Plan progress:** 6/8 steps done

| # | Time | Prompt | What happened |
|---|------|--------|---------------|
| 13 | 13:10 | Add rate limiting | Created middleware with token bucket |
| 14 | 13:25 | Write tests for it | Added 8 unit tests, all passing |
| 15 | 13:40 | Handle edge cases | Added retry-after headers, 429 responses |
```

**On `/resume-session`:**
```
📋 Session: api-redesign (paused → active)
🎯 Objective: Design REST API for user management
📊 Monitor: 23 interactions across 2 saves
📝 Last save: 2026-02-15 14:30 — endpoints + auth done
⚠️  Changes since last save: 0 new files, no orphaned logs
👉 Next: Step 7 — Error handling middleware
```

**On `/finalize-session`:**
Full report with totals, timeline, consolidated decisions, and deliverables list.

## SESSION.md + MONITOR.md

| SESSION.md | MONITOR.md |
|------------|------------|
| Objective, Context, Background | Interaction timestamps |
| Decisions Log (with reasoning) | Prompt/response summaries |
| Plan with checkboxes | Save snapshots with stats |
| File Index | Session timeline |
| Progress Log | Duration tracking |
| Resume Instructions | Final report (on finalize) |

Both are plain markdown. Read them, edit them, grep them, diff them, git blame them.

## End-to-End

```bash
# Monday morning
./new-session.sh api-redesign
cd sessions/2026-02-15_api-redesign && claude

> /init-session                     # SESSION.md + MONITOR.md created
                                    # hooks now logging every prompt
> "Design REST endpoints for users"
> "Add JWT authentication"
> "Write validation schemas"
> /save-session                     # progress saved + interactions summarized
> exit

git add -A && git commit -m "wip: api-redesign — 12 interactions, endpoints done"
git push

# Wednesday afternoon
cd sessions/2026-02-15_api-redesign && claude

> /resume-session                   # context restored, changes shown
                                    # hooks reactivated
> "Continue with rate limiting"
> "Add error handling"
> /save-session                     # second snapshot in MONITOR.md
> exit

git add -A && git commit -m "wip: api-redesign — 23 total, auth + rate limiting"
git push

# Friday
> /resume-session
> "Final review and cleanup"
> /finalize-session                 # full report generated
> exit

git add -A && git commit -m "done: api-redesign — 31 interactions, 3 saves"
git push
```

## What This Is Not

This is not innovative. The structured-markdown-for-memory pattern exists in [Cline Memory Bank](https://github.com/nickbaumann98/cline_docs/blob/main/prompting/custom%20instructions%20library/cline-memory-bank.md), [claude-sessions](https://github.com/iannuttall/claude-sessions), [claude-mem](https://github.com/thedotmack/claude-mem), and many others. Claude Code itself now has `--resume`, Auto Memory, and MEMORY.md.

This adds one thing: **coupling session memory with interaction monitoring.** Not via vector search or plugin infrastructure — just hooks writing to a log, and Claude summarizing that log when you save. You get a searchable, git-trackable, human-readable audit trail of every conversation across every session.

If you need semantic search across sessions, auto-capture of tool invocations, or cross-tool memory — use one of the more powerful tools above. If you want something you can understand in 5 minutes, runs anywhere Claude Code runs, and gives you a complete interaction history — this might work for you.

## Structure

```
your-project/
├── .claude/
│   ├── commands/            ← 6 slash commands
│   ├── hooks/               ← 3 monitoring scripts
│   │   ├── log-prompt.sh    ← logs user prompts
│   │   ├── log-stop.sh      ← marks response completion
│   │   └── session-end.sh   ← cleanup on exit
│   └── settings.json        ← hook configuration
├── sessions/
│   └── 2026-02-15_my-task/
│       ├── SESSION.md        ← memory
│       ├── MONITOR.md        ← audit trail
│       ├── monitor.log       ← raw buffer (temporary)
│       └── input/
├── outputs/                  ← final deliverables
├── templates/                ← SESSION.md reference
├── .active-session           ← pointer to current session (temporary)
├── CLAUDE.md                 ← project instructions
└── new-session.sh            ← session creator
```

## Add Skills

Drop skill folders into `.claude/skills/` if you want them:

```
.claude/skills/my-skill/
├── SKILL.md
└── ...
```

## Requirements

- Claude Code (any version with hooks support)
- `python3` (for JSON parsing in hooks — present on virtually all dev machines)
- `bash`

## License

MIT
