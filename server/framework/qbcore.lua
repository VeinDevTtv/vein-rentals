local QBCore = {}
local Utils = nil
local Core = nil

-- Set utils module (will be called from main.lua)
RegisterNetEvent('vein-rentals:server:setModules', function(utils)
    Utils = utils
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

-- Get player identifier
function QBCore.GetPlayerIdentifier(source)
    if not Core then return nil end
    
    local xPlayer = Core.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

-- Check player money
function QBCore.CheckMoney(source, amount, account)
    if not Core then return false end
    
    local xPlayer = Core.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    if xPlayer.PlayerData.money[account] >= amount then
        return true
    end
    return false
end

-- Remove money from player
function QBCore.RemoveMoney(source, account, amount)
    if not Core then return false end
    
    local xPlayer = Core.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.RemoveMoney(account, amount, "vehicle-rental")
    return true
end

-- Add money to player
function QBCore.AddMoney(source, account, amount)
    if not Core then return false end
    
    local xPlayer = Core.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.AddMoney(account, amount, "vehicle-rental-refund")
    return true
end

-- Notify player
function QBCore.Notify(source, message, type)
    if not Core then return end
    
    TriggerClientEvent('QBCore:Notify', source, message, type)
end

-- Export framework adapter
function GetQBCoreFramework()
    return QBCore
end

return QBCore 