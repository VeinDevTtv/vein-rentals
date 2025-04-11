--[[ Vein Rentals - Client Rentals Management ]]--

-- This file handles rental vehicle tracking, return, and management
local QBCore = nil
local Utils = {}
local Vehicles = {}
local FrameworkFunctions = nil

-- Initialize after the main script has loaded
local isInitialized = false

RegisterNetEvent('vein-rentals:client:initialize', function(utilsExport, vehiclesExport, frameworkFuncs)
    Utils = utilsExport
    Vehicles = vehiclesExport
    FrameworkFunctions = frameworkFuncs
    isInitialized = true
end)

-- Function to return a rented vehicle
function ReturnRentedVehicle(rentalId, vehicle)
    if not isInitialized then return false, "System not initialized" end
    
    -- Calculate damage
    local engineHealth = GetVehicleEngineHealth(vehicle)
    local bodyHealth = GetVehicleBodyHealth(vehicle)
    local damageFee = 0
    
    -- Apply damage fee if vehicle is damaged
    if engineHealth < 900 or bodyHealth < 900 then
        -- Get rental details from store
        local rental = nil
        for _, r in ipairs(exports['vein-rentals']:GetActiveRentals()) do
            if r.id == rentalId then
                rental = r
                break
            end
        end
        
        if rental then
            damageFee = math.floor(rental.cost * Config.DamageFee)
        end
    end
    
    -- Send to server
    TriggerServerEvent('vein-rentals:server:returnVehicle', rentalId, GetPlayerServerId(PlayerId()), damageFee)
    
    -- Delete vehicle
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
    
    return true, "Vehicle returned successfully"
end

-- Function to check if a vehicle is rented by the player
function IsVehicleRented(plate)
    if not isInitialized then return false end
    
    for _, rental in ipairs(exports['vein-rentals']:GetActiveRentals()) do
        if rental.plate == plate then
            return true, rental
        end
    end
    
    return false, nil
end

-- Export functions
exports('ReturnRentedVehicle', ReturnRentedVehicle)
exports('IsVehicleRented', IsVehicleRented) 