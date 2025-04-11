local QBX = {}
local QBCore = exports['qbx_core']:GetCoreObject()
local Utils = require('shared.utils')
local Config = require('shared.config')

-- Initialize framework
function QBX.Initialize()
    Utils.DebugPrint("Initializing QBX framework adapter")
end

-- Get player data
function QBX.GetPlayerData()
    return QBCore.Functions.GetPlayerData()
end

-- Check if player has enough money
function QBX.CheckMoney(amount)
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
    QBCore.Functions.Notify(message, type)
end

return QBX 