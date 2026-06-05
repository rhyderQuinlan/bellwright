# Bellwright Modding Project — Comprehensive Work Breakdown Structure

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Deliver a suite of high-impact Bellwright mods — QoL overhaul, UI overhaul, visual enhancement, settlement automation, and combat expansion — from environment setup through Steam Workshop publication.

**Architecture:** Tiered modding model leveraging the official ModKit (UE5 Blueprint/data) for safe distribution via Steam Workshop, with RE-UE4SS (Lua/C++) as a secondary channel for features not exposed in ModKit. Research epics gate all dependent development epics via explicit prerequisites.

**Tech Stack:** Unreal Engine 5 ModKit (Epic Games Store), Blueprint visual scripting, Data Table / Data Asset editing, RE-UE4SS (Lua + C++ API), Steam Workshop SDK, ReShade (post-process visuals), Git (asset versioning), Markdown (docs).

---

## EPICS

---

### E001 — Research & Discovery

**Type:** Epic
**Status:** todo
**Priority:** critical
**Effort:** L
**Prerequisites:** none
**Description:** Investigate all technical unknowns that gate downstream development decisions. Covers engine version reconciliation, ModKit API surface mapping, RE-UE4SS compatibility verification, and automation/AI node exposure. Until these tasks are complete, no development Epic may begin.
**Acceptance Criteria:**
- All key unknowns listed in the project brief have a documented finding
- Each finding references a reproducible evidence source (log file, screenshot, forum post, test project)
- A go/no-go decision is recorded for each of the four development Epics
- Findings are committed to `docs/research/` in the repo

---

### E002 — Environment Setup

**Type:** Epic
**Status:** todo
**Priority:** critical
**Effort:** M
**Prerequisites:** E001
**Description:** Install and validate the full modding toolchain: ModKit, RE-UE4SS, Steam Workshop CLI, and supporting utilities. Produces a verified, reproducible environment that every development Epic depends on. Includes a smoke-test mod that proves the pipeline end-to-end.
**Acceptance Criteria:**
- ModKit launches without errors and can cook a test asset
- RE-UE4SS injects into Bellwright without crash (if compatibility confirmed in E001)
- Steam Workshop CLI can upload a placeholder mod entry
- A "Hello World" mod is visible and functional in-game via Workshop subscription
- Environment setup steps are documented in `docs/environment-setup.md`

---

### E003 — Bellwright Plus (Comprehensive QoL Overhaul)

**Type:** Epic
**Status:** todo
**Priority:** high
**Effort:** XL
**Prerequisites:** E002
**Description:** A single configurable mod addressing the most common player friction points: carry weight, crafting queue limits, villager assignment limits, hunger/sleep decay rates, respawn timers, and fast travel unlock thresholds. Delivered as one Workshop mod with an in-game settings menu.
**Acceptance Criteria:**
- At least 10 independently toggleable QoL settings are exposed via an in-game UI panel
- All numeric parameters are driven by data assets (no hardcoded values)
- Mod loads cleanly on a fresh save and on existing saves
- No conflicts with base-game systems when all settings are at default values
- Published to Steam Workshop with description, screenshots, and changelog

---

### E004 — UI & Information Overhaul

**Type:** Epic
**Status:** todo
**Priority:** high
**Effort:** XL
**Prerequisites:** E002
**Description:** Replaces or augments the base-game HUD, map, villager dashboard, and inventory screens with information-dense, keyboard/controller-navigable alternatives. Scope is gated by what ModKit exposes for HUD/widget Blueprints.
**Acceptance Criteria:**
- Enhanced map shows settlement radius, resource node icons, and NPC assignment zones
- Villager dashboard lists all villagers with sortable columns (role, health, morale, task)
- Inventory screen shows item weight, stack size, and quick-sort button
- All new UI panels are dismissible and positionally persistent between sessions
- Published to Steam Workshop

---

### E005 — Visual & Atmospheric Enhancement Pack

**Type:** Epic
**Status:** todo
**Priority:** medium
**Effort:** L
**Prerequisites:** E002
**Description:** Improves visual fidelity through texture upscaling, lighting parameter adjustments, and weather variety additions via ModKit, supplemented by a curated ReShade preset for post-process enhancement that works independently.
**Acceptance Criteria:**
- At least 20 material/texture assets are replaced with higher-resolution versions
- Two new weather states (dense fog, overcast drizzle) are added via data assets
- ReShade preset ships as a standalone download with install instructions
- No measurable FPS regression (within 5%) on a reference GPU tier (RTX 3070 equivalent)
- Published to Steam Workshop

---

### E006 — Settlement Automation Tools

**Type:** Epic
**Status:** todo
**Priority:** high
**Effort:** XL
**Prerequisites:** E002
**Description:** Adds auto-routing for resource delivery between stockpiles and crafting stations, persistent task queues for villager roles, and a production chain visualiser. Scope is heavily gated by whether settlement/AI routing APIs are exposed in ModKit or require RE-UE4SS.
**Acceptance Criteria:**
- Resources in a designated stockpile are automatically routed to a linked crafting station when the queue is non-empty
- Villager task queues persist through a save/load cycle
- Production chain visualiser shows a DAG of inputs/outputs for any selected recipe
- Automation rules can be paused/resumed per station from the UI
- Published to Steam Workshop

---

### E007 — Combat Systems Expansion

**Type:** Epic
**Status:** todo
**Priority:** medium
**Effort:** XL
**Prerequisites:** E002
**Description:** Introduces status effects (bleed, stun, slow), three new weapon archetypes, two new enemy variants, and a combo-input system. Entirely gated on E001 confirming that combat Blueprints and enemy AI nodes are exposed in ModKit.
**Acceptance Criteria:**
- Three status effects apply, stack, and expire correctly without game crashes
- New weapons appear in crafting recipes and have correct stat profiles
- New enemy variants spawn in designated biome regions
- Combo system activates via timed sequential inputs and plays distinct animations
- Published to Steam Workshop

---

### E008 — Documentation & Community

**Type:** Epic
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** E002
**Description:** Produces modder documentation (API surface map, tutorial series), Workshop descriptions and trailers, and a community engagement plan (Nexus Mods cross-post, Discord presence, bug report template).
**Acceptance Criteria:**
- Modder API surface document covers all confirmed-accessible nodes/classes
- At least two tutorial articles are published (beginner data-table mod, intermediate Blueprint mod)
- Each Workshop mod has a formatted description with feature list, install notes, and known issues
- A GitHub repo (or equivalent) hosts source assets under a permissive licence
- Community bug report template is live

---

### E009 — Testing & Validation

**Type:** Epic
**Status:** todo
**Priority:** high
**Effort:** L
**Prerequisites:** E003, E004, E005, E006, E007
**Description:** Structured cross-mod compatibility testing, regression testing against game updates, and player-facing beta programme. Catches conflicts between mods and validates that mods survive a base-game patch cycle.
**Acceptance Criteria:**
- All mods pass a compatibility matrix test (each pair of mods loaded together)
- A regression test checklist exists and is executed after each game update
- At least 10 external beta testers have provided structured feedback
- All critical and high bugs found in beta are resolved before public release
- Test results are logged in `docs/testing/`

---

### E010 — Deployment & Workshop Publishing

**Type:** Epic
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** E009
**Description:** Final cook, packaging, and Workshop publication of all mods, including versioning, update notification hooks, and a release communication plan.
**Acceptance Criteria:**
- All mods are cooked in Shipping configuration without errors
- Each mod has a distinct Workshop item ID, version tag, and dependency list
- Update notes are posted to Workshop and community channels on release
- A rollback procedure is documented for reverting a bad Workshop update
- All mod source assets are tagged with a matching Git release tag

---

## STORIES

---

### S001-001 — Engine Version Reconciliation

**Type:** Story
**Parent:** E001
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** none
**Description:** Determine the exact UE5 version embedded in the Bellwright game binary and compare it against the ModKit version (reported 5.5.4). Identify whether asset compatibility shims are needed and whether Blueprint nodes differ between versions.
**Acceptance Criteria:**
- UE5 build version string extracted from game binary and logged
- Version delta between game binary and ModKit identified (patch/minor/major)
- Community forum posts or official statements corroborating version information are cited
- A written compatibility assessment is committed to `docs/research/engine-version.md`
- Go/no-go flag set for whether ModKit-cooked assets load without version mismatch errors

---

### S001-002 — ModKit API Surface Mapping

**Type:** Story
**Parent:** E001
**Status:** todo
**Priority:** critical
**Effort:** M
**Prerequisites:** S001-001
**Description:** Open the ModKit editor and systematically enumerate which Blueprint classes, data table schemas, and nodes are exposed for modding. Focus on quest/NPC AI, settlement management, combat, and UI subsystems.
**Acceptance Criteria:**
- A spreadsheet or markdown table lists every confirmed-accessible Blueprint parent class
- Quest and NPC AI Blueprint node availability is explicitly documented (yes/no/partial)
- Combat Blueprint node availability is explicitly documented
- Settlement/resource-routing API availability is explicitly documented
- Document committed to `docs/research/modkit-api-surface.md`

---

### S001-003 — RE-UE4SS Compatibility Verification

**Type:** Story
**Parent:** E001
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S001-001
**Description:** Test whether the current RE-UE4SS release (or a pinned version) injects cleanly into Bellwright without crashing the process, and verify that the Lua console and C++ API are functional.
**Acceptance Criteria:**
- RE-UE4SS injection attempt is documented with exact version numbers
- Lua `print("hello")` executes and appears in the RE-UE4SS console without crash
- At least one UObject property is successfully read via Lua API
- Crash or incompatibility findings are logged with full error output
- Go/no-go flag set for RE-UE4SS usage committed to `docs/research/re-ue4ss-compatibility.md`

---

### S001-004 — Settlement & Automation API Investigation

**Type:** Story
**Parent:** E001
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S001-002, S001-003
**Description:** Determine whether the villager task assignment, resource routing, and production queue systems have any accessible hooks in either the ModKit or RE-UE4SS API. This gates the entire E006 scope.
**Acceptance Criteria:**
- ModKit Blueprint node search results for "villager", "task", "route", and "queue" are documented
- RE-UE4SS UObject dump is searched for relevant class names and findings recorded
- A scoped statement of what is achievable (full/partial/none) is written
- Alternative implementation approaches are proposed if direct API access is unavailable
- Findings committed to `docs/research/automation-api.md`

