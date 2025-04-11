local QBCore = {}
local Core = exports['qb-core']:GetCoreObject()
local Utils = require('shared.utils')

-- Initialize framework
function QBCore.Initialize()
    Utils.DebugPrint("Initializing QBCore server framework adapter")
end

-- Get player identifier
function QBCore.GetPlayerIdentifier(source)
    local xPlayer = Core.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

-- Check player money
function QBCore.CheckMoney(source, amount, account)
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
    local xPlayer = Core.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.RemoveMoney(account, amount, "vehicle-rental")
    return true
end

-- Add money to player
function QBCore.AddMoney(source, account, amount)
    local xPlayer = Core.Functions.GetPlayer(source)
    if not xPlayer then return false end
    
    account = account or 'cash'
    
    xPlayer.Functions.AddMoney(account, amount, "vehicle-rental-refund")
    return true
end

-- Notify player
function QBCore.Notify(source, message, type)
    TriggerClientEvent('QBCore:Notify', source, message, type)
end

return QBCore 