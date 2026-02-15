List all sessions with their status and monitoring stats.

1. Scan all folders in `sessions/`
2. For each session folder:
   - Read SESSION.md if it exists (extract: status, objective, skills used, last updated)
   - Read MONITOR.md if it exists (extract: total interactions, total saves)
   - Check for `monitor.log` (indicates unsaved monitoring data)
3. Display sorted newest first:

```
📁 2026-02-15_api-redesign
   Status: paused | Objective: Design REST API for user management
   Skills: enterprise-architecture | Last updated: 2026-02-15
   Monitor: 23 interactions, 3 saves | ⚠️ 5 unsaved prompts in buffer

📁 2026-02-10_compliance-review
   Status: completed | Objective: EU AI Act gap analysis
   Skills: eu-ai-act-compliance | Last updated: 2026-02-14
   Monitor: 45 interactions, 5 saves | Final report available

📁 2026-02-08_landing-page
   Status: active | Objective: Company landing page redesign
   [no SESSION.md — run /init-session]
   [no monitoring data]
```

4. Note which session (if any) is currently active (check `.active-session` file)
