local QBX = {}
local QBCore = exports['qbx_core']:GetCoreObject()
local Utils = require('shared.utils')

-- Initialize framework
function QBX.Initialize()
    Utils.DebugPrint("Initializing QBX server framework adapter")
end

-- Get player identifier
function QBX.GetPlayerIdentifier(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

-- Check player money
function QBX.CheckMoney(source, amount, account)
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
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.RemoveMoney(account, amount, "vehicle-rental")
    return true
end

-- Add money to player
function QBX.AddMoney(source, account, amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.AddMoney(account, amount, "vehicle-rental-refund")
    return true
end

-- Notify player
function QBX.Notify(source, message, type)
    QBCore.Functions.Notify(source, message, type)
end

return QBX 