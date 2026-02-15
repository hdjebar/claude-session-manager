Resume a previous session by loading its full context from SESSION.md and monitoring history from MONITOR.md.

1. Ask which session to resume (or detect from current working directory)
   - If unclear, run /list-sessions first to show options

## Restore Context
2. Read **SESSION.md** completely — this is the session memory
3. Read **MONITOR.md** completely — this is the interaction history
4. Verify the file index: check that listed files still exist, flag any missing or new files
5. Check for orphaned `monitor.log` entries (prompts logged after last save but before session ended — summarize them)

## Report
6. Tell me:
   - Session objective (brief reminder)
   - Current status and last progress entry
   - **Monitoring summary**: total interactions so far, number of saves, last save date
   - **Changes since last save**: any new files on disk not in File Index, any orphaned monitor.log entries
   - Next unchecked steps from the Plan
   - Any Resume Instructions specified

## Activate
7. Before starting work, update:
   - SESSION.md: Set **Last updated** to today, **Status** to `active`, add new Progress Log entry
   - MONITOR.md: Add a resume marker: `### Resumed — YYYY-MM-DD HH:MM`
   - Write session path to `.active-session` (reactivates monitoring hooks)

8. Ask me what I want to work on next

Throughout the resumed session:
- After completing any Plan step, check it off in SESSION.md
- Log key decisions in the Decisions Log
- Update the File Index when creating new files
- Hooks are now active — every prompt is being logged to `monitor.log`
