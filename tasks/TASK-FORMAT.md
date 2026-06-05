# Bellwright ModKit — AI Agent Task File Format

## Overview

This document defines the canonical task file format for the Bellwright modding project. All task files are consumed by AI coding agents (Claude Code or equivalent), not human developers. Every field exists to reduce agent ambiguity, prevent race conditions between parallel agents, and make acceptance criteria mechanically verifiable without human judgment.

---

## Task ID Naming Convention

### Structure

```
{LEVEL}-{DOMAIN}-{SEQUENCE}[-{PARENT_REF}]
```

### Levels

| Prefix | Level | Granularity |
|--------|-------|-------------|
| `EPIC` | Epic | Initiative (weeks to months) |
| `STOR` | Story | Feature (days to a week) |
| `TASK` | Task | Concrete action (hours) |

### Domains

| Code | Domain |
|------|--------|
| `RES` | Research |
| `EXP` | ModKit Exploration |
| `DEV` | Mod Development |
| `DOC` | Documentation |
| `COM` | Community / Distribution |
| `VAL` | Validation |

### Sequence

Zero-padded 4-digit integer, scoped within domain+level. Resets per domain per level.

### Parent Reference

Stories append their parent Epic ID. Tasks append their parent Story ID. This encodes hierarchy directly in the ID and makes dependency chains inspectable without reading file contents.

### Examples

```
EPIC-RES-0001                         # First research epic
STOR-EXP-0001-EPIC-RES-0001           # First exploration story under that epic
TASK-EXP-0003-STOR-EXP-0001           # Third exploration task under that story
```

### Rules

1. IDs are immutable once assigned. Never reuse a retired ID.
2. IDs must be unique across the entire `tasks/` directory tree.
3. The filename must be the task ID: `TASK-EXP-0003-STOR-EXP-0001.yaml`
4. A task's `prerequisites` field must reference IDs verbatim as they appear in filenames — no aliases or descriptions.

---

## Template: Epic

```yaml
# ============================================================
# EPIC TASK FILE — Bellwright ModKit AI Agent Format v1.0
# ============================================================

id: EPIC-{DOMAIN}-{SEQUENCE}
level: epic
status: pending
# status values: pending | in-progress | blocked | complete | cancelled

title: "<One sentence. Imperative verb. What the initiative achieves.>"

owner: unassigned
# owner: agent ID or "unassigned". Set by orchestrator before dispatching.

created: "YYYY-MM-DD"
updated: "YYYY-MM-DD"

# -----------------------------------------------------------
# PREREQUISITES
# List task IDs that must reach status=complete before this
# epic may begin. Empty list means no blockers.
# Rule: only reference IDs that exist as files in tasks/.
# -----------------------------------------------------------
prerequisites: []

# -----------------------------------------------------------
# CONTEXT
# Everything a fresh agent needs to start without reading
# other files. Include: what Bellwright is, what the ModKit
# is, why this initiative matters, and relevant constraints.
# Minimum 150 words. No external links required here but
# encouraged for agent research tasks.
# -----------------------------------------------------------
context: |
  <Project background. Game description. ModKit description.
  Why this initiative exists. What problem it solves. Any
  constraints the agent must respect (e.g., UE5 version,
  Steam Workshop rules, file size limits).>

# -----------------------------------------------------------
# GOAL
# The measurable end state. Written as a definition of done
# at the initiative level. Agents use this to assess whether
# child stories are sufficiently covering the epic.
# -----------------------------------------------------------
goal: |
  <What "done" looks like at the initiative level. Must be
  concrete enough that an agent can check it without human
  judgment.>

# -----------------------------------------------------------
# CHILD STORIES
# The Story IDs that together constitute completion of this
# epic. Populated by the orchestrator or planning agent.
# An epic is complete when all child stories are complete.
# -----------------------------------------------------------
child_stories:
  - STOR-{DOMAIN}-{SEQUENCE}-{THIS_EPIC_ID}

# -----------------------------------------------------------
# ACCEPTANCE CRITERIA
# Each criterion must be independently verifiable by an agent
# using file read, bash execution, web search, or browser
# automation. No criterion may rely on human judgment.
# Format: checkable assertions, not aspirational statements.
# -----------------------------------------------------------
acceptance_criteria:
  - "<Criterion 1: specific, agent-verifiable assertion>"
  - "<Criterion 2>"

# -----------------------------------------------------------
# AGENT HINTS
# Tips that help agents avoid failure modes common to this
# type of epic. Not instructions — those go in child tasks.
# Include: known blockers, API rate limits, tool gotchas,
# ordering recommendations across stories.
# -----------------------------------------------------------
agent_hints:
  - "<Hint 1>"
  - "<Hint 2>"

# -----------------------------------------------------------
# OUTPUT ARTIFACTS
# Files or resources this epic is expected to produce.
# Paths relative to repo root. Populated before dispatching.
# -----------------------------------------------------------
output_artifacts:
  - path: "<relative/path/to/file>"
    description: "<What this file contains and who consumes it>"
```

