local QBX = {}
local Utils = nil
-- Config is loaded as a global
local QBCore = nil

-- Set modules (will be called from main.lua)
RegisterNetEvent('vein-rentals:client:setFrameworkModules', function(utils, config)
    Utils = utils
    -- We already have Config globally
end)

-- Initialize framework
function QBX.Initialize()
    -- Try different methods to get QBX Core
    local success, result
    
    -- Method 1: New export
    success, result = pcall(function()
        return exports['qbx_core']:GetCoreObject()
    end)
    
    if success and result then
        QBCore = result
        if Utils then Utils.DebugPrint("Initialized QBX with GetCoreObject") end
        return
    end
    
    -- Method 2: Backward compatibility
    success, result = pcall(function()
        return exports['qbx_core']:GetSharedObject()
    end)
    
    if success and result then
        QBCore = result
        if Utils then Utils.DebugPrint("Initialized QBX with GetSharedObject") end
        return
    end
    
    -- Method 3: QB bridge compatibility
    success, result = pcall(function()
        local QBCore = exports['qb-core']:GetCoreObject()
        return QBCore
    end)
    
    if success and result then
        QBCore = result
        if Utils then Utils.DebugPrint("Initialized QBX with QBCore bridge") end
        return
    end
    
    if Utils then Utils.DebugPrint("Failed to initialize QBX Core") end
end

-- Get player data
function QBX.GetPlayerData()
    if not QBCore then return {} end
    return QBCore.Functions.GetPlayerData()
end

-- Check if player has enough money
function QBX.CheckMoney(amount)
    if not QBCore then return false end
    
    local playerData = QBCore.Functions.GetPlayerData()
    if playerData.money.cash >= amount then
        return true
    elseif playerData.money.bank >= amount then
        return true
    end
    return false
end

-- Remove money from player
function QBX.RemoveMoney(amount)
    if not QBCore then return false end
    
    local playerData = QBCore.Functions.GetPlayerData()
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
function QBX.GetLoyaltyDiscount(points)
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
function QBX.Notify(message, type)
    if not QBCore then 
        print(message)
        return 
    end
    
    QBCore.Functions.Notify(message, type)
end

return QBX 