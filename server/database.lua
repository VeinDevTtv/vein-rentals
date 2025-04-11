--[[ Vein Rentals - Database Management ]]--

local Utils = nil
local Database = {}

-- Receive Utils module from main script
RegisterNetEvent('vein-rentals:server:setModules', function(utils)
    Utils = utils
end)

-- Tables
local RENTALS_TABLE = 'vein_rentals'
local LOYALTY_TABLE = 'vein_loyalty_points'

-- Initialize database tables
function Database.Initialize()
    -- Create rentals table if it doesn't exist
    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS ]] .. RENTALS_TABLE .. [[ (
            id VARCHAR(20) PRIMARY KEY,
            player_id VARCHAR(50) NOT NULL,
            model VARCHAR(50) NOT NULL,
            plate VARCHAR(10) NOT NULL,
            start_time INT NOT NULL,
            duration INT NOT NULL,
            end_time INT NOT NULL,
            cost INT NOT NULL,
            location_index INT NOT NULL,
            spawn_index INT NOT NULL,
            status VARCHAR(20) DEFAULT 'active',
            damage_fee INT DEFAULT 0,
            replacement_fee INT DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]])
    
    -- Create loyalty points table if it doesn't exist
    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS ]] .. LOYALTY_TABLE .. [[ (
            player_id VARCHAR(50) PRIMARY KEY,
            points INT DEFAULT 0,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
    ]])
    
    Utils.DebugPrint("Database tables initialized")
end

-- Save rental to database
function Database.SaveRental(rental)
    local query = [[
        INSERT INTO ]] .. RENTALS_TABLE .. [[ 
        (id, player_id, model, plate, start_time, duration, end_time, cost, location_index, spawn_index, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'active')
    ]]
    
    local success = MySQL.insert.await(query, {
        rental.id,
        rental.playerId,
        rental.model,
        rental.plate,
        rental.startTime,
        rental.duration,
        rental.endTime,
        rental.cost,
        rental.locationIndex,
        rental.spawnIndex
    })
    
    return success ~= nil
end

-- Update rental status
function Database.UpdateRentalStatus(rentalId, status, fees)
    local query = "UPDATE " .. RENTALS_TABLE .. " SET status = ?"
    local params = {status}
    
    if fees then
        if fees.damageFee and fees.damageFee > 0 then
            query = query .. ", damage_fee = ?"
            table.insert(params, fees.damageFee)
        end
        
        if fees.replacementFee and fees.replacementFee > 0 then
            query = query .. ", replacement_fee = ?"
            table.insert(params, fees.replacementFee)
        end
    end
    
    query = query .. " WHERE id = ?"
    table.insert(params, rentalId)
    
    local success = MySQL.update.await(query, params)
    return success ~= nil
end

-- Get player rentals
function Database.GetPlayerRentals(playerId)
    local query = [[
        SELECT * FROM ]] .. RENTALS_TABLE .. [[
        WHERE player_id = ? AND status = 'active'
    ]]
    
    local result = MySQL.query.await(query, {playerId})
    
    -- Format to match client expectations
    if result and #result > 0 then
        local rentals = {}
        for _, rental in ipairs(result) do
            table.insert(rentals, {
                id = rental.id,
                model = rental.model,
                plate = rental.plate,
                startTime = rental.start_time,
                duration = rental.duration,
                endTime = rental.end_time,
                cost = rental.cost,
                locationIndex = rental.location_index,
                spawnIndex = rental.spawn_index
            })
        end
        return rentals
    end
    
    return {}
end

-- Get loyalty points
function Database.GetLoyaltyPoints(playerId)
    local query = [[
        SELECT points FROM ]] .. LOYALTY_TABLE .. [[
        WHERE player_id = ?
    ]]
    
    local result = MySQL.query.await(query, {playerId})
    
    if result and #result > 0 then
        return result[1].points
    end
    
    -- Insert new record if player not found
    MySQL.insert.await("INSERT INTO " .. LOYALTY_TABLE .. " (player_id, points) VALUES (?, 0)", {playerId})
    return 0
end

-- Update loyalty points
function Database.UpdateLoyaltyPoints(playerId, points)
    local query = [[
        INSERT INTO ]] .. LOYALTY_TABLE .. [[ (player_id, points)
        VALUES (?, ?)
        ON DUPLICATE KEY UPDATE points = ?
    ]]
    
    local success = MySQL.update.await(query, {playerId, points, points})
    return success ~= nil
end

-- Export database module
function GetDatabase()
    return Database
end

return Database 