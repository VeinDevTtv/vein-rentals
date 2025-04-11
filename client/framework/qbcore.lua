local QBCore = {}
local Utils = nil
-- Config is loaded as a global
local Core = nil

-- Set modules (will be called from main.lua)
RegisterNetEvent('vein-rentals:client:setFrameworkModules', function(utils, config)
    Utils = utils
    -- We already have Config globally
end)

-- Initialize framework
function QBCore.Initialize()
    -- Try to get QBCore
    local success, result
    
    success, result = pcall(function()
        return exports['qb-core']:GetCoreObject()
    end)
    
    if success and result then
        Core = result
        if Utils then Utils.DebugPrint("Initialized QBCore with GetCoreObject") end
        return
    end
    
    if Utils then Utils.DebugPrint("Failed to initialize QBCore") end
end

-- Get player data
function QBCore.GetPlayerData()
    if not Core then return {} end
    return Core.Functions.GetPlayerData()
end

-- Check if player has enough money
function QBCore.CheckMoney(amount)
    if not Core then return false end
    
    local playerData = Core.Functions.GetPlayerData()
    if playerData.money.cash >= amount then
        return true
    elseif playerData.money.bank >= amount then
        return true
    end
    return false
end

-- Remove money from player
function QBCore.RemoveMoney(amount)
    if not Core then return false end
    
    local playerData = Core.Functions.GetPlayerData()
    if playerData.money.cash >= amount then
        TriggerServerEvent('vein-rentals:server:removeMoney', 'cash', amount)
        return true
    elseif playerData.money.bank >= amount then
        TriggerServerEvent('vein-rentals:server:removeMoney', 'bank', amount)
        return true
    end
    return false
end

-- Get loyalty discount based on points
function QBCore.GetLoyaltyDiscount(points)
    if not Config.EnableLoyalty then return 0 end
    
    local discount = 0
    for threshold, discountValue in pairs(Config.LoyaltyDiscounts) do
        if points >= threshold and discountValue > discount then
            discount = discountValue
        end
    end
    return discount
end

-- Format notification for framework
function QBCore.Notify(message, type)
    if not Core then 
        print(message)
        return 
    end
    
    Core.Functions.Notify(message, type)
end

return QBCore 