# Engine Version Research — Bellwright

*Researched: 2026-06-05*
*Task: S001-001*
*Status: partially-blocked*

## Summary

The Bellwright game binary was upgraded from UE 5.3.2 (at Early Access launch, April 2024) to **UE 5.5.4** at some point, and then upgraded again to **UE 5.6** with the Maiden Voyage (v2.0) update released December 9, 2025 — confirmed directly in a developer interview at TheGamer (January 2, 2026). The ModKit launched in June 2025 was documented as running on **UE 5.5.4** in the official modding wiki; a community user on the Epic UE forums (April 2026) independently described the modkit as "made in Unreal Engine 5 (5.6)", suggesting the ModKit was also updated to 5.6 after the game engine upgrade, though this is unconfirmed from official sources. The exact current ModKit version requires verification against the live modding wiki (TLS cert issue prevented direct fetch during this research).

Binary-level confirmation (strings extraction from the shipping executable) is pending and requires a Windows game installation.

---

## Confirmed Findings

- At Early Access launch (April 2024) the game log showed `LogInit: Engine Version: 5.3.2-0+UE5` — confirmed by Steam community discussion thread.
- The official Bellwright Modding Wiki (`modding.playbellwright.com`) states: *"Bellwright Modkit is a powerful suite of tools that gives you access to the same modified version of Unreal Engine 5 (5.5.4) editor that we use to create the game."* — This quote was retrieved from the Basic Modkit Usage page and was consistent across multiple independent search-result snippets.
- A Donkey Crew developer, in an email interview published January 2, 2026 at TheGamer, stated: *"Our main map, Karvenia, is quite heavy for players, even though we updated to the newer version of Unreal Engine 5.6, which gave us a performance boost."* — This is a primary source, direct developer attribution.
- Multiple secondary sources (Massively Overpowered, GameRant search summaries) independently describe the Maiden Voyage (v2.0) update (released December 9, 2025) as including "a shift to Unreal Engine 5.6 and its associated overall performance boost."
- A user on the Epic Developer Community Forum (thread: "Trying to use an imported asset in a UE5 Game", post dated April 19, 2026) described their modkit as "made in the Unreal Engine 5 (5.6), for a game called Bellwright." This is an independent community source consistent with the 5.6 upgrade.
- RE-UE4SS targets UE versions 4.12 through 5.7 (confirmed from official UE4SS documentation and DeepWiki). UE 5.6 falls within the "5.0–5.7 Modern Support" range.
- No Bellwright-specific compatibility notes were found in the RE-UE4SS GitHub or documentation.
- The UE4SS configuration required for Bellwright: set `bUseUObjectArrayCache = false` in `UE4SS-settings.ini` (confirmed by Nexus Mods community documentation). UE4SS version 3.0.1 is documented as the recommended version for Bellwright.
- The early claim of UE 5.3.2 as the *current* version was refuted — it was the launch version only. The game has since been upgraded.

---

## Version Evidence

| Source | Claimed Version | Scope | Confidence | URL |
|--------|----------------|-------|------------|-----|
| Steam community discussion (game log) | 5.3.2-0+UE5 | Game binary at launch (April 2024) | High — exact log string quoted | https://steamcommunity.com/app/1812450/discussions/0/4364626948848097398/ |
| Official Bellwright Modding Wiki | 5.5.4 | ModKit editor (June 2025 launch) | High — official developer documentation | https://modding.playbellwright.com/modding_basics/basic_modkit_usage |
| TheGamer interview (Donkey Crew developer, Jan 2 2026) | 5.6 | Game binary (current, post Dec 9 2025) | High — primary source, direct developer quote | https://www.thegamer.com/bellwright-halmare-isles-maiden-voyage-interview/ |
| Massively Overpowered (Jan 6 2026) | 5.6 | Game binary (Maiden Voyage update) | Medium-High — editorial corroboration of developer statement | https://massivelyop.com/2026/01/06/bellwright-talks-up-maiden-voyage-patchs-improvements-to-performance-replayability-and-story/ |
| Epic UE Forum user (April 19 2026) | 5.6 | ModKit (current) | Low-Medium — community user, plausible given timeline | https://forums.unrealengine.com/t/trying-to-use-an-imported-asset-in-a-ue5-game/2716556 |
| Guru3D forum thread | 5.3 (general) | Game at launch | Low — general community, no log quoted | https://forums.guru3d.com/threads/bellwright-ue5-3.452196/ |
| ModDB Bellwright Modding Support news | 5.5.4 (inferred) | ModKit (June 2025) | Medium — editorial summary of modding launch | https://www.moddb.com/news/bellwright-modding-support |

