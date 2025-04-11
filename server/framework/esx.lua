local ESX = {}
local Utils = require('shared.utils')

-- Initialize framework
function ESX.Initialize()
    Utils.DebugPrint("Initializing ESX server framework adapter")
    ESX.Core = exports['es_extended']:getSharedObject()
end

-- Get player identifier
function ESX.GetPlayerIdentifier(source)
    local xPlayer = ESX.Core.GetPlayerFromId(source)
    if xPlayer then
        return xPlayer.identifier
    end
    return nil
end

-- Check player money
function ESX.CheckMoney(source, amount, account)
    local xPlayer = ESX.Core.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    account = account or 'money'
    
    if account == 'cash' or account == 'money' then
        if xPlayer.getMoney() >= amount then
            return true
        end
    else
        if xPlayer.getAccount(account).money >= amount then
            return true
        end
    end
    return false
end

-- Remove money from player
function ESX.RemoveMoney(source, account, amount)
    local xPlayer = ESX.Core.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    account = account or 'money'
    
    if account == 'cash' or account == 'money' then
        xPlayer.removeMoney(amount)
    else
        xPlayer.removeAccountMoney(account, amount)
    end
    return true
end

-- Add money to player
function ESX.AddMoney(source, account, amount)
    local xPlayer = ESX.Core.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    account = account or 'money'
    
    if account == 'cash' or account == 'money' then
        xPlayer.addMoney(amount)
    else
        xPlayer.addAccountMoney(account, amount)
    end
    return true
end

-- Notify player
function ESX.Notify(source, message, type)
    TriggerClientEvent('esx:showNotification', source, message)
end

return ESX 