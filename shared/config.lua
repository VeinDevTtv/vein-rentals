Config = {}

-- General settings
Config.Framework = 'qbx' -- 'qbx', 'qbcore', or 'esx'
Config.Debug = false

-- Rental settings
Config.RentalLocations = {
    {
        name = "Premium Deluxe Motorsport",
        coords = vector4(-30.51, -1089.96, 26.42, 340.0),
        blip = {
            sprite = 225,
            color = 4,
            scale = 0.8,
            label = "Vehicle Rentals"
        },
        categories = {'economy', 'luxury', 'sports', 'utility'}, -- Available vehicle categories at this location
        spawn = {
            {coords = vector4(-23.65, -1094.27, 26.75, 158.35), occupied = false},
            {coords = vector4(-28.29, -1095.9, 26.75, 158.35), occupied = false},
            {coords = vector4(-32.88, -1097.53, 26.75, 158.35), occupied = false}
        }
    },
    {
        name = "Airport Car Rentals",
        coords = vector4(-1034.86, -2731.55, 20.17, 240.15),
        blip = {
            sprite = 225,
            color = 4,
            scale = 0.8,
            label = "Airport Rentals"
        },
        categories = {'economy', 'utility'}, -- Only economy and utility vehicles available at the airport
        spawn = {
            {coords = vector4(-1040.23, -2727.22, 20.17, 240.15), occupied = false},
            {coords = vector4(-1044.52, -2722.32, 20.17, 240.15), occupied = false},
            {coords = vector4(-1048.81, -2717.42, 20.17, 240.15), occupied = false}
        }
    }
}

-- Rental duration and pricing
Config.RentalDurations = {
    {
        label = "1 Hour",
        time = 60, -- minutes
        priceMultiplier = 0.1 -- 10% of vehicle base price
    },
    {
        label = "3 Hours",
        time = 180,
        priceMultiplier = 0.2 -- 20% of vehicle base price
    },
    {
        label = "1 Day",
        time = 1440,
        priceMultiplier = 0.5 -- 50% of vehicle base price
    },
    {
        label = "3 Days",
        time = 4320,
        priceMultiplier = 1.0 -- 100% of vehicle base price
    }
}

-- Penalties
Config.LateFee = 0.1 -- 10% of rental cost per hour late
Config.DamageFee = 0.5 -- 50% of rental cost if vehicle is damaged
Config.ReplacementFee = 2.0 -- 200% of rental cost if vehicle is destroyed

-- Loyalty program
Config.EnableLoyalty = true
Config.LoyaltyPointsPerRental = 5
Config.LoyaltyDiscounts = {
    [50] = 0.05, -- 5% discount after 50 points
    [100] = 0.1, -- 10% discount after 100 points
    [200] = 0.15 -- 15% discount after 200 points
}

-- UI Settings
Config.UIColors = {
    primary = "#3f51b5",
    secondary = "#f44336",
    accent = "#4caf50",
    background = "#f5f5f5",
    text = "#212121"
}

return Config 