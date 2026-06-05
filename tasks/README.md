# Bellwright Modding — Task Registry

This directory contains all work items for the Bellwright modding project, structured for execution by AI agents.

## Files

| File | Purpose |
|---|---|
| `TASK-FORMAT.md` | Task file schema, field definitions, ID convention, and dependency rules |
| `WBS.md` | Complete work breakdown structure — all Epics, Stories, and Tasks |

## Epic Overview

| ID | Epic | Priority | Gate |
|---|---|---|---|
| E001 | Research & Discovery | **Critical** | None — start here |
| E002 | Environment Setup | **Critical** | E001 |
| E003 | Bellwright Plus (QoL Overhaul) | High | E002 |
| E004 | UI & Information Overhaul | High | E002 |
| E005 | Visual & Atmospheric Enhancement Pack | Medium | E002 |
| E006 | Settlement Automation Tools | High | E002 + E001 S001-004 |
| E007 | Combat Systems Expansion | Medium | E002 + E001 S001-002 (go/no-go gate) |
| E008 | Documentation & Community | Medium | E002 |
| E009 | Testing & Validation | High | E003–E007 |
| E010 | Deployment & Workshop Publishing | High | E009 |

## Critical Path

```
E001 (Research) → E002 (Environment) → E003/E004/E005/E006/E007 (parallel) → E009 (Testing) → E010 (Publish)
                                         ↑
                               E008 (Docs) can start alongside development
```

## Dependency Rules

1. **E001 is the unconditional gate** — nothing in E003–E007 starts until research go/no-go flags are set
2. **S002-005 (smoke test) is the development gate** — all mod development requires a working end-to-end pipeline
3. **E007 (Combat) has a hard feasibility gate** — S007-001 must confirm ModKit combat Blueprint access before any combat work begins
4. **E006 (Automation) has a scope gate** — S006-001 ADR determines whether Blueprint or RE-UE4SS approach is used

## How to Execute Tasks

Each task is self-contained — an AI agent can execute it with only the task file. The agent should:

1. Read the task's `prerequisites` field and verify all are `status: complete`
2. Read the `context` block (no other files needed)
3. Follow `instructions` steps in order, using the specified `tool` for each
4. Verify each `acceptance_criteria` entry before marking complete
5. On failure, follow `failure_modes` and `escalation` — never stall silently

## Picking What to Work On

Not all tasks need to be executed. Suggested starting order for maximum value:

1. **Start**: E001/S001-001 (engine version), E001/S001-002 (ModKit API surface), E001/S001-003 (RE-UE4SS)
2. **Then**: E002 (environment setup + smoke test)
3. **High value, low risk**: E003 (QoL overhaul) — Tier 1 data work, no API unknowns
4. **High value, investigate first**: E004 (UI), E006 (automation) — needs API findings from E001
5. **Contingent**: E007 (combat) — skip if S007-001 feasibility gate fails
