# Bellwright Modding Project — Comprehensive Work Breakdown Structure

## EPICS

---

### E001 — Research & Discovery

- **ID:** E001
- **Type:** Epic
- **Status:** todo
- **Priority:** critical
- **Effort:** L
- **Prerequisites:** none
- **Description:** Investigate all technical unknowns that gate downstream development decisions. Covers engine version reconciliation, ModKit API surface mapping, RE-UE4SS compatibility verification, and automation/AI node exposure. Until these tasks are complete, no development Epic may begin.
- **Acceptance Criteria:**
  - All key unknowns listed in the project brief have a documented finding
  - Each finding references a reproducible evidence source (log file, screenshot, forum post, test project)
  - A go/no-go decision is recorded for each of the four development Epics
  - Findings are committed to `docs/research/`
- **Agent notes:** This Epic is the critical gate. Nothing in E003–E007 should be started until the four research Stories (S001-001 through S001-004) are complete and their go/no-go flags are recorded.

---

### E002 — Environment Setup

- **ID:** E002
- **Type:** Epic
- **Status:** todo
- **Priority:** critical
- **Effort:** M
- **Prerequisites:** E001
- **Description:** Install and validate the full modding toolchain: ModKit, RE-UE4SS, Steam Workshop CLI, and supporting utilities. Produces a verified, reproducible environment that every development Epic depends on. Includes a smoke-test mod that proves the pipeline end-to-end.
- **Acceptance Criteria:**
  - ModKit launches without errors and can cook a test asset
  - RE-UE4SS injects into Bellwright without crash (if go/no-go positive from E001)
  - Steam Workshop CLI can upload a placeholder mod entry
  - A "Hello World" mod is visible and functional in-game via Workshop subscription
  - Environment setup steps are documented in `docs/environment-setup.md`
- **Agent notes:** The smoke-test Story (S002-005) is the hard gate for all mod development. Do not begin any E003–E007 story until S002-005 passes.

---

### E003 — Bellwright Plus (Comprehensive QoL Overhaul)

- **ID:** E003
- **Type:** Epic
- **Status:** todo
- **Priority:** high
- **Effort:** XL
- **Prerequisites:** E002
- **Description:** A single configurable mod addressing the most common player friction points: carry weight, crafting queue limits, villager assignment limits, hunger/sleep decay rates, respawn timers, and fast travel unlock thresholds. Delivered as one Workshop mod with an in-game settings menu.
- **Acceptance Criteria:**
  - At least 10 independently toggleable QoL settings are exposed via an in-game UI panel
  - All numeric parameters are driven by data assets (no hardcoded values)
  - Mod loads cleanly on a fresh save and on existing saves
  - No conflicts with base-game systems when all settings are at default values
  - Published to Steam Workshop with description, screenshots, and changelog
- **Agent notes:** S003-001 (architecture) must be complete before any feature story. Feature stories S003-002 through S003-008 can execute in parallel once S003-001 is done.

---

### E004 — UI & Information Overhaul

- **ID:** E004
- **Type:** Epic
- **Status:** todo
- **Priority:** high
- **Effort:** XL
- **Prerequisites:** E002
- **Description:** Replaces or augments the base-game HUD, map, villager dashboard, and inventory screens with information-dense, keyboard/controller-navigable alternatives. Scope is gated by what ModKit exposes for HUD/widget Blueprints.
- **Acceptance Criteria:**
  - Enhanced map shows settlement radius, resource node icons, and NPC assignment zones
  - Villager dashboard lists all villagers with sortable columns (role, health, morale, task)
  - Inventory screen shows item weight, stack size, and quick-sort button
  - All new UI panels are dismissible and positionally persistent between sessions
  - Published to Steam Workshop
- **Agent notes:** S004-001 (widget framework) must precede all feature stories. The accessibility findings from T001-002-004 may constrain scope — confirm before investing in widget work.

---

### E005 — Visual & Atmospheric Enhancement Pack

- **ID:** E005
- **Type:** Epic
- **Status:** todo
- **Priority:** medium
- **Effort:** L
- **Prerequisites:** E002
- **Description:** Improves visual fidelity through texture upscaling, lighting parameter adjustments, and weather variety additions via ModKit, supplemented by a curated ReShade preset for post-process enhancement that works independently.
- **Acceptance Criteria:**
  - At least 20 material/texture assets are replaced with higher-resolution versions
  - Two new weather states (dense fog, overcast drizzle) are added via data assets
  - ReShade preset ships as a standalone download with install instructions
  - No measurable FPS regression (within 5%) on a reference GPU tier (RTX 3070 equivalent)
  - Published to Steam Workshop
- **Agent notes:** S005-003 (ReShade preset) has no ModKit dependency and can be started immediately, even before E002. The texture and lighting stories require ModKit.

---

### E006 — Settlement Automation Tools

- **ID:** E006
- **Type:** Epic
- **Status:** todo
- **Priority:** high
- **Effort:** XL
- **Prerequisites:** E002
- **Description:** Adds auto-routing for resource delivery between stockpiles and crafting stations, persistent task queues for villager roles, and a production chain visualiser. Scope is heavily gated by whether settlement/AI routing APIs are exposed in ModKit or require RE-UE4SS.
- **Acceptance Criteria:**
  - Resources in a designated stockpile are automatically routed to a linked crafting station when the queue is non-empty
  - Villager task queues persist through a save/load cycle
  - Production chain visualiser shows a DAG of inputs/outputs for any selected recipe
  - Automation rules can be paused/resumed per station from the UI
  - Published to Steam Workshop
- **Agent notes:** S006-001 (architecture decision, which depends on S001-004) is the hard gate for this entire Epic. Do not begin S006-002 or S006-003 until the ADR is written and the feasibility scope is bounded.

---

### E007 — Combat Systems Expansion

- **ID:** E007
- **Type:** Epic
- **Status:** todo
- **Priority:** medium
- **Effort:** XL
- **Prerequisites:** E002
- **Description:** Introduces status effects (bleed, stun, slow), three new weapon archetypes, two new enemy variants, and a combo-input system. Entirely gated on E001 confirming that combat Blueprints and enemy AI nodes are exposed in ModKit.
- **Acceptance Criteria:**
  - Three status effects apply, stack, and expire correctly without game crashes
  - New weapons appear in crafting recipes and have correct stat profiles
  - New enemy variants spawn in designated biome regions
  - Combo system activates via timed sequential inputs and plays distinct animations
  - Published to Steam Workshop
- **Agent notes:** S007-001 (feasibility gate) is the single most likely Epic-killing task in the project. If combat Blueprint nodes are not exposed, this entire Epic must be descoped. Do not begin any S007-00x story until T007-001-001 produces a go decision.

---

### E008 — Documentation & Community

- **ID:** E008
- **Type:** Epic
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** E002
- **Description:** Produces modder documentation (API surface map, tutorial series), Workshop descriptions and trailers, and a community engagement plan (Nexus Mods cross-post, Discord presence, bug report template).
- **Acceptance Criteria:**
  - Modder API surface document covers all confirmed-accessible nodes/classes
  - At least two tutorial articles are published (beginner data-table mod, intermediate Blueprint mod)
  - Each Workshop mod has a formatted description with feature list, install notes, and known issues
  - A GitHub repo hosts source assets under a permissive licence
  - Community bug report template is live
- **Agent notes:** S008-001 (API docs) can be started as soon as S001-002 and S001-003 are complete, independent of mod development. S008-003 (Workshop listings) depends on all mods being published and feeds into E010.

---

### E009 — Testing & Validation

- **ID:** E009
- **Type:** Epic
- **Status:** todo
- **Priority:** high
- **Effort:** L
- **Prerequisites:** E003, E004, E005, E006, E007
- **Description:** Structured cross-mod compatibility testing, regression testing against game updates, and player-facing beta programme. Catches conflicts between mods and validates that mods survive a base-game patch cycle.
- **Acceptance Criteria:**
  - All mods pass a compatibility matrix test (each pair of mods loaded together)
  - A regression test checklist exists and is executed after each game update
  - At least 10 external beta testers have provided structured feedback
  - All critical and high bugs found in beta are resolved before public release
  - Test results are logged in `docs/testing/`
- **Agent notes:** S009-003 (regression checklist) can be written during E003–E007 development, not just after. It is better to author the checklist while the mod behaviour is fresh.

---

### E010 — Deployment & Workshop Publishing

- **ID:** E010
- **Type:** Epic
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** E009
- **Description:** Final cook, packaging, and Workshop publication of all mods, including versioning, update notification hooks, and a release communication plan.
- **Acceptance Criteria:**
  - All mods are cooked in Shipping configuration without errors
  - Each mod has a distinct Workshop item ID, version tag, and dependency list
  - Update notes are posted to Workshop and community channels on release
  - A rollback procedure is documented for reverting a bad Workshop update
  - All mod source assets are tagged with a matching Git release tag
- **Agent notes:** T010-002-003 (rollback procedure) should be written and tested before the go-live date, not after. Do not allow public release without a tested rollback path.

---

## STORIES

---

### S001-001 — Engine Version Reconciliation

- **ID:** S001-001
- **Type:** Story
- **Parent:** E001
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** none
- **Description:** Determine the exact UE5 version embedded in the Bellwright game binary and compare it against the ModKit version (reported 5.5.4). Identify whether asset compatibility shims are needed and whether Blueprint nodes differ between versions.
- **Acceptance Criteria:**
  - UE5 build version string extracted from game binary and logged
  - Version delta between game binary and ModKit identified (patch/minor/major)
  - Community forum posts or official statements corroborating version information are cited
  - A written compatibility assessment is committed to `docs/research/engine-version.md`
  - Go/no-go flag set for whether ModKit-cooked assets load without version mismatch errors
- **Agent notes:** Three tasks: binary extraction (T001-001-001), community source search (T001-001-002), and document write-up (T001-001-003). All three must complete before this Story is done.

---

### S001-002 — ModKit API Surface Mapping

- **ID:** S001-002
- **Type:** Story
- **Parent:** E001
- **Status:** todo
- **Priority:** critical
- **Effort:** M
- **Prerequisites:** S001-001
- **Description:** Open the ModKit editor and systematically enumerate which Blueprint classes, data table schemas, and nodes are exposed for modding. Focus on quest/NPC AI, settlement management, combat, and UI subsystems.
- **Acceptance Criteria:**
  - A markdown table lists every confirmed-accessible Blueprint parent class
  - Quest and NPC AI Blueprint node availability is explicitly documented (yes/no/partial)
  - Combat Blueprint node availability is explicitly documented
  - Settlement/resource-routing API availability is explicitly documented
  - Document committed to `docs/research/modkit-api-surface.md`
- **Agent notes:** Five tasks covering NPC AI (T001-002-002), combat (T001-002-003), UI widgets (T001-002-004), data tables (T001-002-005), and the final document (T001-002-006), all preceded by a class enumeration task (T001-002-001).

---

### S001-003 — RE-UE4SS Compatibility Verification

- **ID:** S001-003
- **Type:** Story
- **Parent:** E001
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S001-001
- **Description:** Test whether the current RE-UE4SS release injects cleanly into Bellwright without crashing and verify that the Lua console and C++ API are functional.
- **Acceptance Criteria:**
  - RE-UE4SS injection attempt is documented with exact version numbers
  - Lua `print("hello")` executes and appears in the RE-UE4SS console without crash
  - At least one UObject property is successfully read via Lua API
  - Crash or incompatibility findings are logged with full error output
  - Go/no-go flag committed to `docs/research/re-ue4ss-compatibility.md`
