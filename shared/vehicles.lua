local Config = {}

-- Vehicle categories
Config.VehicleCategories = {
    economy = {
        label = "Economy",
        description = "Affordable vehicles for daily commuting",
        icon = "car"
    },
    luxury = {
        label = "Luxury",
        description = "Premium vehicles for a refined driving experience",
        icon = "car-side"
    },
    sports = {
        label = "Sports",
        description = "High-performance vehicles for speed enthusiasts",
        icon = "car-sports"
    },
    utility = {
        label = "Utility",
        description = "Versatile vehicles for work and transport",
        icon = "truck"
    }
}

-- Rental vehicles
Config.RentalVehicles = {
    -- Economy Class
    {
        name = "Asbo",
        model = "asbo",
        category = "economy",
        price = 15000,
        rentalPrice = 150, -- Base rental price per hour
        description = "Compact and fuel-efficient city car",
        stats = {
            speed = 30,
            acceleration = 25,
            handling = 40,
            braking = 35
        },
        image = "https://i.imgur.com/7Vf5W1a.png"
    },
    {
        name = "Blista",
        model = "blista",
        category = "economy",
        price = 18000,
        rentalPrice = 180,
        description = "Reliable compact hatchback with good fuel economy",
        stats = {
            speed = 35,
            acceleration = 30,
            handling = 45,
            braking = 40
        },
        image = "https://i.imgur.com/8zdQiAT.png"
    },
    {
        name = "Dilettante",
        model = "dilettante",
        category = "economy",
        price = 20000,
        rentalPrice = 200,
        description = "Eco-friendly hybrid with excellent fuel efficiency",
        stats = {
            speed = 30,
            acceleration = 25,
            handling = 40,
            braking = 35
        },
        image = "https://i.imgur.com/gQZ1gyd.png"
    },
    
    -- Luxury Class
    {
        name = "Cognoscenti",
        model = "cognoscenti",
        category = "luxury",
        price = 75000,
        rentalPrice = 750,
        description = "Executive sedan with premium comfort features",
        stats = {
            speed = 60,
            acceleration = 55,
            handling = 50,
            braking = 60
        },
        image = "https://i.imgur.com/2QgKnUi.png"
    },
    {
        name = "Schafter",
        model = "schafter2",
        category = "luxury",
        price = 65000,
        rentalPrice = 650,
        description = "German-engineered luxury sedan with balanced performance",
        stats = {
            speed = 65,
            acceleration = 60,
            handling = 60,
            braking = 65
        },
        image = "https://i.imgur.com/Hr9XxXO.png"
    },
    {
        name = "Oracle",
        model = "oracle",
        category = "luxury",
        price = 60000,
        rentalPrice = 600,
        description = "Elegant coupe with a smooth ride and premium interior",
        stats = {
            speed = 60,
            acceleration = 55,
            handling = 55,
            braking = 60
        },
        image = "https://i.imgur.com/AF0Aeha.png"
    },
    
    -- Sports Class
    {
        name = "Buffalo",
        model = "buffalo",
        category = "sports",
        price = 85000,
        rentalPrice = 850,
        description = "American muscle car with aggressive styling",
        stats = {
            speed = 75,
            acceleration = 70,
            handling = 65,
            braking = 70
        },
        image = "https://i.imgur.com/3AJxwJK.png"
    },
    {
        name = "Elegy",
        model = "elegy2",
        category = "sports",
        price = 95000,
        rentalPrice = 950,
        description = "Japanese-inspired sports car with excellent handling",
        stats = {
            speed = 80,
            acceleration = 75,
            handling = 80,
            braking = 75
        },
        image = "https://i.imgur.com/hCOb8PU.png"
    },
    {
        name = "Comet",
        model = "comet2",
        category = "sports",
        price = 100000,
        rentalPrice = 1000,
        description = "Precision-engineered sports car with balanced performance",
        stats = {
            speed = 85,
            acceleration = 80,
            handling = 85,
            braking = 80
        },
        image = "https://i.imgur.com/SH3Wfgu.png"
    },
    
    -- Utility Class
    {
        name = "Bison",
        model = "bison",
        category = "utility",
        price = 45000,
        rentalPrice = 450,
        description = "Dependable pickup truck for work and utility",
        stats = {
            speed = 50,
            acceleration = 45,
            handling = 40,
            braking = 45
        },
        image = "https://i.imgur.com/5pejz7Q.png"
    },
    {
        name = "Surfer",
        model = "surfer",
        category = "utility",
        price = 35000,
        rentalPrice = 350,
        description = "Classic van with spacious interior",
        stats = {
            speed = 35,
            acceleration = 30,
            handling = 35,
            braking = 30
        },
        image = "https://i.imgur.com/Ftw0xR0.png"
    },
    {
        name = "Rumpo",
        model = "rumpo",
        category = "utility",
        price = 40000,
        rentalPrice = 400,
        description = "Commercial van with ample cargo space",
        stats = {
            speed = 40,
            acceleration = 35,
            handling = 35,
            braking = 35
        },
        image = "https://i.imgur.com/4pP1Aum.png"
    }
}

-- Utility function to get vehicle by model
Config.GetVehicleByModel = function(model)
    for _, vehicle in ipairs(Config.RentalVehicles) do
        if vehicle.model == model then
            return vehicle
        end
    end
    return nil
end

-- Utility function to get vehicles by category
Config.GetVehiclesByCategory = function(category)
    local vehicles = {}
    for _, vehicle in ipairs(Config.RentalVehicles) do
        if vehicle.category == category then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

return Config 