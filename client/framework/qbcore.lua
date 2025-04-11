local QBCore = {}
local Core = exports['qb-core']:GetCoreObject()
local Utils = require('shared.utils')
local Config = require('shared.config')

-- Initialize framework
function QBCore.Initialize()
    Utils.DebugPrint("Initializing QBCore framework adapter")
end

-- Get player data
function QBCore.GetPlayerData()
    return Core.Functions.GetPlayerData()
end

-- Check if player has enough money
function QBCore.CheckMoney(amount)
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
    Core.Functions.Notify(message, type)
end

return QBCore 