- **Agent notes:** Tasks run sequentially: download/pin version (T001-003-001), inject (T001-003-002), run Lua test (T001-003-003), write document (T001-003-004).

---

### S001-004 — Settlement & Automation API Investigation

- **ID:** S001-004
- **Type:** Story
- **Parent:** E001
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S001-002, S001-003
- **Description:** Determine whether villager task assignment, resource routing, and production queue systems have any accessible hooks in either the ModKit or RE-UE4SS API. This gates the entire E006 scope.
- **Acceptance Criteria:**
  - ModKit Blueprint node search results for "villager", "task", "route", and "queue" are documented
  - RE-UE4SS UObject dump is searched for relevant class names and findings recorded
  - A scoped statement of what is achievable (full/partial/none) is written
  - Alternative implementation approaches are proposed if direct API access is unavailable
  - Findings committed to `docs/research/automation-api.md`
- **Agent notes:** Depends on both S001-002 (ModKit) and S001-003 (RE-UE4SS). Tasks: ModKit search (T001-004-001), UObject dump search (T001-004-002), write document (T001-004-003).

---

### S002-001 — ModKit Installation & Configuration

- **ID:** S002-001
- **Type:** Story
- **Parent:** E002
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** S001-001
- **Description:** Install the Bellwright ModKit via Epic Games Store, configure project settings, and verify that the editor launches and can open sample content.
- **Acceptance Criteria:**
  - ModKit installs without errors on the development machine
  - Sample content project opens without missing asset warnings
  - Editor version string is recorded
  - Project settings (target platform, cook directory) are configured and saved
  - Setup steps documented in `docs/environment-setup.md`
- **Agent notes:** Tasks: install (T002-001-001), launch and verify (T002-001-002), configure settings (T002-001-003). Must precede all other E002 stories.

---

### S002-002 — Source Control Setup for Mod Assets

- **ID:** S002-002
- **Type:** Story
- **Parent:** E002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S002-001
- **Description:** Initialise a Git repository with a `.gitignore` tuned for UE5 and configure Git LFS for binary asset types.
- **Acceptance Criteria:**
  - Git repo initialised with correct `.gitignore` (no Intermediate or DerivedDataCache files tracked)
  - Git LFS tracking `.uasset`, `.umap`, `.png`, `.fbx`, `.wav`
  - Initial commit contains only source-controlled files
  - Remote repository is created and first push succeeds
  - `docs/contributing.md` documents the LFS setup steps
- **Agent notes:** Tasks: init repo (T002-002-001), configure LFS (T002-002-002), create remote and push (T002-002-003).

---

### S002-003 — RE-UE4SS Installation & Baseline

- **ID:** S002-003
- **Type:** Story
- **Parent:** E002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S001-003, S002-001
- **Description:** Install RE-UE4SS into the Bellwright game directory and verify a baseline Lua script runs on game launch. Conditional on S001-003 go/no-go being positive.
- **Acceptance Criteria:**
  - RE-UE4SS DLLs are present in the correct game directory path
  - `UE4SS-settings.ini` is configured with correct game name and logging paths
  - Baseline Lua mod executes on game launch
  - Console output confirms script loaded without errors
  - Steps documented in `docs/environment-setup.md`
- **Agent notes:** If S001-003 go/no-go is negative, this Story is skipped and all RE-UE4SS-dependent features across E003–E007 must be descoped.

---

### S002-004 — Steam Workshop CLI Setup

- **ID:** S002-004
- **Type:** Story
- **Parent:** E002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S002-001
- **Description:** Configure the Steam Workshop upload pipeline, create placeholder Workshop items for all five mods, and verify that a cooked mod package can be uploaded and subscribed to.
- **Acceptance Criteria:**
  - Steam Workshop developer account is linked to the upload tool
  - Five placeholder Workshop items exist (one per mod), all private
  - A cooked `.pak` file uploads successfully
  - The uploaded mod appears in the in-game mod browser after subscription
  - Upload command is scripted and documented in `docs/workshop-publishing.md`
- **Agent notes:** Tasks: configure CLI (T002-004-001), create first placeholder item (T002-004-002), create remaining four placeholders (T002-004-003).

---

### S002-005 — End-to-End Pipeline Smoke Test

- **ID:** S002-005
- **Type:** Story
- **Parent:** E002
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** S002-001, S002-002, S002-003, S002-004
- **Description:** Create, cook, upload, and in-game verify a minimal data table override mod to validate the full pipeline before any real development begins.
- **Acceptance Criteria:**
  - A data table row is modified (e.g., player carry weight +1)
  - Mod cooks without errors in Development configuration
  - Cooked mod uploads to Workshop and downloads via subscription
  - In-game value reflects the modification
  - The smoke test mod is committed to `mods/SmokeTest/`
- **Agent notes:** This is the most important Story in E002. If any step fails, the pipeline is broken and E003–E007 cannot begin. Tasks: create and cook (T002-005-001), upload (T002-005-002), verify in-game (T002-005-003).

---

### S003-001 — QoL Settings Architecture

- **ID:** S003-001
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S002-005
- **Description:** Design and implement the configuration Data Asset schema and in-game settings panel Blueprint that backs all QoL settings. All individual QoL feature stories depend on this.
- **Acceptance Criteria:**
  - `DA_BellwrightPlus_Config` Data Asset is defined with typed fields for each setting
  - Default values match vanilla game behaviour
  - In-game settings panel Blueprint opens from the pause menu
  - Settings persist to save file between sessions
  - Architecture document committed to `docs/mods/bellwright-plus/architecture.md`
- **Agent notes:** Tasks: define Data Asset class (T003-001-001), implement persistence (T003-001-002), create settings panel Blueprint (T003-001-003). Feature stories S003-002 through S003-008 must not start until all three tasks are done.

---

### S003-002 — Carry Weight & Inventory Limits

- **ID:** S003-002
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Expose player carry weight limit and inventory slot count as configurable settings, driven by the config Data Asset.
- **Acceptance Criteria:**
  - Carry weight limit is adjustable from 0.5x to 5x vanilla in 0.1x increments
  - Inventory slot count is adjustable from vanilla to 2x vanilla
  - Changes take effect immediately without requiring a save/reload
  - Default values reproduce vanilla behaviour exactly
  - Setting labels and tooltips are present in the UI panel
- **Agent notes:** Tasks: locate data table (T003-002-001), implement override (T003-002-002).

---

### S003-003 — Crafting Queue & Batch Size

- **ID:** S003-003
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Increase the maximum crafting queue depth and per-craft batch size limits via data table overrides and config-driven Blueprint logic.
- **Acceptance Criteria:**
  - Crafting queue depth is configurable from vanilla up to 50 items
  - Batch craft size is configurable from vanilla up to 100 units per action
  - Queue overflow is handled gracefully
  - Default values match vanilla
  - Feature is independently toggled from other QoL settings
- **Agent notes:** Locate the crafting queue data table (parallel approach to T003-002-001). Check for a queue depth field in the crafting station data table or a Blueprint variable on the crafting station actor.

---

### S003-004 — Villager Assignment Limits

- **ID:** S003-004
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Remove or raise the cap on how many villagers can be assigned to a single building or role, configurable via the settings panel.
- **Acceptance Criteria:**
  - Per-building villager cap is configurable from vanilla up to unlimited (0 = unlimited)
  - Per-role global cap is separately configurable
  - Existing assignments are preserved when the cap is raised
  - Setting the cap below current assignments clamps gracefully without crashing
  - Default values match vanilla
- **Agent notes:** Locate the building definition data table. Look for fields named "MaxWorkers", "VillagerCap", "AssignmentLimit" or similar. If the cap is in a Blueprint variable rather than a data table, a runtime override via Blueprint node will be needed.

---

### S003-005 — Hunger, Sleep & Needs Decay Rates

- **ID:** S003-005
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Expose player and villager hunger/sleep/morale decay multipliers as configurable settings.
- **Acceptance Criteria:**
  - Player hunger decay rate configurable from 0 (disabled) to 2x vanilla
  - Player sleep decay rate configurable from 0 to 2x vanilla
  - Villager morale decay rate configurable from 0 to 2x vanilla
  - All three settings are independent sliders
  - Zero value correctly disables the mechanic without errors
- **Agent notes:** Locate the needs/survival data table. If decay rates are driven by a curve asset or Blueprint timer rather than a data table float, document the approach chosen and any limitations.

---

### S003-006 — Respawn & Cooldown Timers

- **ID:** S003-006
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Expose enemy respawn timers, resource node respawn timers, and player death cooldown as configurable multipliers.
- **Acceptance Criteria:**
  - Enemy respawn timer configurable from 0.1x to 5x vanilla
  - Resource node respawn timer configurable from 0.1x to 5x vanilla
  - Player death cooldown configurable from 0 to vanilla value
  - All three settings are independent
  - Default values match vanilla
- **Agent notes:** Search for data tables named with "Spawn", "Respawn", "Death", "Cooldown". These may be in separate tables per entity type. Document each table path in `docs/mods/bellwright-plus/data-table-map.md`.

---

### S003-007 — Fast Travel Unlock Thresholds

- **ID:** S003-007
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Lower or remove the settlement reputation/progression thresholds required to unlock fast travel points.
- **Acceptance Criteria:**
  - Fast travel unlock threshold configurable from 0% (always unlocked) to 100% (vanilla)
  - Existing unlocked fast travel points preserved at any setting
  - Setting to 0% unlocks all points immediately on load
  - Default value matches vanilla
  - Setting is clearly labelled with a note about its impact on game progression
- **Agent notes:** This may be a numeric field on the fast travel point Blueprint or in a progression data table. If it is a Blueprint variable with no data table backing, a runtime Blueprint override is needed.

---

### S003-008 — XP & Progression Rate Multipliers

- **ID:** S003-008
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S003-001
- **Description:** Add XP gain multipliers for player skills and technology research speed as configurable settings.
- **Acceptance Criteria:**
  - Player skill XP multiplier configurable from 0.5x to 10x
  - Technology research speed multiplier configurable from 0.5x to 10x
  - Multipliers apply to all skill/tech paths uniformly
  - Default is 1x (vanilla)
  - Values above 1x are clearly marked as affecting game balance
- **Agent notes:** Locate the skill XP and tech research data tables. These are often separate tables. If XP is granted via a Blueprint event rather than a data table lookup, a multiplier may need to be injected via a Blueprint patch.

---

### S003-009 — Bellwright Plus — Cook, Package & Publish

- **ID:** S003-009
- **Type:** Story
- **Parent:** E003
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S003-002, S003-003, S003-004, S003-005, S003-006, S003-007, S003-008
- **Description:** Cook the complete Bellwright Plus mod in Shipping configuration and publish to Steam Workshop.
- **Acceptance Criteria:**
  - Mod cooks in Shipping without errors or warnings
  - Workshop listing has a feature list, installation notes, and at least 3 screenshots
  - Version 1.0.0 tag is applied in Git and on Workshop
  - Mod is subscribe-and-play with no manual file installation required
  - Update/changelog section is present on the Workshop page
- **Agent notes:** All eight feature stories (S003-002 through S003-008) plus the architecture story (S003-001) must be complete before cooking. Verify the Shipping cook produces a smaller pak file than the Development cook (expected).

---

### S004-001 — UI Mod Architecture & Widget Framework

