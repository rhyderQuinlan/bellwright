# ModKit API Surface Research — Bellwright

*Researched: 2026-06-05*
*Task: S001-002*
*Status: partially-blocked (official wiki TLS expired; editor access pending)*

---

## Summary

The Bellwright ModKit (released June 25, 2025, UE5.5.4) exposes a substantial modding surface for **Tier 1 data-driven content** (items, buildings, recipes, technology, production timings, storage, villager stats) and a meaningful but **partially documented** surface for **Tier 2 Blueprint scripting** (weapons, NPCs, quests, UI, placeables). The hard ceiling is C++ code — modders cannot modify game systems that are not reflected/exposed in the Blueprint layer.

**Definitively accessible:** Item templates, weapon templates, building/structure templates, deployable items, spline walls, production data tables, crafting recipes, tech tree entries, NPC templates (for use in quests and shops), basic quest structures, villager buff/debuff data, UI widget creation for new screens.

**Probably accessible but underdocumented:** Full quest dialogue trees, combat status effects, map-level changes, new villager role definitions, custom gameplay Blueprint logic.

**Likely blocked or restricted:** C++ gameplay systems not yet reflected by Donkey Crew, deep NPC AI behavior trees, modifying the base Karvenia map alongside any other map mod (one-map-at-a-time limit), audio codec restrictions.

**Unknown (requires editor):** The full enumerated set of exposed Blueprint classes, which data tables have overrideable rows vs. locked rows, whether Widget Blueprints can be extended (subclassed) or must be replaced wholesale, whether combat damage type enums are accessible, whether quest dialogue node types are fully exposed.

---

## Official Documentation Findings

The official modding wiki is at **https://modding.playbellwright.com/** and is structured around these confirmed sections (retrieved via search index — direct fetch blocked by expired TLS certificate as of June 2026):

### Wiki Structure — Confirmed Pages

| URL path | Section title | Description (from search metadata) |
|---|---|---|
| `/` | Home | Landing page, links to all sections |
| `/en/modding_basics` | Modding Basics | Getting started with ModKit |
| `/modding_basics/basic_modkit_usage` | Basic Modkit Usage | Core workflow guide |
| `/modding_basics/Debugging_and_Tools` | Debugging & Tools | Cheats, entity debugger, dev tools |
| `/modding_basics/testing_mods` | Testing Mods | How to test in-editor and in-game |
| `/bellwright_modding` | Bellwright Modding | Top-level content modding index |
| `/en/bellwright_modding/item_equipment` | Items & Equipment | Adding/modifying items |
| `/bellwright_modding/item_equipment/adding_a_new_weapon` | Adding a new weapon | Weapon template guide (`MistWeaponItemTemplate`) |
| `/en/bellwright_modding/placeables` | Placeables | Buildings and structures |
| `/bellwright_modding/placeables/adding-a-deployable-item` | Adding a deployable item | Traps/decorations workflow |
| `/bellwright_modding/placeables/adding_a_spline_wall` | Adding a spline wall | Spline wall tutorial |
| `/en/bellwright_modding/Quests` | Quests & NPCs | Quest implementation, NPC modification |
| `/bellwright_modding/quests_npcs/adding_a_new_npc` | Adding a new NPC | NPC creation for quests, shops, activities |
| `/en/bellwright_modding/gameplay` | Gameplay | General gameplay Blueprint implementations |
| `/en/bellwright_modding/user-interface` | User Interface | New screens, UI for new mechanics |
| `/en/bellwright_modding/miscellaneous` | Miscellaneous | Cross-category guides |
| `/en/third_party_modding` | Third-Party Modding | UE4SS, Blender, Photoshop guides |

**Note:** The official wiki TLS certificate was expired at time of research. Page content was extracted indirectly via Google search metadata and cached snippet results. The structure above is confirmed but individual page bodies could not be fully read.

### Official Developer Statements (from ModDB/Steam announcements, sourced via search)

Donkey Crew's key claims about the ModKit:

