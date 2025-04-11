local Database = {}
local Utils = require('shared.utils')

-- Initialize database tables
function Database.Initialize()
    local rentalsTable = [[
        CREATE TABLE IF NOT EXISTS vein_rentals (
            id VARCHAR(50) PRIMARY KEY,
            player_id VARCHAR(50) NOT NULL,
            model VARCHAR(50) NOT NULL,
            plate VARCHAR(50) NOT NULL,
            start_time INTEGER NOT NULL,
            duration INTEGER NOT NULL,
            end_time INTEGER NOT NULL,
            cost INTEGER NOT NULL,
            status VARCHAR(50) DEFAULT 'active',
            damage_fee INTEGER DEFAULT 0,
            replacement_fee INTEGER DEFAULT 0,
            late_fee INTEGER DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]]
    
    local loyaltyTable = [[
        CREATE TABLE IF NOT EXISTS vein_loyalty (
            player_id VARCHAR(50) PRIMARY KEY,
            points INTEGER DEFAULT 0,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]]
    
    MySQL.Async.execute(rentalsTable, {}, function(rowsChanged)
        Utils.DebugPrint("Created rentals table")
    end)
    
    MySQL.Async.execute(loyaltyTable, {}, function(rowsChanged)
        Utils.DebugPrint("Created loyalty table")
    end)
end

-- Save rental to database
function Database.SaveRental(rental)
    local params = {
        id = rental.id,
        player_id = rental.playerId,
        model = rental.model,
        plate = rental.plate,
        start_time = rental.startTime,
        duration = rental.duration,
        end_time = rental.endTime,
        cost = rental.cost,
        status = 'active'
    }
    
    local query = [[
        INSERT INTO vein_rentals (id, player_id, model, plate, start_time, duration, end_time, cost, status)
        VALUES (@id, @player_id, @model, @plate, @start_time, @duration, @end_time, @cost, @status)
    ]]
    
    local success = MySQL.Sync.execute(query, params)
    return success > 0
end

-- Update rental status in database
function Database.UpdateRentalStatus(rentalId, status, fees)
    local params = {
        id = rentalId,
        status = status
    }
    
    local query = [[
        UPDATE vein_rentals
        SET status = @status
    ]]
    
    if fees then
        if fees.damageFee and fees.damageFee > 0 then
            query = query .. ", damage_fee = @damage_fee"
            params.damage_fee = fees.damageFee
        end
        
        if fees.replacementFee and fees.replacementFee > 0 then
            query = query .. ", replacement_fee = @replacement_fee"
            params.replacement_fee = fees.replacementFee
        end
        
        if fees.lateFee and fees.lateFee > 0 then
            query = query .. ", late_fee = @late_fee"
            params.late_fee = fees.lateFee
        end
    end
    
    query = query .. " WHERE id = @id"
    
    local success = MySQL.Sync.execute(query, params)
    return success > 0
end

-- Get player's active rentals
function Database.GetPlayerRentals(playerId)
    local query = [[
        SELECT * FROM vein_rentals
        WHERE player_id = @player_id AND status = 'active'
    ]]
    
    local result = MySQL.Sync.fetchAll(query, {
        player_id = playerId
    })
    
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
                timeRemaining = Utils.FormatTimeRemaining(math.floor((rental.end_time - os.time()) / 60))
            })
        end
        return rentals
    end
    
    return {}
end

-- Get player's loyalty points
function Database.GetLoyaltyPoints(playerId)
    local query = [[
        SELECT points FROM vein_loyalty
        WHERE player_id = @player_id
    ]]
    
    local result = MySQL.Sync.fetchScalar(query, {
        player_id = playerId
    })
    
    return result or 0
end

-- Update player's loyalty points
function Database.UpdateLoyaltyPoints(playerId, points)
    local query = [[
        INSERT INTO vein_loyalty (player_id, points, updated_at)
        VALUES (@player_id, @points, CURRENT_TIMESTAMP)
        ON DUPLICATE KEY UPDATE
        points = @points,
        updated_at = CURRENT_TIMESTAMP
    ]]
    
    local success = MySQL.Sync.execute(query, {
        player_id = playerId,
        points = points
    })
    
    return success > 0
end

-- Get rental statistics
function Database.GetRentalStats()
    local query = [[
        SELECT
            COUNT(*) as total_rentals,
            SUM(cost) as total_revenue,
            SUM(damage_fee) as total_damage_fees,
            SUM(replacement_fee) as total_replacement_fees,
            SUM(late_fee) as total_late_fees
        FROM vein_rentals
    ]]
    
    local result = MySQL.Sync.fetchAll(query, {})
    return result[1]
end

return Database 