---

### S002-001 — ModKit Installation & Configuration

**Type:** Story
**Parent:** E002
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** S001-001
**Description:** Install the Bellwright ModKit via Epic Games Store, configure project settings, and verify that the editor launches and can open the sample content provided by Donkey Crew.
**Acceptance Criteria:**
- ModKit installs without errors on the development machine
- Sample content project opens in the editor without missing asset warnings
- Editor version matches the expected ModKit version string
- Project settings (target platform, cook directory) are configured and saved
- Setup steps documented in `docs/environment-setup.md`

---

### S002-002 — Source Control Setup for Mod Assets

**Type:** Story
**Parent:** E002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S002-001
**Description:** Initialise a Git repository for mod source assets with a `.gitignore` tuned for UE5 (excludes Binaries, Intermediate, Saved, DerivedDataCache). Configure Git LFS for binary asset types (`.uasset`, `.umap`, `.png`, `.fbx`).
**Acceptance Criteria:**
- Git repo initialised with correct `.gitignore` (no Intermediate or DerivedDataCache files tracked)
- Git LFS configured and tracking `.uasset`, `.umap`, `.png`, `.fbx`, `.wav`
- Initial commit contains only source-controlled files
- Remote repository (GitHub or equivalent) is created and first push succeeds
- `docs/contributing.md` documents the LFS setup steps for new contributors

---

### S002-003 — RE-UE4SS Installation & Baseline

**Type:** Story
**Parent:** E002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S001-003, S002-001
**Description:** Install RE-UE4SS into the Bellwright game directory, configure the UE4SS-settings.ini, and verify a baseline Lua script runs on game launch. Conditional on S001-003 go/no-go being positive.
**Acceptance Criteria:**
- RE-UE4SS DLLs are present in the correct game directory path
- UE4SS-settings.ini is configured with correct game name and logging paths
- Baseline Lua script (`mods/HelloWorld/scripts/main.lua`) executes on game launch
- Console output confirms script loaded without errors
- Steps documented in `docs/environment-setup.md` under RE-UE4SS section

---

### S002-004 — Steam Workshop CLI Setup

**Type:** Story
**Parent:** E002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S002-001
**Description:** Configure the Steam Workshop upload pipeline using the ModKit's built-in Workshop integration or SteamCMD, create a placeholder Workshop item, and verify that a cooked mod package can be uploaded and subscribed to.
**Acceptance Criteria:**
- Steam Workshop developer account is linked to the ModKit upload tool
- A placeholder mod item exists on the Workshop with correct AppID
- A cooked `.pak` file uploads successfully to the placeholder item
- The uploaded mod appears in the in-game mod browser after subscription
- Upload command is scripted and documented in `docs/workshop-publishing.md`

---

### S002-005 — End-to-End Pipeline Smoke Test

**Type:** Story
**Parent:** E002
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** S002-001, S002-002, S002-003, S002-004
**Description:** Create a minimal "Hello World" mod (a single modified data table row changing a numeric value), cook it, upload it, subscribe in-game, and verify the change is observable in-game. This validates the full pipeline before any real development begins.
**Acceptance Criteria:**
- A data table row is modified (e.g., player carry weight +1)
- Mod cooks without errors in Development configuration
- Cooked mod uploads to Workshop and downloads via subscription
- In-game value reflects the modification
- The smoke test mod is committed to the repo under `mods/SmokeTest/`

---

### S003-001 — QoL Settings Architecture

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S002-005
**Description:** Design and implement the configuration data asset schema and in-game settings panel Blueprint that will back all QoL settings. All individual QoL feature stories depend on this architecture being in place.
**Acceptance Criteria:**
- A `DA_BellwrightPlus_Config` Data Asset class is defined with typed fields for each setting
- Default values match vanilla game behaviour (no unintended changes at default)
- An in-game settings panel Blueprint opens from the main menu or pause menu
- Settings persist to save file between sessions
- Architecture document committed to `docs/mods/bellwright-plus/architecture.md`

---

### S003-002 — Carry Weight & Inventory Limits

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S003-001
**Description:** Expose player carry weight limit and inventory slot count as configurable settings within the Bellwright Plus settings panel, driven by the config Data Asset.
**Acceptance Criteria:**
- Carry weight limit is adjustable from 0.5x to 5x vanilla value in 0.1x increments
- Inventory slot count is adjustable from vanilla to 2x vanilla
- Changes take effect immediately without requiring a save/reload
- Default values reproduce vanilla behaviour exactly
- Setting labels and tooltips are present in the UI panel

---

### S003-003 — Crafting Queue & Batch Size

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S003-001
**Description:** Increase the maximum crafting queue depth and per-craft batch size limits via data table overrides and config-driven Blueprint logic.
**Acceptance Criteria:**
- Crafting queue depth is configurable from vanilla value up to 50 items
- Batch craft size is configurable from vanilla up to 100 units per action
- Queue overflow is handled gracefully (no crash, informative message)
- Default values match vanilla
- Feature is toggled independently of other QoL settings

---

### S003-004 — Villager Assignment Limits

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S003-001
**Description:** Remove or raise the cap on how many villagers can be assigned to a single building or role, configurable via the settings panel.
**Acceptance Criteria:**
- Per-building villager cap is configurable from vanilla up to unlimited (0 = unlimited)
- Per-role global cap is separately configurable
- Existing assignments are preserved when the cap is raised
- Setting the cap below current assignments clamps gracefully without crashing
- Default values match vanilla

---

### S003-005 — Hunger, Sleep & Needs Decay Rates

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S003-001
**Description:** Expose player and villager hunger/sleep/morale decay multipliers as configurable settings, allowing players to reduce survival micromanagement to taste.
**Acceptance Criteria:**
- Player hunger decay rate configurable from 0 (disabled) to 2x vanilla
- Player sleep decay rate configurable from 0 to 2x vanilla
- Villager morale decay rate configurable from 0 to 2x vanilla
- All three settings are independent sliders
- Zero value correctly disables the mechanic without errors

---

### S003-006 — Respawn & Cooldown Timers

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S003-001
**Description:** Expose enemy respawn timers, resource node respawn timers, and player death cooldown as configurable multipliers.
**Acceptance Criteria:**
- Enemy respawn timer configurable from 0.1x to 5x vanilla
- Resource node respawn timer configurable from 0.1x to 5x vanilla
- Player death cooldown configurable from 0 to vanilla value
- All three settings are independent
- Default values match vanilla

---

### S003-007 — Fast Travel Unlock Thresholds

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S003-001
**Description:** Lower or remove the settlement reputation/progression thresholds required to unlock fast travel points, configurable via the settings panel.
**Acceptance Criteria:**
- Fast travel unlock threshold is configurable from 0% (always unlocked) to 100% (vanilla)
- Existing unlocked fast travel points are preserved at any setting
- Setting to 0% unlocks all points immediately on load
- Default value matches vanilla
- Setting is clearly labelled with a note about its impact on game progression

---

### S003-008 — XP & Progression Rate Multipliers

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S003-001
**Description:** Add XP gain multipliers for player skills and technology research speed as configurable settings.
**Acceptance Criteria:**
- Player skill XP multiplier configurable from 0.5x to 10x
- Technology research speed multiplier configurable from 0.5x to 10x
- Multipliers apply to all skill/tech paths uniformly
- Default is 1x (vanilla)
- Values above 1x are clearly marked as affecting game balance

---

### S003-009 — Bellwright Plus — Cook, Package & Publish

**Type:** Story
**Parent:** E003
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S003-002, S003-003, S003-004, S003-005, S003-006, S003-007, S003-008
**Description:** Cook the complete Bellwright Plus mod in Shipping configuration, prepare Workshop metadata (description, screenshots, tags), and publish to Steam Workshop.
**Acceptance Criteria:**
- Mod cooks in Shipping without errors or warnings
- Workshop listing has a feature list, installation notes, and at least 3 screenshots
- Version 1.0.0 tag is applied in Git and on Workshop
- Mod is subscribe-and-play with no manual file installation required
- Update/changelog section is present on the Workshop page

---

### S004-001 — UI Mod Architecture & Widget Framework

**Type:** Story
**Parent:** E004
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S002-005, S001-002
**Description:** Establish the Blueprint widget framework for all UI mod panels — base widget class, theme data asset, input handling, and persistence layer. All UI feature stories depend on this.
**Acceptance Criteria:**
- A `WBP_BellwrightUI_Base` widget Blueprint is created with shared styling properties
- A `DA_UITheme` Data Asset defines colours, fonts, and spacing
- Input handling routes keyboard and gamepad navigation correctly
- Panel position and visibility state persists across sessions via save game object
- Framework committed and importable by all subsequent UI stories

---

### S004-002 — Enhanced World Map

**Type:** Story
**Parent:** E004
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S004-001
**Description:** Replace or overlay the base-game world map with an enhanced version showing settlement influence radius, resource node type icons, NPC assignment zones, and a mini-legend.
**Acceptance Criteria:**
- Settlement influence radius is drawn as a coloured overlay circle on the map
- At least 6 resource node types have distinct icons on the map
- NPC assignment zones are shown as coloured regions when a villager role is selected
- Map supports zoom in/out via scroll wheel and keyboard shortcuts
- Icons are toggleable via a filter panel on the map screen

---

### S004-003 — Villager Dashboard

**Type:** Story
**Parent:** E004
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S004-001
**Description:** Add a full-screen villager management dashboard listing all recruited villagers with sortable columns for name, role, health, morale, current task, and equipment slots.
**Acceptance Criteria:**
- Dashboard lists every villager currently in the settlement
- Columns are sortable ascending/descending by click
- Clicking a villager row opens their assignment panel
- Dashboard updates in real time (no stale data after 1 second)
- Accessible from pause menu and a configurable hotkey

---

### S004-004 — Enhanced Inventory Screen

