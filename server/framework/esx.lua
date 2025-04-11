local ESX = {}
local Utils = nil
local ESXCore = nil

-- Set utils module (will be called from main.lua)
RegisterNetEvent('vein-rentals:server:setModules', function(utils)
    Utils = utils
end)

-- Initialize framework
function ESX.Initialize()
    if Utils then Utils.DebugPrint("Initializing ESX server framework adapter") end
    ESXCore = exports['es_extended']:getSharedObject()
end

-- Get player identifier
function ESX.GetPlayerIdentifier(source)
    local xPlayer = ESXCore.GetPlayerFromId(source)
    if xPlayer then
        return xPlayer.identifier
    end
    return nil
end

-- Check player money
function ESX.CheckMoney(source, amount, account)
    local xPlayer = ESXCore.GetPlayerFromId(source)
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
    local xPlayer = ESXCore.GetPlayerFromId(source)
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
    local xPlayer = ESXCore.GetPlayerFromId(source)
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

-- Export framework adapter
function GetESXFramework()
    return ESX
end

return ESX 