- **ID:** S004-001
- **Type:** Story
- **Parent:** E004
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S002-005, S001-002
- **Description:** Establish the Blueprint widget framework for all UI mod panels — base widget class, theme data asset, input handling, and persistence layer. All UI feature stories depend on this.
- **Acceptance Criteria:**
  - `WBP_BellwrightUI_Base` widget Blueprint is created with shared styling properties
  - `DA_UITheme` Data Asset defines colours, fonts, and spacing
  - Input handling routes keyboard and gamepad navigation correctly
  - Panel position and visibility state persists across sessions
  - Framework committed and importable by all subsequent UI stories
- **Agent notes:** Tasks: create base widget (T004-001-001), create theme Data Asset (T004-001-002), implement persistence layer (T004-001-003). All three must complete before S004-002 through S004-005 can begin.

---

### S004-002 — Enhanced World Map

- **ID:** S004-002
- **Type:** Story
- **Parent:** E004
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S004-001
- **Description:** Replace or overlay the base-game world map with an enhanced version showing settlement influence radius, resource node type icons, NPC assignment zones, and a mini-legend.
- **Acceptance Criteria:**
  - Settlement influence radius is drawn as a coloured overlay circle on the map
  - At least 6 resource node types have distinct icons
  - NPC assignment zones are shown as coloured regions when a villager role is selected
  - Map supports zoom in/out via scroll wheel and keyboard shortcuts
  - Icons are toggleable via a filter panel
- **Agent notes:** Access to map data (settlement radius, resource node positions) must be verified against the S001-002 findings. If the map widget is not extensible, this story must be rescoped as a standalone overlay widget drawn on top of the vanilla map.

---

### S004-003 — Villager Dashboard

- **ID:** S004-003
- **Type:** Story
- **Parent:** E004
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S004-001
- **Description:** Add a full-screen villager management dashboard listing all recruited villagers with sortable columns.
- **Acceptance Criteria:**
  - Dashboard lists every villager currently in the settlement
  - Columns are sortable ascending/descending by click
  - Clicking a villager row opens their assignment panel
  - Dashboard updates in real time (no stale data after 1 second)
  - Accessible from pause menu and a configurable hotkey
- **Agent notes:** Depends on villager data (list of villager actors, their roles, health, morale, current task) being accessible via Blueprint. Verify this against S001-002 findings. If the villager manager class is not Blueprint-accessible, use a RE-UE4SS Lua bridge to feed the data.

---

### S004-004 — Enhanced Inventory Screen

- **ID:** S004-004
- **Type:** Story
- **Parent:** E004
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** S004-001
- **Description:** Augment the inventory screen with per-item weight display, stack size indicator, category filter tabs, and a one-click sort button.
- **Acceptance Criteria:**
  - Each inventory slot shows item weight in small text
  - Stack size is shown as a numeric badge
  - Category filter tabs filter the inventory grid
  - Sort button orders items by category then name
  - All additions are non-destructive overlays on the existing inventory widget
- **Agent notes:** Prefer overlaying the existing inventory widget rather than replacing it, to maximise compatibility with other mods. If the inventory widget is not extensible (confirmed via T001-002-004), a full replacement is required with a compatibility warning on the Workshop page.

---

### S004-005 — HUD Information Density Improvements

- **ID:** S004-005
- **Type:** Story
- **Parent:** E004
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S004-001
- **Description:** Add optional HUD overlays for carry weight percentage, active villager alerts, and nearby resource node indicators.
- **Acceptance Criteria:**
  - Carry weight bar shows current/max with colour transition at 80% and 100%
  - Villager alert badge shows count of villagers with critical health or zero morale
  - Resource node indicators appear within a configurable radius
  - All three HUD elements are individually toggleable
  - HUD elements do not overlap with vanilla HUD elements at default positions
- **Agent notes:** HUD overlay widgets should be added as separate `AddToViewport` calls at a higher Z-order than the vanilla HUD, not by modifying the vanilla HUD widget directly.

---

### S004-006 — UI Overhaul — Cook, Package & Publish

- **ID:** S004-006
- **Type:** Story
- **Parent:** E004
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S004-002, S004-003, S004-004, S004-005
- **Description:** Cook the UI overhaul mod in Shipping configuration and publish to Steam Workshop.
- **Acceptance Criteria:**
  - Mod cooks without errors
  - Workshop listing documents which vanilla UI elements are replaced/augmented
  - Compatibility note for Bellwright Plus mod is included
  - Version 1.0.0 tag applied in Git and Workshop
  - Install/uninstall instructions present
- **Agent notes:** The Workshop description must clearly state which UI elements are modified so users loading alongside other UI mods understand what may conflict.

---

### S005-001 — Texture Upscaling Pipeline

- **ID:** S005-001
- **Type:** Story
- **Parent:** E005
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** S002-005
- **Description:** Establish a repeatable pipeline for selecting vanilla textures, upscaling them 2x using an AI upscaler, reimporting into ModKit, and validating compression settings.
- **Acceptance Criteria:**
  - Pipeline script automates batch upscaling for a given texture list
  - At least 20 environment textures are upscaled and reimported
  - Texture compression settings match or improve on vanilla
  - No visible tiling artefacts introduced
  - Pipeline documented in `docs/mods/visuals/texture-pipeline.md`
- **Agent notes:** Tasks: catalogue textures (T005-001-001), set up Real-ESRGAN (T005-001-002), reimport into ModKit (T005-001-003).

---

### S005-002 — Lighting & Weather Data Adjustments

- **ID:** S005-002
- **Type:** Story
- **Parent:** E005
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** S002-005, S001-002
- **Description:** Modify sky atmosphere, directional light, and weather data assets to improve time-of-day lighting quality and add two new weather states.
- **Acceptance Criteria:**
  - Golden-hour lighting is visibly warmer and more directional than vanilla
  - Dense fog weather state triggers and clears correctly
  - Overcast drizzle weather state includes particle effects and reduced sun intensity
  - New weather states appear in the rotation with configurable frequency
  - No lighting artefacts introduced
- **Agent notes:** Requires weather data table/Blueprint accessibility, confirmed in S001-002. If the weather system is not data-driven, lighting tweaks via sky atmosphere overrides are the fallback scope.

---

### S005-003 — ReShade Preset

- **ID:** S005-003
- **Type:** Story
- **Parent:** E005
- **Status:** todo
- **Priority:** low
- **Effort:** S
- **Prerequisites:** none
- **Description:** Create a curated ReShade preset for Bellwright that improves colour grading, ambient occlusion, and sharpness without breaking UI readability or causing excessive performance loss.
- **Acceptance Criteria:**
  - ReShade preset file is tuned specifically for Bellwright's art style
  - UI elements remain fully readable with the preset active
  - FPS impact is below 5% on an RTX 3070 equivalent at 1440p
  - Installation instructions are written
  - Preset is distributed as a standalone download separate from Workshop mods
- **Agent notes:** No ModKit or RE-UE4SS dependency. Can begin immediately. Use SMAA anti-aliasing, Ambient Light, and Clarity shaders as a starting point. Avoid lens effects (vignette, lens flare) that clash with Bellwright's tone.

---

### S005-004 — Visuals Pack — Cook, Package & Publish

- **ID:** S005-004
- **Type:** Story
- **Parent:** E005
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S005-001, S005-002, S005-003
- **Description:** Cook and publish the visual enhancement pack to Steam Workshop, and distribute the ReShade preset via a linked GitHub release.
- **Acceptance Criteria:**
  - Workshop mod contains upscaled textures and weather data assets
  - ReShade preset is linked from the Workshop description
  - Performance benchmarks are included in the description
  - Version 1.0.0 tagged in Git and Workshop
  - Known conflicts (e.g., other texture mods) are documented
- **Agent notes:** The ReShade preset ships separately from the Workshop mod. Link the GitHub release (not the raw file) from the Workshop description for download tracking.

---

### S006-001 — Automation Architecture Decision

- **ID:** S006-001
- **Type:** Story
- **Parent:** E006
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** S001-004
- **Description:** Based on S001-004 findings, decide whether settlement automation will be implemented via ModKit Blueprints, RE-UE4SS Lua, or a hybrid approach.
- **Acceptance Criteria:**
  - Implementation approach is selected with written rationale
  - Scope is explicitly bounded by what the chosen approach can access
  - Infeasible features are formally descoped with explanation
  - Architecture document committed to `docs/mods/automation/architecture.md`
  - Go/no-go for each automation sub-feature (routing, task queues, visualiser) is recorded
- **Agent notes:** Task: write ADR (T006-001-001). This is the hardest architectural decision in the project. The visualiser (S006-004) is purely UI and is almost certainly feasible regardless; the routing (S006-002) and task queues (S006-003) depend critically on villager task class access.

---

### S006-002 — Resource Auto-Routing Rules Engine

- **ID:** S006-002
- **Type:** Story
- **Parent:** E006
- **Status:** todo
- **Priority:** high
- **Effort:** L
- **Prerequisites:** S006-001, S002-005
- **Description:** Implement the core auto-routing logic that monitors stockpile contents and triggers villager carry tasks to feed linked crafting stations.
- **Acceptance Criteria:**
  - A "link stockpile to station" action is available in the station UI
  - When station input buffer drops below 25% (configurable), a carry task is generated
  - Villagers with no current task are assigned the carry task automatically
  - Routing rules persist through save/load cycles
  - Routing can be paused per link without deleting the rule
- **Agent notes:** Implementation approach is determined by S006-001. If RE-UE4SS Lua is required, this story will take significantly longer than estimated. The persist-through-save requirement is the most technically difficult aspect; plan for it explicitly.

---

### S006-003 — Persistent Villager Task Queues

- **ID:** S006-003
- **Type:** Story
- **Parent:** E006
- **Status:** todo
- **Priority:** high
- **Effort:** L
- **Prerequisites:** S006-001, S002-005
- **Description:** Replace ephemeral villager task assignment with a persistent FIFO queue per villager allowing up to 5 pre-scheduled tasks.
- **Acceptance Criteria:**
  - Each villager has a task queue panel showing up to 5 queued tasks
  - Tasks execute in FIFO order; completed tasks are removed automatically
  - Queue state persists through save/load
  - Tasks can be reordered by drag-and-drop
  - Invalid tasks are skipped with a log entry, not silently stalled
- **Agent notes:** The drag-and-drop reordering requires a `DragDropOperation` Blueprint in UMG. The "invalid task skipped" behaviour requires detecting when a queued task's preconditions (resource availability) are no longer met.

---

### S006-004 — Production Chain Visualiser

- **ID:** S006-004
- **Type:** Story
- **Parent:** E006
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** S006-001, S004-001
- **Description:** Add a UI panel that renders the full directed acyclic graph of resource inputs and outputs for any selected recipe, showing what feeds what across multiple production stages.
- **Acceptance Criteria:**
  - Selecting any recipe opens a DAG panel showing all upstream inputs recursively
  - Each node shows current stockpile count vs required count
  - Nodes with insufficient stock are highlighted in red
  - DAG updates in real time as stockpile levels change
  - Panel is accessible from any crafting station UI
- **Agent notes:** Recipe data is almost certainly available via data tables (confirmed in T001-002-005). Build the DAG renderer as a recursive Blueprint function that traverses recipe input rows. The UI is a `CanvasPanel` with dynamically placed node widgets and line connections drawn via `DrawLine` calls in `OnPaint`.

---

### S006-005 — Automation Tools — Cook, Package & Publish

- **ID:** S006-005
- **Type:** Story
- **Parent:** E006
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S006-002, S006-003, S006-004
- **Description:** Cook and publish the automation tools mod to Steam Workshop, noting any RE-UE4SS dependency in the Workshop description if applicable.
- **Acceptance Criteria:**
  - Mod cooks without errors (or RE-UE4SS Lua bundle is packaged correctly)
  - Workshop description clearly states whether RE-UE4SS is a required dependency
  - Dependency link to RE-UE4SS Workshop item is set if applicable
  - Version 1.0.0 tagged
  - Known performance implications of auto-routing are documented