**Type:** Story
**Parent:** E004
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** S004-001
**Description:** Augment the inventory screen with per-item weight display, stack size indicator, category filter tabs, and a one-click sort button.
**Acceptance Criteria:**
- Each inventory slot shows item weight in small text
- Stack size is shown as a numeric badge
- Category filter tabs (weapons, tools, food, materials, misc) filter the grid
- Sort button orders items by category then name
- All additions are non-destructive overlays on the existing inventory widget

---

### S004-005 — HUD Information Density Improvements

**Type:** Story
**Parent:** E004
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S004-001
**Description:** Add optional HUD overlays for current carry weight percentage, active villager alerts, and nearby resource node indicators.
**Acceptance Criteria:**
- Carry weight bar shows current/max with colour transition at 80% and 100%
- Villager alert badge shows count of villagers with critical health or zero morale
- Resource node indicators appear within a configurable radius (default 50m)
- All three HUD elements are individually toggleable in settings
- HUD elements do not overlap with vanilla HUD elements at default positions

---

### S004-006 — UI Overhaul — Cook, Package & Publish

**Type:** Story
**Parent:** E004
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S004-002, S004-003, S004-004, S004-005
**Description:** Cook the UI overhaul mod in Shipping configuration and publish to Steam Workshop.
**Acceptance Criteria:**
- Mod cooks without errors
- Workshop listing documents which vanilla UI elements are replaced/augmented
- Compatibility note for Bellwright Plus mod is included
- Version 1.0.0 tag applied in Git and Workshop
- Install/uninstall instructions present

---

### S005-001 — Texture Upscaling Pipeline

**Type:** Story
**Parent:** E005
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** S002-005
**Description:** Establish a repeatable pipeline for selecting vanilla textures, upscaling them 2x using an AI upscaler (e.g., Real-ESRGAN), reimporting into ModKit, and validating compression settings.
**Acceptance Criteria:**
- Pipeline script (shell or Python) automates batch upscaling for a given texture list
- At least 20 environment textures are upscaled and reimported
- Texture compression settings match or improve on vanilla (BC7 for diffuse, BC5 for normal)
- No visible tiling artefacts introduced by the upscaling process
- Pipeline documented in `docs/mods/visuals/texture-pipeline.md`

---

### S005-002 — Lighting & Weather Data Adjustments

**Type:** Story
**Parent:** E005
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** S002-005, S001-002
**Description:** Modify sky atmosphere, directional light, and weather data assets to improve time-of-day lighting quality and add two new weather states (dense fog, overcast drizzle).
**Acceptance Criteria:**
- Golden-hour lighting (dawn/dusk) is visibly warmer and more directional than vanilla
- Dense fog weather state triggers and clears correctly via the weather system
- Overcast drizzle weather state includes particle effects and reduced sun intensity
- New weather states appear in the weather rotation with configurable frequency
- No lighting artefacts (shadow acne, over-bright bloom) introduced

---

### S005-003 — ReShade Preset

**Type:** Story
**Parent:** E005
**Status:** todo
**Priority:** low
**Effort:** S
**Prerequisites:** none
**Description:** Create a curated ReShade preset for Bellwright that improves colour grading, ambient occlusion, and sharpness without breaking UI readability or causing excessive performance loss.
**Acceptance Criteria:**
- ReShade preset file (`.ini`) is tuned specifically for Bellwright's art style
- UI elements remain fully readable with the preset active
- FPS impact is below 5% on an RTX 3070 equivalent at 1440p
- Installation instructions (ReShade version, shader list, file placement) are written
- Preset is distributed as a standalone download separate from Workshop mods

---

### S005-004 — Visuals Pack — Cook, Package & Publish

**Type:** Story
**Parent:** E005
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S005-001, S005-002, S005-003
**Description:** Cook and publish the visual enhancement pack to Steam Workshop, and distribute the ReShade preset via a linked GitHub release.
**Acceptance Criteria:**
- Workshop mod contains upscaled textures and weather data assets
- ReShade preset is linked from the Workshop description
- Performance benchmarks are included in the description
- Version 1.0.0 tagged in Git and Workshop
- Known conflicts (e.g., other texture mods) are documented

---

### S006-001 — Automation Architecture Decision

**Type:** Story
**Parent:** E006
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** S001-004
**Description:** Based on S001-004 findings, decide whether settlement automation will be implemented via ModKit Blueprints, RE-UE4SS Lua, or a hybrid approach. Document the chosen architecture and its constraints.
**Acceptance Criteria:**
- Implementation approach (ModKit/RE-UE4SS/hybrid) is selected with written rationale
- Scope is explicitly bounded by what the chosen approach can access
- Any features that are infeasible are formally descoped with explanation
- Architecture document committed to `docs/mods/automation/architecture.md`
- Go/no-go for each automation sub-feature is recorded

---

### S006-002 — Resource Auto-Routing Rules Engine

**Type:** Story
**Parent:** E006
**Status:** todo
**Priority:** high
**Effort:** L
**Prerequisites:** S006-001, S002-005
**Description:** Implement the core auto-routing logic that monitors stockpile contents and triggers villager carry tasks to feed linked crafting stations when their input buffers fall below a threshold.
**Acceptance Criteria:**
- A "link stockpile to station" action is available in the station UI
- When station input buffer drops below 25% (configurable), a carry task is generated
- Villagers with no current task are assigned the carry task automatically
- Routing rules persist through save/load cycles
- Routing can be paused per link without deleting the rule

---

### S006-003 — Persistent Villager Task Queues

**Type:** Story
**Parent:** E006
**Status:** todo
**Priority:** high
**Effort:** L
**Prerequisites:** S006-001, S002-005
**Description:** Replace the ephemeral villager task assignment with a persistent FIFO queue per villager, allowing players to pre-schedule up to 5 tasks that execute in order.
**Acceptance Criteria:**
- Each villager has a task queue panel showing up to 5 queued tasks
- Tasks execute in FIFO order; completed tasks are removed automatically
- Queue state persists through save/load
- Tasks can be reordered by drag-and-drop in the queue panel
- Invalid tasks (resource unavailable) are skipped with a log entry, not silently stalled

---

### S006-004 — Production Chain Visualiser

**Type:** Story
**Parent:** E006
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** S006-001, S004-001
**Description:** Add a UI panel that renders the full directed acyclic graph of resource inputs and outputs for any selected recipe, showing what feeds what across multiple production stages.
**Acceptance Criteria:**
- Selecting any recipe opens a DAG panel showing all upstream inputs recursively
- Each node in the DAG shows current stockpile count vs required count
- Nodes with insufficient stock are highlighted in red
- DAG updates in real time as stockpile levels change
- Panel is accessible from any crafting station UI

---

### S006-005 — Automation Tools — Cook, Package & Publish

**Type:** Story
**Parent:** E006
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S006-002, S006-003, S006-004
**Description:** Cook and publish the automation tools mod to Steam Workshop, noting any RE-UE4SS dependency in the Workshop description if applicable.
**Acceptance Criteria:**
- Mod cooks without errors (or RE-UE4SS Lua bundle is packaged correctly)
- Workshop description clearly states whether RE-UE4SS is a required dependency
- Dependency link to RE-UE4SS Workshop item is set if applicable
- Version 1.0.0 tagged
- Known performance implications of auto-routing are documented

---

### S007-001 — Combat Mod Feasibility Gate

**Type:** Story
**Parent:** E007
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** S001-002
**Description:** Evaluate S001-002 findings to determine whether combat Blueprint nodes (damage types, status effect application, weapon component attachment, AI behaviour trees) are exposed in ModKit. Gate all S007-00x stories on a positive outcome.
**Acceptance Criteria:**
- Combat Blueprint parent classes accessible in ModKit are enumerated
- Status effect system hooks (if any) are documented
- Weapon component attachment API availability is confirmed or denied
- Enemy AI behaviour tree editability is confirmed or denied
- Go/no-go decision for combat mod is written and committed

---

### S007-002 — Status Effects System

**Type:** Story
**Parent:** E007
**Status:** todo
**Priority:** high
**Effort:** L
**Prerequisites:** S007-001, S002-005
**Description:** Implement bleed, stun, and slow status effects as Blueprint components that can be applied to any actor with a health component, including players and enemies.
**Acceptance Criteria:**
- Bleed applies damage over time at a configurable tick rate and duration
- Stun interrupts current action and prevents input for a configurable duration
- Slow reduces movement speed by a configurable percentage for a configurable duration
- Multiple instances of the same effect stack correctly (refresh or add)
- Visual indicators (UI icon + particle effect) are shown on affected actors

---

### S007-003 — New Weapon Archetypes

**Type:** Story
**Parent:** E007
**Status:** todo
**Priority:** medium
**Effort:** L
**Prerequisites:** S007-001, S002-005
**Description:** Add three new weapon archetypes — a war scythe (reach + bleed), a buckler (parry + stun), and a recurve bow (long range + slow arrows) — with crafting recipes, stat profiles, and basic animations.
**Acceptance Criteria:**
- All three weapons appear in the appropriate crafting station recipe lists
- Each weapon has correct stats (damage, speed, range) relative to vanilla equivalents
- War scythe applies bleed on hit; recurve arrows apply slow on hit; buckler bash applies stun
- Weapons use placeholder animations that do not clip through terrain
- Item icons and descriptions are present in the inventory

---

### S007-004 — New Enemy Variants

**Type:** Story
**Parent:** E007
**Status:** todo
**Priority:** medium
**Effort:** L
**Prerequisites:** S007-001, S002-005
**Description:** Add two new enemy variants — an armoured bandit (high HP, slow, bleed-resistant) and a skirmisher (low HP, fast, applies slow on hit) — with spawn entries in appropriate biome regions.
**Acceptance Criteria:**
- Both variants spawn in at least two biome regions at correct difficulty tiers
- Armoured bandit has 2x HP and 50% bleed resistance compared to vanilla bandit
- Skirmisher has 0.7x HP and 1.4x movement speed compared to vanilla equivalent
- Both variants have loot tables with at least one unique drop
- Enemy names and descriptions appear correctly in the kill feed

---