1. **Engine version:** UE5.5.4, the same modified editor the developers use internally.
2. **Scope claim:** "You can modify virtually anything in the game short of C++ code."
3. **Tier 1 statement:** "Simple changes like modifying or adding new items, structures and technologies are very simple and trivial, and don't require any prior knowledge or experience."
4. **Tier 2 statement:** "Adding new features via visual scripting and other Unreal tools is a little more tricky, and may require some tinkering."
5. **Blueprint ceiling:** "The only limitation in terms of blueprint logic is what's already exposed from the game's code, but the developers are committed to continuously expose more functionality over time, focusing on mod authors' feedback and requests."
6. **Known map limitation:** "Only a single mod modifying the Karvenia map will be loaded on the player's side, since any map modification requires cooking and packaging Karvenia_08."
7. **Audio limitation:** "Sounds imported via modkit don't support all codecs. Please use Bink with inline loading, PCM or ADPCM."
8. **Distribution:** Mods are .pak + .sig + .json files uploaded to Steam Workshop; requires owning Bellwright on Steam.
9. **Third-party:** UE4SS is separately documented as a supported third-party approach (Lua scripting, no Blueprint).

### Community Update 6 — Developer-Highlighted Mod Examples (August 2025)

From the Bellwright Community Update 6, the developers highlighted mods created within ~2 months of ModKit release:
- New potions (item template Tier 1)
- New quests (confirms quest Blueprint access is real)
- Pre-built castle with full functionality (confirms complex building/placeable Blueprint scripting)
- New building pieces (confirms asset addition)

---

## Confirmed Accessible Systems

### Tier 1 — Data-Driven (No Code Required)

All of the following are confirmed accessible via data table overrides, evidenced by existing workshop mods that published specific numerical changes:

- **Item definitions** — item stats, stack sizes, weights, recipes
- **Weapon templates** — damage values, durability, weapon class (`MistWeaponItemTemplate`)
- **Consumable templates** — potion/food effects, nutrition values
- **Building/structure definitions** — housing capacity (e.g. Big House: 7→12, House: 4→9), storage capacity
- **Production recipes** — crafting time values (e.g. Crude Fur: 600s→120s, Leather: 720s→144s, Flour: 150s→30s)
- **Resource regeneration timings** — tree respawn at 50% vanilla, foliage yield multipliers
- **Fuel burn durations** — bakeries, bloomeries, cauldrons, smelters
- **Food spoilage timings** — dried food, smoked food preservation durations
- **Storage capacity values** — wearable items (quivers, bags, backpacks), workshop storage
- **Villager buff/debuff values** — productivity debuffs, injury effects, seasonal effects
- **Villager movement speed parameters** — walkSpeedMultiplier, runSpeedMultiplier exposed via UE4SS and likely also data tables
- **Enemy loot tables** — what enemies drop
- **Villager recruitment cost multipliers** — renown-based cost values
- **Technology tree entries** — adding/modifying research nodes (confirmed by developer Tier 1 statement)

### Tier 2 — Blueprint Scripting (Visual Scripting Required)

Confirmed accessible with some depth:

- **Weapon Blueprints** — `MistWeaponItemTemplate` class confirmed; create new weapon types with custom stats
- **NPC templates** — create new NPCs for use in quests, shops, and other activities (confirmed guide exists)
- **Quest Blueprints** — new quest creation confirmed working (community mods shipped quests; dedicated wiki section exists)
- **Deployable items** — traps and decorations via placeable Blueprint (dedicated guide)
- **Spline walls** — custom wall/fence structures via spline Blueprint (dedicated guide)
- **User Interface — new screens** — creating new UI screens and implementing UI support for new mechanics (confirmed wiki section)
- **Gameplay Blueprint logic** — general gameplay implementations (wiki section confirmed, detail unknown without editor access)
- **Map/level modifications** — possible but restricted to one map mod at a time (Karvenia_08 cook limitation)

---

## System Accessibility Assessment

