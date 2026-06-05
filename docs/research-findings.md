# Bellwright Modding Ecosystem — Research Findings

*Research conducted: June 5, 2026*
*Method: 104-agent deep research workflow — 22 sources fetched, 25 claims adversarially verified (3-vote), 14 confirmed, 11 killed*

---

## Key Confirmed Facts

### Modding Infrastructure

| Finding | Confidence | Source |
|---|---|---|
| ModKit launched June 25, 2025 — custom UE5 editor on Epic Games Store, free | High (3-0) | Steam news post, SteamDB |
| Steam Workshop is the sole mod distribution channel | High (3-0) | Official announcement |
| Subscribed mods auto-enable on launch; can be disabled in-game | High (3-0) | Official announcement |
| Modding docs hosted at modding.playbellwright.com | Confirmed (site reachable, not extractable) | |
| 200+ mods existed by Aug 25, 2025 (2 months post-launch) | High (3-0) | Community Update 6 |
| 621 mods across 10 categories as of June 2026 | High (2-1) | Live Steam Workshop |

### Modding Capability Tiers

| Tier | Method | Example | Barrier |
|---|---|---|---|
| 1 — Data content | ModKit (no code) | Items, structures, technologies | None |
| 2 — Feature additions | ModKit + UE5 Blueprints | UI, new systems | Moderate |
| 3 — Deep scripting | RE-UE4SS (unofficial) | Lua, C++ API hooks | High |

Developer quote (confirmed): *"Simple changes like modifying or adding new items, structures and technologies are very simple and trivial, and don't require any prior knowledge. Adding new features via visual scripting and other Unreal tools is a little more tricky."*

### Current Workshop Catalogue (June 2026)

| Category | Count | Share |
|---|---|---|
| Gameplay | 372 | 59.9% |
| Buildings | 121 | 19.5% |
| Overhauls | 49 | 7.9% |
| Items & Equipment | 34 | 5.5% |
| Miscellaneous | 20 | 3.2% |
| **Visuals** | **9** | **1.45%** |
| **User Interface** | **9** | **1.45%** |
| **Combat** | **3** | **0.48%** |
| **Quests** | **2** | **0.32%** |
| Placeable | 2 | 0.32% |
| **Total** | **621** | |

### Technical Notes

- **Engine version**: UE5 confirmed. Community reports 5.6 (game binary), 5.5.4 (ModKit editor). Claim of UE 5.3.2 was adversarially refuted (0-3). Exact version unconfirmed from public sources.
- **RE-UE4SS**: Community tool targeting UE 4.12–5.7. Installs via DLL proxy to `{game}/Binaries/Win64/`. Not plug-and-play — requires game-specific AOB patterns. Confirmed range includes Bellwright's engine version. (Source: GitHub, 3-0)
- **Mod load order**: Addressed in hotfixes July 2025 and March 2026 — recurring structural concern for multi-mod setups. (Confirmed 3-0)
- **Mod fragility**: Pre-modkit mods broke on game updates (crafting time mod, January 2025). Post-modkit mods are more stable but load-order issues persist.

### Refuted Claims (do not rely on)

- Nexus Mods is a primary distribution channel — **refuted (0-3)**
- Game runs on UE 5.3.2 — **refuted (0-3)**
- Official modding support launched July 2024 — **refuted (0-3)** (correct: June 25, 2025)
- Subscribe button auto-installs (no in-game steps needed) — **partially refuted (1-2)**
- RE-UE4SS Blueprint Loader is plug-and-play — **refuted (0-3)**

---

## Comparative Ecosystem Benchmarks

*Note: Comparative data is training-knowledge baseline, not adversarially verified against live sources.*

| Mod Category | Valheim | 7 Days to Die | RimWorld | ARK | Minecraft | Bellwright |
|---|---|---|---|---|---|---|
| Comprehensive QoL overhaul | Essential (Valheim Plus) | Present | Present | Present | Modpacks | **Absent** |
| UI/information improvements | Essential | Present | Essential | Present | Present | **Near-absent (9)** |
| Visual/graphics enhancement | Present | Present | Present | Present | Essential | **Near-absent (9)** |
| Balance/pacing tweaks | Present | Present | Present | Present | Present | Dominant (372) |
| New structures/buildings | Essential | Present | Present | Essential | Essential | Present (121) |
| New items/equipment | Present | Present | Present | Present | Essential | Present (34) |
| Combat depth expansion | Present | Present | Present | Present | Present | **Near-absent (3)** |
| Quest/narrative content | Absent | Limited | Essential | Limited | Present | **Near-absent (2)** |
| Automation/efficiency | Present | Present | Essential | Limited | Essential | Unknown |
| Map extensions/new regions | Essential | Present | Limited | Essential (Ragnarok) | Essential | **Absent** |
| Total conversions | Limited | Essential | Present | Present | Present | Absent |