### S007-005 — Combo Input System

**Type:** Story
**Parent:** E007
**Status:** todo
**Priority:** medium
**Effort:** L
**Prerequisites:** S007-002, S007-003
**Description:** Implement a timed sequential input combo system where light-light-heavy and light-heavy-light input sequences trigger enhanced attacks with unique animations and status effect application.
**Acceptance Criteria:**
- Two combo sequences (LLH and LHL) are recognised with a 400ms input window
- Each combo plays a distinct attack animation
- LLH combo applies stun on the final hit; LHL applies bleed
- Combo window is visualised with a brief on-screen indicator
- Combo system does not interfere with vanilla attack inputs outside the window

---

### S007-006 — Combat Expansion — Cook, Package & Publish

**Type:** Story
**Parent:** E007
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S007-002, S007-003, S007-004, S007-005
**Description:** Cook and publish the combat expansion mod to Steam Workshop.
**Acceptance Criteria:**
- Mod cooks without errors in Shipping configuration
- Workshop description includes a compatibility note for Bellwright Plus (stat multiplier interactions)
- Version 1.0.0 tagged in Git and Workshop
- Known balance implications are documented
- A balance/feedback section is present on the Workshop page

---

### S008-001 — Modder API Documentation

**Type:** Story
**Parent:** E008
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** S001-002, S001-003
**Description:** Compile the ModKit API surface map and RE-UE4SS findings into a structured modder reference document covering accessible classes, data table schemas, Blueprint patterns, and Lua API examples.
**Acceptance Criteria:**
- Document covers all confirmed-accessible Blueprint parent classes with brief descriptions
- At least 5 data table schema definitions are documented with field types
- At least 3 Lua API examples are provided with expected output
- Document is published to the project GitHub wiki or Nexus Mods article
- Document version is tied to game version and ModKit version

---

### S008-002 — Tutorial Series

**Type:** Story
**Parent:** E008
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** S002-005, S008-001
**Description:** Write and publish two tutorials: one beginner article covering data table modification to change a numeric stat, and one intermediate article covering Blueprint widget creation for a HUD overlay.
**Acceptance Criteria:**
- Beginner tutorial covers: install ModKit, find a data table, modify a value, cook, upload to Workshop
- Intermediate tutorial covers: create a widget Blueprint, bind to a game variable, cook, upload
- Both tutorials include screenshots of each step in the ModKit editor
- Tutorials are published to Nexus Mods article section or a community wiki
- Both tutorials are cross-posted to the Bellwright community Discord

---

### S008-003 — Workshop Listings & Community Setup

**Type:** Story
**Parent:** E008
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S003-009, S004-006, S005-004, S006-005, S007-006
**Description:** Finalise all Workshop mod listings with formatted descriptions, feature tables, screenshots, and cross-mod compatibility notes. Set up a community hub (Discord server or GitHub Discussions) for bug reports and feedback.
**Acceptance Criteria:**
- All Workshop mod pages have structured descriptions with feature list, requirements, and known issues
- A bug report template is live in the community hub
- All mod source repos are public with permissive licence (MIT or CC BY)
- Discord/GitHub link is present on every Workshop page
- Mod collection grouping all five mods is created on Workshop

---

### S009-001 — Cross-Mod Compatibility Matrix Testing

**Type:** Story
**Parent:** E009
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S003-009, S004-006, S005-004, S006-005, S007-006
**Description:** Test every pairwise combination of the five released mods loaded together. Document any conflicts, crashes, or unexpected interactions.
**Acceptance Criteria:**
- All 10 pairwise combinations (C(5,2)) are tested
- All three-mod and higher combinations are tested (at least the most likely user combinations)
- Each conflict is logged with reproduction steps in `docs/testing/compatibility-matrix.md`
- All critical conflicts are resolved before public release
- A compatibility table is added to each Workshop listing

---

### S009-002 — Beta Programme

**Type:** Story
**Parent:** E009
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S009-001
**Description:** Recruit at least 10 external beta testers, distribute pre-release Workshop builds via a private collection, and collect structured feedback using a standardised form.
**Acceptance Criteria:**
- At least 10 testers are recruited from the Bellwright community Discord or forums
- Each tester receives a structured feedback form (bug severity, reproduction steps, system specs)
- Beta period runs for at least 7 days
- All critical and high-severity bugs reported are triaged and assigned
- Beta findings are logged in `docs/testing/beta-feedback.md`

---

### S009-003 — Post-Patch Regression Checklist

**Type:** Story
**Parent:** E009
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S002-005
**Description:** Write a repeatable regression checklist that can be executed after any Bellwright game update to verify all mods still function correctly.
**Acceptance Criteria:**
- Checklist covers at least 20 specific in-game verifiable behaviours across all mods
- Checklist is written in a format that a non-developer tester can follow
- Estimated execution time per checklist run is documented (target: under 60 minutes)
- Checklist is committed to `docs/testing/regression-checklist.md`
- Checklist is reviewed and updated after each game patch that affects mod behaviour

---

### S010-001 — Final Cook & Packaging

**Type:** Story
**Parent:** E010
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S009-002
**Description:** Perform final Shipping-configuration cooks of all five mods, verify pak integrity, and prepare release bundles with version manifests.
**Acceptance Criteria:**
- All five mods cook in Shipping configuration without errors
- Pak file checksums are recorded in a release manifest
- Each mod's file size is within Workshop item size limits
- Release bundles are tagged with v1.0.0 in Git
- Cook log files are archived in `docs/releases/v1.0.0/`

---

### S010-002 — Workshop Publication & Release Communication

**Type:** Story
**Parent:** E010
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S010-001, S008-003
**Description:** Publish all mods publicly on Steam Workshop, post release announcements to community channels, and activate the mod collection.
**Acceptance Criteria:**
- All five mods are set to public visibility on Workshop simultaneously
- Release announcement is posted to Bellwright community Discord and forums
- Mod collection is promoted to featured status (if available)
- GitHub releases are created with release notes for each mod
- A rollback procedure (reverting to previous Workshop build) is tested and documented

---

## TASKS

---

### T001-001-001 — Extract UE5 Version from Game Binary

**Type:** Task
**Parent:** S001-001
**Status:** todo
**Priority:** critical
**Effort:** XS
**Prerequisites:** none
**Description:** Use a hex editor or the `strings` utility on `Bellwright-Win64-Shipping.exe` to locate the UE5 build version string embedded in the binary. Record the exact version string.
**Acceptance Criteria:**
- Exact version string (e.g., `++UE5+Release-5.6-CL-XXXXXXX`) is extracted and recorded
- Screenshot or log output of the extraction is saved to `docs/research/evidence/binary-version-extract.txt`
- Version is compared against ModKit `VersionInfo.txt` or equivalent
- Discrepancy (if any) is quantified (patch/minor/major delta)
- Finding is committed

**Agent notes:** Run `strings Bellwright-Win64-Shipping.exe | grep -E "UE[45]\+|++UE"` on the game binary. ModKit version is in `Engine/Build/Build.version` within the ModKit install directory. Compare the two JSON version files directly.

---

### T001-001-002 — Search Community Sources for Version Confirmation

**Type:** Task
**Parent:** S001-001
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T001-001-001
**Description:** Search the Bellwright Steam forums, Donkey Crew Discord, Nexus Mods comments, and RE-UE4SS GitHub issues for community reports on the UE5 version used in Bellwright. Cross-reference with binary extraction findings.
**Acceptance Criteria:**
- At least 3 independent community sources are cited
- Any conflicts between community reports and binary extraction are noted
- Official statements from Donkey Crew (if any) are recorded
- Sources are hyperlinked in the research document
- Finding is incorporated into `docs/research/engine-version.md`

**Agent notes:** Search terms: "Bellwright UE5 version", "Bellwright Unreal version", "Bellwright 5.6". Check the pinned posts in the Bellwright Steam forum and the #modding channel of the Donkey Crew Discord.

---

### T001-001-003 — Write Engine Version Research Document

**Type:** Task
**Parent:** S001-001
**Status:** todo
**Priority:** critical
**Effort:** XS
**Prerequisites:** T001-001-001, T001-001-002
**Description:** Synthesise the binary extraction and community findings into a structured document that states the confirmed version, the version delta, compatibility implications, and a go/no-go recommendation.
**Acceptance Criteria:**
- Document states confirmed game binary version and ModKit version
- Compatibility implication is classified as: no issue / shim required / blocker
- Go/no-go flag for ModKit asset loading is explicit
- Document is under `docs/research/engine-version.md`
- Committed to repo

**Agent notes:** Document should follow this structure: Summary, Evidence (binary extraction, community sources), Version Comparison Table, Compatibility Assessment, Recommendation.

---

### T001-002-001 — Open ModKit and Enumerate Blueprint Parent Classes

**Type:** Task
**Parent:** S001-002
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** S002-001, T001-001-003
**Description:** Open the Bellwright ModKit editor and use the content browser and class viewer to enumerate all Blueprint parent classes that modders can extend. Filter for game-specific classes (not engine-only classes).
**Acceptance Criteria:**
- Class viewer is filtered to show only project-specific (non-engine) Blueprint classes
- At least 30 game-specific Blueprint parent classes are listed
- Each class has a one-line description of its apparent purpose
- Screenshot of the class viewer is saved to `docs/research/evidence/`
- Raw class list is committed to `docs/research/modkit-api-surface.md`

**Agent notes:** In the ModKit editor, use Window > Class Viewer, filter by "Blueprint" and uncheck "Engine Classes". Export the filtered list via right-click > Copy Class Hierarchy if available.

---

### T001-002-002 — Test Quest & NPC AI Node Accessibility

**Type:** Task
**Parent:** S001-002
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T001-002-001
**Description:** Create a test Blueprint in the ModKit that attempts to extend the NPC AI controller class. Verify which AI behaviour tree nodes and task classes are accessible and which are restricted.
**Acceptance Criteria:**
- A test Blueprint extending the NPC AI controller class (or closest accessible equivalent) is created
- Accessible behaviour tree task classes are listed
- Restricted/unavailable classes are listed with the specific error or omission noted
- Finding is categorised: full access / partial access / no access
- Evidence committed to `docs/research/modkit-api-surface.md`

