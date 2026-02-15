# 🧠 Claude Session Manager

**Persistent memory for Claude Code.** A lightweight framework that gives Claude Code cross-session continuity — because Claude forgets everything when you close the terminal.

## The Problem

Claude Code is stateless. Every time you start a new conversation, Claude has **zero memory** of what you did before. If you're working on a multi-day project, you have to re-explain everything from scratch.

## The Solution

**SESSION.md** — a structured context file that captures everything Claude needs to resume work: objective, decisions, plan, progress, file index, and resume instructions. Combined with 6 slash commands that automate the create → work → save → resume → finalize cycle.

```
 Monday                    Wednesday                  Friday
┌──────────┐              ┌──────────┐              ┌───────────┐
│ /init    │  /save  git  │ /resume  │  /save  git  │ /resume   │
│ SESSION  │ ────► push ──►│ Context  │ ────► push ──►│ /finalize │
│ .md      │              │ restored │              │ completed │
└──────────┘              └──────────┘              └───────────┘
```

Claude reads SESSION.md and picks up exactly where you left off — with full context of decisions made, steps completed, and what's next.

## Quick Start

```bash
# Option 1: Clone this repo as your workspace
git clone https://github.com/hdjebar/claude-session-manager.git my-project
cd my-project && claude

# Option 2: Add to an existing project
cp -r claude-session-manager/.claude your-project/
cp claude-session-manager/CLAUDE.md your-project/
cp claude-session-manager/new-session.sh your-project/
mkdir -p your-project/sessions your-project/outputs
```

## How It Works

### 6 Slash Commands

| Command | When | What |
|---------|------|------|
| `/new-session` | Starting | Creates empty session folder |
| `/init-session` | When ready | Creates SESSION.md — asks objective, context, generates plan |
| `/save-session` | Before leaving | Checkpoints progress, updates plan & file index (status → paused) |
| `/resume-session` | Coming back | Reads SESSION.md, restores full context, shows next steps |
| `/list-sessions` | Anytime | Overview of all sessions with status |
| `/finalize-session` | Done | Documents results, copies deliverables to outputs/ |

### SESSION.md = Persistent Memory

This is what gives Claude its memory. Each section serves a purpose:

| Section | Why Claude needs it |
|---------|-------------------|
| **Objective** | Knows what you're trying to achieve |
| **Context** | Audience, constraints, background — no need to re-explain |
| **Decisions Log** | Remembers why you chose X over Y |
| **Plan** | Sees `[x]` done, `[ ]` todo — knows where you stopped |
| **File Index** | Knows every file and its purpose |
| **Progress Log** | Reads what was done each day |
| **Resume Instructions** | Session-specific notes on how to pick up |

### End-to-End Example

```bash
# ── Setup (once) ──────────────────────────────────
git clone https://github.com/hdjebar/claude-session-manager.git my-project
cd my-project

# ── Monday: Start ────────────────────────────────
./new-session.sh api-redesign
cd sessions/2026-02-15_api-redesign
claude

> /init-session                            # creates SESSION.md
> ... work work work ...
> /save-session                            # checkpoint, status: paused
> exit

cd ../..
git add -A && git commit -m "wip: api-redesign — auth module done" && git push

# ── Wednesday: Resume ─────────────────────────────
git pull                                   # if on another machine
cd sessions/2026-02-15_api-redesign
claude

> /resume-session                          # Claude reads SESSION.md, full context
> "Continue with step 3"                   # picks up exactly where you left off
> /save-session
> exit

git add -A && git commit -m "wip: api-redesign — endpoints done" && git push

# ── Friday: Finalize ──────────────────────────────
cd sessions/2026-02-15_api-redesign
claude

> /resume-session
> ... finish up ...
> /finalize-session                        # documents results, copies to outputs/
> exit

git add -A && git commit -m "done: api-redesign complete" && git push
```

## Structure

```
your-project/
├── .claude/
│   └── commands/            ← 6 slash commands (auto-discovered)
│       ├── new-session.md
│       ├── init-session.md
│       ├── save-session.md
│       ├── resume-session.md
│       ├── list-sessions.md
│       └── finalize-session.md
├── sessions/                ← Your work sessions
│   ├── 2026-02-15_api-redesign/
│   │   ├── SESSION.md           ← The memory file
│   │   ├── input/
│   │   └── ... outputs ...
│   └── 2026-02-18_bug-fix/
├── outputs/                 ← Final deliverables
├── templates/
│   └── SESSION-REFERENCE.md ← Full SESSION.md template for reference
├── CLAUDE.md                ← Project-level instructions for Claude
├── new-session.sh           ← Bash session creator
└── README.md
```

## Add Your Own Skills

Drop skill folders into `.claude/skills/` — Claude Code auto-discovers them:

```
.claude/skills/my-skill/
├── SKILL.md          # Required: YAML frontmatter + instructions
├── references/       # Optional: reference docs
├── scripts/          # Optional: executable scripts
└── templates/        # Optional: reusable templates
```

Skills used in each session are automatically tracked in SESSION.md.

## Use Cases

- **Multi-day coding projects** — resume complex refactors without re-explaining architecture
- **Research & analysis** — save findings, decisions, and progress across sessions
- **Document creation** — iterate on reports, presentations across multiple days
- **Consulting work** — manage multiple client sessions with full context preservation
- **Learning & experimentation** — checkpoint experiments, come back to promising directions

## Why Not Just Use CLAUDE.md?

CLAUDE.md is project-level instructions — it tells Claude *how* to behave. SESSION.md is session-level state — it tells Claude *where you are* in a specific task. You need both:

| | CLAUDE.md | SESSION.md |
|-|-----------|------------|
| **Scope** | Whole project | One task |
| **Changes** | Rarely | Every session |
| **Contains** | Rules, conventions | State, progress, decisions |
| **Read** | Always | When resuming a session |

## Contributing

Ideas and PRs welcome. The framework is intentionally minimal — the value is in the SESSION.md structure and the command workflows, not in complexity.

## License

MIT
