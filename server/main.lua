local QBCore = nil
local Vehicles = require('shared.vehicles')
local Utils = require('shared.utils')
local FrameworkFunctions = nil
local Database = require('server.database')

-- Active rentals tracking
local activeRentals = {}
local playerLoyaltyPoints = {}

-- Framework detection and initialization
local function InitializeFramework()
    if Config.Framework == 'qbx' then
        QBCore = exports['qbx_core']:GetCoreObject()
        FrameworkFunctions = require('server.framework.qbx')
    elseif Config.Framework == 'qbcore' then
        QBCore = exports['qb-core']:GetCoreObject()
        FrameworkFunctions = require('server.framework.qbcore')
    elseif Config.Framework == 'esx' then
        FrameworkFunctions = require('server.framework.esx')
    end
    
    if FrameworkFunctions then
        FrameworkFunctions.Initialize()
        Utils.DebugPrint("Server framework initialized:", Config.Framework)
    else
        Utils.DebugPrint("Failed to initialize server framework:", Config.Framework)
    end
end

-- Load player rentals from database
local function LoadPlayerRentals(source)
    local playerId = FrameworkFunctions.GetPlayerIdentifier(source)
    if not playerId then return {} end
    
    local rentals = Database.GetPlayerRentals(playerId)
    activeRentals[source] = rentals or {}
    
    return activeRentals[source]
end

-- Load player loyalty points from database
local function LoadPlayerLoyaltyPoints(source)
    local playerId = FrameworkFunctions.GetPlayerIdentifier(source)
    if not playerId then return 0 end
    
    local points = Database.GetLoyaltyPoints(playerId)
    playerLoyaltyPoints[source] = points or 0
    
    return playerLoyaltyPoints[source]
end

-- Save rental to database
local function SaveRental(rental, source)
    local playerId = FrameworkFunctions.GetPlayerIdentifier(source)
    if not playerId then return false end
    
    rental.playerId = playerId
    
    local success = Database.SaveRental(rental)
    if success then
        if not activeRentals[source] then
            activeRentals[source] = {}
        end
        table.insert(activeRentals[source], rental)
    end
    
    return success
end

-- Update rental status in database
local function UpdateRentalStatus(rentalId, status, fees)
    local success = Database.UpdateRentalStatus(rentalId, status, fees)
    return success
end

-- Add loyalty points to player
local function AddLoyaltyPoints(source, points)
    local playerId = FrameworkFunctions.GetPlayerIdentifier(source)
    if not playerId then return false end
    
    if not playerLoyaltyPoints[source] then
        playerLoyaltyPoints[source] = 0
    end
    
    playerLoyaltyPoints[source] = playerLoyaltyPoints[source] + points
    
    local success = Database.UpdateLoyaltyPoints(playerId, playerLoyaltyPoints[source])
    if success then
        TriggerClientEvent('vein-rentals:client:syncLoyaltyPoints', source, playerLoyaltyPoints[source])
    end
    
    return success
end

-- Server Events
RegisterNetEvent('vein-rentals:server:saveRental', function(rental, source)
    local src = source
    SaveRental(rental, src)
end)

RegisterNetEvent('vein-rentals:server:returnVehicle', function(rentalId, source, damageFee)
    local src = source
    UpdateRentalStatus(rentalId, 'returned', { damageFee = damageFee })
    
    -- Update active rentals
    if activeRentals[src] then
        for i, rental in ipairs(activeRentals[src]) do
            if rental.id == rentalId then
                table.remove(activeRentals[src], i)
                break
            end
        end
        TriggerClientEvent('vein-rentals:client:syncRentals', src, activeRentals[src])
    end
end)

RegisterNetEvent('vein-rentals:server:vehicleDestroyed', function(rentalId, source, replacementFee)
    local src = source
    UpdateRentalStatus(rentalId, 'destroyed', { replacementFee = replacementFee })
    
    -- Update active rentals
    if activeRentals[src] then
        for i, rental in ipairs(activeRentals[src]) do
            if rental.id == rentalId then
                table.remove(activeRentals[src], i)
                break
            end
        end
        TriggerClientEvent('vein-rentals:client:syncRentals', src, activeRentals[src])
    end
end)

RegisterNetEvent('vein-rentals:server:removeMoney', function(account, amount)
    local src = source
    FrameworkFunctions.RemoveMoney(src, account, amount)
end)

RegisterNetEvent('vein-rentals:server:getPlayerRentals', function(source)
    local src = source
    local rentals = LoadPlayerRentals(src)
    TriggerClientEvent('vein-rentals:client:syncRentals', src, rentals)
end)

RegisterNetEvent('vein-rentals:server:getLoyaltyPoints', function(source)
    local src = source
    local points = LoadPlayerLoyaltyPoints(src)
    TriggerClientEvent('vein-rentals:client:syncLoyaltyPoints', src, points)
end)

RegisterNetEvent('vein-rentals:server:addLoyaltyPoints', function(source, points)
    local src = source
    AddLoyaltyPoints(src, points)
end)

-- Player Connection Events
AddEventHandler('playerJoining', function()
    local src = source
    Wait(1000) -- Wait for player to fully connect
    LoadPlayerRentals(src)
    LoadPlayerLoyaltyPoints(src)
end)

AddEventHandler('playerDropped', function()
    local src = source
    activeRentals[src] = nil
    playerLoyaltyPoints[src] = nil
end)

-- Framework specific events
if Config.Framework == 'qbx' or Config.Framework == 'qbcore' then
    RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
        local src = source
        LoadPlayerRentals(src)
        LoadPlayerLoyaltyPoints(src)
    end)
elseif Config.Framework == 'esx' then
    RegisterNetEvent('esx:playerLoaded', function()
        local src = source
        LoadPlayerRentals(src)
        LoadPlayerLoyaltyPoints(src)
    end)
end

-- Commands
QBCore.Commands.Add('rentalstats', 'View rental statistics', {}, false, function(source, args)
    local src = source
    local playerName = GetPlayerName(src)
    local points = playerLoyaltyPoints[src] or 0
    local activeCount = activeRentals[src] and #activeRentals[src] or 0
    
    TriggerClientEvent('QBCore:Notify', src, 'Rental Stats - Active: ' .. activeCount .. ' | Loyalty Points: ' .. points)
end)

-- Initialize on resource start
CreateThread(function()
    InitializeFramework()
    Database.Initialize()
end) 