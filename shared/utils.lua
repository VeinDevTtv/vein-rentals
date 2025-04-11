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
Utils.FormatTimeRemaining = function(timeRemaining)
    local minutes = timeRemaining
    if minutes < 60 then
        return minutes .. " minutes"
    elseif minutes < 1440 then -- Less than a day
        local hours = math.floor(minutes / 60)
        local mins = minutes % 60
        if mins > 0 then
            return hours .. " hours, " .. mins .. " minutes"
        else
            return hours .. " hours"
        end
    else -- Days
        local days = math.floor(minutes / 1440)
        local hours = math.floor((minutes % 1440) / 60)
        if hours > 0 then
            return days .. " days, " .. hours .. " hours"
        else
            return days .. " days"
        end
    end
end

-- Check if player is near a rental location
Utils.IsNearRentalLocation = function(playerCoords, locations, distance)
    for _, location in pairs(locations) do
        local locationCoords = vector3(location.coords.x, location.coords.y, location.coords.z)
        if #(playerCoords - locationCoords) <= distance then
            return true, location
        end
    end
    return false, nil
end

-- Get free spawn point at a rental location
Utils.GetFreeSpawnPoint = function(location)
    for i, spawnPoint in ipairs(location.spawn) do
        if not spawnPoint.occupied then
            return i, spawnPoint.coords
        end
    end
    return nil, nil
end

-- Mark a spawn point as occupied/free
Utils.SetSpawnPointStatus = function(locationIndex, spawnIndex, status)
    if Config.RentalLocations[locationIndex] and Config.RentalLocations[locationIndex].spawn[spawnIndex] then
        Config.RentalLocations[locationIndex].spawn[spawnIndex].occupied = status
        return true
    end
    return false
end

-- Generate a unique rental ID
Utils.GenerateRentalID = function()
    return "R-" .. math.random(100000, 999999)
end

-- Debug print function
Utils.DebugPrint = function(...)
    if Config.Debug then
        local args = {...}
        local str = "[vein-rentals] "
        for i, v in ipairs(args) do
            if type(v) == "table" then
                str = str .. json.encode(v) .. " "
            else
                str = str .. tostring(v) .. " "
            end
        end
        print(str)
    end
end

return Utils 