- **Agent notes:** If RE-UE4SS is a dependency, the Workshop item must use the "Required Items" field to link the RE-UE4SS Workshop item. Include a performance note: auto-routing polling frequency (default: every 10 seconds) and how to tune it.

---

### S007-001 — Combat Mod Feasibility Gate

- **ID:** S007-001
- **Type:** Story
- **Parent:** E007
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** S001-002
- **Description:** Evaluate S001-002 findings to determine whether combat Blueprint nodes are exposed in ModKit. Gate all S007-00x stories on a positive outcome.
- **Acceptance Criteria:**
  - Combat Blueprint parent class accessibility enumerated
  - Status effect system hooks documented
  - Weapon component attachment API availability confirmed or denied
  - Enemy AI behaviour tree editability confirmed or denied
  - Go/no-go decision committed to `docs/mods/combat/adr-001-feasibility.md`
- **Agent notes:** Task: T007-001-001. The three key gates are: (1) weapon Blueprint subclassable? (2) status effect applicable via Blueprint? (3) enemy spawn data tables modifiable? All three must be "yes" or "partial" for the mod to proceed.

---

### S007-002 — Status Effects System

- **ID:** S007-002
- **Type:** Story
- **Parent:** E007
- **Status:** todo
- **Priority:** high
- **Effort:** L
- **Prerequisites:** S007-001, S002-005
- **Description:** Implement bleed, stun, and slow status effects as Blueprint components that can be applied to any actor with a health component.
- **Acceptance Criteria:**
  - Bleed applies damage over time at a configurable tick rate and duration
  - Stun interrupts current action and prevents input for a configurable duration
  - Slow reduces movement speed by a configurable percentage for a configurable duration
  - Multiple instances stack correctly (refresh or add, configurable)
  - Visual indicators (UI icon + particle effect) are shown on affected actors
- **Agent notes:** Implement each status effect as a separate `ActorComponent` Blueprint. Apply via `AddComponent` on the target actor. The stacking behaviour should default to "refresh duration" to avoid snowball effects in early testing.

---

### S007-003 — New Weapon Archetypes

- **ID:** S007-003
- **Type:** Story
- **Parent:** E007
- **Status:** todo
- **Priority:** medium
- **Effort:** L
- **Prerequisites:** S007-001, S002-005
- **Description:** Add three new weapon archetypes: war scythe (reach + bleed), buckler (parry + stun), and recurve bow (long range + slow arrows), with crafting recipes and stat profiles.
- **Acceptance Criteria:**
  - All three weapons appear in appropriate crafting station recipe lists
  - Each weapon has correct stats relative to vanilla equivalents
  - War scythe applies bleed on hit; recurve arrows apply slow; buckler bash applies stun
  - Weapons use placeholder animations that do not clip through terrain
  - Item icons and descriptions are present in the inventory
- **Agent notes:** Weapon icons can be placeholder vector art for v1.0.0 — note this in the Workshop description as a known limitation. Focus on mechanical correctness first. The buckler is a shield variant, not a weapon — verify it fits the equipment slot system.

---

### S007-004 — New Enemy Variants

- **ID:** S007-004
- **Type:** Story
- **Parent:** E007
- **Status:** todo
- **Priority:** medium
- **Effort:** L
- **Prerequisites:** S007-001, S002-005
- **Description:** Add two new enemy variants — an armoured bandit (high HP, slow, bleed-resistant) and a skirmisher (low HP, fast, applies slow on hit) — with spawn entries in appropriate biome regions.
- **Acceptance Criteria:**
  - Both variants spawn in at least two biome regions at correct difficulty tiers
  - Armoured bandit has 2x HP and 50% bleed resistance compared to vanilla bandit
  - Skirmisher has 0.7x HP and 1.4x movement speed
  - Both variants have loot tables with at least one unique drop
  - Enemy names and descriptions appear correctly in the kill feed
- **Agent notes:** New enemy variants should subclass the closest vanilla enemy Blueprint and override stat rows in data tables. Avoid creating entirely new AI Blueprints for v1.0.0 — inherit vanilla AI behaviour and only modify stats and spawning.

---

### S007-005 — Combo Input System

- **ID:** S007-005
- **Type:** Story
- **Parent:** E007
- **Status:** todo
- **Priority:** medium
- **Effort:** L
- **Prerequisites:** S007-002, S007-003
- **Description:** Implement a timed sequential input combo system where LLH and LHL input sequences trigger enhanced attacks with unique animations and status effect application.
- **Acceptance Criteria:**
  - Two combo sequences (LLH and LHL) recognised with a 400ms input window
  - Each combo plays a distinct attack animation
  - LLH combo applies stun on the final hit; LHL applies bleed
  - Combo window is visualised with a brief on-screen indicator
  - Combo system does not interfere with vanilla attack inputs outside the window
- **Agent notes:** Implement the combo detection as a state machine Blueprint on the player character. State transitions are triggered by input events within the time window. The 400ms window is a starting point — expose it as a config variable for tuning.

---

### S007-006 — Combat Expansion — Cook, Package & Publish

- **ID:** S007-006
- **Type:** Story
- **Parent:** E007
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S007-002, S007-003, S007-004, S007-005
- **Description:** Cook and publish the combat expansion mod to Steam Workshop.
- **Acceptance Criteria:**
  - Mod cooks without errors in Shipping configuration
  - Workshop description includes a compatibility note for Bellwright Plus (stat multiplier interactions)
  - Version 1.0.0 tagged in Git and Workshop
  - Known balance implications are documented
  - A balance/feedback section is present on the Workshop page
- **Agent notes:** The combo system (S007-005) interacts with the Bellwright Plus XP multiplier (S003-008). Document this interaction explicitly: combo kills may grant XP at a different rate than expected when both mods are active.

---

### S008-001 — Modder API Documentation

- **ID:** S008-001
- **Type:** Story
- **Parent:** E008
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** S001-002, S001-003
- **Description:** Compile ModKit API surface map and RE-UE4SS findings into a structured modder reference document covering accessible classes, data table schemas, Blueprint patterns, and Lua API examples.
- **Acceptance Criteria:**
  - Document covers all confirmed-accessible Blueprint parent classes with brief descriptions
  - At least 5 data table schema definitions are documented with field types
  - At least 3 Lua API examples are provided with expected output
  - Document published to the project GitHub wiki or Nexus Mods article
  - Document version is tied to game version and ModKit version
- **Agent notes:** Task: T008-001-001. This document is valuable to the entire Bellwright modding community — write it for a public audience, not just internal reference.

---

### S008-002 — Tutorial Series

- **ID:** S008-002
- **Type:** Story
- **Parent:** E008
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** S002-005, S008-001
- **Description:** Write and publish two tutorials: one beginner article covering data table modification, and one intermediate article covering Blueprint widget creation for a HUD overlay.
- **Acceptance Criteria:**
  - Beginner tutorial covers: install ModKit, find a data table, modify a value, cook, upload to Workshop
  - Intermediate tutorial covers: create a widget Blueprint, bind to a game variable, cook, upload
  - Both tutorials include screenshots of each step
  - Both tutorials are published to Nexus Mods article section or community wiki
  - Both tutorials are cross-posted to the Bellwright community Discord
- **Agent notes:** Task: T008-001-001 must be done first (API surface needed for accurate tutorial content). Write tutorials using the Smoke Test mod (S002-005) as the beginner example — it was already built and tested.

---

### S008-003 — Workshop Listings & Community Setup

- **ID:** S008-003
- **Type:** Story
- **Parent:** E008
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S003-009, S004-006, S005-004, S006-005, S007-006
- **Description:** Finalise all Workshop mod listings and set up a community hub for bug reports and feedback.
- **Acceptance Criteria:**
  - All Workshop mod pages have structured descriptions with feature list, requirements, and known issues
  - A bug report template is live in the community hub
  - All mod source repos are public with permissive licence
  - Discord/GitHub link is present on every Workshop page
  - Mod collection grouping all five mods is created on Workshop
- **Agent notes:** Task: T008-001-001 feeds the description content. The Workshop collection creation is the final step — do it after all five individual items are published and confirmed working.

---

### S009-001 — Cross-Mod Compatibility Matrix Testing

- **ID:** S009-001
- **Type:** Story
- **Parent:** E009
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S003-009, S004-006, S005-004, S006-005, S007-006
- **Description:** Test every pairwise combination of the five released mods loaded together. Document any conflicts, crashes, or unexpected interactions.
- **Acceptance Criteria:**
  - All 10 pairwise combinations (C(5,2)) are tested
  - All three-mod and higher combinations are tested for the most likely user combinations
  - Each conflict is logged with reproduction steps in `docs/testing/compatibility-matrix.md`
  - All critical conflicts are resolved before public release
  - A compatibility table is added to each Workshop listing
- **Agent notes:** Task: T009-001-001. The most likely conflicts are: Bellwright Plus stat multipliers vs Combat Expansion stat profiles, and UI Overhaul widget overlaps with Automation Tools' new UI panels.

---

### S009-002 — Beta Programme

- **ID:** S009-002
- **Type:** Story
- **Parent:** E009
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S009-001
- **Description:** Recruit at least 10 external beta testers, distribute pre-release Workshop builds, and collect structured feedback.
- **Acceptance Criteria:**
  - At least 10 testers recruited from the Bellwright community
  - Structured feedback form covers bug severity, reproduction steps, and system specs
  - Beta period runs for at least 7 days
  - All critical and high-severity bugs are triaged and assigned
  - Beta findings committed to `docs/testing/beta-feedback.md`
- **Agent notes:** Tasks: recruit testers (T009-002-001), distribute builds and collect feedback (T009-002-002). Run beta for at least 7 days to capture weekend playtime.

---

### S009-003 — Post-Patch Regression Checklist

- **ID:** S009-003
- **Type:** Story
- **Parent:** E009
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S002-005
- **Description:** Write a repeatable regression checklist that can be executed after any Bellwright game update to verify all mods still function correctly.
- **Acceptance Criteria:**
  - Checklist covers at least 20 specific in-game verifiable behaviours across all mods
  - Checklist is written in a format a non-developer tester can follow
  - Estimated execution time per run is documented (target: under 60 minutes)
  - Checklist committed to `docs/testing/regression-checklist.md`
  - Checklist is reviewed and updated after each game patch that affects mod behaviour
- **Agent notes:** Write this checklist during mod development (not after). Each story's acceptance criteria are the source material for regression test cases. Each checklist item should be: "Navigate to X, do Y, expect Z."

---

### S010-001 — Final Cook & Packaging

- **ID:** S010-001
- **Type:** Story
- **Parent:** E010
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S009-002
- **Description:** Perform final Shipping-configuration cooks of all five mods, verify pak integrity, and prepare release bundles with version manifests.
- **Acceptance Criteria:**
  - All five mods cook in Shipping configuration without errors
  - Pak file SHA256 checksums are recorded in a release manifest
  - Each mod's file size is within Workshop item size limits
  - Release bundles are tagged with v1.0.0 in Git
  - Cook log files are archived in `docs/releases/v1.0.0/`
- **Agent notes:** Tasks: final cook (T010-001-001), apply Git release tags (T010-001-002). Cook each mod in isolation — do not merge pak files. Verify integrity with `UnrealPak.exe <file.pak> -List`.

---

### S010-002 — Workshop Publication & Release Communication

