# Settlement & Automation API Research — Bellwright

*Researched: 2026-06-05*
*Task: S001-004*
*Status: partially-blocked*

---

## Summary

No automation-specific mods exist in the Bellwright Workshop or on Nexus Mods as of June 2026. The modding community has focused almost entirely on **numeric parameter changes** (skill caps, production speed multipliers, inventory sizes, movement speed) and **content additions** (new items, buildings, quests). No mod attempts to change villager task assignment logic, resource routing decisions, or production queue behaviour.

There is, however, strong player demand for exactly these features across multiple Steam discussions, confirming market need. The ModKit description explicitly states modders can modify "anything short of C++ code," but qualifies that with "the only limitation in terms of blueprint logic is what's already exposed from the game's code." This means villager AI/task systems are likely locked in compiled C++ unless the devs explicitly expose them — which they have not yet done for task assignment or routing logic.

The most technically significant finding is that **UE4SS Lua mods successfully reach villager character objects** and modify movement speed properties, confirming that the `VillagerCharacter` class (or equivalent) is accessible at runtime via RE-UE4SS. Whether task-assignment properties (`JobPriority`, `CurrentTask`, routing state) are exposed on those objects is unknown without a full UObject dump.

---

## Existing Automation-Adjacent Mods

### Mods That Touch Villager Behaviour (Confirmed)