**Agent notes:** Look for classes named `*AIController*`, `*BTTask*`, `*BTDecorator*`, `*NPCCharacter*` in the class viewer. Attempt to create a child Blueprint of each. If the class is abstract-only with no overrideable functions, note that.

---

### T001-002-003 — Test Combat Node Accessibility

**Type:** Task
**Parent:** S001-002
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T001-002-001
**Description:** Create a test Blueprint in the ModKit that attempts to extend the weapon, damage type, and status effect classes. Document which combat-related Blueprint nodes are callable.
**Acceptance Criteria:**
- Weapon component base class accessibility is confirmed or denied
- Damage type class accessibility is confirmed or denied
- Status effect application function availability is confirmed or denied
- Test Blueprint is saved to the ModKit project under `Mods/Research/`
- Findings committed to `docs/research/modkit-api-surface.md`

**Agent notes:** Search class viewer for `*Weapon*`, `*DamageType*`, `*StatusEffect*`, `*CombatComponent*`. For each, check if "Create Child Blueprint Class" is available (right-click in content browser).

---

### T001-002-004 — Test UI Widget Accessibility

**Type:** Task
**Parent:** S001-002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T001-002-001
**Description:** Attempt to subclass or add to existing HUD and inventory widget Blueprints to determine whether the UI layer is extensible through the ModKit.
**Acceptance Criteria:**
- HUD widget Blueprint accessibility (extend vs replace) is documented
- Inventory screen widget Blueprint accessibility is documented
- Map widget Blueprint accessibility is documented
- At least one successful widget override test is demonstrated
- Findings committed to `docs/research/modkit-api-surface.md`

**Agent notes:** Search for `*HUD*`, `*Widget*`, `*UserWidget*`, `*InventoryUI*` in the content browser. Try adding a new widget Blueprint and referencing vanilla widgets to check for circular dependency blocks.

---

### T001-002-005 — Test Settlement/Resource Data Table Accessibility

**Type:** Task
**Parent:** S001-002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T001-002-001
**Description:** Locate and open settlement-related data tables (building definitions, resource types, crafting recipes, tech tree) in the ModKit and verify which fields can be overridden.
**Acceptance Criteria:**
- At least 5 settlement/crafting data tables are located in the ModKit content browser
- Column schema for each table is documented
- Fields that are read-only vs modifiable are identified
- A test row override is created and cooked successfully
- Findings committed to `docs/research/modkit-api-surface.md`

**Agent notes:** Search the content browser for assets of type `DataTable`. Check the row structure editor for each. Attempt to duplicate a row and modify numeric fields, then cook to verify no errors.

---

### T001-002-006 — Write ModKit API Surface Document

**Type:** Task
**Parent:** S001-002
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T001-002-002, T001-002-003, T001-002-004, T001-002-005
**Description:** Consolidate all ModKit investigation findings into the structured API surface document with a summary table and per-system go/no-go flags.
**Acceptance Criteria:**
- Document has a summary table: System | Accessibility | Notes
- Each of the four target systems (quest/NPC AI, combat, UI, settlement) has a go/no-go flag
- Accessible classes are listed with their overrideable functions
- Document is under `docs/research/modkit-api-surface.md`
- Committed to repo

**Agent notes:** The summary table should use clear symbols (e.g., Full / Partial / None) and the body should have a section per system with evidence screenshots referenced.

---

### T001-003-001 — Download and Pin RE-UE4SS Version

**Type:** Task
**Parent:** S001-003
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** none
**Description:** Download the latest stable RE-UE4SS release from GitHub and identify the specific version number. Pin this version for reproducibility.
**Acceptance Criteria:**
- RE-UE4SS release version number is recorded (e.g., v3.0.1)
- Release download URL and SHA256 checksum are recorded in `docs/research/re-ue4ss-compatibility.md`
- The downloaded archive is stored in `tools/re-ue4ss/` in the repo (if under size limit) or linked
- Version is confirmed against the RE-UE4SS GitHub releases page
- Committed to repo

**Agent notes:** RE-UE4SS releases are at https://github.com/UE4SS-RE/RE-UE4SS/releases. Download the `UE4SS_v*.zip` asset. Record the exact tag version. Do not use a pre-release build unless the stable release is confirmed incompatible.

---

### T001-003-002 — Inject RE-UE4SS into Bellwright

**Type:** Task
**Parent:** S001-003
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T001-003-001
**Description:** Place RE-UE4SS DLLs in the Bellwright game binary directory per the official installation instructions, launch the game, and observe whether injection succeeds without crash.
**Acceptance Criteria:**
- `UE4SS.dll`, `dwmapi.dll` (or equivalent proxy), and `UE4SS-settings.ini` are placed in the correct directory
- Game launches without crash to main menu
- RE-UE4SS console window appears (or log file is written) confirming injection
- UE4SS version and detected game name are logged
- Outcome (success/crash/silent fail) committed to `docs/research/re-ue4ss-compatibility.md`

**Agent notes:** Default install path for the proxy DLL is `Bellwright/Binaries/Win64/`. The `UE4SS-settings.ini` `[General]` section must have `GuiConsoleEnabled = 1` to see the console. Check `UE4SS.log` in the same directory for injection outcome.

---

### T001-003-003 — Execute Baseline Lua Script via RE-UE4SS

**Type:** Task
**Parent:** S001-003
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T001-003-002
**Description:** Create a minimal Lua mod that prints a message and reads a UObject property, and verify it executes correctly via the RE-UE4SS Lua runtime.
**Acceptance Criteria:**
- A `mods/HelloLua/scripts/main.lua` file with `print("RE-UE4SS OK")` executes on game launch
- Output appears in the RE-UE4SS console
- At least one UObject property (e.g., player location) is read and printed without error
- Full Lua mod structure (`enabled.txt`, `scripts/main.lua`) is committed to `tools/re-ue4ss-test/`
- Outcome committed to `docs/research/re-ue4ss-compatibility.md`

**Agent notes:** Lua mod structure: create folder `ue4ss/Mods/HelloLua/`, add `enabled.txt` (empty file), add `scripts/main.lua`. Use `UEHelpers.GetPlayer()` to get the player Pawn, then `player:GetActorLocation()` to read a property. Log with `print(...)`.

---

### T001-003-004 — Write RE-UE4SS Compatibility Document

**Type:** Task
**Parent:** S001-003
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T001-003-002, T001-003-003
**Description:** Write the compatibility finding document with pinned version, injection outcome, Lua runtime status, and a go/no-go recommendation for RE-UE4SS-based features.
**Acceptance Criteria:**
- Document states RE-UE4SS version and injection method
- Injection outcome (success/fail/partial) is stated with evidence
- Lua runtime status is confirmed
- Go/no-go flag for RE-UE4SS development is explicit
- Committed to `docs/research/re-ue4ss-compatibility.md`

**Agent notes:** If injection fails, document the exact error, the Bellwright build version, and any workarounds found in community sources before setting the go/no-go flag to no.

---

### T001-004-001 — Search ModKit for Settlement API Nodes

**Type:** Task
**Parent:** S001-004
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T001-002-001, T001-003-004
**Description:** Perform a systematic keyword search in the ModKit Blueprint editor for functions and nodes related to villager tasks, resource routing, and production queues.
**Acceptance Criteria:**
- Blueprint function search results for "villager", "task", "route", "queue", "assign", "carry" are documented
- At least one callable function for villager task assignment (if any) is demonstrated in a test Blueprint
- Data table schemas for villager role definitions are located and documented
- Findings are categorised by accessibility tier (data-only / Blueprint / none)
- Raw search screenshots saved to `docs/research/evidence/`

**Agent notes:** Use the Blueprint editor's "Find in Blueprints" tool (Edit menu) with wildcard search. Also search the data table list for tables with "Villager", "Task", "Job", "Role" in their names.

---

### T001-004-002 — Search RE-UE4SS UObject Dump for Automation Classes

**Type:** Task
**Parent:** S001-004
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T001-003-003
**Description:** Use RE-UE4SS's UObject dump feature to generate a full class list and search it for settlement automation-related classes and properties.
**Acceptance Criteria:**
- Full UObject dump is generated via RE-UE4SS console command `DumpAllObjects` or equivalent
- Dump is searched for classes containing "Villager", "Task", "Route", "Production", "Queue"
- At least 5 relevant classes are identified with their property lists
- Property access test (read a villager task property via Lua) is attempted and outcome recorded
- Findings committed to `docs/research/automation-api.md`

**Agent notes:** In the RE-UE4SS console, run `UEHelpers.DumpAllObjects("dump.txt")` or use the built-in object dump tool (Dumper tab in GUI). Parse the output file for relevant class names. Then attempt `FindFirstOf("VillagerCharacter")` in Lua to get a live instance and read its properties.

---

### T001-004-003 — Write Automation API Document and Scope Statement

**Type:** Task
**Parent:** S001-004
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T001-004-001, T001-004-002
**Description:** Synthesise the ModKit and RE-UE4SS findings into a scoped statement of what automation features are achievable and at what implementation tier, with descoped items explained.
**Acceptance Criteria:**
- Document states which automation features are achievable via ModKit data / ModKit Blueprint / RE-UE4SS Lua / none
- Infeasible features are listed with technical reason
- Alternative approaches for infeasible features are proposed (where any exist)
- Go/no-go flag for each of the three automation sub-features (routing, task queues, visualiser) is explicit
- Committed to `docs/research/automation-api.md`

**Agent notes:** The three sub-features have different feasibility profiles. Routing may require RE-UE4SS if villager task classes aren't Blueprint-accessible. The visualiser is likely UI-only (always feasible). Be explicit about which tier each requires.

---

### T002-001-001 — Install ModKit via Epic Games Launcher

**Type:** Task
**Parent:** S002-001
**Status:** todo
**Priority:** critical
**Effort:** XS
**Prerequisites:** none
**Description:** Install the Bellwright ModKit through the Epic Games Store/Launcher and record the installed version, install path, and disk space used.
**Acceptance Criteria:**
- ModKit installed without errors
- Installed version string is recorded
- Install path is confirmed (default or custom)
- Disk usage is recorded (for documentation)
- Installation outcome committed to `docs/environment-setup.md`

