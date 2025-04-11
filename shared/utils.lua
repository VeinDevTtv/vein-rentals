--[[ Vein Rentals - Utility Functions ]]--

local Utils = {}

-- Format money amount for display
Utils.FormatMoney = function(amount)
    local formatted = math.floor(tonumber(amount))
    if formatted >= 1000 then
        formatted = tostring(formatted)
        local k
        while true do  
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
            if k == 0 then break end
        end
    end
    return "$" .. formatted
end

-- Calculate rental price based on duration and vehicle base price
Utils.CalculateRentalPrice = function(basePrice, durationMultiplier, loyaltyDiscount)
    local price = basePrice * durationMultiplier
    if loyaltyDiscount and loyaltyDiscount > 0 then
        price = price * (1 - loyaltyDiscount)
    end
    return math.floor(price)
end

-- Calculate time remaining in human-readable format
Utils.FormatTimeRemaining = function(minutes)
    if minutes <= 0 then
        return "Expired"
    end
    
    if minutes < 60 then
        return minutes .. " min"
    end
    
    local hours = math.floor(minutes / 60)
    local remainingMinutes = minutes % 60
    
    if remainingMinutes == 0 then
        return hours .. " hour" .. (hours > 1 and "s" or "")
    else
        return hours .. "h " .. remainingMinutes .. "m"
    end
end

-- Check if player is near a rental location
Utils.IsNearRentalLocation = function(playerCoords, locations, maxDistance)
    for _, location in pairs(locations) do
        local distance = #(playerCoords - vector3(location.coords.x, location.coords.y, location.coords.z))
        if distance <= maxDistance then
            return true, location
        end
    end
    return false, nil
end

-- Get an available spawn point
Utils.GetFreeSpawnPoint = function(location)
    for i, spawnPoint in ipairs(location.spawn) do
        if not spawnPoint.occupied then
            return i, spawnPoint.coords
        end
    end
    return nil, nil
end

-- Update spawn point status (occupied or free)
Utils.SetSpawnPointStatus = function(locationIndex, spawnIndex, isOccupied)
    if Config.RentalLocations[locationIndex] and Config.RentalLocations[locationIndex].spawn[spawnIndex] then
        Config.RentalLocations[locationIndex].spawn[spawnIndex].occupied = isOccupied
        return true
    end
    return false
end

-- Generate a unique rental ID
Utils.GenerateRentalID = function()
    return "RENT-" .. math.random(1000, 9999) .. "-" .. math.random(1000, 9999)
end

-- Debug print function
Utils.DebugPrint = function(...)
    if Config.Debug then
        local args = {...}
        local text = ""
        for i=1, #args do
            if i > 1 then text = text .. " " end
            text = text .. tostring(args[i])
        end
        print("^2[Vein-Rentals] ^7" .. text)
    end
end

-- Export the utils module
function GetUtils()
    return Utils
end

return Utils 