---

## Template: Story

```yaml
# ============================================================
# STORY TASK FILE — Bellwright ModKit AI Agent Format v1.0
# ============================================================

id: STOR-{DOMAIN}-{SEQUENCE}-{PARENT_EPIC_ID}
level: story
status: pending

title: "<One sentence. Imperative verb. Scoped to a single feature or capability.>"

parent_epic: {PARENT_EPIC_ID}
owner: unassigned

created: "YYYY-MM-DD"
updated: "YYYY-MM-DD"

prerequisites:
  - "<TASK-ID or STOR-ID>"

context: |
  <Full background: game, modkit, why this story exists,
  what the parent epic is trying to achieve, technical
  constraints, relevant file locations if known, relevant
  URLs for research, UE5 / Blueprint / Lua constraints.>

goal: |
  <Specific, scoped outcome this story delivers. Narrow
  enough that a single agent can complete it in one session.>

child_tasks:
  - TASK-{DOMAIN}-{SEQUENCE}-{THIS_STORY_ID}

acceptance_criteria:
  - "<Agent-verifiable assertion. Reference specific file
     paths, expected file contents, bash commands that
     should return exit 0, or web-verifiable states.>"

agent_hints:
  - "<Ordering hint: which child tasks can run in parallel>"
  - "<Known failure mode for this type of story>"
  - "<Tool-specific advice: e.g., UE5 editor crash recovery>"

output_artifacts:
  - path: "<relative/path>"
    description: "<Content and consumer>"
```

---

## Template: Task

```yaml
# ============================================================
# TASK FILE — Bellwright ModKit AI Agent Format v1.0
# ============================================================

id: TASK-{DOMAIN}-{SEQUENCE}-{PARENT_STORY_ID}
level: task
status: pending

title: "<One sentence. Imperative verb. Single concrete action.>"

parent_story: {PARENT_STORY_ID}
owner: unassigned
estimated_duration: "<30m | 1h | 2h | 4h>"

created: "YYYY-MM-DD"
updated: "YYYY-MM-DD"

prerequisites:
  - "<TASK-ID>"

context: |
  <Complete background for a cold-start agent. Must include:
  - What Bellwright is and what the ModKit is
  - Why this specific task exists
  - Relevant file paths (absolute or repo-relative)
  - Relevant URLs the agent should consult
  - Technical environment: OS, UE5 version, tool versions
  - Any prior findings from prerequisite tasks (copy in
    key facts rather than referencing other files)>

instructions:
  - step: 1
    action: "<Exact action: search query, file path, bash command, URL to open>"
    tool: "<read | write | bash | web_search | browser>"
    expected_outcome: "<What the agent should observe if the step succeeded>"

  - step: 2
    action: "<Next action>"
    tool: "<tool>"
    expected_outcome: "<Observable outcome>"

acceptance_criteria:
  - type: file_exists
    path: "<relative/path/to/output>"
    description: "<Why this file's existence proves the task is done>"

  - type: file_contains
    path: "<relative/path>"
    expected_content: "<Substring or regex that must be present>"
    description: "<What this proves>"

  - type: bash_exit_0
    command: "<bash command>"
    description: "<What a zero exit code proves>"

output_artifacts:
  - path: "<relative/path>"
    format: "<yaml | json | md | txt | uasset | blueprint>"
    description: "<What it contains and which downstream task consumes it>"

agent_hints:
  - "<Hint 1: specific, not generic>"
  - "<Hint 2>"

failure_modes:
  - condition: "<What the agent observes when this failure occurs>"
    action: "<retry | skip | escalate | use_fallback>"
    fallback: "<Alternative approach if primary fails>"

escalation: |
  <Specific escalation instruction. If task cannot complete,
  write a NEGATIVE-FINDING-{ID}.md with all attempted
  approaches and results, then mark task complete.
  Do not block the parent story silently.>
```