| System | Accessibility | Evidence | Notes |
|---|---|---|---|
| Quest creation | Partial | Official wiki "Quests & NPCs" section; 2 Quest mods on Workshop; Community Update 6 confirmed new quests shipped | NPC creation guide confirmed; full dialogue tree depth unknown |
| NPC creation & shops | Confirmed | "Adding a new NPC" guide on wiki; YouTube tutorial; NPC template Blueprint exposed | For use in quests, shops, activities |
| NPC AI behavior | Unknown | No evidence of AI behavior tree access; villager speed modded via UE4SS not official modkit | Deep AI graph likely in C++ |
| Dialogue trees | Unknown | Wiki has quest section but dialogue tree node types not confirmed in search results | Needs editor Class Viewer check |
| Combat — weapon templates | Confirmed | `MistWeaponItemTemplate` documented on wiki; weapon creation guide exists | Data table values for damage confirmed accessible |
| Combat — damage types | Partial | Game has slashing/piercing/blunt; "Higher Player Damage" mod exists; damage value data tables accessible | Whether damage type enums are Blueprint-scriptable unknown |
| Combat — status effects | Unknown | No confirmed modder work on new status effect Blueprint nodes | Only 3 Combat mods total on Workshop |
| UI Widgets — new screens | Confirmed | Official wiki UI section: "creating new screens, implementing UI support for new mechanics" | 9 UI mods exist on Workshop |
| UI Widgets — extend existing | Unknown | Wiki mentions creation not explicitly extension; extend-vs-replace unknown | Needs editor check of existing Widget BPs |
| HUD modification | Unknown | No specific HUD Blueprint mod documented in searches | Likely requires full Widget replacement |
| Inventory UI | Partial | Inventory capacity mods exist (Tier 1 data); satchel/backpack mods confirmed; UI layer itself unconfirmed | Satchelkeep mod changed capacities, not UI |
| Map UI | Unknown | No evidence of map Widget modding | Unknown |
| Settlement data tables | Confirmed | Multiple mods publish exact second/capacity values changed; developer Tier 1 statement explicit | Production times, capacities, costs all accessible |
| Building definitions | Confirmed | Community mods add new building pieces, pre-built castle with full functionality | Placeable Blueprint + data confirmed |
| Spline structures (walls) | Confirmed | Dedicated wiki guide for adding spline walls | |
| Technology tree | Confirmed | Developer explicitly stated tech tree modifications are "simple and trivial" (Tier 1) | |
| Item definitions | Confirmed | Multiple mods; developer Tier 1 statement; MistWeaponItemTemplate named in docs | |
| Villager roles/jobs | Partial | Buff/debuff data tables accessible; "Better Villagers — Optimized Workflows" mod exists | Whether new role *types* can be defined unclear |
| Villager recruitment | Confirmed | Villager recruitment cost multipliers modded (renown cost removal mod) | |
| Karvenia world map | Partial | Map modification possible but **only one map mod loads at a time** (Karvenia_08 cook limit) | Documented restriction |
| Audio | Partial | Audio importable but codec-restricted (Bink inline, PCM, ADPCM only) | Documented restriction |

---

## Go/No-Go Flags (Web Research Basis)

- **Quest modding:** GREEN — Official wiki section, YouTube tutorial, confirmed shipped mods, NPC creation guide. Dialogue depth needs editor verification but quest creation is clearly supported.

- **Combat modding:** AMBER — Weapon templates confirmed accessible (MistWeaponItemTemplate), damage value data tables overrideable. New status effect types and full combat Blueprint graph access unconfirmed. Very few (3) combat mods exist on Workshop, suggesting this area is less developed/explored. Full combat AI scripting likely blocked by C++ ceiling.

- **UI modding:** AMBER — New UI screen creation confirmed by official wiki. 9 UI mods exist on Workshop. However, whether existing game UI (HUD, inventory panel, map) can be subclassed/extended vs. must be fully replaced is unknown. Full replacement carries high maintenance burden (breaks on game updates).

- **Settlement automation / data-driven modding:** GREEN — Extremely well supported. Multiple mods publish exact numerical overrides for production timings, storage, building capacities, villager stats. Developer explicitly called this "simple and trivial." The Workshop has 372 Gameplay + 121 Building + 49 Overhaul mods, the majority of which operate at this tier.

---

## What Existing Mods Reveal About API Access

The Workshop breakdown (372 Gameplay, 121 Buildings, 49 Overhauls, 9 UI, 9 Visuals, 3 Combat, 2 Quests) is itself strong evidence of the modding tier distribution:

**High-volume tiers (data table / asset addition):**
- 372 Gameplay mods and 121 Building mods indicates a well-functioning Tier 1 pipeline. The sheer volume suggests mods are easy to create, which matches the developer's "simple and trivial" claim.
- 49 Overhaul mods shows modders can combine multiple data table changes into comprehensive balance mods.

**Evidence from specific overhaul mods:**
- *Faster Tasks Processing Speed Overhaul* — publishes exact override values (Crude Fur 600.0s→120.0s) — **confirms data table rows are directly overridable with specific float precision**
- *Big House capacity* (7→12) and *House capacity* (4→9) — **confirms building property data tables are accessible**
- *Fuel burn duration doubled* across bakeries, bloomeries, cauldrons — **confirms production building parameters are accessible**
- *Tree respawn at 50% / foliage yield x10* — **confirms world resource data tables accessible**
- *Villager recruitment renown cost removal* — **confirms economic/progression data tables accessible**
- *Satchelkeep* (wearable storage overhaul) — **confirms item property data tables accessible**

