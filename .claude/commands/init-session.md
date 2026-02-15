Create a SESSION.md for an existing session folder. This file serves as the **persistent memory** of the session — it must contain everything needed for Claude to resume work later without any prior context.

1. Ask which session to document (or detect from current working directory)
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
2. Check file index against actual files
3. Continue from the next unchecked step in Plan
4. [any session-specific instructions]
```

Important: Add skills to **Skills used** only as they are actually used during work, not upfront.
Save as SESSION.md in the session folder root.
