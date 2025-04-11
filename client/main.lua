local QBCore = nil
local Vehicles = nil
local Utils = nil
-- Config will be loaded from shared_script in fxmanifest.lua
local FrameworkFunctions = nil

-- Variables
local isInitialized = false
local isNearRentalLocation = false
local currentRentalLocation = nil
local currentRentals = {}
local activeRentalMenu = false
local playerLoaded = false
local playerData = {}
local loyaltyPoints = 0

-- Load shared modules directly using require
local function LoadModules()
    -- Config is already loaded as a global from shared_script in fxmanifest.lua
    Utils = require('shared.utils')
    Vehicles = require('shared.vehicles')
    
    if not Config or not Utils or not Vehicles then
        print("^1[ERROR] Failed to load modules: Config=", tostring(Config), " Utils=", tostring(Utils), " Vehicles=", tostring(Vehicles), "^7")
        return false
    end
    
    -- Register exports for other scripts to use
    exports('GetConfig', function() return Config end)
    exports('GetUtils', function() return Utils end)
    exports('GetVehicles', function() return Vehicles end)
    exports('GetActiveRentals', function() return currentRentals end)
    
    -- Share modules with other client scripts
    TriggerEvent('vein-rentals:client:setModules', Utils, Vehicles)
    
    return true
end

-- Framework detection and initialization
local function InitializeFramework()
    local success = LoadModules()
    if not success then
        print("^1[Error] Failed to load modules^7")
        return false
    end
    
    -- Share modules with framework adapters
    TriggerEvent('vein-rentals:client:setFrameworkModules', Utils)

    if Config.Framework == 'qbx' then
        QBCore = exports['qbx_core']:GetCoreObject()
        FrameworkFunctions = require('client.framework.qbx')
    elseif Config.Framework == 'qbcore' then
        QBCore = exports['qb-core']:GetCoreObject()
        FrameworkFunctions = require('client.framework.qbcore')
    elseif Config.Framework == 'esx' then
        FrameworkFunctions = require('client.framework.esx')
    end
    
    if FrameworkFunctions then
        FrameworkFunctions.Initialize()
        isInitialized = true
        Utils.DebugPrint("Framework initialized:", Config.Framework)
        
        -- Initialize rentals module
        TriggerEvent('vein-rentals:client:initialize', Utils, Vehicles, FrameworkFunctions)
        return true
    else
        Utils.DebugPrint("Failed to initialize framework:", Config.Framework)
        return false
    end
end

