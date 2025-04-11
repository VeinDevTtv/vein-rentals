local QBX = {}
local Utils = nil
local QBCore = nil

-- Set utils module (will be called from main.lua)
RegisterNetEvent('vein-rentals:server:setModules', function(utils)
    Utils = utils
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

-- Get player identifier
function QBX.GetPlayerIdentifier(source)
    if not QBCore then return nil end
    
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

-- Check player money
function QBX.CheckMoney(source, amount, account)
    if not QBCore then return false end
    
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    if xPlayer.PlayerData.money[account] >= amount then
        return true
    end
    return false
end

-- Remove money from player
function QBX.RemoveMoney(source, account, amount)
    if not QBCore then return false end
    
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.RemoveMoney(account, amount, "vehicle-rental")
    return true
end

-- Add money to player
function QBX.AddMoney(source, account, amount)
    if not QBCore then return false end
    
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.AddMoney(account, amount, "vehicle-rental-refund")
    return true
end

-- Notify player
function QBX.Notify(source, message, type)
    if not QBCore then return end
    
    QBCore.Functions.Notify(source, message, type)
end

-- Export framework adapter
function GetQBXFramework()
    return QBX
end

return QBX 