- **ID:** S010-002
- **Type:** Story
- **Parent:** E010
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S010-001, S008-003
- **Description:** Publish all mods publicly on Steam Workshop, post release announcements, and document the rollback procedure.
- **Acceptance Criteria:**
  - All five mods are set to public visibility on Workshop simultaneously
  - Release announcement is posted to at least 2 community channels
  - Mod collection is promoted to featured status if available
  - GitHub releases are created with release notes for each mod
  - Rollback procedure (reverting to previous Workshop build) is tested and documented
- **Agent notes:** Tasks: set Workshop items to public (T010-002-001), post announcements (T010-002-002), document rollback (T010-002-003). Prepare announcement copy in advance. The rollback document (T010-002-003) must be written and tested before go-live.

---

## TASKS

---

### T001-001-001 — Extract UE5 Version from Game Binary

- **ID:** T001-001-001
- **Type:** Task
- **Parent:** S001-001
- **Status:** todo
- **Priority:** critical
- **Effort:** XS
- **Prerequisites:** none
- **Description:** Use a hex editor or the `strings` utility on `Bellwright-Win64-Shipping.exe` to locate the UE5 build version string embedded in the binary. Record the exact version string.
- **Acceptance Criteria:**
  - Exact version string (e.g., `++UE5+Release-5.6-CL-XXXXXXX`) is extracted and recorded
  - Screenshot or log output saved to `docs/research/evidence/binary-version-extract.txt`
  - Version compared against ModKit `Engine/Build/Build.version`
  - Discrepancy (if any) is quantified (patch/minor/major delta)
  - Finding is committed
- **Agent notes:** Run `strings Bellwright-Win64-Shipping.exe | grep -E "UE[45]\+|++UE"` on the game binary. ModKit version is in `Engine/Build/Build.version` within the ModKit install directory. Compare the two JSON version files directly.

---

### T001-001-002 — Search Community Sources for Version Confirmation

- **ID:** T001-001-002
- **Type:** Task
- **Parent:** S001-001
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T001-001-001
- **Description:** Search the Bellwright Steam forums, Donkey Crew Discord, Nexus Mods comments, and RE-UE4SS GitHub issues for community reports on the UE5 version. Cross-reference with binary extraction findings.
- **Acceptance Criteria:**
  - At least 3 independent community sources are cited
  - Conflicts between community reports and binary extraction are noted
  - Official statements from Donkey Crew (if any) are recorded
  - Sources are hyperlinked in the research document
  - Finding incorporated into `docs/research/engine-version.md`
- **Agent notes:** Search terms: "Bellwright UE5 version", "Bellwright Unreal version", "Bellwright 5.6". Check pinned posts in the Bellwright Steam forum and the #modding channel of the Donkey Crew Discord.

---

### T001-001-003 — Write Engine Version Research Document

- **ID:** T001-001-003
- **Type:** Task
- **Parent:** S001-001
- **Status:** todo
- **Priority:** critical
- **Effort:** XS
- **Prerequisites:** T001-001-001, T001-001-002
- **Description:** Synthesise the binary extraction and community findings into a structured document stating the confirmed version, the version delta, compatibility implications, and a go/no-go recommendation.
- **Acceptance Criteria:**
  - Document states confirmed game binary version and ModKit version
  - Compatibility implication classified as: no issue / shim required / blocker
  - Go/no-go flag for ModKit asset loading is explicit
  - Document is under `docs/research/engine-version.md`
  - Committed to repo
- **Agent notes:** Structure: Summary, Evidence (binary extraction, community sources), Version Comparison Table, Compatibility Assessment, Recommendation.

---

### T001-002-001 — Open ModKit and Enumerate Blueprint Parent Classes

- **ID:** T001-002-001
- **Type:** Task
- **Parent:** S001-002
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** S002-001, T001-001-003
- **Description:** Open the Bellwright ModKit editor and use the content browser and class viewer to enumerate all Blueprint parent classes that modders can extend, filtering for game-specific classes.
- **Acceptance Criteria:**
  - Class viewer is filtered to show only project-specific Blueprint classes
  - At least 30 game-specific Blueprint parent classes are listed
  - Each class has a one-line description of its apparent purpose
  - Screenshot of the class viewer saved to `docs/research/evidence/`
  - Raw class list committed to `docs/research/modkit-api-surface.md`
- **Agent notes:** In the ModKit editor, use Window > Class Viewer, filter by "Blueprint" and uncheck "Engine Classes". Export the filtered list via right-click > Copy Class Hierarchy if available.

---

### T001-002-002 — Test Quest & NPC AI Node Accessibility

- **ID:** T001-002-002
- **Type:** Task
- **Parent:** S001-002
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T001-002-001
- **Description:** Create a test Blueprint in the ModKit that attempts to extend the NPC AI controller class. Verify which AI behaviour tree nodes and task classes are accessible.
- **Acceptance Criteria:**
  - Test Blueprint extending the NPC AI controller class (or closest equivalent) is created
  - Accessible behaviour tree task classes are listed
  - Restricted/unavailable classes are listed with the specific error or omission noted
  - Finding is categorised: full access / partial access / no access
  - Evidence committed to `docs/research/modkit-api-surface.md`
- **Agent notes:** Look for classes named `*AIController*`, `*BTTask*`, `*BTDecorator*`, `*NPCCharacter*` in the class viewer. Attempt to create a child Blueprint of each. If the class is abstract-only with no overrideable functions, note that.

---

### T001-002-003 — Test Combat Node Accessibility

- **ID:** T001-002-003
- **Type:** Task
- **Parent:** S001-002
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T001-002-001
- **Description:** Create a test Blueprint in the ModKit that attempts to extend the weapon, damage type, and status effect classes. Document which combat-related Blueprint nodes are callable.
- **Acceptance Criteria:**
  - Weapon component base class accessibility confirmed or denied
  - Damage type class accessibility confirmed or denied
  - Status effect application function availability confirmed or denied
  - Test Blueprint saved to `Mods/Research/` in the ModKit project
  - Findings committed to `docs/research/modkit-api-surface.md`
- **Agent notes:** Search class viewer for `*Weapon*`, `*DamageType*`, `*StatusEffect*`, `*CombatComponent*`. For each, check if "Create Child Blueprint Class" is available (right-click in content browser).

---

### T001-002-004 — Test UI Widget Accessibility

- **ID:** T001-002-004
- **Type:** Task
- **Parent:** S001-002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T001-002-001
- **Description:** Attempt to subclass or add to existing HUD and inventory widget Blueprints to determine whether the UI layer is extensible through the ModKit.
- **Acceptance Criteria:**
  - HUD widget Blueprint accessibility (extend vs replace) is documented
  - Inventory screen widget Blueprint accessibility is documented
  - Map widget Blueprint accessibility is documented
  - At least one successful widget override test is demonstrated
  - Findings committed to `docs/research/modkit-api-surface.md`
- **Agent notes:** Search for `*HUD*`, `*Widget*`, `*UserWidget*`, `*InventoryUI*` in the content browser. Try adding a new widget Blueprint and referencing vanilla widgets to check for circular dependency blocks.

---

### T001-002-005 — Test Settlement/Resource Data Table Accessibility

- **ID:** T001-002-005
- **Type:** Task
- **Parent:** S001-002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T001-002-001
- **Description:** Locate and open settlement-related data tables (building definitions, resource types, crafting recipes, tech tree) in the ModKit and verify which fields can be overridden.
- **Acceptance Criteria:**
  - At least 5 settlement/crafting data tables are located in the ModKit content browser
  - Column schema for each table is documented
  - Fields that are read-only vs modifiable are identified
  - A test row override is created and cooked successfully
  - Findings committed to `docs/research/modkit-api-surface.md`
- **Agent notes:** Search the content browser for assets of type `DataTable`. Check the row structure editor for each. Attempt to duplicate a row and modify numeric fields, then cook to verify no errors.

---

### T001-002-006 — Write ModKit API Surface Document

- **ID:** T001-002-006
- **Type:** Task
- **Parent:** S001-002
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T001-002-002, T001-002-003, T001-002-004, T001-002-005
- **Description:** Consolidate all ModKit investigation findings into the structured API surface document with a summary table and per-system go/no-go flags.
- **Acceptance Criteria:**
  - Document has a summary table: System | Accessibility | Notes
  - Each of the four target systems has a go/no-go flag
  - Accessible classes are listed with their overrideable functions
  - Document is under `docs/research/modkit-api-surface.md`
  - Committed to repo
- **Agent notes:** The summary table should use clear symbols (Full / Partial / None) and the body should have a section per system with evidence screenshots referenced.

---

### T001-003-001 — Download and Pin RE-UE4SS Version

- **ID:** T001-003-001
- **Type:** Task
- **Parent:** S001-003
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** none
- **Description:** Download the latest stable RE-UE4SS release from GitHub and record the specific version number and SHA256 checksum.
- **Acceptance Criteria:**
  - RE-UE4SS release version number is recorded
  - Release download URL and SHA256 checksum recorded in `docs/research/re-ue4ss-compatibility.md`
  - Downloaded archive stored in `tools/re-ue4ss/` or linked
  - Version confirmed against the RE-UE4SS GitHub releases page
  - Committed to repo
- **Agent notes:** RE-UE4SS releases are at https://github.com/UE4SS-RE/RE-UE4SS/releases. Download the `UE4SS_v*.zip` asset. Do not use a pre-release build unless the stable release is confirmed incompatible.

---

### T001-003-002 — Inject RE-UE4SS into Bellwright

- **ID:** T001-003-002
- **Type:** Task
- **Parent:** S001-003
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T001-003-001
- **Description:** Place RE-UE4SS DLLs in the Bellwright game binary directory per official installation instructions, launch the game, and observe whether injection succeeds.
- **Acceptance Criteria:**
  - `UE4SS.dll`, proxy DLL, and `UE4SS-settings.ini` are placed in the correct directory
  - Game launches without crash to main menu
  - RE-UE4SS console window appears confirming injection
  - UE4SS version and detected game name are logged
  - Outcome committed to `docs/research/re-ue4ss-compatibility.md`
- **Agent notes:** Default install path for the proxy DLL is `Bellwright/Binaries/Win64/`. Set `GuiConsoleEnabled = 1` in `UE4SS-settings.ini` to see the console. Check `UE4SS.log` in the same directory for injection outcome.

---

### T001-003-003 — Execute Baseline Lua Script via RE-UE4SS

- **ID:** T001-003-003
- **Type:** Task
- **Parent:** S001-003
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T001-003-002
- **Description:** Create a minimal Lua mod that prints a message and reads a UObject property, and verify it executes correctly.
- **Acceptance Criteria:**
  - `mods/HelloLua/scripts/main.lua` with `print("RE-UE4SS OK")` executes on game launch
  - Output appears in the RE-UE4SS console
  - At least one UObject property (e.g., player location) is read and printed without error
  - Full Lua mod structure committed to `tools/re-ue4ss-test/`
  - Outcome committed to `docs/research/re-ue4ss-compatibility.md`
- **Agent notes:** Lua mod structure: folder `ue4ss/Mods/HelloLua/`, add `enabled.txt` (empty), add `scripts/main.lua`. Use `UEHelpers.GetPlayer()` to get the player Pawn, then `player:GetActorLocation()` to read a property. Log with `print(...)`.

---

### T001-003-004 — Write RE-UE4SS Compatibility Document