---

## Version Delta Analysis

### Timeline Reconstruction

| Period | Game Binary | ModKit |
|--------|-------------|--------|
| April 2024 (Early Access launch) | 5.3.2 | No ModKit |
| June 25, 2025 (ModKit launch) | Likely 5.5.4 (same as ModKit per wiki) | 5.5.4 |
| December 9, 2025 (Maiden Voyage v2.0) | 5.6 (developer confirmed) | Unknown — wiki may be outdated |
| April 2026 (community report) | 5.6 (inferred current) | 5.6 (one community user report) |

### Compatibility Assessment

**If the current ModKit is still 5.5.4 and the game binary is 5.6:**
- This is a **minor version delta** (5.5 → 5.6), which is a significant concern.
- Assets cooked by a UE 5.5.4 ModKit carry a UE 5.5.4 package version header. The game binary (UE 5.6) must be backward-compatible with 5.5 assets for them to load.
- UE maintains backward-read compatibility within a major version as a general policy, but there may be deprecation warnings or edge cases with newer asset features.
- **Bottom line:** Amber concern. Assets cooked in 5.5.4 may load in 5.6 but should be validated. If the ModKit was also updated to 5.6 (as one community user suggests), this concern is eliminated.

**If the ModKit has been updated to 5.6 (consistent with game binary):**
- No version delta. Green.
- The official wiki quote of 5.5.4 may simply be a documentation lag from before the December 2025 engine upgrade.

**Recommended action:** Check the current live ModKit version on Epic Games Store or by inspecting the ModKit's `Engine/Binaries/Win64/` directory for a version string. The wiki's SSL cert was expired during this research, which may indicate the documentation is not actively maintained.

---

## RE-UE4SS Compatibility Assessment

- RE-UE4SS explicitly supports UE versions **4.12 through 5.7** (confirmed from official documentation).
- UE 5.6 falls within the "5.0–5.7 Modern Support" range.
- **RE-UE4SS is compatible with Bellwright at UE 5.6.** No version-range blocking issue exists.
- **AOB pattern note:** RE-UE4SS uses Array of Bytes (AOB) patterns that can break on engine upgrades even within the supported range. Since the game upgraded from 5.5.4 to 5.6, existing AOB signatures should be re-verified.
- **Known Bellwright-specific configuration:** Set `bUseUObjectArrayCache = false` in `UE4SS-settings.ini`. This requirement may persist or change after the 5.6 upgrade and should be retested.
- No Bellwright-specific issues were found in the RE-UE4SS GitHub repository or documentation.

---

## Go/No-Go Recommendation

| Concern | Status | Reason |
|---------|--------|--------|
| ModKit asset loading | AMBER | Game binary is confirmed UE 5.6; ModKit documentation shows 5.5.4 from June 2025, but may have been updated — actual current ModKit version is unconfirmed. Assets cooked in 5.5.4 should load in 5.6 under UE's backward-compat policy, but this is not validated. |
| RE-UE4SS injection | GREEN (pending AOB verification) | UE 5.6 is within RE-UE4SS's 4.12–5.7 supported range. The `bUseUObjectArrayCache = false` setting is required; AOB patterns should be re-verified after the 5.5→5.6 engine upgrade. |

---

## Pending: Requires Physical Testing

The definitive check for the exact current game binary version cannot be performed on this macOS machine against a Windows-only game binary.

### Required commands (run on a Windows machine with the game installed):

```powershell
# 1. Check engine version string in the game binary
strings "C:\...\Bellwright\Binaries\Win64\Bellwright-Win64-Shipping.exe" | grep -E "UE[45]\+|Engine Version"

# 2. Alternative: check the game's log file after a launch
Get-Content "$env:LOCALAPPDATA\Bellwright\Saved\Logs\Bellwright.log" | Select-String "Engine Version"
# Expected format: LogInit: Engine Version: 5.X.Y-0+UE5

# 3. Check cooked asset package versions in game Pak files
# Use UnrealPak or FModel to inspect any .uasset/.umap header for SavedByEngineVersion

# 4. Verify current ModKit version
# In the ModKit installation directory, check:
Get-Content "C:\...\BellwrightModKit\Engine\Build\Build.version"
# This will show the exact engine version the ModKit was built against
```

