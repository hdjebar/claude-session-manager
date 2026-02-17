Save a checkpoint of session progress AND monitoring data.
Use this before ending a Claude Code conversation to preserve both context and interaction history.

1. Detect the current session (from `.active-session`, working directory, or ask)
2. If SESSION.md doesn't exist yet, run /init-session first

## Update SESSION.md
- Set **Last updated** to today
- Set **Status** to `paused`
- Check off any completed steps in **Plan**
- Update **File Index** with any new files created since last save
- Update **Skills used** with any skills used during this work period
- Log any new **Decisions** made during this work period
- Add entry in **Progress Log** for today:
  - What was accomplished
  - What's in progress (partial work)
  - What should be done next
- Update **Resume Instructions** with anything specific for next time

## Update MONITOR.md (Monitoring Snapshot)
Read `monitor.log` in the session folder — this contains timestamped raw prompts and response markers logged by hooks.

**Token budget:** MONITOR.md is read in full on every `/resume-session`. Keep each save snapshot compact:
- Interaction summaries: max 10 words per column. Collapse repetitive interactions (e.g., "3× iterated on test fixes").
- If there are more than 20 interactions in a period, summarize in groups rather than listing each one.
- Omit the Decisions Made sub-section if none were made.

Add a new snapshot section to MONITOR.md:

```markdown
---
### Save #N — YYYY-MM-DD HH:MM
- **Interactions this period:** X
- **Duration:** ~Xh Xm (from first to last prompt timestamp)
- **Files changed:** [list new/modified files]
- **Plan progress:** X/Y steps done

#### Interaction Summary
| # | Time | Prompt | What happened |
|---|------|--------|---------------|
| 1 | HH:MM | [prompt summary, ≤10 words] | [response summary, ≤15 words] |
| 2 | HH:MM | ... | ... |

#### Decisions Made
- [any decisions from this period]
```

For the "What happened" column: you have the full conversation in your current context — summarize what you actually did in response to each prompt. Keep it terse.

Update the Overview section totals (total interactions, total saves).

## After saving
- Clear `monitor.log` (the data is now in MONITOR.md)
- Remove `.active-session` (deactivates hooks)
- Confirm what was saved
- Remind me to git commit
