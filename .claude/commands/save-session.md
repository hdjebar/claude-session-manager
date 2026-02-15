Save a checkpoint of the current session progress without finalizing.
Use this before ending a Claude Code conversation to preserve context for next time.

1. Detect the current session (from working directory or ask)
2. If SESSION.md doesn't exist yet, run /init-session first
3. Update SESSION.md:
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
4. Confirm what was saved
5. Remind me to git commit if I want to preserve this checkpoint