**Low-volume tiers (Blueprint scripting):**
- Only 3 Combat mods — suggests either combat BP scripting is harder or the community hasn't invested heavily. More likely the latter, since basic damage value mods work.
- Only 2 Quest mods — very low for a ~1-year-old modkit. This likely reflects the higher skill ceiling, not an access block, since the official wiki has quest documentation and the developer highlighted quest mods in Community Update 6.
- 9 UI mods — moderate. UI creation is supported but likely requires UE5 Widget Blueprint knowledge.

**UE4SS mods as a signal:**
The Bellwright Modifier (UE4SS Lua) and Villager Speed Enhancer (UE4SS Lua) both exist as separate from official ModKit mods. These use Lua runtime scripting to access C++ properties at runtime — meaning these modders found it *easier* to use UE4SS than official ModKit Blueprint for these specific modifications. This is a signal that the official Blueprint layer may not yet expose villager movement speed parameters, while UE4SS can access them via runtime reflection.

---

## Pending: Requires ModKit Editor Access

The Bellwright ModKit is Windows-only (UE5.5.4 editor via Epic Games Store). This machine is macOS. The following investigations are **PENDING: requires Windows ModKit installation**:

### 1. Class Viewer — Full Blueprint Hierarchy
**What to check:** In the ModKit editor → Window → Class Viewer → filter by "Mist" prefix.
- Enumerate all `Mist*` Blueprint classes (likely the game's namespace prefix, e.g. `MistWeaponItemTemplate`, `MistNPCTemplate`, `MistQuestTemplate`, etc.)
- Document the full inheritance hierarchy
- Note which classes have `BlueprintType` / `Blueprintable` flags set
- Note which are abstract vs. concrete

### 2. Content Browser — Data Table Assets
**What to check:** Content Browser → search for `DataTable` asset type.
- List all data table assets present in the ModKit content
- For each table, open it and note: row struct name, number of columns, whether game rows are included (read-only) or only example rows
- Key tables to locate: item definitions, weapon stats, building properties, production recipes, tech tree nodes, villager roles/jobs, buff/debuff definitions, combat damage types

### 3. Find in Blueprints — Quest Node Search
**What to check:** Edit → Find in Blueprints → search for "Quest", "Dialogue", "Conversation", "NPC".
- Identify whether a dialogue tree node system exists
- Note any `MistDialogue*` or `MistConversation*` classes
- Check if the NPC template Blueprint has dialogue assignment fields

### 4. Widget Blueprint Hierarchy
**What to check:** Content Browser → filter by `Widget Blueprint` → search "HUD", "Inventory", "Map", "Quest".
- Determine whether base game Widget Blueprints are included in the ModKit content
- If present, check whether they are marked as final/sealed or can be subclassed
- Check if the UI documentation means "replace existing widget" or "add new widget panel"

### 5. Blueprint Editor — Combat System
**What to check:** Open `MistWeaponItemTemplate` (or equivalent) in Blueprint editor.
- Note all exposed properties: damage type enum values, status effect references, hit response nodes
- Check if `DamageType` is a data-driven enum or a hardcoded C++ enum
- Look for any `StatusEffect` or `ApplyEffect` Blueprint callable functions

### 6. Input/Event Dispatcher Surface
**What to check:** In any gameplay Blueprint, open the My Blueprint panel → look at "Event Dispatchers" and "Functions" exposed from parent classes.
- Determine whether settlement events (villager assigned, building completed, quest started) are dispatched as Blueprint events
- This would reveal whether automation/scripting of settlement mechanics is possible

### 7. Exposed C++ Functions via UFUNCTION
**What to check:** In Blueprint editor, right-click empty space → search for game-specific function nodes.
- Test searches: "Quest", "Villager", "Combat", "Damage", "Settlement", "AI"
- Document any custom Bellwright functions exposed as Blueprint callable nodes

---

## Sources

| URL | Type | Notes |
|---|---|---|
| https://modding.playbellwright.com/ | **official** | Wiki homepage — TLS expired, accessed via search index |
| https://modding.playbellwright.com/modding_basics/basic_modkit_usage | **official** | Basic usage guide — TLS expired, content via search snippets |
| https://modding.playbellwright.com/bellwright_modding/item_equipment/adding_a_new_weapon | **official** | Weapon guide confirming `MistWeaponItemTemplate` |
| https://modding.playbellwright.com/bellwright_modding/quests_npcs/adding_a_new_npc | **official** | NPC creation guide |
| https://modding.playbellwright.com/en/bellwright_modding/Quests | **official** | Quests & NPCs section |
| https://modding.playbellwright.com/en/bellwright_modding/user-interface | **official** | UI modding section |
| https://modding.playbellwright.com/en/bellwright_modding/placeables | **official** | Placeables section |
| https://modding.playbellwright.com/bellwright_modding/placeables/adding-a-deployable-item | **official** | Deployable item guide |
| https://modding.playbellwright.com/bellwright_modding/placeables/adding_a_spline_wall | **official** | Spline wall guide |
| https://modding.playbellwright.com/en/bellwright_modding/gameplay | **official** | Gameplay section |
| https://modding.playbellwright.com/en/third_party_modding | **official** | Third-party (UE4SS) modding section |
| https://steamcommunity.com/games/1812450/announcements/detail/529849950216912918 | **primary** | Official Steam modding announcement (June 25, 2025) — body not retrievable |
| https://store.steampowered.com/news/app/1812450/view/529854389218705712 | **primary** | Community Update 6 featuring mods — highlights new potions, quests, castle |
| https://steamcommunity.com/app/1812450/discussions/1/604159978054457288/ | **community** | ModKit Discussion thread — file cooking limits, NPC traits, translation queries |
| https://steamcommunity.com/app/1812450/workshop/ | **primary** | Steam Workshop for Bellwright (app 1812450) |
| https://store.epicgames.com/en-US/p/bellwright-modkit | **primary** | Epic Games Store ModKit page — blocked 403 |
| https://www.moddb.com/news/bellwright-modding-support | **primary** | ModDB modding announcement — blocked 403 |
| https://www.nexusmods.com/bellwright/news/12995 | **community** | "Making of a modder (part 1)" — blocked 403 |
| https://www.nexusmods.com/bellwright/mods/104 | **community** | Faster Tasks mod — specific data table values revealed |
| https://www.nexusmods.com/bellwright/mods/45 | **community** | Higher Player Damage and Combat EXP mod |
| https://www.nexusmods.com/bellwright/mods/52 | **community** | Better Villagers — Buffs and Debuffs mod |
| https://www.nexusmods.com/bellwright/mods/113 | **community** | Villager Speed Enhancer (UE4SS) |
| https://www.nexusmods.com/bellwright/mods/69 | **community** | Bellwright Modifier (UE4SS) |
| https://www.nexusmods.com/bellwright/mods/16 | **community** | The Satchelkeep — wearable storage overhaul |
| https://www.nexusmods.com/bellwright/news/14093 | **community** | Project Spotlight: iEquip — confirms advanced UI mod work |
| https://massivelyop.com/2025/08/26/bellwright-highlights-junes-modkit-features-and-player-made-mods-teases-its-next-content-update/ | **secondary** | Massively OP coverage of Community Update 6 — blocked 403 |
| https://x.com/BellwrightGame/status/1937937332130484268 | **primary** | Official BellwrightGame Twitter: ModKit launch announcement |
| https://steamdb.info/patchnotes/18980444/ | **secondary** | SteamDB patch notes for June 25 2025 modding update — blocked 403 |
| https://buckminsterfullerene02.github.io/dev-guide/ModSupport/ModKits/DeveloperModkits/ExtraFeatures.html | **secondary** | UE DevModkit extra features guide — blueprint reflection theory, no Bellwright-specific content |
| https://www.youtube.com/watch?v=EHE7Ut8XKlI | **community** | Bellwright Modkit Spawning NPC Tutorial (YouTube) |
| https://www.youtube.com/watch?v=Q2Mcw9kNROA | **community** | Bellwright Modkit Consumable Item Tutorial (YouTube) |
| https://www.youtube.com/watch?v=reFfz6YFNmE | **community** | Bellwright Modkit Placeable Item Tutorial (YouTube) |
| https://www.youtube.com/watch?v=71y7IRv4u7c | **primary** | Bellwright Modkit Announcement (YouTube) |
| https://www.nexusmods.com/site/mods/1065 | **community** | Bellwright Vortex Extension — confirms Pak mod workflow |
| https://nexusmods.com/bellwright/articles/193 | **community** | Villager Speed Enhancer install guide |