-- Rental Logic
local function SetupRentalBlips()
    for _, location in pairs(Config.RentalLocations) do
        local blip = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)
        SetBlipSprite(blip, location.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, location.blip.scale)
        SetBlipColour(blip, location.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(location.blip.label)
        EndTextCommandSetBlipName(blip)
    end
end

local function CheckRentalLocations()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local isNear, location = Utils.IsNearRentalLocation(playerCoords, Config.RentalLocations, 5.0)
    
    if isNear and not isNearRentalLocation then
        isNearRentalLocation = true
        currentRentalLocation = location
        if not activeRentalMenu then
            -- Show interaction prompt
            exports['qbx_core']:DrawText('[E] Open ' .. location.name, 'left')
        end
    elseif not isNear and isNearRentalLocation then
        isNearRentalLocation = false
        currentRentalLocation = nil
        if not activeRentalMenu then
            -- Hide interaction prompt
            exports['qbx_core']:HideText()
        end
    end
end

local function OpenRentalMenu()
    if not isNearRentalLocation or not currentRentalLocation then return end
    
    activeRentalMenu = true
    exports['qbx_core']:HideText()
    
    -- Get categories available at this location
    local availableCategories = {}
    for _, category in ipairs(currentRentalLocation.categories) do
        table.insert(availableCategories, {
            name = category,
            label = Vehicles.VehicleCategories[category].label,
            description = Vehicles.VehicleCategories[category].description,
            icon = Vehicles.VehicleCategories[category].icon
        })
    end
    
    -- Send NUI message to open the menu
    SendNUIMessage({
        action = 'openRentalMenu',
        data = {
            location = currentRentalLocation.name,
            categories = availableCategories,
            loyaltyPoints = loyaltyPoints,
            activeRentals = currentRentals
        }
    })
    
    -- Show cursor
    SetNuiFocus(true, true)
end

local function CloseRentalMenu()
    activeRentalMenu = false
    SetNuiFocus(false, false)
    
    if isNearRentalLocation and currentRentalLocation then
        exports['qbx_core']:DrawText('[E] Open ' .. currentRentalLocation.name, 'left')
    end
end

local function LoadVehiclesByCategory(category)
    local vehicles = Vehicles.GetVehiclesByCategory(category)
    if vehicles then
        SendNUIMessage({
            action = 'updateVehicles',
            data = vehicles
        })
    end
end

local function ViewVehicleDetails(model)
    local vehicle = Vehicles.GetVehicleByModel(model)
    if vehicle then
        SendNUIMessage({
            action = 'viewVehicleDetails',
            data = {
                vehicle = vehicle,
                durations = Config.RentalDurations,
                loyaltyDiscount = FrameworkFunctions.GetLoyaltyDiscount(loyaltyPoints)
            }
        })
    end
end

local function RentVehicle(data)
    if not currentRentalLocation then return false, "No rental location found" end
    
    local vehicleModel = data.model
    local duration = data.duration
    local totalCost = data.cost
    
    -- Check if player has enough money
    local canAfford = FrameworkFunctions.CheckMoney(totalCost)
    if not canAfford then
        return false, "You cannot afford this rental"
    end
    
    -- Get available spawn point
    local locationIndex = nil
    for i, loc in ipairs(Config.RentalLocations) do
        if loc.name == currentRentalLocation.name then
            locationIndex = i
            break
        end
    end
    
    if not locationIndex then
        return false, "Location not found"
    end
    
    local spawnIndex, spawnCoords = Utils.GetFreeSpawnPoint(Config.RentalLocations[locationIndex])
    if not spawnIndex then
        return false, "No available spawn points"
    end
    
    -- Charge player
    FrameworkFunctions.RemoveMoney(totalCost)
    
    -- Request vehicle model
    local hash = GetHashKey(vehicleModel)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
    
    -- Spawn vehicle
    local vehicle = CreateVehicle(hash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, true, false)
    SetVehicleNumberPlateText(vehicle, "RENT" .. math.random(100, 999))
    SetEntityAsMissionEntity(vehicle, true, true)
    
    -- Mark spawn point as occupied
    Utils.SetSpawnPointStatus(locationIndex, spawnIndex, true)
    
    -- Generate rental information
    local rentalId = Utils.GenerateRentalID()
    local rentalInfo = {
        id = rentalId,
        model = vehicleModel,
        plate = GetVehicleNumberPlateText(vehicle),
        startTime = os.time(),
        duration = duration,
        endTime = os.time() + (duration * 60),
        cost = totalCost,
        locationIndex = locationIndex,
        spawnIndex = spawnIndex,
        netId = NetworkGetNetworkIdFromEntity(vehicle)
    }
    
    -- Send event to server to save rental
    TriggerServerEvent('vein-rentals:server:saveRental', rentalInfo, GetPlayerServerId(PlayerId()))
    
    -- Add to active rentals
    table.insert(currentRentals, rentalInfo)
    
    -- Add loyalty points
    TriggerServerEvent('vein-rentals:server:addLoyaltyPoints', GetPlayerServerId(PlayerId()), Config.LoyaltyPointsPerRental)
    
    return true, "Vehicle rented successfully!"
end

local function UpdateRentalStatus()
    if #currentRentals == 0 then return end
    
    local currentTime = os.time()
    local updatedRentals = {}
    
    for _, rental in ipairs(currentRentals) do
        -- Calculate time remaining
        local timeRemaining = rental.endTime - currentTime
        if timeRemaining > 0 then
            -- Still active
            rental.timeRemaining = Utils.FormatTimeRemaining(math.floor(timeRemaining / 60))
            table.insert(updatedRentals, rental)
        else
            -- Rental has expired - calculate late fees
            local minutesLate = math.floor((currentTime - rental.endTime) / 60)
            if minutesLate > 0 then
                local hoursLate = math.ceil(minutesLate / 60)
                local lateFee = math.floor(rental.cost * Config.LateFee * hoursLate)
                
                rental.isOverdue = true
                rental.timeOverdue = Utils.FormatTimeRemaining(minutesLate)
                rental.lateFee = lateFee
                table.insert(updatedRentals, rental)
            end
        end
    end
    
    currentRentals = updatedRentals
    
    -- If menu is active, update the rentals list
    if activeRentalMenu then
        SendNUIMessage({
            action = 'updateActiveRentals',
            data = currentRentals
        })
    end
end

local function ReturnVehicle(rentalId)
    for i, rental in ipairs(currentRentals) do
        if rental.id == rentalId then
            -- Find vehicle
            local vehicle = NetworkGetEntityFromNetworkId(rental.netId)
            if DoesEntityExist(vehicle) then
                -- Check vehicle condition
                local engineHealth = GetVehicleEngineHealth(vehicle)
                local bodyHealth = GetVehicleBodyHealth(vehicle)
                
                local damageFee = 0
                if engineHealth < 700 or bodyHealth < 700 then
                    damageFee = math.floor(rental.cost * Config.DamageFee)
                    -- Charge damage fee
                    FrameworkFunctions.RemoveMoney(damageFee)
                    TriggerEvent('QBCore:Notify', 'Vehicle damage fee charged: $' .. damageFee, 'error')
                end
                
                -- Delete vehicle
                SetVehicleHasBeenOwnedByPlayer(vehicle, false)
                SetEntityAsMissionEntity(vehicle, false, true)
                DeleteVehicle(vehicle)
                
                -- Free up the spawn point
                Utils.SetSpawnPointStatus(rental.locationIndex, rental.spawnIndex, false)
                
                -- Pay late fee if applicable
                if rental.isOverdue and rental.lateFee then
                    FrameworkFunctions.RemoveMoney(rental.lateFee)
                    TriggerEvent('QBCore:Notify', 'Late return fee charged: $' .. rental.lateFee, 'error')
                end
                
                -- Remove from active rentals
                table.remove(currentRentals, i)
                
                -- Notify server
                TriggerServerEvent('vein-rentals:server:returnVehicle', rentalId, GetPlayerServerId(PlayerId()), damageFee)
                
                return true, "Vehicle returned successfully!"
            else
                -- Vehicle not found, possibly destroyed
                local replacementFee = math.floor(rental.cost * Config.ReplacementFee)
                
                -- Charge replacement fee
                FrameworkFunctions.RemoveMoney(replacementFee)
                
                -- Free up the spawn point
                Utils.SetSpawnPointStatus(rental.locationIndex, rental.spawnIndex, false)
                
                -- Remove from active rentals
                table.remove(currentRentals, i)
                
                -- Notify server
                TriggerServerEvent('vein-rentals:server:vehicleDestroyed', rentalId, GetPlayerServerId(PlayerId()), replacementFee)
                
                return true, "Vehicle replacement fee charged: $" .. replacementFee
            end
        end
    end
    
    return false, "Rental not found"
end

-- NUI Callbacks
RegisterNUICallback('closeMenu', function(data, cb)
    CloseRentalMenu()
    cb({})
end)

RegisterNUICallback('selectCategory', function(data, cb)
    LoadVehiclesByCategory(data.category)
    cb({})
end)

RegisterNUICallback('viewVehicleDetails', function(data, cb)
    ViewVehicleDetails(data.model)
    cb({})
end)

RegisterNUICallback('rentVehicle', function(data, cb)
    local success, message = RentVehicle(data)
    cb({ success = success, message = message })
    
    if success then
        CloseRentalMenu()
    end
end)

RegisterNUICallback('returnVehicle', function(data, cb)
    local success, message = ReturnVehicle(data.rentalId)
    cb({ success = success, message = message })
    
    if success then
        SendNUIMessage({
            action = 'updateActiveRentals',
            data = currentRentals
        })
    end
end)

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    playerLoaded = true
    -- Get player data from framework
    playerData = FrameworkFunctions.GetPlayerData()
    
    -- Load active rentals for player
    TriggerServerEvent('vein-rentals:server:getPlayerRentals', GetPlayerServerId(PlayerId()))
    
    -- Get loyalty points
    TriggerServerEvent('vein-rentals:server:getLoyaltyPoints', GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    playerLoaded = false
    currentRentals = {}
end)

RegisterNetEvent('vein-rentals:client:syncRentals', function(rentals)
    currentRentals = rentals
end)

RegisterNetEvent('vein-rentals:client:syncLoyaltyPoints', function(points)
    loyaltyPoints = points
end)

-- Key mapping for opening rental menu
RegisterCommand('openRentalMenu', function()
    if isNearRentalLocation and not activeRentalMenu then
        OpenRentalMenu()
    end
end, false)

RegisterKeyMapping('openRentalMenu', 'Open Vehicle Rental Menu', 'keyboard', 'E')

-- Initialization
CreateThread(function()
    Wait(1000) -- Give time for resource to load
    local success = InitializeFramework()
    if success then
        -- Initialize other components
        SetupRentalBlips()
        
        -- Get player rentals
        TriggerServerEvent('vein-rentals:server:getPlayerRentals', GetPlayerServerId(PlayerId()))
        TriggerServerEvent('vein-rentals:server:getLoyaltyPoints', GetPlayerServerId(PlayerId()))
    else
        print("^1[ERROR] Failed to initialize Vein Rentals^7")
    end
end)

-- Main loop for rental locations and status updates
CreateThread(function()
    while true do
        Wait(1000)
        if isInitialized then
            CheckRentalLocations()
            UpdateRentalStatus()
        end
    end
end)

-- Export functions
exports('GetVehicles', function() return Vehicles end)
exports('GetUtils', function() return Utils end)
exports('GetActiveRentals', function() return currentRentals end) 