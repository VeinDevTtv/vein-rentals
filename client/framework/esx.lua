local ESX = {}
local Utils = nil
-- Config is loaded as a global
local ESXCore = nil

-- Set modules (will be called from main.lua)
RegisterNetEvent('vein-rentals:client:setFrameworkModules', function(utils, config)
    Utils = utils
    -- We already have Config globally
end)

-- Initialize framework
function ESX.Initialize()
    if Utils then Utils.DebugPrint("Initializing ESX framework adapter") end
    ESXCore = exports['es_extended']:getSharedObject()
end

-- Get player data
function ESX.GetPlayerData()
    if not ESXCore then return {} end
    return ESXCore.GetPlayerData()
end

-- Check if player has enough money
function ESX.CheckMoney(amount)
    if not ESXCore then return false end
    
    local playerData = ESXCore.GetPlayerData()
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
    if not ESXCore then return false end
    
    local playerData = ESXCore.GetPlayerData()
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
    if not ESXCore then return end
    ESXCore.ShowNotification(message)
end

return ESX 