**Agent notes:** The ModKit is listed under the "Library" section of the Epic Games Launcher as a separate entry from the base game. It may be listed under "Bellwright" as a "Mod Tools" option. Note the exact product name as listed in the launcher.

---

### T002-001-002 — Launch ModKit and Verify Sample Content

**Type:** Task
**Parent:** S002-001
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T002-001-001
**Description:** Launch the ModKit editor, open the sample content project (if provided), and verify it loads without missing asset warnings or crashes.
**Acceptance Criteria:**
- ModKit editor launches to the project selection screen
- A new or sample project opens without "missing asset" warnings in the message log
- The content browser shows game content assets are available for reference
- The editor version string in the Help > About menu is recorded
- Any first-launch configuration steps are documented in `docs/environment-setup.md`

**Agent notes:** Check the Output Log window (Window > Output Log) for any errors after the project opens. A small number of warnings about shader compilation is normal. Missing asset warnings (red text) should be flagged.

---

### T002-001-003 — Configure ModKit Project Settings

**Type:** Task
**Parent:** S002-001
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T002-001-002
**Description:** Configure the ModKit project settings for mod development: set target platform (Windows 64), configure the cook output directory, and set up mod metadata defaults.
**Acceptance Criteria:**
- Target platform is set to Win64 Shipping
- Cook output directory is set to a known, version-controlled-adjacent path (e.g., `output/cooked/`)
- Mod metadata defaults (author name, mod prefix) are configured
- Settings are saved and persist after editor restart
- Configuration steps committed to `docs/environment-setup.md`

**Agent notes:** Project settings are under Edit > Project Settings. Look for "Mod Configuration" or "Packaging" sections. The cook directory should be outside the `Intermediate/` folder to survive editor cleans.

---

### T002-002-001 — Initialise Git Repository

**Type:** Task
**Parent:** S002-002
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T002-001-003
**Description:** Initialise a Git repository in the modding project root directory with the correct UE5 `.gitignore` and an initial commit.
**Acceptance Criteria:**
- `git init` run in the project root
- `.gitignore` contains exclusions for `Binaries/`, `Intermediate/`, `Saved/`, `DerivedDataCache/`, `Build/`
- Initial commit contains only `.gitignore`, `README.md`, and `docs/` skeleton
- No `.uasset` or binary files are in the initial commit
- Git log shows a clean initial commit

**Agent notes:** Use the official Unreal Engine `.gitignore` template from GitHub (search "github/gitignore UE5"). Add custom exclusions for ModKit-specific output folders. Do not add the entire ModKit install directory — only the `Content/Mods/` subdirectory.

---

### T002-002-002 — Configure Git LFS

**Type:** Task
**Parent:** S002-002
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T002-002-001
**Description:** Install Git LFS and configure it to track binary UE5 asset types so they don't bloat the repository history.
**Acceptance Criteria:**
- `git lfs install` succeeds
- `.gitattributes` tracks `*.uasset`, `*.umap`, `*.png`, `*.fbx`, `*.wav`, `*.mp3`
- A test binary file round-trips correctly through LFS (add, commit, push, pull, verify)
- `.gitattributes` is committed
- LFS quota/storage requirements are estimated and noted in `docs/contributing.md`

**Agent notes:** Run `git lfs track "*.uasset"` etc. for each type. Verify with `git lfs ls-files` after adding a test `.uasset`. GitHub LFS has a 1GB free tier; estimate your asset budget accordingly.

---

### T002-002-003 — Create Remote Repository and Push

**Type:** Task
**Parent:** S002-002
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T002-002-002
**Description:** Create a GitHub (or equivalent) remote repository, push the initial commit, and verify Git LFS objects upload correctly.
**Acceptance Criteria:**
- Remote repository is created with appropriate visibility (public for open source)
- `git remote add origin` and `git push -u origin main` succeed
- Git LFS objects are confirmed uploaded (GitHub LFS storage shows usage)
- Remote URL is recorded in `docs/environment-setup.md`
- Repo has a `LICENSE` file (MIT or CC BY recommended)

**Agent notes:** If using GitHub, create the repo via the web UI first (do not initialise with README to avoid merge conflict). Then push the local initial commit. Verify LFS upload by checking the LFS objects tab in the repo settings.

---

### T002-003-001 — Install RE-UE4SS into Game Directory

**Type:** Task
**Parent:** S002-003
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T001-003-004, T002-001-002
**Description:** Copy the pinned RE-UE4SS release files into the Bellwright game binary directory per the installation instructions.
**Acceptance Criteria:**
- `UE4SS.dll` and proxy DLL are in `Bellwright/Binaries/Win64/`
- `UE4SS-settings.ini` is present and configured
- `ue4ss/Mods/` directory structure is created
- Files are listed in `docs/environment-setup.md` with their expected paths
- Installation is reversible (original files backed up or documented)

**Agent notes:** Back up the original `dwmapi.dll` (or whichever proxy is used) before replacement. Document the exact files changed so the installation can be cleanly reversed if needed.

---

### T002-003-002 — Configure UE4SS-settings.ini

**Type:** Task
**Parent:** S002-003
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T002-003-001
**Description:** Edit `UE4SS-settings.ini` to enable GUI console, set correct game name, and configure logging to a known output path.
**Acceptance Criteria:**
- `GuiConsoleEnabled = 1` is set
- `LogToFile = 1` and log path are set
- Game name override (if needed) is configured
- Settings are tested by launching the game and verifying console appearance
- Final `UE4SS-settings.ini` is committed to `tools/re-ue4ss/UE4SS-settings.ini` in the repo

**Agent notes:** The `[General]` section controls console visibility. `[Dumper]` section controls UObject dump settings. Keep `ObjectDumperEnabled = 0` by default to avoid startup lag; enable only when needed for research.

---

### T002-004-001 — Configure Steam Workshop Upload Tool

**Type:** Task
**Parent:** S002-004
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T002-001-003
**Description:** Configure the ModKit's built-in Workshop upload tool (or SteamCMD) with developer Steam credentials and Bellwright AppID to enable Workshop publishing.
**Acceptance Criteria:**
- Workshop upload tool launches without authentication errors
- Bellwright AppID is confirmed and configured
- Developer Steam account has Workshop publisher permissions for Bellwright
- Upload tool configuration is documented (excluding credentials) in `docs/workshop-publishing.md`
- A test upload of an empty item succeeds

**Agent notes:** The Bellwright AppID is needed for SteamCMD uploads. Check the ModKit documentation for whether a built-in uploader is provided. If using SteamCMD, the `workshop_build_item.vdf` file format should be documented.

---

### T002-004-002 — Create Placeholder Workshop Item

**Type:** Task
**Parent:** S002-004
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T002-004-001
**Description:** Create a placeholder Workshop item for Bellwright Plus to claim a Workshop item ID before any content is ready. Set visibility to private.
**Acceptance Criteria:**
- Workshop item is created with correct AppID and set to private visibility
- Workshop item ID is recorded in the repo under `mods/BellwrightPlus/workshop-id.txt`
- Item title and description placeholder are set
- Item is visible in the developer's Workshop submissions list
- Item ID committed to repo

**Agent notes:** Creating a Workshop item early locks in the item ID, which is embedded in the mod's metadata. This prevents ID changes later. Do the same for all five mods (one placeholder item per mod).

---

### T002-004-003 — Create Placeholder Workshop Items for All Mods

**Type:** Task
**Parent:** S002-004
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T002-004-002
**Description:** Create private placeholder Workshop items for the remaining four mods (UI Overhaul, Visual Enhancement, Automation Tools, Combat Expansion) and record their IDs.
**Acceptance Criteria:**
- Five total Workshop items exist (one per mod), all set to private
- Each item ID is recorded in `mods/<ModName>/workshop-id.txt`
- All IDs are committed to the repo
- Workshop submissions list confirms all five items
- `docs/workshop-publishing.md` lists all five IDs

**Agent notes:** Repeat the process from T002-004-002 for each remaining mod. Use descriptive placeholder titles so the items are identifiable in the submissions list.

---

### T002-005-001 — Create and Cook Smoke Test Mod

**Type:** Task
**Parent:** S002-005
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T002-001-003, T002-002-003, T002-004-003
**Description:** Create a minimal data table override mod that changes one numeric value (player carry weight +1 kg), cook it in Development configuration, and verify the pak file is generated.
**Acceptance Criteria:**
- A new mod content folder `Content/Mods/SmokeTest/` exists in the ModKit project
- A single data table row override is created changing one numeric value
- Cook completes without errors in Development configuration
- A `.pak` file is generated in the cook output directory
- `.pak` file size is under 1 MB

**Agent notes:** In the ModKit, duplicate the target data table row into your mod's override table (following whatever override mechanism ModKit provides — check documentation for "data table override" or "primary asset label"). Cook via File > Cook Content for Windows.

---

### T002-005-002 — Upload Smoke Test Mod to Workshop

