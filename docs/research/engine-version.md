# Engine Version Research — Bellwright

*Researched: 2026-06-05*
*Updated: 2026-06-05 (binary confirmed via game log)*
*Task: S001-001*
*Status: complete*

## Summary

**CONFIRMED via game log (2026-06-05):** The Bellwright game binary is **UE 5.6.1-0+UE5** with compatible engine version **5.6.0-0+UE5**. This was read directly from `%LOCALAPPDATA%\Bellwright\Saved\Logs\Bellwright.log` on the Windows machine running the game. The game upgraded from UE 5.3.2 (EA launch, April 2024) → UE 5.5.4 (ModKit launch, June 2025) → **UE 5.6.1** (Maiden Voyage v2.0, December 9, 2025).

The ModKit is documented at UE 5.5.4 (official wiki, June 2025 launch). Whether the ModKit was also updated to 5.6 after December 2025 is the **one remaining unknown** — the wiki's TLS cert is expired. **This should be checked on the Windows machine** by reading `BellwrightModKit\Engine\Build\Build.version`.

---

## Confirmed Findings

- **[CONFIRMED 2026-06-05 via game log]** Current game binary: `Engine Version: 5.6.1-0+UE5` / `Compatible Engine Version: 5.6.0-0+UE5`
- At Early Access launch (April 2024) the game log showed `LogInit: Engine Version: 5.3.2-0+UE5` — confirmed by Steam community discussion thread.
- The official Bellwright Modding Wiki (`modding.playbellwright.com`) states: *"Bellwright Modkit is a powerful suite of tools that gives you access to the same modified version of Unreal Engine 5 (5.5.4) editor that we use to create the game."* — Retrieved from Basic Modkit Usage page. May be outdated (wiki TLS cert expired).
- A Donkey Crew developer, in an email interview published January 2, 2026 at TheGamer, stated: *"we updated to the newer version of Unreal Engine 5.6, which gave us a performance boost."* — Primary source, direct developer attribution.
- RE-UE4SS stable v3.0.1 supports UE 4.12–5.5 only. **UE 5.6.1 requires the `experimental-latest` build.**
- RE-UE4SS `experimental-latest` adds UE 5.6 support (PR #977) but Utf8String is unsupported.
- Required Bellwright config for RE-UE4SS: `bUseUObjectArrayCache = false` in `UE4SS-settings.ini`.
- The early claim of UE 5.3.2 as the *current* version was refuted — it was the launch version only.

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
| ModKit asset loading | AMBER | Game binary confirmed **UE 5.6.1**. ModKit documented at 5.5.4 (wiki may be outdated). If ModKit is still 5.5.4, cooked assets carry a 5.5 version header — UE's backward-compat policy should load them in 5.6.1 but this is unvalidated. Check `BellwrightModKit\Engine\Build\Build.version` to resolve. |
| RE-UE4SS injection | **AMBER — action required** | Stable v3.0.1 does NOT support UE 5.6. Must use `experimental-latest` build. UE 5.6 support is functional but Utf8String is unsupported (may affect some property reads). Download: https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest |

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