- **ID:** T001-003-004
- **Type:** Task
- **Parent:** S001-003
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T001-003-002, T001-003-003
- **Description:** Write the compatibility finding document with pinned version, injection outcome, Lua runtime status, and a go/no-go recommendation.
- **Acceptance Criteria:**
  - Document states RE-UE4SS version and injection method
  - Injection outcome (success/fail/partial) is stated with evidence
  - Lua runtime status is confirmed
  - Go/no-go flag for RE-UE4SS development is explicit
  - Committed to `docs/research/re-ue4ss-compatibility.md`
- **Agent notes:** If injection fails, document the exact error, the Bellwright build version, and any workarounds found in community sources before setting the go/no-go flag to no.

---

### T001-004-001 — Search ModKit for Settlement API Nodes

- **ID:** T001-004-001
- **Type:** Task
- **Parent:** S001-004
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T001-002-001, T001-003-004
- **Description:** Perform a systematic keyword search in the ModKit Blueprint editor for functions and nodes related to villager tasks, resource routing, and production queues.
- **Acceptance Criteria:**
  - Blueprint function search results for "villager", "task", "route", "queue", "assign", "carry" are documented
  - At least one callable function for villager task assignment (if any) is demonstrated in a test Blueprint
  - Data table schemas for villager role definitions are located and documented
  - Findings are categorised by accessibility tier (data-only / Blueprint / none)
  - Raw search screenshots saved to `docs/research/evidence/`
- **Agent notes:** Use the Blueprint editor's "Find in Blueprints" tool (Edit menu) with wildcard search. Also search the data table list for tables with "Villager", "Task", "Job", "Role" in their names.

---

### T001-004-002 — Search RE-UE4SS UObject Dump for Automation Classes

- **ID:** T001-004-002
- **Type:** Task
- **Parent:** S001-004
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T001-003-003
- **Description:** Use RE-UE4SS's UObject dump feature to generate a full class list and search it for settlement automation-related classes and properties.
- **Acceptance Criteria:**
  - Full UObject dump is generated
  - Dump is searched for classes containing "Villager", "Task", "Route", "Production", "Queue"
  - At least 5 relevant classes are identified with their property lists
  - Property access test (read a villager task property via Lua) is attempted and outcome recorded
  - Findings committed to `docs/research/automation-api.md`
- **Agent notes:** In the RE-UE4SS console, use the built-in object dump tool (Dumper tab in GUI). Parse the output for relevant class names. Then attempt `FindFirstOf("VillagerCharacter")` in Lua to get a live instance and read its properties.

---

### T001-004-003 — Write Automation API Document and Scope Statement

- **ID:** T001-004-003
- **Type:** Task
- **Parent:** S001-004
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T001-004-001, T001-004-002
- **Description:** Synthesise the ModKit and RE-UE4SS findings into a scoped statement of what automation features are achievable and at what implementation tier.
- **Acceptance Criteria:**
  - Document states which automation features are achievable via ModKit data / ModKit Blueprint / RE-UE4SS Lua / none
  - Infeasible features are listed with technical reason
  - Alternative approaches for infeasible features are proposed
  - Go/no-go flag for each of the three automation sub-features is explicit
  - Committed to `docs/research/automation-api.md`
- **Agent notes:** The three sub-features have different feasibility profiles. The visualiser is likely UI-only (always feasible). Routing and task queues depend on villager task class accessibility. Be explicit about which tier each feature requires.

---

### T002-001-001 — Install ModKit via Epic Games Launcher

- **ID:** T002-001-001
- **Type:** Task
- **Parent:** S002-001
- **Status:** todo
- **Priority:** critical
- **Effort:** XS
- **Prerequisites:** none
- **Description:** Install the Bellwright ModKit through the Epic Games Store/Launcher and record the installed version, install path, and disk space used.
- **Acceptance Criteria:**
  - ModKit installed without errors
  - Installed version string is recorded
  - Install path is confirmed
  - Disk usage is recorded
  - Installation outcome committed to `docs/environment-setup.md`
- **Agent notes:** The ModKit is listed under the "Library" section of the Epic Games Launcher as a separate entry from the base game. It may be listed under "Bellwright" as a "Mod Tools" option. Note the exact product name as listed in the launcher.

---

### T002-001-002 — Launch ModKit and Verify Sample Content

- **ID:** T002-001-002
- **Type:** Task
- **Parent:** S002-001
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T002-001-001
- **Description:** Launch the ModKit editor, open the sample content project, and verify it loads without missing asset warnings or crashes.
- **Acceptance Criteria:**
  - ModKit editor launches to the project selection screen
  - A new or sample project opens without "missing asset" warnings in the message log
  - Content browser shows game content assets are available for reference
  - Editor version string in Help > About is recorded
  - Any first-launch configuration steps are documented in `docs/environment-setup.md`
- **Agent notes:** Check the Output Log window (Window > Output Log) for any errors after the project opens. A small number of shader compilation warnings is normal. Missing asset warnings (red text) should be flagged.

---

### T002-001-003 — Configure ModKit Project Settings

- **ID:** T002-001-003
- **Type:** Task
- **Parent:** S002-001
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T002-001-002
- **Description:** Configure the ModKit project settings: set target platform (Windows 64), configure the cook output directory, and set up mod metadata defaults.
- **Acceptance Criteria:**
  - Target platform is set to Win64 Shipping
  - Cook output directory is set to a known path outside `Intermediate/`
  - Mod metadata defaults (author name, mod prefix) are configured
  - Settings persist after editor restart
  - Configuration steps committed to `docs/environment-setup.md`
- **Agent notes:** Project settings are under Edit > Project Settings. Look for "Mod Configuration" or "Packaging" sections. The cook directory should be outside `Intermediate/` to survive editor cleans.

---

### T002-002-001 — Initialise Git Repository

- **ID:** T002-002-001
- **Type:** Task
- **Parent:** S002-002
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T002-001-003
- **Description:** Initialise a Git repository in the modding project root with the correct UE5 `.gitignore` and an initial commit.
- **Acceptance Criteria:**
  - `git init` run in the project root
  - `.gitignore` contains exclusions for `Binaries/`, `Intermediate/`, `Saved/`, `DerivedDataCache/`, `Build/`
  - Initial commit contains only `.gitignore`, `README.md`, and `docs/` skeleton
  - No `.uasset` or binary files are in the initial commit
  - Git log shows a clean initial commit
- **Agent notes:** Use the official Unreal Engine `.gitignore` template from GitHub. Add custom exclusions for ModKit-specific output folders. Only track the `Content/Mods/` subdirectory, not the entire ModKit install.

---

### T002-002-002 — Configure Git LFS

- **ID:** T002-002-002
- **Type:** Task
- **Parent:** S002-002
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T002-002-001
- **Description:** Install Git LFS and configure it to track binary UE5 asset types.
- **Acceptance Criteria:**
  - `git lfs install` succeeds
  - `.gitattributes` tracks `*.uasset`, `*.umap`, `*.png`, `*.fbx`, `*.wav`, `*.mp3`
  - A test binary file round-trips correctly through LFS
  - `.gitattributes` is committed
  - LFS storage requirements are estimated and noted in `docs/contributing.md`
- **Agent notes:** Run `git lfs track "*.uasset"` etc. for each type. Verify with `git lfs ls-files` after adding a test `.uasset`. GitHub LFS has a 1GB free tier; estimate your asset budget accordingly.

---

### T002-002-003 — Create Remote Repository and Push

- **ID:** T002-002-003
- **Type:** Task
- **Parent:** S002-002
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T002-002-002
- **Description:** Create a GitHub remote repository, push the initial commit, and verify Git LFS objects upload correctly.
- **Acceptance Criteria:**
  - Remote repository created with appropriate visibility
  - `git remote add origin` and `git push -u origin main` succeed
  - Git LFS objects confirmed uploaded
  - Remote URL recorded in `docs/environment-setup.md`
  - Repo has a `LICENSE` file
- **Agent notes:** Create the repo via the web UI first without a README to avoid merge conflict. Push the local initial commit. Verify LFS upload by checking the LFS objects tab in repo settings.

---

### T002-003-001 — Install RE-UE4SS into Game Directory

- **ID:** T002-003-001
- **Type:** Task
- **Parent:** S002-003
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T001-003-004, T002-001-002
- **Description:** Copy the pinned RE-UE4SS release files into the Bellwright game binary directory per the installation instructions.
- **Acceptance Criteria:**
  - `UE4SS.dll` and proxy DLL are in `Bellwright/Binaries/Win64/`
  - `UE4SS-settings.ini` is present and configured
  - `ue4ss/Mods/` directory structure is created
  - Files are listed in `docs/environment-setup.md` with their expected paths
  - Installation is reversible (original files backed up or documented)
- **Agent notes:** Back up the original proxy DLL before replacement. Document the exact files changed so the installation can be cleanly reversed if needed.

---

### T002-003-002 — Configure UE4SS-settings.ini

- **ID:** T002-003-002
- **Type:** Task
- **Parent:** S002-003
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T002-003-001
- **Description:** Edit `UE4SS-settings.ini` to enable GUI console, set correct game name, and configure logging to a known output path.
- **Acceptance Criteria:**
  - `GuiConsoleEnabled = 1` is set
  - `LogToFile = 1` and log path are set
  - Game name override (if needed) is configured
  - Settings tested by launching the game and verifying console appearance
  - Final `UE4SS-settings.ini` committed to `tools/re-ue4ss/` in the repo
- **Agent notes:** The `[General]` section controls console visibility. Keep `ObjectDumperEnabled = 0` by default to avoid startup lag; enable only when needed for research.

---

### T002-004-001 — Configure Steam Workshop Upload Tool

- **ID:** T002-004-001
- **Type:** Task
- **Parent:** S002-004
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T002-001-003
- **Description:** Configure the ModKit's built-in Workshop upload tool (or SteamCMD) with developer Steam credentials and the Bellwright AppID.
- **Acceptance Criteria:**
  - Workshop upload tool launches without authentication errors
  - Bellwright AppID is confirmed and configured
  - Developer Steam account has Workshop publisher permissions for Bellwright
  - Upload tool configuration documented (excluding credentials) in `docs/workshop-publishing.md`
  - A test upload of an empty item succeeds
- **Agent notes:** Check the ModKit documentation for whether a built-in uploader is provided. If using SteamCMD, document the `workshop_build_item.vdf` file format.

---

### T002-004-002 — Create First Placeholder Workshop Item

- **ID:** T002-004-002
- **Type:** Task
- **Parent:** S002-004
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T002-004-001
- **Description:** Create a placeholder Workshop item for Bellwright Plus to claim a Workshop item ID, set to private visibility.
- **Acceptance Criteria:**
  - Workshop item created with correct AppID and set to private visibility
  - Workshop item ID recorded in `mods/BellwrightPlus/workshop-id.txt`
  - Item title and description placeholder are set
  - Item is visible in the developer's Workshop submissions list
  - Item ID committed to repo
- **Agent notes:** Creating a Workshop item early locks in the item ID, which is embedded in the mod's metadata. This prevents ID changes later. Set a descriptive placeholder title so the item is identifiable in the submissions list.

---

### T002-004-003 — Create Remaining Four Placeholder Workshop Items

- **ID:** T002-004-003
- **Type:** Task
- **Parent:** S002-004
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T002-004-002
- **Description:** Create private placeholder Workshop items for the remaining four mods (UI Overhaul, Visual Enhancement, Automation Tools, Combat Expansion) and record their IDs.
- **Acceptance Criteria:**
  - Five total Workshop items exist (one per mod), all set to private
  - Each item ID is recorded in `mods/<ModName>/workshop-id.txt`
  - All IDs are committed to the repo
  - Workshop submissions list confirms all five items
  - `docs/workshop-publishing.md` lists all five IDs
