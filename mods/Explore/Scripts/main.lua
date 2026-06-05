local UEHelpers = require("UEHelpers")

-- Wait 8 seconds for the world to fully populate, then scan all UObjects
ExecuteWithDelay(8000, function()
    print("[Explore] Starting ForEachUObject scan...")

    local classes = {}
    local total = 0

    ForEachUObject(function(obj, chunkIdx, objIdx)
        if not obj:IsValid() then return end
        total = total + 1
        local cn = obj:GetClass():GetName()
        classes[cn] = (classes[cn] or 0) + 1
    end)

    print("[Explore] Total valid UObjects: " .. total)

    -- Print anything that looks like a character/AI/villager
    local keywords = {
        "villager", "settler", "resident", "worker", "npc",
        "character", "human", "oasis", "mist", "unit",
        "citizen", "peasant", "follower", "recruit"
    }

    print("[Explore] Keyword-matched classes:")
    local matchCount = 0
    for name, count in pairs(classes) do
        local lower = name:lower()
        for _, kw in ipairs(keywords) do
            if lower:find(kw) then
                print("[Explore]   " .. name .. " x" .. count)
                matchCount = matchCount + 1
                break
            end
        end
    end

    if matchCount == 0 then
        -- No matches — print top 40 most common classes to see what IS there
        print("[Explore] No keyword matches. Top 40 classes by count:")
        local sorted = {}
        for name, count in pairs(classes) do
            table.insert(sorted, {name = name, count = count})
        end
        table.sort(sorted, function(a, b) return a.count > b.count end)
        for i = 1, math.min(40, #sorted) do
            print("[Explore]   " .. sorted[i].name .. " x" .. sorted[i].count)
        end
    end

    print("[Explore] Scan complete.")
end)

print("[Explore] Scheduled scan in 8 seconds...")