### Also pending:
- Whether the Bellwright ModKit on Epic Games Store was updated after December 2025 to match UE 5.6. The official wiki (`modding.playbellwright.com`) showed 5.5.4 in all cached/indexed content but the TLS certificate was expired at time of research, making the current live content unverifiable.
- Whether AOB signatures in RE-UE4SS 3.0.1 still work after the 5.5→5.6 engine upgrade. The `bUseUObjectArrayCache = false` setting should be retested.

---

## Sources

| URL | Type | Notes |
|-----|------|-------|
| https://steamcommunity.com/app/1812450/discussions/0/4364626948848097398/ | Community | Steam discussion thread; contains game log string `5.3.2-0+UE5` from launch |
| https://modding.playbellwright.com/modding_basics/basic_modkit_usage | Primary (official) | Official modding wiki; states ModKit uses UE 5.5.4; TLS cert expired, content retrieved via search snippets |
| https://modding.playbellwright.com/ | Primary (official) | Official modding wiki home; TLS cert expired at time of research |
| https://www.thegamer.com/bellwright-halmare-isles-maiden-voyage-interview/ | Primary | Developer interview (Jan 2, 2026); direct Donkey Crew quote confirming UE 5.6 upgrade |
| https://massivelyop.com/2026/01/06/bellwright-talks-up-maiden-voyage-patchs-improvements-to-performance-replayability-and-story/ | Community | Corroborates Maiden Voyage = UE 5.6 shift; 403 on direct fetch |
| https://forums.unrealengine.com/t/trying-to-use-an-imported-asset-in-a-ue5-game/2716556 | Community | Epic UE forum user (April 19, 2026) describes Bellwright modkit as UE 5.6 |
| https://store.epicgames.com/en-US/p/bellwright-modkit | Primary | Epic Games Store ModKit listing; 403 on direct fetch, no version info extracted |
| https://steamcommunity.com/games/1812450/announcements/detail/529849950216912918 | Primary | Official Steam modding support announcement (June 25, 2025); Steam rendered empty content |
| https://steamdb.info/patchnotes/18980444/ | Community | SteamDB record of modding support patch note (June 25, 2025); 403 on direct fetch |
| https://www.moddb.com/news/bellwright-modding-support | Community | ModDB editorial on modding launch; 403 on direct fetch |
| https://www.playbellwright.com/news/maiden-voyage-launch | Primary | Official Maiden Voyage launch blog; no engine version mentioned in body |
| https://github.com/UE4SS-RE/RE-UE4SS | Primary | RE-UE4SS GitHub; confirms UE 4.12–5.7 support range, no Bellwright-specific notes |
| https://deepwiki.com/UE4SS-RE/RE-UE4SS/12.3-version-compatibility-guide | Community | DeepWiki documentation; confirms UE 5.6 is in "Modern Support" (5.0–5.7) range |
| https://nexusmods.com/bellwright/mods/69 | Community | Nexus Mods — Bellwright Modifier; documents UE4SS 3.0.1 usage and `bUseUObjectArrayCache = false` requirement |
| https://nexusmods.com/site/mods/1065 | Community | Bellwright Vortex Extension; references ModKit/Workshop integration |
| https://forums.guru3d.com/threads/bellwright-ue5-3.452196/ | Community | Guru3D thread "Bellwright - UE5.3"; reflects launch-era version, now outdated |
| https://80.lv/articles/how-bellwright-simulates-a-living-medieval-world-with-thousands-of-npcs | Community | 80.lv developer article; confirms UE5 but no specific minor version |
| https://steamcommunity.com/app/1812450/discussions/ | Community | Steam hub discussions index; no engine version info found in general listing |
| https://steamcommunity.com/app/1812450/discussions/1/604159978054457288/ | Community | Modkit Discussions thread; no engine version numbers mentioned in 23 comments |