- **Agent notes:** Repeat the T002-004-002 process for each remaining mod. Use descriptive placeholder titles so the items are identifiable in the submissions list.

---

### T002-005-001 — Create and Cook Smoke Test Mod

- **ID:** T002-005-001
- **Type:** Task
- **Parent:** S002-005
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T002-001-003, T002-002-003, T002-004-003
- **Description:** Create a minimal data table override mod that changes one numeric value, cook it in Development configuration, and verify the pak file is generated.
- **Acceptance Criteria:**
  - A new mod content folder `Content/Mods/SmokeTest/` exists in the ModKit project
  - A single data table row override is created changing one numeric value
  - Cook completes without errors in Development configuration
  - A `.pak` file is generated in the cook output directory
  - `.pak` file size is under 1 MB
- **Agent notes:** In the ModKit, duplicate the target data table row into your mod's override table. Cook via File > Cook Content for Windows. The exact override mechanism (primary asset label or override table) should follow the ModKit documentation.

---

### T002-005-002 — Upload Smoke Test Mod to Workshop

- **ID:** T002-005-002
- **Type:** Task
- **Parent:** S002-005
- **Status:** todo
- **Priority:** critical
- **Effort:** XS
- **Prerequisites:** T002-005-001, T002-004-003
- **Description:** Upload the cooked Smoke Test `.pak` to the placeholder Workshop item and verify the upload succeeds.
- **Acceptance Criteria:**
  - Upload completes without errors
  - Workshop item shows the new build version
  - Download via Workshop subscription succeeds
  - Subscribed mod appears in the in-game mod browser
  - Upload log saved to `docs/releases/smoke-test/`
- **Agent notes:** After upload, wait 1–2 minutes for Steam Workshop propagation before testing subscription download. Check the Workshop item's "Change Notes" to confirm the build was registered.

---

### T002-005-003 — Verify Smoke Test Mod In-Game

- **ID:** T002-005-003
- **Type:** Task
- **Parent:** S002-005
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T002-005-002
- **Description:** Subscribe to the Smoke Test mod, launch Bellwright, load a save, and verify the modified numeric value is reflected in-game.
- **Acceptance Criteria:**
  - Mod is active in the in-game mod list
  - The modified stat value is observable in-game
  - No crash or error on game launch with mod active
  - No crash or error on save load with mod active
  - Findings (pass/fail + evidence screenshot) committed to `docs/releases/smoke-test/smoke-test-result.md`
- **Agent notes:** To compare values, note the vanilla carry weight from a save without the mod active, then enable the mod and compare. If the mod system requires a new save to take effect, document that.

---

### T003-001-001 — Define Config Data Asset Schema

- **ID:** T003-001-001
- **Type:** Task
- **Parent:** S003-001
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S002-005
- **Description:** Define the `DA_BellwrightPlus_Config` Data Asset class in the ModKit with typed fields for all planned QoL settings.
- **Acceptance Criteria:**
  - Data Asset class is created with fields for carry weight multiplier, crafting queue depth, villager cap, hunger decay rate, sleep decay rate, respawn multiplier, fast travel threshold, XP multiplier, tech speed multiplier
  - All fields have explicit default values matching vanilla
  - Field types are correct (float for multipliers, int for counts, bool for toggles)
  - Data Asset compiles without errors
  - Class committed to `Content/Mods/BellwrightPlus/Config/`
- **Agent notes:** Create a new Blueprint class inheriting from `PrimaryDataAsset`. Add each setting as a property with a category of "BellwrightPlus". Set default values by inspecting vanilla data tables.

---

### T003-001-002 — Implement Settings Persistence

- **ID:** T003-001-002
- **Type:** Task
- **Parent:** S003-001
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** T003-001-001
- **Description:** Implement a save/load mechanism for the config Data Asset values so player preferences persist between game sessions.
- **Acceptance Criteria:**
  - A custom save game object (`SaveGame_BellwrightPlus`) stores all config field values
  - Config is saved when any setting is changed in the UI
  - Config is loaded on game start before any gameplay systems are initialised
  - Resetting to defaults restores all vanilla values without requiring a game restart
  - Save/load tested on a fresh game and on an existing save
- **Agent notes:** Use the `SaveGame` Blueprint subsystem. Serialise the config Data Asset fields to the save game object. Load from slot on `BeginPlay` of a persistent game instance or subsystem.

---

### T003-001-003 — Create In-Game Settings Panel Blueprint

- **ID:** T003-001-003
- **Type:** Task
- **Parent:** S003-001
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** T003-001-002
- **Description:** Build the `WBP_BellwrightPlus_Settings` widget Blueprint that displays all config settings as labelled sliders or toggles and allows in-game adjustment.
- **Acceptance Criteria:**
  - Panel opens from the pause menu via a new "Bellwright Plus" button
  - Each setting is displayed with a label, current value, and input control
  - Slider ranges and step sizes match the per-setting spec
  - "Reset to Defaults" button is present and functional
  - Panel closes without saving changes if the player presses Escape
- **Agent notes:** Build the widget in the UMG editor. Use a `ScrollBox` to handle the full list of settings. Bind each control's value to the config Data Asset field via a `GetConfig` function on the game instance. The panel should be opened via `AddToViewport` on pause.

---

### T003-002-001 — Locate Carry Weight Data Table

- **ID:** T003-002-001
- **Type:** Task
- **Parent:** S003-002
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T001-002-005, S003-001
- **Description:** Find the data table row that controls the player carry weight limit and document its table name, row name, and field name.
- **Acceptance Criteria:**
  - Data table name and row identifier for player carry weight are recorded
  - Field type (float, int) is confirmed
  - Vanilla value is recorded as the baseline
  - Finding committed to `docs/mods/bellwright-plus/data-table-map.md`
  - No changes to game data are made in this task
- **Agent notes:** Search the content browser for data tables with "Player", "Stats", "Inventory", "Weight" in the name. Open each and look for a "CarryWeight", "MaxCarryWeight", or similar column.

---

### T003-002-002 — Implement Carry Weight Override

- **ID:** T003-002-002
- **Type:** Task
- **Parent:** S003-002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T003-002-001, T003-001-002
- **Description:** Implement the carry weight limit override using a data table row override driven by the config multiplier value.
- **Acceptance Criteria:**
  - Carry weight limit is calculated as `vanilla_value * config.CarryWeightMultiplier`
  - Override is applied on game start and on settings change
  - Setting the multiplier to 1.0 produces exactly the vanilla carry weight value
  - Override works on both new and existing saves
  - No other player stats are affected
- **Agent notes:** If the data table approach allows runtime overrides, apply the multiplier via a Blueprint node that sets the row value at session start. If not, a dynamic approach via character stat components may be needed.

---

### T004-001-001 — Create Base Widget Blueprint

- **ID:** T004-001-001
- **Type:** Task
- **Parent:** S004-001
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S002-005, T001-002-004
- **Description:** Create the `WBP_BellwrightUI_Base` Blueprint widget class with shared properties: background panel, title bar, close button, drag-to-reposition functionality, and theme data asset reference.
- **Acceptance Criteria:**
  - Base widget has a configurable title bar with text binding
  - Close button dispatches a `OnCloseRequested` event that callers can bind
  - Widget can be dragged to any screen position
  - Theme data asset reference is exposed as a public variable
  - Widget compiles and is renderable in the UMG preview
- **Agent notes:** Use a `Canvas Panel` as the root. Add drag-and-drop via `OnMouseButtonDown` and `OnMouseMove` event overrides. The theme data asset should contain `PrimaryColour`, `BackgroundColour`, `FontFamily`, and `BaseFontSize` — applied in `NativeConstruct`.

---

### T004-001-002 — Create UI Theme Data Asset

- **ID:** T004-001-002
- **Type:** Task
- **Parent:** S004-001
- **Status:** todo
- **Priority:** medium
- **Effort:** XS
- **Prerequisites:** T004-001-001
- **Description:** Create the `DA_UITheme` Data Asset with colour palette, font references, and spacing values.
- **Acceptance Criteria:**
  - Data Asset defines at least 5 named colours (primary, secondary, background, text, alert)
  - Font references cover regular and bold weights
  - Spacing values cover small/medium/large padding
  - Default theme is legible against Bellwright's game environment
  - Data Asset committed to `Content/Mods/BellwrightUI/Theme/`
- **Agent notes:** Base the colour palette on Bellwright's existing earthy/medieval aesthetic. Avoid pure white or neon colours. Check what font assets are accessible in the ModKit content browser.

---

### T004-001-003 — Implement Panel Persistence Layer

- **ID:** T004-001-003
- **Type:** Task
- **Parent:** S004-001
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** T004-001-002, T003-001-002
- **Description:** Implement a persistence mechanism that saves each UI panel's position and visibility state to the save game object.
- **Acceptance Criteria:**
  - Panel screen positions are saved per-panel to the UI save game slot
  - Panel visibility (open/closed) is persisted
  - Positions are loaded and applied before the panel is made visible on load
  - Position is clamped to the current screen bounds (handles resolution changes)
  - Persistence tested across a session save/load cycle
- **Agent notes:** Add `FVector2D PanelPosition` and `bool bIsVisible` for each panel to the save game object. Apply position via `SetRenderTranslation` after `AddToViewport`.

---

### T005-001-001 — Select and Catalogue Textures for Upscaling

- **ID:** T005-001-001
- **Type:** Task
- **Parent:** S005-001
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** S002-005
- **Description:** Browse the ModKit content browser to identify and catalogue 25+ highest-impact environment textures for upscaling.
- **Acceptance Criteria:**
  - A list of at least 25 texture asset paths is compiled in `docs/mods/visuals/texture-upscale-list.md`
  - Textures are prioritised by visual impact (frequently visible surfaces first)
  - Each texture's current resolution is recorded
  - Asset paths confirmed accessible for export from the ModKit
  - List committed to repo
- **Agent notes:** In the ModKit content browser, filter by asset type "Texture2D". Sort by most recently used or search for common material name prefixes ("T_Ground", "T_Rock", "T_Wood", "T_Wall"). Prioritise seamless tiling textures used on large surfaces.

---

### T005-001-002 — Set Up Real-ESRGAN Upscaling Pipeline

- **ID:** T005-001-002
- **Type:** Task
- **Parent:** S005-001
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** T005-001-001
- **Description:** Install Real-ESRGAN and write a batch script that processes each texture in the catalogue list from exported PNG to 2x upscaled PNG.
- **Acceptance Criteria:**
  - Real-ESRGAN CLI is installed and invocable from a script
  - Batch script processes a list of PNG files and outputs to an `upscaled/` directory
  - Script handles errors (missing input file) without silently failing
  - A test run on 3 textures completes successfully
  - Script committed to `tools/texture-upscale/upscale.sh`
- **Agent notes:** `realesrgan-ncnn-vulkan -i input.png -o output.png -n realesrgan-x2plus`. Use `realesrgan-x2plus` for photographs and `realesrgan-x4plus-anime` for stylised assets. Process at 2x; cap output at 4K to avoid excessive pak sizes.

---

### T005-001-003 — Reimport Upscaled Textures into ModKit

- **ID:** T005-001-003
- **Type:** Task
- **Parent:** S005-001
- **Status:** todo
- **Priority:** medium
- **Effort:** M
- **Prerequisites:** T005-001-002
- **Description:** Reimport the batch-upscaled PNG files into the ModKit as texture overrides with correct compression settings.
- **Acceptance Criteria:**
  - All 20+ upscaled textures reimported without errors
  - Compression format set to BC7 for diffuse textures
  - Normal maps use BC5 compression
  - No visible tiling seams or artefacts introduced
  - Reimported textures visible in the ModKit material preview
