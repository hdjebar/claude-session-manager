Finalize and close a session, preserving full memory and a complete monitoring report.

1. Ask which session to finalize (or detect from current working directory)
2. Check if SESSION.md exists:
   - If yes: update it with final results
   - If no: create it now (ask for objective, then document everything)
3. Scan the session folder for all files produced

## Update SESSION.md
- Set **Status** to `completed`
- Set **Last updated** to today
- Complete the **File Index** with all files and descriptions
- Update **Skills used** with all skills that were actually used
- Check off all completed steps in **Plan**
- Add final entry in **Progress Log** summarizing what was accomplished
- Add a **Results Summary** section at the end:
  ```
  ## Results Summary
  [Brief summary of what was delivered, key outcomes, and any follow-up needed]
  ```

## Finalize MONITOR.md
First, process any remaining `monitor.log` entries (do a final save snapshot).

Then add a **Final Report** section:

```markdown
---
## Final Report — YYYY-MM-DD

### Totals
- **Total interactions:** X
- **Total saves:** X
- **Sessions (resume cycles):** X
- **Total duration:** ~Xh across X days
- **Files produced:** X

### Session Timeline
| Date | Action | Interactions | Key work |
|------|--------|-------------|----------|
| YYYY-MM-DD | Init | — | Session created |
| YYYY-MM-DD | Save #1 | 12 | Endpoints + auth |
| YYYY-MM-DD | Resume → Save #2 | 11 | Tests + docs |
| YYYY-MM-DD | Finalized | 5 | Final review |

### All Decisions (consolidated)
- [decision] — [reasoning] (date)

### Key Deliverables
- `file.ext` — [what it is]
```

## After finalizing
- Clear `monitor.log`
- Remove `.active-session`
- Copy key deliverables to `outputs/` with naming: `<date>_<session-name>_<filename>`
- Suggest a git commit message
