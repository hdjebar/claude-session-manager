Finalize and close a session, preserving full memory for potential future reference.

1. Ask which session to finalize (or detect from current working directory)
2. Check if SESSION.md exists:
   - If yes: update it with final results
   - If no: create it now (ask for objective, then document everything)
3. Scan the session folder for all files produced
4. Update SESSION.md:
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
5. Copy key deliverables to `outputs/` with naming: `<date>_<session-name>_<filename>`
6. Suggest a git commit message
