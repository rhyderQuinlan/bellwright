# RE-UE4SS Lua API Reference — Bellwright

*Researched: 2026-06-05*
*Version: experimental-latest (v3.0.1-953-gb872ad11)*
*UE version: 5.6.1*
*Status: complete*

## Key Functions

### `ForEachUObject(callback)` — scan all UObjects
```lua
ForEachUObject(function(obj, chunkIdx, objIdx)
    if not obj:IsValid() then return end
    print(obj:GetClass():GetName())
end)
```
Most reliable way to find game-specific classes. Iterates GUObjectArray.

### `FindAllOf(shortClassName)` — find instances of a class
```lua
local results = FindAllOf("PlayerController")
if results then
    for _, obj in pairs(results) do  -- use pairs(), not ipairs()
        if obj:IsValid() then
            print(obj:GetFullName())
        end
    end
end
```
- Returns a table or `nil` (check before iterating)
- Finds subclasses too
- Use `pairs()` not `#` or `ipairs()`

### `NotifyOnNewObject(fullClassPath, callback)` — hook object creation
```lua
NotifyOnNewObject("/Script/Engine.PlayerController", function(obj)
    obj.bShowMouseCursor = true
end)
```
- Requires **full path** (`/Script/Package.ClassName`), not short name
- Fires for subclasses too
- **UE 5.6 risk:** May fail if `StaticConstructObject_Internal` scan fails (game-binary-specific — unconfirmed on Bellwright)

### `RegisterHook(functionPath, callback)` — hook a UFunction
```lua
local PreId, PostId = RegisterHook("/Script/Engine.PlayerController:ClientRestart",
    function(context, newPawn)
        local ctrl = context:get()   -- MUST call :get() to unwrap
        local pawn = newPawn:get()
        print(ctrl:GetFullName())
    end
)
-- Unregister when done:
UnregisterHook("/Script/Engine.PlayerController:ClientRestart", PreId, PostId)
```
- Parameters arrive **wrapped** — always call `:get()` to extract the UObject
- Returns two IDs (PreId, PostId) — both needed to unregister
- Function path format: `/Script/Package.ClassName:FunctionName`

### `ExecuteWithDelay(ms, callback)` — delayed execution
```lua
ExecuteWithDelay(5000, function()
    -- Runs 5 seconds after this line, on game thread
    local player = UEHelpers.GetPlayer()
end)
```
Use instead of tick-hook hacks for delayed startup logic.

### `ExecuteInGameThread(callback)` — safe UObject access
```lua
ExecuteInGameThread(function()
    local player = UEHelpers.GetPlayer()
    if player:IsValid() then
        player.MaxHealth = 200.0
    end
end)
```
Use when writing properties or calling functions from outside a hook.

---

## UEHelpers Module

```lua
local UEHelpers = require("UEHelpers")

UEHelpers.GetPlayer()              -- local player pawn (APawn)
UEHelpers.GetPlayerController()    -- first player controller
UEHelpers.GetEngine()              -- UEngine instance
UEHelpers.GetWorld()               -- UWorld instance
UEHelpers.GetGameInstance()        -- UGameInstance
UEHelpers.GetGameModeBase()        -- AGameModeBase
UEHelpers.GetGameStateBase()       -- AGameStateBase
UEHelpers.GetAllPlayers()          -- table of all player pawns
UEHelpers.GetGameplayStatics()     -- UGameplayStatics
UEHelpers.GetKismetMathLibrary()   -- UKismetMathLibrary
```
Pass `true` to any function to force cache invalidation (e.g. `UEHelpers.GetEngine(true)`).

---

## UObject Property Access

```lua
local obj = UEHelpers.GetPlayer()

-- Read
local speed = obj.MaxWalkSpeed      -- returns Lua number
local alive = obj.bAlive            -- returns boolean
local name  = obj.CharacterName     -- returns string

-- Write
obj.MaxWalkSpeed = 800.0
obj.bAlive = true

-- Always check IsValid() first
if obj:IsValid() then
    print(obj:GetClass():GetName())
    print(obj:GetFullName())        -- full UObject path
    print(obj:GetFName():ToString()) -- short name
end
```

---

## Property Iteration

```lua
obj:GetClass():ForEachProperty(function(prop)
    print(prop:GetFName():ToString())
    return false  -- return true to stop iteration
end)
```

---

## Config File Pattern

**Scripts/config.lua:**
```lua
return {
    walkSpeedMultiplier = 1.5,
    taskSpeedMultiplier = 2.0,
}
```

**Scripts/main.lua:**
```lua
local config = require("config")
print(config.walkSpeedMultiplier)
```

---

## Mod Folder Structure

```
ue4ss/Mods/
├── mods.txt                    (ModName : 1 to enable)
└── MyMod/
    └── Scripts/
        ├── main.lua            (required entry point)
        └── config.lua          (optional)
```

---

## Confirmed Working on Bellwright UE 5.6.1

- `require("UEHelpers")` ✓
- `UEHelpers.GetPlayer()` ✓
- `player:K2_GetActorLocation()` ✓ (use K2_ prefix in UE5)
- `player:IsValid()` ✓
- `player:GetClass():GetName()` ✓
- `print()` output appears in UE4SS.log ✓
- Mod loaded via mods.txt ✓
- `ExecuteWithDelay` — untested on Bellwright, confirmed in API docs
- `ForEachUObject` — untested on Bellwright, confirmed in API docs
- `NotifyOnNewObject` — untested on Bellwright, UE 5.6 scan risk

---

## Known Gotchas

| Issue | Cause | Fix |
|---|---|---|
| `attempt to index nil (global 'UEHelpers')` | Module not required | Add `local UEHelpers = require("UEHelpers")` |
| `unexpected symbol near '<\239>'` | PowerShell UTF-8 BOM | Deploy Lua files via SCP from Mac, not PowerShell |
| Hook callback params are nil | Forgot `:get()` | Use `context:get()` to unwrap hook parameters |
| `FindAllOf` returns empty | Wrong class name | Use `ForEachUObject` to discover actual class names first |
| `RegisterHook` — function not found | Wrong path or function not hookable | Try `/Script/Engine.Actor:ReceiveBeginPlay` for actor spawns |
| `AActor:GetWorld()` returns invalid object not nil | UE4SS experimental breaking change | Use `:IsValid()` not `== nil` checks |
| Engine tick hook not found | `GameViewportClient:Tick` not a Lua-hookable UFunction | Use `ExecuteWithDelay` instead |

---

## Sources

- https://docs.ue4ss.com/lua-api/
- https://github.com/UE4SS-RE/RE-UE4SS/tree/main/assets/Mods (built-in mod examples)
- https://github.com/UE4SS-RE/RE-UE4SS/pull/977 (UE5.6 support PR)
- https://pwmodding.wiki/docs/developers/ue4ss-modding/lua-mods/ (Palworld — same API)
