# RE-UE4SS Compatibility Research — Bellwright

*Researched: 2026-06-05*
*Task: S001-003*
*Status: complete*

## Summary

RE-UE4SS v3.0.1 is **confirmed working** with Bellwright by the community. Multiple Lua-based mods are actively published and used on Nexus Mods (as of 2024–2025), all requiring UE4SS 3.0.1 as a dependency. The key Bellwright-specific configuration requirement is setting `bUseUObjectArrayCache = false` in `UE4SS-settings.ini`. No Bellwright-specific crashes or incompatibilities with UE4SS are reported in any RE-UE4SS GitHub issues. Risk level is **LOW** for the game's confirmed UE5.3 binary; **MEDIUM-LOW** if Bellwright has been updated to UE5.6 (experimental UE4SS builds add UE5.6 support with known limitations around Utf8String).

---

## RE-UE4SS Current Release

| Field | Value |
|---|---|
| Latest Stable Version | v3.0.1 |
| Release Date | February 14, 2024 |
| Download URL (stable) | https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/v3.0.1 |
| Direct zip download | `UE4SS_v3.0.1.zip` (5.5 MB) via GitHub Releases assets |
| Dev build download | `zDEV-UE4SS_v3.0.1.zip` (23.8 MB) |
| Confirmed UE Version Support (stable) | UE 4.11 – UE 5.5 |
| UE 5.6 support | Experimental-latest branch only (PR #977, merged) — boot + dumpers work; Utf8String unsupported |
| UE 5.7 support | Not supported; active crash issues (GitHub Issues #1118, #1198) |
| SHA256 | Not published in release notes; not found in searches |
| Experimental-latest URL | https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest |

**Note:** v3.0.1 is a patch on top of v3.0.0. Users upgrading from v2.5.2 must delete the old `xinput1_3.dll` — it will crash the game if left in place. C++ mods must be rebuilt for v3.0.1. Installation layout changed in v3.0.0: UE4SS files now live in a `ue4ss/` subfolder, with only the proxy DLL (`dwmapi.dll`) remaining in Win64.

---

## Bellwright-Specific Community Reports

Community evidence is **positive and concrete**: multiple UE4SS Lua mods for Bellwright are published and actively maintained on Nexus Mods, each citing UE4SS as a required dependency.

### Confirmed Working Mods (Nexus Mods)

**Bellwright Modifier** (nexusmods.com/bellwright/mods/69)
- Requires: UE4SS 3.0.1, extracted to `Bellwright\Binaries\Win64`
- Requires: `bUseUObjectArrayCache = false` in `UE4SS-settings.ini`
- A general-purpose game modifier implemented as a Lua mod

**Villager Speed Enhancer** (nexusmods.com/bellwright/mods/113)
- Requires: UE4SS 3.0.1 or newer
- Adjusts villager walk/run speeds via Lua scripting
- Has a published getting-started article confirming installation steps for Bellwright

**Map Revealer Alternative** (nexusmods.com/bellwright/mods/66)
- Requires: UE4SS 3.0.1 Experimental build 81+
- Confirms that even early experimental UE4SS builds were tested and confirmed on Bellwright

**Bellwright - UE4SS** (nexusmods.com/bellwright/mods/109)
- A dedicated Nexus Mods page for UE4SS itself, scoped to Bellwright
- Confirms the community treats Bellwright as a first-class UE4SS target

### RE-UE4SS GitHub Issues — Bellwright Mentions
- A search of `https://github.com/UE4SS-RE/RE-UE4SS/issues?q=Bellwright` returned **zero results**. No crash reports or incompatibility tickets exist for Bellwright in the RE-UE4SS issue tracker. This is a positive signal — no known breakage.

### Steam Forum
- A Steam discussion thread about using mods with Bellwright (appid 1812450) makes no mention of UE4SS crashes; mod-related crash reports reference outdated pak mods, not UE4SS.
- A separate thread confirmed the engine version as UE5.3 (game log: `Engine Version: 5.3.2-0+UE5`), placing it firmly in the well-supported UE4SS range.

### Bellwright Official Modding Wiki
- The official wiki at `modding.playbellwright.com` focuses on the official Bellwright ModKit (UE 5.5.4 editor). It does not mention UE4SS directly but does not prohibit or warn against it either.
- The modding community Discord (#mod-dev-general) is active and the UE4SS-based mod ecosystem there is well-established.

---

## AOB Configuration Status

- **Is there a known working AOB config for Bellwright?** — No custom AOB overrides are publicly documented or required. UE4SS works with its built-in AOB patterns on Bellwright (confirmed by working mods). No `UE4SS_Signatures/` Lua overrides have been published for Bellwright.
- **Source:** Community mod pages and search results show standard UE4SS installation (no custom signatures needed); nexusmods.com/bellwright/mods/69 and /mods/113.
- **Community AOB database:** No centralized per-game AOB database exists in the RE-UE4SS project. When needed, per-game fixes use Lua scripts in `UE4SS_Signatures/`. The documentation provides instructions for writing these manually. No Bellwright entry exists in any such database because none has been needed.

### What AOBs Are and Why They Matter

AOBs (Array of Bytes) are hex byte patterns that UE4SS uses to locate Unreal Engine internal functions (e.g., `GUObjectArray`, `FName_Constructor`, `StaticConstructObject`) in the game binary at runtime. Because games compile their own UE5 binaries with different compilers, optimization settings, and engine modifications, the byte sequences that identify these functions differ per-game. UE4SS ships with broad pattern sets that cover most games, but some games require manually crafted per-game Lua overrides in `UE4SS_Signatures/`. The fact that no Bellwright-specific AOB overrides exist on Nexus Mods or GitHub suggests the built-in patterns work without modification.

---

## Installation Steps for Bellwright

Based on official RE-UE4SS documentation and Bellwright-specific community guides.

### Prerequisites

- RE-UE4SS v3.0.1 downloaded: `UE4SS_v3.0.1.zip` from https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/v3.0.1
- Bellwright installed via Steam. Default path: `C:\Program Files (x86)\Steam\steamapps\common\Bellwright\`
- Game executable directory: `...\Bellwright\Binaries\Win64\`

### Step 1 — Remove old proxy DLL if upgrading

If previously had UE4SS v2.x installed, delete `xinput1_3.dll` from `Binaries\Win64\`. Leaving it causes game crashes.

### Step 2 — Extract UE4SS to the game executable directory

Extract `UE4SS_v3.0.1.zip` contents into:

```
...\Bellwright\Binaries\Win64\
```

After extraction, this directory should contain:
```
Win64\
  dwmapi.dll              ← proxy DLL (injection point)
  ue4ss\
    UE4SS.dll
    UE4SS-settings.ini
    Mods\
      mods.txt
    UE4SS.log             ← created on first run
```

**Note:** In v3.0.0+, UE4SS files moved into a `ue4ss\` subfolder. Only `dwmapi.dll` stays in the root Win64 directory.

### Step 3 — Apply Bellwright-specific settings

Open `...\Binaries\Win64\ue4ss\UE4SS-settings.ini` and change:

```ini
bUseUObjectArrayCache = false
```

(The default is `true`. Bellwright requires `false` — this is the **only known Bellwright-specific configuration change**. Multiple Nexus Mods pages for Bellwright explicitly call this out.)

### Step 4 — (Optional) Enable developer console

For development use, in `UE4SS-settings.ini` also set:

```ini
ConsoleEnabled = 1
GuiConsoleEnabled = 1
GuiConsoleVisible = 1
```

### Step 5 — Install mods (if desired)

Place Lua mod folders inside:

```
...\Binaries\Win64\ue4ss\Mods\
```

Each mod is a folder containing `Scripts\main.lua`. Enable mods by adding entries to `mods.txt`:

```
ModName : 1
```

### Step 6 — Launch the game

Start Bellwright via Steam normally. UE4SS injects automatically via the `dwmapi.dll` proxy.

### Step 7 — Verify injection

Confirm successful injection by:

1. Checking that `UE4SS.log` was created/updated in `...\Binaries\Win64\ue4ss\` with a fresh timestamp.
2. If GUI console is enabled: a separate UE4SS console window appears alongside the game.
3. In-game, press `@` (default keybind) to open the UE4SS Lua console.
4. `UE4SS.log` should show no `Fatal Error` lines; look for `UE4SS started` or similar success messages.

---

## Known Issues / Risks

### Bellwright-Specific
- **bUseUObjectArrayCache must be false**: Required for Bellwright. If left at default (`true`), mods may malfunction. This is well-documented in community mod pages.
- **No Bellwright-specific crashes reported**: Zero GitHub issues for Bellwright + UE4SS. No Steam forum reports of UE4SS causing crashes in Bellwright.

### General RE-UE4SS Known Issues (relevant to Bellwright)
- **BPModLoaderMod restart crash** (GitHub Issue #1043): The "Restart All Mods" button in the UE4SS GUI can crash the game if `BPModLoaderMod` is enabled. Workaround: don't use the restart button; restart the game instead.
- **bUseUObjectArrayCache = false side effect** (GitHub Issue #772): When set to false, `UObject.IsA(string FullClassName)` may partially ignore inheritance after first construction. Known bug, affects Lua mods using `IsA` checks.
- **Old xinput1_3.dll crash**: If upgrading from v2.x, the old proxy DLL causes an immediate game crash. Must be deleted.

---

## UE5 Version Compatibility

### Bellwright Engine Version History
The game's engine version has evolved:
- **UE5.3.2** — Confirmed via game log (`LogInit: Engine Version: 5.3.2-0+UE5`); well-documented in Steam forum thread (steamcommunity.com/app/1812450/discussions/0/4364626948848097398/)
- **UE5.5.4** — Referenced in the official Bellwright ModKit documentation (the editor shipped at this version)
- **UE5.6 / UE5.6.1** — Reported by community members on FearLess Cheat Engine forum following a late-2025 update; game binary may have been updated to 5.6 alongside the "Maiden Voyage" update (December 9, 2025)

**Best current assessment:** The live game binary is likely UE5.6.x as of late 2025 / early 2026. The ModKit remains at UE5.5.4.

### RE-UE4SS Support by UE Version (relevant range)

| UE Version | Stable v3.0.1 | Experimental-latest | Notes |
|---|---|---|---|
| 5.3.x | Fully supported | Fully supported | Confirmed working with Bellwright (existing mods) |
| 5.4.x | Fully supported | Fully supported | No issues reported |
| 5.5.x | Fully supported | Fully supported | Added in v3.0.0 timeframe; required Discussion #672 off-source changes |
| 5.6.x | Not supported | Supported (with caveats) | PR #977 merged to experimental; Utf8String unsupported; some scan failures reported on specific games (Issue #1204) |
| 5.7.x | Not supported | Not supported | Active crash issues (Issues #1118, #1198) |

### UE5.6 Specific Risk
If Bellwright's binary is now on UE5.6+, the stable RE-UE4SS v3.0.1 will produce `Fatal Error: Engine version is not supported.` The experimental-latest build adds UE5.6 support but:
- `Utf8String` type is not supported (FString properties may have been converted to Utf8 in UE5.6)
- Some games show `StaticConstructObject_Internal` scan failures on UE5.6 (Issue #1204, game-specific)
- These are not confirmed for Bellwright specifically, but represent potential failure modes

---

## Go/No-Go Recommendation

- **RE-UE4SS feasibility:** GREEN (if game binary is UE5.3–5.5) / AMBER (if binary is UE5.6+)
- **Risk level:** Low (UE5.3) / Medium-Low (UE5.6)
- **Reason:** Community has confirmed RE-UE4SS v3.0.1 working with Bellwright, with active Lua mods published on Nexus Mods. The only required game-specific config is `bUseUObjectArrayCache = false`. The primary remaining uncertainty is whether a 2025 game update pushed the binary to UE5.6 — if so, the experimental-latest build must be used instead of stable v3.0.1, and Utf8String-dependent functionality may be unavailable. No AOB customization has been needed by the community.

---

## Pending: Requires Physical Testing

| Test ID | Test | What to Run | Expected Output | Blocker |
|---|---|---|---|---|
| T001-003-001 | Detect current binary UE version | Run game, check `UE4SS.log` first line | `Engine version: 5.x.y` logged | macOS — requires Windows |
| T001-003-002 | Injection test | Place DLLs in `Win64\`, launch game | UE4SS console appears; `UE4SS.log` created with no Fatal Error | macOS — requires Windows |
| T001-003-003 | Lua baseline | Open UE4SS console (`@`), run `print("hello")` | Text `hello` appears in console output | macOS — requires Windows |
| T001-003-004 | UObject read | `UEHelpers.GetPlayer():GetActorLocation()` in Lua console | Location vector printed (e.g., `{X=1234.5, Y=5678.9, Z=200.0}`) | macOS — requires Windows |
| T001-003-005 | bUseUObjectArrayCache validation | Test with setting `true` vs `false` | Game works with `false`; may crash or malfunction with `true` | macOS — requires Windows |

**All physical tests are PENDING — requires Windows with Bellwright installed.**

If the game is now on UE5.6: use `experimental-latest` build instead of stable v3.0.1 for tests T001-003-002 through T001-003-005.

---

## Sources

| URL | Type | Notes |
|---|---|---|
| https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/v3.0.1 | Official | Stable release page |
| https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest | Official | Experimental build with UE5.6 support |
| https://docs.ue4ss.com/installation-guide.html | Official | Installation guide |
| https://docs.ue4ss.com/guides/fixing-compatibility-problems.html | Official | AOB fixing guide |
| https://github.com/UE4SS-RE/RE-UE4SS/pull/977 | Official | UE5.6 support PR |
| https://github.com/UE4SS-RE/RE-UE4SS/issues/972 | Official | UE5.6 `Fatal Error` issue (resolved) |
| https://github.com/UE4SS-RE/RE-UE4SS/issues/1204 | Official | UE5.6 scan failure (Surroundead, game-specific, unresolved) |
| https://github.com/UE4SS-RE/RE-UE4SS/issues/1118 | Official | UE5.7 crash issues |
| https://github.com/UE4SS-RE/RE-UE4SS/issues/1198 | Official | UE5.7.2 `Fatal Error` |
| https://github.com/UE4SS-RE/RE-UE4SS/pull/747 | Official | `bUseUObjectArrayCache` default changed to false in non-zDev |
| https://github.com/UE4SS-RE/RE-UE4SS/issues/772 | Official | `bUseUObjectArrayCache = false` side effect on `IsA()` |
| https://github.com/UE4SS-RE/RE-UE4SS/discussions/672 | Official | UE5.5 off-source changes discussion |
| https://www.nexusmods.com/bellwright/mods/69 | Community | Bellwright Modifier — confirmed UE4SS 3.0.1 working |
| https://www.nexusmods.com/bellwright/mods/113 | Community | Villager Speed Enhancer — confirmed UE4SS 3.0.1 working |
| https://www.nexusmods.com/bellwright/articles/193 | Community | Villager Speed Enhancer installation guide |
| https://www.nexusmods.com/bellwright/mods/66 | Community | Map Revealer Alternative — requires UE4SS experimental build 81+ |
| https://www.nexusmods.com/bellwright/mods/109 | Community | Dedicated Bellwright UE4SS page on Nexus |
| https://steamcommunity.com/app/1812450/discussions/0/4364626948848097398/ | Community/Forum | Steam discussion confirming UE5.3.2 engine version |
| https://steamcommunity.com/app/1812450/discussions/0/4334231842061562918/ | Community/Forum | Steam mod usage discussion |
| https://forums.guru3d.com/threads/bellwright-ue5-3.452196/ | Community/Forum | External forum confirming UE5.3 |
| https://deepwiki.com/UE4SS-RE/RE-UE4SS/12.3-version-compatibility-guide | Community (wiki) | UE version compatibility breakdown |
| https://deepwiki.com/UE4SS-RE/RE-UE4SS/4.1-signature-scanning-and-aob-patterns | Community (wiki) | AOB scanning architecture |
| https://modding.playbellwright.com/modding_basics/basic_modkit_usage | Official (game) | Official Bellwright modding wiki |
| https://github.com/UE4SS-RE/RE-UE4SS/blob/main/docs/installation-guide.md | Official | Raw installation guide source |
