Create SESSION.md and MONITOR.md for a session folder. These files serve as **persistent memory** (SESSION.md) and **interaction audit trail** (MONITOR.md).

1. Ask which session to initialize (or detect from current working directory)
2. Scan the session folder:
   - What files already exist (inputs, drafts, outputs)
   - What subfolders exist
3. Ask me about:
   - The objective / goal
   - Key context: who is this for, what constraints, what standards to follow
   - Any decisions already made
4. Generate SESSION.md with ALL of the following sections:

```markdown
# Session: <name>

## Meta
- **Date created:** YYYY-MM-DD
- **Last updated:** YYYY-MM-DD
- **Status:** active | paused | completed
- **Skills used:** [filled in as work progresses]

## Objective
[Clear statement of what we're trying to achieve]

## Context
[Everything Claude needs to know to resume this session without any prior context]
- **Audience:** [who is this for?]
- **Constraints:** [format, standards, regulations, deadlines]
- **Background:** [relevant history, assumptions, technical details]

## Decisions Log
[Key decisions made during the session, with reasoning]
- YYYY-MM-DD: [decision] — [why]

## Plan
[Ordered steps / tasks with status]
- [ ] Step 1: ...
- [ ] Step 2: ...
- [ ] Step 3: ...

## File Index
[Every file in this session folder with its purpose and status]
- `input/filename.ext` — [description]
- `output-file.ext` — [description] — status: draft | final

## Progress Log
[Chronological log of work done each time the session is opened]

### YYYY-MM-DD
- [what was accomplished]
- [what's in progress]
- [what's next]

## Resume Instructions
[Specific instructions for Claude when resuming this session]
1. Read this SESSION.md fully
2. Read MONITOR.md for interaction history
3. Check file index against actual files
4. Continue from the next unchecked step in Plan
5. [any session-specific instructions]
```

5. Initialize MONITOR.md:

```markdown
# Monitor: <name>

## Overview
- **Session:** <name>
- **Started:** YYYY-MM-DD HH:MM
- **Total interactions:** 0
- **Total saves:** 0

## Interaction Log
[Populated on each /save-session with summarized prompt/response pairs]
```

6. **Activate monitoring:** Write the session path to `.active-session` in the project root. This tells the monitoring hooks where to log prompts.

Important:
- Add skills to **Skills used** only as they are actually used during work, not upfront.
- Save both files in the session folder root.
- After init, every prompt you type is automatically timestamped in `monitor.log` by the hooks.
- **Token awareness:** SESSION.md is read in full on resume. Keep sections concise — use bullet points, not paragraphs. The Progress Log should capture *what* and *what's next*, not narrative.