---

## Field Reference Summary

| Field | Required At | Purpose |
|-------|-------------|---------|
| `id` | All levels | Unique identifier; encodes level, domain, sequence, parent |
| `level` | All levels | epic / story / task |
| `status` | All levels | Agent sets this; orchestrator reads it to detect completion |
| `title` | All levels | Human-readable label; imperative verb phrase |
| `parent_epic` / `parent_story` | Story / Task | Enables upward traversal without scanning all files |
| `owner` | All levels | Agent ID once dispatched; "unassigned" until then |
| `estimated_duration` | Task only | Helps orchestrator schedule and detect stalled agents |
| `prerequisites` | All levels | Task IDs (not descriptions); must match filenames exactly |
| `context` | All levels | Complete self-contained background; no cross-file refs |
| `goal` | All levels | Definition of done at this level |
| `child_stories` / `child_tasks` | Epic / Story | Explicit membership; completion rolls up |
| `instructions` | Task only | Ordered, tool-tagged steps with expected outcomes |
| `acceptance_criteria` | All levels | Machine-verifiable assertions with type tags |
| `output_artifacts` | All levels | Files produced; includes schema for Task level |
| `agent_hints` | All levels | Failure-mode prevention specific to this task type |
| `failure_modes` | Task only | Observed condition + action + fallback |
| `escalation` | Task only | What to do when all fallbacks are exhausted |

---

## Acceptance Criteria Types

| Type | What Agent Does |
|------|----------------|
| `file_exists` | `ls` or `Read` on the path |
| `file_contains` | Read file and check for substring or regex |
| `bash_exit_0` | Run command and check exit code |
| `web_verifiable` | Open URL and check page state via browser |

No criterion may require human judgment to evaluate.

---

## Rules for Writing New Tasks

1. **Never write "see parent task"** — repeat every necessary fact inline in `context`.
2. **Every prerequisite must be a file ID** that exists in `tasks/`. Orphan references are treated as permanent blockers.
3. **`instructions` steps must specify a `tool`** from: `read | write | bash | web_search | browser`.
4. **Every `acceptance_criteria` entry must have a `type`** — no open-ended quality judgments.
5. **`output_artifacts` at Task level must include `format`** — downstream tasks use this to choose a parser.
6. **Every Task must have an `escalation` block** — agents must never stall silently.
7. **`agent_hints` must be specific to this task** — generic UE5 advice belongs in shared docs, not here.

---

## Dependency Rules (No Race Conditions)

- Any task that **produces** files consumed by another task must be listed as a **prerequisite** of the consumer.
- Research tasks that **unblock technical decisions** must precede dependent development tasks.
- **E001 (Research) must precede E003–E007** — no development epic may start until research gates are resolved.
- **E002 (Environment Setup) must precede all mod development** — specifically S002-005 (smoke test) is the hard gate.
- **Testing/validation tasks** must follow the implementation tasks they validate.
- **Publishing tasks** must follow all feature tasks for a given mod.

### Parallel Execution is Safe When:
- Two tasks have **no shared output files**
- Neither task's output is a prerequisite for the other
- Both tasks read from the same source but write to different paths

### Parallel Execution is UNSAFE When:
- Both tasks write to the same file
- Task B reads from a file Task A is still writing
- Both tasks modify the ModKit project state concurrently