| Mod | Platform | What It Does | System Modified | Modding Tier |
|---|---|---|---|---|
| **Villager Skill Overhaul** | Steam Workshop | Raises skill potential caps; allows villagers to reach level 10 in eligible skills | `NPCskillstemplate` data table (villager skill range rows) | Tier 1 — data table |
| **Better Villagers – Optimized Workflows** *(deleted)* | Nexus Mods | Reportedly increased task speed/gains across Cooking, Crafting, Farming, Harvesting, Hunting, Laboring, Researching uniformly | Likely Tier 1 data table; deleted June 2024 | Tier 1 — data table |
| **Better Villagers – Buffs and Debuffs** | Nexus Mods (Anniversary Update) | Modifies villager NPC stats/buffs | Tier 1 — data table | Tier 1 |
| **Villager Speed Enhancer** | Nexus Mods | Doubles walk speed (default 2×) and run speed (default 2.5×) via configurable Lua; works on existing and new villagers | RE-UE4SS Lua — reaches `VillagerCharacter` UObject, modifies `walkSpeedMultiplier` / `runSpeedMultiplier` properties | **Tier 3 — RE-UE4SS** |
| **K's Villagers Move Faster** | Nexus Mods | Changes `MaxWalkSpeed` and `SprintSpeed` for villagers; road-speed boost at higher agility | RE-UE4SS Lua — same approach | **Tier 3 — RE-UE4SS** |
| **Haul(Ass)** | Nexus Mods | Faster villager walking (Sprint/Fast Walk versions; uses Joew's Mod Unlocker instead of UE4SS) | Possibly Blueprint or asset patch | Tier 2–3 |
| **Recruitment Overhaul (Stages 1–5)** | Steam Workshop | Relaxes renown cost multipliers; removes liberation pre-requisite for recruitment | Tier 1 — data table (recruitment cost rows) | Tier 1 |
| **Higher Potential** *(moved to Workshop)* | Steam Workshop | Raises villager skill potential ceilings | Tier 1 — data table | Tier 1 |

### Mods That Touch Resource/Production Systems

| Mod | Platform | What It Does | Tier |
|---|---|---|---|
| **Faster Tasks – [Material] (×2 / ×5 / ×10)** | Nexus Mods + Steam Workshop | Reduces processing time per task type (crude fur, rawhide, leather, flour, honey, fertilizer, etc.); packaged as one-folder-per-material, modular | Tier 1 — data table (task duration rows) |
| **Old Outpost Delivery System** | Steam Workshop | Restores pre-Maiden-Voyage inter-outpost delivery system alongside current caravans | Tier 1–2 — replaces/restores game logic asset |
| **Carpentry++ / Smelting++ / Cooking++** | Steam Workshop | Boosts production output quantities | Tier 1 — data table |
| **Super Fast Crop Growth** | Steam Workshop | Reduces farm growth time by 75% | Tier 1 — data table |
| **Storage [X] mods** | Steam Workshop | Increase stockpile/warehouse/barn capacity | Tier 1 — data table |

### Notable Absences

- **No mod attempts direct villager task assignment** (e.g., assigning a specific villager to a specific building slot).
- **No mod implements a task queue or work order system.**
- **No mod adds a production chain visualiser or UI overlay for settlement logistics.**
- **No mod modifies resource routing logic** (how villagers decide where to carry resources).
- The "Better Villagers – Optimized Workflows" mod was the closest attempt and was deleted. Its mechanism was almost certainly a data table edit (task completion speed scalars), not AI logic.

---

## Player Demand Signals

| Request Type | Evidence | Source |
|---|---|---|
| Auto resource routing | Players describe villagers carrying 1 log at a time across the entire village; request "predefined routes and priorities" and stockpile transfer automation; "stockpile transfer" is a known vanilla-ish feature but inadequate for complex chains | Steam discussions: "Villager production chains needs to be streamlined," "Work orders," "Help needed with resource management" |
| Better villager assignment | Recurring request to assign a specific named villager to a specific building ("assign Klara to mining hut"); current priority system described as unreliable at scale (90 villagers, 250 buildings = broken) | Steam discussions: "Job assignment," "Assigning Villagers," "assignment villager," "The villager work algorithms requires serious improvements" |
| Task queues/scheduling | Players explicitly request "Dwarf Fortress-style work orders" — batch thresholds that trigger a work order for N items when stock drops below X; dislike of one-item-per-trip waste | Steam discussions: "Work orders," "Priorities"; described as the most commonly repeated QoL request |
| Production chain visibility | No direct mod or thread on this specifically; implied by widespread confusion about why production chains stall (inputs, fuel, storage mismatches); devs and guides describe "automation feels broken = priorities + logistics" | Steam guide: "Outposts and Automation"; QoL wishlist thread |
| Idle villager auto-assign | Request for villagers to automatically pick up the highest-priority available task when idle rather than "wandering" | "The villager work algorithms requires serious improvements"; "Further problems with villager AI" |
| Automated trade / market stall | Request to automate trade with towns via market stall improvements staffed by villagers | QoL wishlist thread ("automate trade with towns somehow") |
| Round-robin farming | Request to prevent farmers planting entire fields of one crop simultaneously; implement cyclic planting | QoL wishlist thread |
| Research queuing | Request for ability to queue research tasks | QoL wishlist thread |

---

## Technical System Analysis

### Villager Task Assignment Architecture (Inferred)

Bellwright uses UE5 (version 5.5.4 per ModKit docs). Standard UE5 NPC task patterns are:

1. **AIController** — controls pawn; runs behaviour tree; receives perception input.
2. **BehaviorTree + Blackboard** — drives task selection; job priorities likely feed into blackboard keys.
3. **TaskComponent (custom)** — Bellwright almost certainly has a custom C++ component attached to villager characters that manages which jobs they are eligible for, their current priority values (1–9 scale), and the work state machine (idle → travel → work → return).
4. **Job/Building Registry** — a system that maintains which buildings need workers and advertises available tasks; villagers poll this or receive notifications.
5. **Resource routing** — likely implemented as "haul task" entries in the job system: when a stockpile or building needs an item, a haul task is created; available workers compete for it based on priority.

### What Can Be Modded (Confirmed from Evidence)

| System | Access Tier | Evidence |
|---|---|---|
| Villager skill caps/potential ranges | **Tier 1** (data table) | `NPCskillstemplate` rows modified by multiple mods (Villager Skill Overhaul, Higher Potential) |
| Task processing/crafting durations | **Tier 1** (data table) | Faster Tasks mod modifies task duration values per-material |
| Villager movement speed properties | **Tier 3** (RE-UE4SS Lua) | Villager Speed Enhancer reads/writes `walkSpeedMultiplier`, `runSpeedMultiplier` on `VillagerCharacter` UObject |
| Villager recruitment costs/conditions | **Tier 1** (data table) | Recruitment Overhaul mods modify cost rows |
| New buildings, items, quests | **Tier 1–2** (ModKit Blueprint + data tables) | Modding wiki; pre-built castle mod; new potion mods |
| UI (new screens/overlays) | **Tier 2** (ModKit Blueprint) | Modding wiki has a User Interface section; ModKit uses same UE5 editor |

### What Is Probably NOT Accessible (Without RE-UE4SS Deeper Hooks)

- **Job priority logic** — the decision tree for which job a villager picks next is compiled C++ (BehaviorTree tasks), not exposed Blueprint.
- **Task queue / work order creation** — creating new task entries or work orders programmatically requires hooking into the job registry, which is C++ level.
- **Resource routing decisions** — which stockpile/building gets hauled to is determined at runtime by C++ task selection, not data tables.
- **Villager-to-building binding** — dedicated assignment of a named villager to a specific building slot is a game feature request, not currently implemented; no data table row exists to patch.

The ModKit documentation explicitly states: "the only limitation in terms of blueprint logic is what's already exposed from the game's code, but the developers are committed to continuously expose more functionality over time."

---

## Automation Feature Feasibility

| Feature | Likely Tier | Confidence | Evidence |
|---|---|---|---|
| Resource auto-routing (modify existing haul logic) | Tier 3 (RE-UE4SS) or **Not accessible** | Low–Medium | No existing mod approaches it; would require finding haul task C++ class via UObject dump |
| Resource delivery config (change delivery schedule/quantity) | Tier 1–2 | Medium | "Old Outpost Delivery System" mod demonstrates delivery logic is modifiable; delivery is asset-level, not pure C++ |
| Villager task queues (new work order system) | Tier 3 or **Not accessible** | Low | Would require injecting new task types into job registry; no mod has attempted this; C++ barrier likely |
| Task processing speed (existing tasks faster/slower) | **Tier 1** | High | Faster Tasks mod family confirms data table rows for task duration exist and are patchable |
| Villager job priority defaults (set default priority for all new villagers) | Tier 1 | Medium | Skill potential mods prove NPC template data tables are accessible; priority defaults are likely adjacent rows |
| Production chain visualiser (UI overlay) | **Tier 2** | Medium-High | ModKit exposes full UE5 UMG (UI Markup & Graphics); creating a new Blueprint UI widget is standard ModKit usage; *reading* production state data is the uncertain part |
| Idle villager auto-assign (override AI to fill idle villagers) | Tier 3 or **Not accessible** | Low | Requires overriding BehaviorTree idle state — compiled C++ |
| Villager movement speed (existing mods) | **Tier 3 (confirmed)** | High | Villager Speed Enhancer and K's Villagers Move Faster are proven, working mods |
| Skill progression rate (XP gain scalars) | **Tier 1** | High | Better Villagers – Buffs and Debuffs and Skill Overhaul confirm skill system is data-driven |

---

## Go/No-Go Assessment (Web Research Basis)

- **Settlement automation (any tier): AMBER** — Some peripheral automation is provably moddable (task speed, delivery config), but the core features (task queues, routing logic, idle-villager assignment) are behind the C++ wall. Partial wins (speed, scheduling parameters) are achievable at Tier 1–2. Full automation logic requires RE-UE4SS with a deep UObject dump.

- **Blueprint-level access: AMBER** — The ModKit exposes Blueprint for new content (buildings, items, quests, UI). Whether settlement/villager *management logic* is surfaced as callable Blueprint functions is unconfirmed. The modding wiki's User Interface section suggests new UI widgets are possible; wiring them to live settlement data is the unknown.

- **Requires RE-UE4SS: Likely** for any feature that reads or modifies runtime villager state (task, routing, assignment). Data-only features (speed, duration, skill caps) are Tier 1 without UE4SS.

---

## Scope Recommendation

Given web-research findings, the safest first targets are:

1. **Task processing speed UI** — Use Tier 1 data table knowledge to expose task duration parameters via a clean mod; validates the data table pipeline and delivers immediate player value (Faster Tasks family proves this works).

2. **Production chain visualiser (read-only UI)** — A Blueprint UMG overlay showing what each building is producing and what it's waiting for. If production state is accessible from Blueprint, this is Tier 2. This is the highest-value automation sub-feature with the highest chance of being achievable via ModKit alone. **Recommend starting here after physical testing confirms Blueprint can read building production state.**

3. **Delivery schedule manager** — A UI wrapper over the existing caravan/delivery system that makes configuring automated resource routes less painful. The delivery system is already moddable (Old Outpost Delivery System mod). A UI improvement is Tier 2 and does not require touching AI code.

4. **Defer task queues and auto-routing** until physical testing determines whether the job registry or BehaviorTree blackboard is exposed to Blueprint. These are likely Tier 3 or blocked.

**Do not invest in villager-to-building direct assignment** as a first mod — it is a game design feature not an exposed API, and no modder has been able to implement it despite strong community demand.

---

## Pending: Requires Physical Testing

| Test | Tool Needed | What to Search | Why It Matters |
|---|---|---|---|
| ModKit Blueprint search for villager systems | ModKit editor (Windows) | Keywords: "villager", "task", "route", "queue", "assign", "job", "priority", "haul" in Blueprint asset browser | Determine whether task-assignment or routing logic has any Blueprint-callable nodes exposed by devs |
| ModKit data table inspection for job/task rows | ModKit editor (Windows) | Tables named with: "Villager", "Job", "Role", "Task", "Priority", "NPC", "Worker" | Find if job priority defaults or task configs are data-driven and patchable at Tier 1 |
| UObject class dump — villager character | RE-UE4SS (Windows), CTRL+J dump | Search UE4SS_ObjectDump.txt for: `VillagerCharacter`, `TaskComponent`, `JobPriority`, `ResourceRoute`, `HaulTask`, `BlackboardComponent` | Identify accessible runtime properties on villager objects for Tier 3 Lua mods |
| UObject class dump — production/building | RE-UE4SS (Windows) | Search dump for: `ProductionBuilding`, `CraftingStation`, `StockpileComponent`, `DeliveryTask`, `WorkOrder` | Determine if production queue state is accessible at runtime |
| Blueprint node search for UI / settlement state | ModKit editor (Windows) | Look for Blueprint function libraries exposing settlement stats, building state, villager state as readable values | Determine if a production chain visualiser is achievable at Tier 2 |
| Villager Speed Enhancer source code review | GitHub / NexusMods download | Read the Lua source to extract exact class names and property names used to reach villager objects | Provides confirmed class/property names to bootstrap the UObject dump search |

---

## Sources

| URL | Type | Notes |
|---|---|---|
| https://steamcommunity.com/app/1812450/workshop/ | primary | Bellwright Steam Workshop main page |
| https://steamcommunity.com/sharedfiles/filedetails/?id=3509556201 | primary | Villager Skill Overhaul mod page |
| https://steamcommunity.com/sharedfiles/filedetails/?id=3633050300 | primary | Bellwright Mods collection (54 mods) |
| https://steamcommunity.com/sharedfiles/filedetails/?id=3622120021 | primary | BellWright ModList 2026 (18 mods) |
| https://steamcommunity.com/sharedfiles/filedetails/?id=3624256831 | primary | Old Outpost Delivery System mod |
| https://steamcommunity.com/sharedfiles/filedetails/?id=3268721127 | community | Outposts and Automation guide |
| https://steamcommunity.com/app/1812450/discussions/0/3803901365999058260/ | community | "Villager production chains needs to be streamlined" discussion |
| https://steamcommunity.com/app/1812450/discussions/0/4634862385195128226/ | community | "Work orders" discussion |
| https://steamcommunity.com/app/1812450/discussions/0/724651541045184104/ | community | "The villager work algorithms requires serious improvements" |
| https://steamcommunity.com/app/1812450/discussions/0/604161881226153366/ | community | "Wishlist of QOL improvements" |
| https://steamcommunity.com/app/1812450/discussions/0/684115079179925751/ | community | "Job assignment" discussion |
| https://steamcommunity.com/app/1812450/discussions/1/604159978054457288/ | community | Modkit Discussions thread |
| https://modding.playbellwright.com/ | official | Bellwright Modding Wiki (SSL expired at time of research) |
| https://modding.playbellwright.com/modding_basics/basic_modkit_usage | official | Basic ModKit Usage page |
| https://www.nexusmods.com/bellwright/mods/113 | primary | Villager Speed Enhancer mod |
| https://www.nexusmods.com/bellwright/articles/193 | primary | Villager Speed Enhancer install guide (403 at time of research) |
| https://www.nexusmods.com/bellwright/mods/95 | primary | K's Villagers Move Faster mod |
| https://www.nexusmods.com/bellwright/mods/25 | primary | Haul(Ass) mod |
| https://www.nexusmods.com/bellwright/mods/104 | primary | Faster Tasks Processing Speed Overhaul |
| https://www.nexusmods.com/bellwright/mods/54 | primary | Better Villagers – Optimized Workflows (deleted) |
| https://www.nexusmods.com/bellwright/mods/69 | primary | Bellwright Modifier (UE4SS-based) |
| https://www.nexusmods.com/games/bellwright/mods | primary | Nexus Mods Bellwright listing (~84 mods) |
| https://gamerant.com/bellwright-best-mods/ | community | "Best Bellwright Mods You Should Try" article |
| https://massivelyop.com/2025/08/26/bellwright-highlights-junes-modkit-features-and-player-made-mods-teases-its-next-content-update/ | community | Massively Overpowered: ModKit June 2025 highlights (403 at time of research) |
| https://steamdb.info/patchnotes/18980444/ | official | Bellwright modding support patch notes June 2025 (403 at time of research) |
| https://theguidehall.com/whats-new-in-the-bellright-2-0-update/ | community | Bellwright 2.0 update features |
| https://sihmar.com/bellwright-update-patch-notes-may-8-2025/ | community | May 2025 patch notes |
| https://bellwright.fandom.com/wiki/Settlement | official | Settlement wiki page |
| https://bellwright.fandom.com/wiki/Job_Priorities | official | Job Priorities wiki page |
| https://bellwright.fandom.com/wiki/Population | official | Population management wiki page |
| https://github.com/UE4SS-RE/RE-UE4SS | official | RE-UE4SS GitHub repository |
| https://docs.ue4ss.com/ | official | UE4SS Documentation |
| https://www.moddb.com/games/bellwright | community | Bellwright on ModDB |