- **Agent notes:** After import, open each Texture2D asset and set: Compression Settings = TC_BC7 (or TC_Normalmap for normal maps), sRGB = true for diffuse/albedo, Mip Gen Settings = FromTextureGroup.

---

### T006-001-001 — Write Automation Architecture Decision Record

- **ID:** T006-001-001
- **Type:** Task
- **Parent:** S006-001
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T001-004-003
- **Description:** Write the automation architecture decision record (ADR) based on the S001-004 findings, selecting the implementation approach for each sub-feature.
- **Acceptance Criteria:**
  - ADR format is used (Context, Decision, Consequences)
  - Implementation tier is specified for each sub-feature
  - Descoped features are listed with rationale
  - ADR committed to `docs/mods/automation/adr-001-architecture.md`
  - ADR is reviewed and approved before any automation development begins
- **Agent notes:** Use the standard ADR format. The "Consequences" section should explicitly state what becomes impossible or more difficult with the chosen approach.

---

### T007-001-001 — Evaluate Combat Blueprint Accessibility and Write Feasibility Document

- **ID:** T007-001-001
- **Type:** Task
- **Parent:** S007-001
- **Status:** todo
- **Priority:** critical
- **Effort:** S
- **Prerequisites:** T001-002-003
- **Description:** Review T001-002-003 findings and make an explicit go/no-go decision for the combat expansion mod. If partial access is available, define a reduced scope.
- **Acceptance Criteria:**
  - Go/no-go decision is written with rationale referencing T001-002-003 evidence
  - If "go with reduced scope", the reduced scope is enumerated
  - Decision committed to `docs/mods/combat/adr-001-feasibility.md`
  - Decision communicated to all parties before combat mod development begins
  - If "no-go", Epic E007 is formally descoped in the WBS
- **Agent notes:** The three key gates: (1) can you subclass the weapon Blueprint? (2) can you apply a status effect via Blueprint? (3) can you modify enemy spawn data tables? If all three are "no", the mod is not viable via ModKit and would require RE-UE4SS.

---

### T008-001-001 — Extract and Format Accessible Class List for Public Documentation

- **ID:** T008-001-001
- **Type:** Task
- **Parent:** S008-001
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** T001-002-006
- **Description:** Transform the raw ModKit API surface findings into a well-formatted modder reference table suitable for public documentation.
- **Acceptance Criteria:**
  - Table format: Class Name | Accessible | Overrideable Functions | Notes
  - All confirmed-accessible classes are included
  - Notes column includes brief usage guidance
  - Document written in Markdown
  - Committed to `docs/modder-reference/api-surface.md`
- **Agent notes:** Pull data from `docs/research/modkit-api-surface.md`. Format for a non-expert audience — assume the reader knows Blueprint basics but has never looked at the Bellwright ModKit before.

---

### T009-001-001 — Execute Cross-Mod Compatibility Matrix

- **ID:** T009-001-001
- **Type:** Task
- **Parent:** S009-001
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S003-009, S004-006, S005-004, S006-005, S007-006
- **Description:** Design and execute the compatibility test matrix by loading each pairwise mod combination and running a standard test sequence.
- **Acceptance Criteria:**
  - All 10 pairwise combinations are tested
  - Test sequence is standardised and documented
  - Results logged in a table: Mod A | Mod B | Result | Notes
  - Any conflict's reproduction steps are recorded
  - Matrix committed to `docs/testing/compatibility-matrix.md`
- **Agent notes:** Standard test sequence for each combination: (1) subscribe both mods, (2) launch game, (3) load a mid-game save, (4) exercise each mod's primary feature, (5) save and reload, (6) check for errors in game log at `%LOCALAPPDATA%/Bellwright/Saved/Logs/`.

---

### T009-002-001 — Recruit Beta Testers

- **ID:** T009-002-001
- **Type:** Task
- **Parent:** S009-002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** S009-001
- **Description:** Post recruitment messages in the Bellwright Steam forums and Discord server seeking at least 10 beta testers.
- **Acceptance Criteria:**
  - Recruitment post is live on at least 2 community channels
  - Post describes the beta programme scope, time commitment, and feedback format
  - At least 10 testers are recruited and confirmed
  - Tester system specs are collected (GPU, RAM, game version)
  - Tester contact list is maintained in a private document
- **Agent notes:** Specify in the recruitment post that testers must have at least 10 hours of Bellwright playtime. Provide a Google Form or GitHub Discussion thread for initial sign-up.

---

### T009-002-002 — Distribute Beta Builds and Collect Feedback

- **ID:** T009-002-002
- **Type:** Task
- **Parent:** S009-002
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** T009-002-001
- **Description:** Share private Workshop links with beta testers, run the beta for 7+ days, and collect structured feedback.
- **Acceptance Criteria:**
  - All beta testers receive Workshop links and installation instructions
  - Structured feedback form covers bug severity, reproduction steps, system specs, and free-text comments
  - At least 80% of recruited testers submit feedback
  - All bugs are triaged within 24 hours of receipt
  - Beta findings committed to `docs/testing/beta-feedback.md`
- **Agent notes:** Use a Google Form with required fields for: mod(s) affected, bug severity (Critical/High/Medium/Low), steps to reproduce, actual behaviour, expected behaviour, system specs. Share the form link in the beta tester channel.

---

### T010-001-001 — Final Shipping Cook for All Mods

- **ID:** T010-001-001
- **Type:** Task
- **Parent:** S010-001
- **Status:** todo
- **Priority:** high
- **Effort:** M
- **Prerequisites:** S009-002
- **Description:** Cook all five mods in Shipping configuration, record pak file checksums, and verify file sizes are within Workshop limits.
- **Acceptance Criteria:**
  - All five mods cook without errors in Shipping configuration
  - Cook logs show zero errors and acceptable warning counts
  - Pak file SHA256 checksums recorded in `docs/releases/v1.0.0/manifest.json`
  - All pak files are under the Steam Workshop item size limit
  - Cook output files archived in `docs/releases/v1.0.0/`
- **Agent notes:** Cook each mod separately. Verify pak integrity with `UnrealPak.exe <file.pak> -List`. The Shipping build should produce a smaller pak than Development due to removed debug symbols.

---

### T010-001-002 — Apply Git Release Tags

- **ID:** T010-001-002
- **Type:** Task
- **Parent:** S010-001
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T010-001-001
- **Description:** Tag the Git repository at the release commit with `v1.0.0` and create a GitHub release with release notes and checksums.
- **Acceptance Criteria:**
  - `git tag -a v1.0.0` applied at the final release commit
  - Tag is pushed to the remote repository
  - GitHub release is created with a written changelog
  - Pak file checksums from the manifest are included in the release notes
  - Release is marked as "latest" on GitHub
- **Agent notes:** Use annotated tags: `git tag -a v1.0.0 -m "Bellwright Mod Suite v1.0.0 — initial public release"`. Push with `git push origin v1.0.0`. The GitHub release can be created via `gh release create v1.0.0`.

---

### T010-002-001 — Set All Workshop Items to Public

- **ID:** T010-002-001
- **Type:** Task
- **Parent:** S010-002
- **Status:** todo
- **Priority:** high
- **Effort:** XS
- **Prerequisites:** T010-001-001, S008-003
- **Description:** Change all five Workshop items from private to public visibility simultaneously.
- **Acceptance Criteria:**
  - All five Workshop items are set to public visibility
  - Visibility change confirmed in the Workshop submissions dashboard
  - Items are discoverable via Workshop search
  - All items show correct titles, descriptions, and screenshots
  - Release timestamp recorded in `docs/releases/v1.0.0/release-log.md`
- **Agent notes:** Do this in a single session to minimise the window between first and last mod going public. Change items via the Steam Workshop web interface in rapid succession.

---

### T010-002-002 — Post Release Announcements

- **ID:** T010-002-002
- **Type:** Task
- **Parent:** S010-002
- **Status:** todo
- **Priority:** medium
- **Effort:** S
- **Prerequisites:** T010-002-001
- **Description:** Post release announcements to the Bellwright Steam forum, Donkey Crew Discord, and any other community channels.
- **Acceptance Criteria:**
  - Announcement posted to at least 2 community channels within 1 hour of Workshop publication
  - Announcement includes links to all five Workshop items and the mod collection
  - Announcement includes a brief feature summary for each mod
  - GitHub repository link is included
  - Announcement is pinned or highlighted where possible
- **Agent notes:** Prepare the announcement text in advance so it can be posted immediately after Workshop visibility is changed. Use named hyperlinks, not raw Workshop item IDs.

---

### T010-002-003 — Document and Test Rollback Procedure

- **ID:** T010-002-003
- **Type:** Task
- **Parent:** S010-002
- **Status:** todo
- **Priority:** high
- **Effort:** S
- **Prerequisites:** T010-001-002
- **Description:** Write and test the procedure for reverting a Workshop item to a previous build if a post-release patch introduces a breaking bug.
- **Acceptance Criteria:**
  - Rollback procedure documented step by step in `docs/workshop-publishing.md`
  - Procedure covers: identify broken version, locate previous pak file, re-upload previous pak, update change notes
  - Procedure tested by uploading a v1.0.0-test build and reverting to a prior build
  - Maximum rollback time is estimated and documented
  - Change note template for rollback announcements is included
- **Agent notes:** Steam Workshop does not natively support version rollback — you must re-upload the previous pak file as a new version. Keep all versioned pak files archived locally. The rollback note should clearly state which version users should expect after the rollback.

---

## Summary Statistics

| Epic | Stories | Tasks | Total Items |
|------|---------|-------|-------------|
| E001 Research & Discovery | 4 | 13 | 17 |
| E002 Environment Setup | 5 | 12 | 17 |
| E003 Bellwright Plus QoL | 9 | 4 | 13 |
| E004 UI & Information Overhaul | 6 | 3 | 9 |
| E005 Visual Enhancement | 4 | 3 | 7 |
| E006 Settlement Automation | 5 | 3 | 8 |
| E007 Combat Expansion | 6 | 1 | 7 |
| E008 Documentation & Community | 3 | 1 | 4 |
| E009 Testing & Validation | 3 | 3 | 6 |
| E010 Deployment & Publishing | 2 | 5 | 7 |
| **Total** | **47** | **48** | **95** |

---

## Critical Path Summary

The longest blocking chain runs: engine version research → ModKit API surface mapping → settlement automation API investigation → automation architecture decision → routing engine implementation → testing → final cook → Workshop publication.

Key gates that block multiple Epics simultaneously:

- S001-001 (engine version) blocks S002-001 and S001-003
- S002-005 (smoke test pipeline) blocks all five mod development Epics
- S001-002 (ModKit API surface) blocks S007-001 (combat feasibility) and informs S004-001 and S006-001
- S001-003 (RE-UE4SS compat) blocks S002-003 and S001-004
- S001-004 (automation API) blocks S006-001 which blocks all of E006

The file is saved to `/Users/rhyderquinlan/development/bellwright/docs/superpowers/plans/2026-06-05-bellwright-modding-wbs.md`.

---

Two execution options for working through this WBS:

**1. Subagent-Driven (recommended)** — Dispatch a fresh subagent per task, review between tasks, fast iteration suited to the research-heavy early Epics where findings gate later decisions.

**2. Inline Execution** — Execute tasks in this session using executing-plans, with batch execution and checkpoints for review.

Which approach would you like to use — and would you like to start with E001 (Research & Discovery) tasks first, given they gate everything else?