**Type:** Task
**Parent:** S002-005
**Status:** todo
**Priority:** critical
**Effort:** XS
**Prerequisites:** T002-005-001, T002-004-003
**Description:** Upload the cooked Smoke Test `.pak` to the placeholder SmokeTest Workshop item and verify the upload succeeds.
**Acceptance Criteria:**
- Upload completes without errors
- Workshop item shows the new build version
- Download via Workshop subscription succeeds (pak file is present in game's Workshop content dir)
- Subscribed mod appears in the in-game mod browser
- Upload log is saved to `docs/releases/smoke-test/`

**Agent notes:** After upload, wait 1-2 minutes for Steam Workshop propagation before testing subscription download. Check the Workshop item's "Change Notes" to confirm the build was registered.

---

### T002-005-003 — Verify Smoke Test Mod In-Game

**Type:** Task
**Parent:** S002-005
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T002-005-002
**Description:** Subscribe to the Smoke Test mod, launch Bellwright, load a save, and verify that the modified numeric value is reflected in-game.
**Acceptance Criteria:**
- Mod is active in the in-game mod list
- The modified stat value is observable in-game (carry weight shows +1 kg vs unmodded)
- No crash or error on game launch with mod active
- No crash or error on save load with mod active
- Findings (pass/fail + evidence screenshot) committed to `docs/releases/smoke-test/smoke-test-result.md`

**Agent notes:** To compare values, note the vanilla carry weight from a save without the mod active, then enable the mod and compare. If the mod system requires a new save to take effect, document that.

---

### T003-001-001 — Define Config Data Asset Schema

**Type:** Task
**Parent:** S003-001
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S002-005
**Description:** Define the `DA_BellwrightPlus_Config` Data Asset class in the ModKit with typed fields for all planned QoL settings, including default values matching vanilla.
**Acceptance Criteria:**
- Data Asset class is created with fields for carry weight multiplier, crafting queue depth, villager cap, hunger decay rate, sleep decay rate, respawn multiplier, fast travel threshold, XP multiplier, tech speed multiplier
- All fields have explicit default values matching vanilla behaviour
- Field types are correct (float for multipliers, int for counts, bool for toggles)
- Data Asset compiles without errors
- Class is committed to `Content/Mods/BellwrightPlus/Config/`

**Agent notes:** Create a new Blueprint class inheriting from `PrimaryDataAsset` (or the game's custom config base class if one exists). Add each setting as a `UPROPERTY` with a category of "BellwrightPlus". Set default values by inspecting vanilla data tables.

---

### T003-001-002 — Implement Settings Persistence

**Type:** Task
**Parent:** S003-001
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** T003-001-001
**Description:** Implement a save/load mechanism for the config Data Asset values so that player preferences persist between game sessions.
**Acceptance Criteria:**
- A custom save game object (`SaveGame_BellwrightPlus`) stores all config field values
- Config is saved when any setting is changed in the UI
- Config is loaded on game start before any gameplay systems are initialised
- Resetting to defaults restores all vanilla values without requiring a game restart
- Save/load tested on a fresh game and on an existing save

**Agent notes:** Use the `SaveGame` Blueprint subsystem. Serialise the config Data Asset fields to the save game object using a `SaveConfigToSlot` function. Load from slot on `BeginPlay` of a persistent game instance or subsystem.

---

### T003-001-003 — Create In-Game Settings Panel Blueprint

**Type:** Task
**Parent:** S003-001
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** T003-001-002
**Description:** Build the `WBP_BellwrightPlus_Settings` widget Blueprint that displays all config settings as labelled sliders or toggles and allows in-game adjustment.
**Acceptance Criteria:**
- Panel opens from the pause menu via a new "Bellwright Plus" button
- Each setting is displayed with a label, current value, and input control (slider or toggle)
- Slider ranges and step sizes match the per-setting spec (defined in S003-002 through S003-008)
- "Reset to Defaults" button is present and functional
- Panel closes without saving changes if the player presses Escape

**Agent notes:** Build the widget in the UMG editor. Use a `ScrollBox` to handle the full list of settings. Bind each control's value to the config Data Asset field via a `GetConfig` function on the game instance. The panel should be opened via `AddToViewport` on pause.

---

### T003-002-001 — Locate Carry Weight Data Table

**Type:** Task
**Parent:** S003-002
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T001-002-005, S003-001
**Description:** Find the data table row that controls the player carry weight limit and document its table name, row name, and field name.
**Acceptance Criteria:**
- Data table name and row identifier for player carry weight are recorded
- Field type (float, int) is confirmed
- Vanilla value is recorded as the baseline
- Finding committed to `docs/mods/bellwright-plus/data-table-map.md`
- No changes to game data are made in this task

**Agent notes:** Search the content browser for data tables with "Player", "Stats", "Inventory", "Weight" in the name. Open each and look for a "CarryWeight", "MaxCarryWeight", or similar column. Note the exact field name for the override task.

---

### T003-002-002 — Implement Carry Weight Override

**Type:** Task
**Parent:** S003-002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T003-002-001, T003-001-002
**Description:** Implement the carry weight limit override using a data table row override driven by the config multiplier value, applied at game load.
**Acceptance Criteria:**
- Carry weight limit is calculated as `vanilla_value * config.CarryWeightMultiplier`
- Override is applied on game start and on settings change
- Setting the multiplier to 1.0 produces exactly the vanilla carry weight value
- Override works on both new and existing saves
- No other player stats are affected by the override

**Agent notes:** If the data table approach allows runtime overrides, apply the multiplier via a Blueprint node that sets the row value at start-of-session. If not, a dynamic approach via character stat components may be needed — check what's accessible based on T001-002 findings.

---

### T004-001-001 — Create Base Widget Blueprint

**Type:** Task
**Parent:** S004-001
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S002-005, T001-002-004
**Description:** Create the `WBP_BellwrightUI_Base` Blueprint widget class with shared properties: background panel style, title bar, close button, drag-to-reposition functionality, and the theme data asset reference.
**Acceptance Criteria:**
- Base widget has a configurable title bar with text binding
- Close button dispatches a `OnCloseRequested` event that callers can bind
- Widget can be dragged to any screen position
- Theme data asset reference is exposed as a public variable
- Widget compiles and is renderable in the UMG preview

**Agent notes:** Use a `Canvas Panel` as the root. Add drag-and-drop via `OnMouseButtonDown` and `OnMouseMove` event overrides. The theme data asset should contain a `PrimaryColour`, `BackgroundColour`, `FontFamily`, and `BaseFontSize` — these are applied in the widget's `NativeConstruct`.

---

### T004-001-002 — Create UI Theme Data Asset

**Type:** Task
**Parent:** S004-001
**Status:** todo
**Priority:** medium
**Effort:** XS
**Prerequisites:** T004-001-001
**Description:** Create the `DA_UITheme` Data Asset with colour palette, font references, and spacing values that define the visual language for all UI mod panels.
**Acceptance Criteria:**
- Data Asset defines at least 5 named colours (primary, secondary, background, text, alert)
- Font references cover regular and bold weights
- Spacing values cover small/medium/large padding
- Default theme is legible against Bellwright's game environment
- Data Asset is committed to `Content/Mods/BellwrightUI/Theme/`

**Agent notes:** Base the colour palette on Bellwright's existing earthy/medieval aesthetic. Avoid pure white or neon colours. The font should match or complement the vanilla UI font — check what font assets are accessible in the ModKit content browser.

---

### T004-001-003 — Implement Panel Persistence Layer

**Type:** Task
**Parent:** S004-001
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** T004-001-002, T003-001-002
**Description:** Implement a persistence mechanism that saves each UI panel's position and visibility state to the save game object so panels reappear in the same position after a session restart.
**Acceptance Criteria:**
- Panel screen positions are saved per-panel to the UI save game slot
- Panel visibility (open/closed) is persisted
- Positions are loaded and applied before the panel is made visible on load
- Position is clamped to the current screen bounds (handles resolution changes)
- Persistence is tested across a session save/load cycle

**Agent notes:** Add a `FVector2D PanelPosition` and `bool bIsVisible` for each panel to the `SaveGame_BellwrightPlus` object (or a separate `SaveGame_BellwrightUI`). Apply position via `SetRenderTranslation` after `AddToViewport`.

---

### T005-001-001 — Select and Catalogue Textures for Upscaling

**Type:** Task
**Parent:** S005-001
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** S002-005
**Description:** Browse the ModKit content browser to identify and catalogue the 20+ highest-impact textures for upscaling — focus on environment surfaces visible from ground level (stone, wood, soil, foliage).
**Acceptance Criteria:**
- A list of at least 25 texture asset paths is compiled in `docs/mods/visuals/texture-upscale-list.md`
- Textures are prioritised by visual impact (frequently visible surfaces first)
- Each texture's current resolution is recorded
- Asset paths are confirmed accessible for export from the ModKit
- List is committed to repo

**Agent notes:** In the ModKit content browser, filter by asset type "Texture2D". Sort by most recently used or search for common material name prefixes ("T_Ground", "T_Rock", "T_Wood", "T_Wall"). Prioritise seamless tiling textures used on large surfaces.

---

### T005-001-002 — Set Up Real-ESRGAN Upscaling Pipeline

**Type:** Task
**Parent:** S005-001
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** T005-001-001
**Description:** Install Real-ESRGAN (or equivalent AI upscaler) and write a batch script that processes each texture in the catalogue list from its exported PNG to a 2x upscaled PNG.
**Acceptance Criteria:**
- Real-ESRGAN CLI is installed and invocable from a script
- Batch script processes a list of PNG files and outputs to an `upscaled/` directory
- Script handles errors (missing input file) without silently failing
- A test run on 3 textures completes successfully
- Script is committed to `tools/texture-upscale/upscale.sh` (or `.py`)

**Agent notes:** Real-ESRGAN CLI: `realesrgan-ncnn-vulkan -i input.png -o output.png -n realesrgan-x2plus`. Use `realesrgan-x2plus` model for photographs and `realesrgan-x4plus-anime` for stylised assets. Process textures at 2x unless vanilla is already 2K+ (cap output at 4K to avoid excessive pak sizes).

---

### T005-001-003 — Reimport Upscaled Textures into ModKit

**Type:** Task
**Parent:** S005-001
**Status:** todo
**Priority:** medium
**Effort:** M
**Prerequisites:** T005-001-002
**Description:** Reimport the batch-upscaled PNG files into the ModKit as texture overrides with correct compression settings and verify they load without errors.
**Acceptance Criteria:**
- All 20+ upscaled textures are reimported without errors
- Compression format is set to BC7 for diffuse (colour) textures
- Normal maps use BC5 compression
- No visible tiling seams or artefacts are introduced
- Reimported textures are visible in the ModKit material preview

**Agent notes:** Import via the ModKit content browser "Import" function. After import, open each Texture2D asset and set: Compression Settings = TC_BC7 (or TC_Normalmap for normal maps), sRGB = true for diffuse/albedo, Mip Gen Settings = FromTextureGroup. Verify in the editor viewport.

---

### T006-001-001 — Document Architecture Decision

**Type:** Task
**Parent:** S006-001
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T001-004-003
**Description:** Write the automation architecture decision record (ADR) based on the S001-004 findings, selecting the implementation approach for each sub-feature and documenting constraints.
**Acceptance Criteria:**
- ADR format is used (Context, Decision, Consequences)
- Implementation tier is specified for each sub-feature: routing (ModKit/RE-UE4SS/hybrid), task queues, visualiser
- Descoped features are listed with rationale
- ADR is committed to `docs/mods/automation/adr-001-architecture.md`
- ADR is reviewed and approved before any automation development begins

**Agent notes:** Use the standard ADR format. The "Consequences" section should explicitly state what becomes impossible or more difficult with the chosen approach. This document is the gate for all S006-002 through S006-004 work.

---

### T007-001-001 — Evaluate Combat Blueprint Accessibility

**Type:** Task
**Parent:** S007-001
**Status:** todo
**Priority:** critical
**Effort:** S
**Prerequisites:** T001-002-003
**Description:** Review the T001-002-003 findings and make an explicit go/no-go decision for the combat expansion mod. If partial access is available, define a reduced scope.
**Acceptance Criteria:**
- Go/no-go decision is written with rationale referencing T001-002-003 evidence
- If "go with reduced scope", the reduced scope is enumerated (which features are feasible)
- Decision is committed to `docs/mods/combat/adr-001-feasibility.md`
- Decision is communicated to all parties before combat mod development begins
- If "no-go", the Epic E007 is formally descoped in the WBS

**Agent notes:** The three key gates are: (1) can you subclass the weapon Blueprint? (2) can you apply a status effect via Blueprint? (3) can you modify enemy spawn data tables? If all three are "no", the mod is not viable via ModKit and would require RE-UE4SS.

---

### T008-001-001 — Extract Accessible Class List for Documentation

**Type:** Task
**Parent:** S008-001
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** T001-002-006
**Description:** Transform the raw ModKit API surface findings into a well-formatted modder reference table suitable for public documentation.
**Acceptance Criteria:**
- Table format: Class Name | Accessible | Overrideable Functions | Notes
- All confirmed-accessible classes are included
- Notes column includes brief usage guidance
- Document is written in Markdown
- Committed to `docs/modder-reference/api-surface.md`

**Agent notes:** Pull data from `docs/research/modkit-api-surface.md`. Format it for a non-expert audience — assume the reader knows Blueprint basics but has never looked at the Bellwright ModKit before.

---

### T009-001-001 — Build Compatibility Test Matrix

**Type:** Task
**Parent:** S009-001
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S003-009, S004-006, S005-004, S006-005, S007-006
**Description:** Design and execute the compatibility test matrix by loading each pairwise mod combination and running a standard test sequence (launch, load save, exercise mod features, save, quit).
**Acceptance Criteria:**
- All 10 pairwise combinations are tested
- Test sequence is standardised and documented
- Results are logged in a table: Mod A | Mod B | Result | Notes
- Any conflict's reproduction steps are recorded
- Matrix is committed to `docs/testing/compatibility-matrix.md`

**Agent notes:** The standard test sequence for each combination: (1) subscribe both mods, (2) launch game, (3) load a mid-game save, (4) exercise each mod's primary feature, (5) save and reload, (6) check for errors in game log. Log path: `%LOCALAPPDATA%/Bellwright/Saved/Logs/`.

---

### T009-002-001 — Recruit Beta Testers

**Type:** Task
**Parent:** S009-002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** S009-001
**Description:** Post recruitment messages in the Bellwright Steam forums and Discord server seeking beta testers for the mod suite, and collect contact information from respondents.
**Acceptance Criteria:**
- Recruitment post is live on at least 2 community channels
- Post describes the beta programme scope, time commitment, and feedback format
- At least 10 testers are recruited and confirmed
- Tester system specs are collected (GPU, RAM, game version)
- Tester contact list is maintained in a private document

**Agent notes:** Specify in the recruitment post that testers must have at least 10 hours of Bellwright playtime so they can meaningfully evaluate QoL and automation changes. Provide a simple Google Form or GitHub Discussion thread for initial sign-up.

---

### T009-002-002 — Distribute Beta Builds and Collect Feedback

**Type:** Task
**Parent:** S009-002
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** T009-002-001
**Description:** Share private Workshop links with beta testers, run the beta for 7+ days, and collect structured feedback using the standardised form.
**Acceptance Criteria:**
- All beta testers receive Workshop links and installation instructions
- Structured feedback form covers: bug severity (1-4), reproduction steps, system specs, free-text comments
- At least 80% of recruited testers submit feedback
- All bugs are triaged into the issue tracker within 24 hours of receipt
- Beta findings summary is committed to `docs/testing/beta-feedback.md`

**Agent notes:** Use a Google Form with required fields for: mod(s) affected, bug severity (Critical/High/Medium/Low), steps to reproduce, actual behaviour, expected behaviour, system specs. Share the form link in the beta tester channel.

---

### T010-001-001 — Final Shipping Cook for All Mods

**Type:** Task
**Parent:** S010-001
**Status:** todo
**Priority:** high
**Effort:** M
**Prerequisites:** S009-002
**Description:** Cook all five mods in Shipping configuration, record pak file checksums, and verify file sizes are within Workshop limits.
**Acceptance Criteria:**
- All five mods cook without errors in Shipping configuration
- Cook log files show zero errors and acceptable warning counts
- Pak file SHA256 checksums are recorded in `docs/releases/v1.0.0/manifest.json`
- All pak files are under the Steam Workshop item size limit (currently 100MB per item)
- Cook output files are archived in `docs/releases/v1.0.0/`

**Agent notes:** Cook each mod separately (do not merge paks). Use `File > Package Project > Windows (64-bit)` or the ModKit's dedicated cook command. Verify pak integrity with the Unreal `UnrealPak` tool: `UnrealPak.exe <file.pak> -List`.

---

### T010-001-002 — Apply Git Release Tags

**Type:** Task
**Parent:** S010-001
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T010-001-001
**Description:** Tag the Git repository at the release commit with `v1.0.0` and push the tag. Create a GitHub release with the release notes and pak file checksums attached.
**Acceptance Criteria:**
- `git tag v1.0.0` is applied at the final release commit
- Tag is pushed to the remote repository
- GitHub release is created with a written changelog
- Pak file checksums from the manifest are included in the release notes
- Release is marked as "latest" on GitHub

**Agent notes:** Use annotated tags: `git tag -a v1.0.0 -m "Bellwright Mod Suite v1.0.0 — initial public release"`. Push with `git push origin v1.0.0`. The GitHub release can be created via the web UI or `gh release create v1.0.0`.

---

### T010-002-001 — Set All Workshop Items to Public

**Type:** Task
**Parent:** S010-002
**Status:** todo
**Priority:** high
**Effort:** XS
**Prerequisites:** T010-001-001, S008-003
**Description:** Change all five Workshop items from private to public visibility simultaneously to co-ordinate the release.
**Acceptance Criteria:**
- All five Workshop items are set to public visibility
- Visibility change is confirmed in the Workshop submissions dashboard
- Items are discoverable via Workshop search
- All items show correct titles, descriptions, and screenshots
- Release timestamp is recorded in `docs/releases/v1.0.0/release-log.md`

**Agent notes:** Do this in a single session to minimise the window between first and last mod going public. If the ModKit uploader supports batch visibility changes, use that. Otherwise, change items via the Steam Workshop web interface in rapid succession.

---

### T010-002-002 — Post Release Announcements

**Type:** Task
**Parent:** S010-002
**Status:** todo
**Priority:** medium
**Effort:** S
**Prerequisites:** T010-002-001
**Description:** Post release announcements to the Bellwright Steam forum, Donkey Crew Discord, and any other community channels, linking all five Workshop mods and the GitHub repository.
**Acceptance Criteria:**
- Announcement is posted to at least 2 community channels within 1 hour of Workshop publication
- Announcement includes links to all five Workshop items and the mod collection
- Announcement includes a brief feature summary for each mod
- GitHub repository link is included
- Announcement is pinned or highlighted where possible

**Agent notes:** Prepare the announcement text in advance so it can be posted immediately after Workshop visibility is changed. Include key features, compatibility notes, and a link to the community hub for bug reports. Do not paste raw Workshop item IDs — use named hyperlinks.

---

### T010-002-003 — Document Rollback Procedure

**Type:** Task
**Parent:** S010-002
**Status:** todo
**Priority:** high
**Effort:** S
**Prerequisites:** T010-001-002
**Description:** Write and test the procedure for reverting a Workshop item to a previous build if a post-release patch introduces a breaking bug.
**Acceptance Criteria:**
- Rollback procedure is documented step by step in `docs/workshop-publishing.md`
- Procedure covers: identify broken version, locate previous pak file, re-upload previous pak, update change notes
- Procedure is tested by uploading a v1.0.0-test build and then reverting to a prior build
- Maximum rollback time is estimated and documented
- Change note template for rollback announcements is included

**Agent notes:** Steam Workshop does not natively support version rollback via the web UI — you must re-upload the previous pak file as a new version. Keep all versioned pak files archived locally. The rollback note should clearly state which version users should expect after the rollback.

---

*End of Work Breakdown Structure — 10 Epics, 39 Stories, 57 Tasks*

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

## Dependency Graph (Critical Path)

```
E001 (Research) → E002 (Environment) → E003/E004/E005/E006/E007 (Mod Dev) → E009 (Testing) → E010 (Deploy)
                                                                              ↑
                                                                         E008 (Docs) feeds E010
```

**Longest critical path:** T001-001-001 → T001-002-001 → T001-004-001 → S006-001 → S006-002 → S006-003 → S006-004 → S006-005 → S009-001 → S009-002 → T010-001-001 → T010-002-001

**Key gates (blocking multiple epics):**
- S001-001 (engine version) gates S002-001 and S001-003
- S002-005 (smoke test) gates all mod development epics
- S001-002 (API surface) gates S007-001 and informs S004-001, S006-001
- S001-003 (RE-UE4SS compat) gates S002-003 and S001-004
- S001-004 (automation API) gates S006-001 which gates all of E006