**Categories essential in 3+ comparators but absent/near-absent in Bellwright:**
1. Comprehensive QoL overhaul
2. UI/information improvements
3. Visual/graphics enhancement
4. Automation/efficiency systems
5. Map extensions/new regions

---

## Key Unknowns (unresolved — gate development decisions)

1. **ModKit Blueprint scope**: Does the ModKit expose Quest/Dialogue/NPC AI Blueprint nodes? Determines whether Quest (2 mods) and Combat (3 mods) gaps are addressable or a technical ceiling.
2. **Exact engine version**: Game binary UE5 version vs ModKit 5.5.4 — determines RE-UE4SS AOB compatibility profile.
3. **Settlement/automation API**: Are villager task assignment and resource routing accessible via Blueprint or RE-UE4SS? Gates entire automation mod scope.
4. **RE-UE4SS Bellwright compatibility**: No confirmed Bellwright-specific compatibility test in public sources.
5. **Workshop subscription metrics**: Actual download/popularity data not accessible — supply counts only, no demand signal.
6. **Active modder community size**: No confirmed figure for creators vs. subscribers.

---

## Top Opportunities (Ranked)

### #1 — Comprehensive QoL Overhaul ("Bellwright Plus")
**Confidence: High** | **Feasibility: High** | **Effort: Medium**

A single, maintained, configurable mod consolidating common friction points: carry weight, crafting speed, villager caps, hunger decay, XP rates. Mirrors Valheim Plus's community impact. All Tier 1 (data-driven) work. The 372 fragmented Gameplay mods are demand evidence — this consolidates them.

*Risk: maintenance burden during active EA development.*

### #2 — UI/Information Overhaul
**Confidence: High** | **Feasibility: Medium** | **Effort: High**

Enhanced map with resource markers and territory info, villager dashboard, inventory improvements. 9 UI mods in year one is anomalously low for a settlement management game. Requires Blueprint/UMG work. High retention impact for mid/late-game players managing complex settlements.

*Risk: requires Blueprint access to villager/map data APIs.*

### #3 — Visual/Atmospheric Enhancement Pack
**Confidence: High** | **Feasibility: Medium-Low** | **Effort: Medium**

Texture upscaling, weather system additions, lighting improvements, ReShade preset. Screenshot culture drives discovery. UE5 tooling is strong. ReShade is independent of ModKit — can start immediately.

*Risk: performance impact on lower-end hardware.*

### #4 — Settlement Automation Tools
**Confidence: Medium** | **Feasibility: Unknown** | **Effort: High**

Auto-routing resources, persistent villager task queues, production chain visualiser. Essential category in RimWorld, Minecraft. May already exist in Gameplay 372 — verify first. Technical feasibility depends on API access.

*Risk: feasibility is the primary unknown. Must investigate before building.*

### #5 — Combat Systems Expansion
**Confidence: Medium** | **Feasibility: Uncertain** | **Effort: High**

Status effects, new weapons, enemy variants, combo system. Three mods in a year suggests structural blockage. Near-zero count is more consistent with locked subsystems than lack of demand.

*Risk: may be technically impossible without RE-UE4SS. Must confirm ModKit access before investing.*

---

## Source Log

### Verified Primary Sources (adversarial verification passed)
- `https://store.steampowered.com/news/app/1812450/view/529849950216912917` — ModKit launch announcement, June 25 2025
- `https://store.steampowered.com/news/app/1812450/view/529854389218705712` — Community Update 6, August 25 2025
- `https://steamcommunity.com/app/1812450/workshop/` — Live Workshop page (June 2026 snapshot)
- `https://github.com/UE4SS-RE/RE-UE4SS` — RE-UE4SS README
- `https://store.epicgames.com/en-US/p/bellwright-modkit` — Epic Games Store ModKit page
- `https://steamdb.info/patchnotes/19174248/` — July 2025 hotfix notes

### Community/Forum Sources
- `https://steamcommunity.com/app/1812450/discussions/0/695376132937206220/` — Crafting time mod breakage thread
- `https://steamcommunity.com/app/1812450/discussions/0/4364626948848097398/` — Engine version discussion
- `https://steamcommunity.com/app/1812450/discussions/0/4361250086036118074/` — Player demand discussion

### Sites Returned Inaccessible During Research
- `https://modding.playbellwright.com/` — Official docs (reachable, not extractable — **priority retrieval target**)
- `https://www.nexusmods.com/bellwright/mods/top` — Not extractable
