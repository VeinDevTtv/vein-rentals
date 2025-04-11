local ESX = {}
local Utils = require('shared.utils')
local Config = require('shared.config')

-- Initialize framework
function ESX.Initialize()
    Utils.DebugPrint("Initializing ESX framework adapter")
    ESX.Core = exports['es_extended']:getSharedObject()
end

-- Get player data
function ESX.GetPlayerData()
    return ESX.Core.GetPlayerData()
end

-- Check if player has enough money
function ESX.CheckMoney(amount)
    local playerData = ESX.Core.GetPlayerData()
    if playerData.money >= amount then
        return true
    elseif playerData.accounts then
        for _, account in pairs(playerData.accounts) do
            if account.name == 'bank' and account.money >= amount then
                return true
            end
        end
    end
    return false
end

-- Remove money from player
function ESX.RemoveMoney(amount)
    local playerData = ESX.Core.GetPlayerData()
    if playerData.money >= amount then
        TriggerServerEvent('vein-rentals:server:removeMoney', 'cash', amount)
        return true
    elseif playerData.accounts then
        for _, account in pairs(playerData.accounts) do
            if account.name == 'bank' and account.money >= amount then
                TriggerServerEvent('vein-rentals:server:removeMoney', 'bank', amount)
                return true
            end
        end
    end
    return false
end

-- Get loyalty discount based on points
function ESX.GetLoyaltyDiscount(points)
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
function ESX.Notify(message, type)
    ESX.Core.ShowNotification(message)
end

return ESX 