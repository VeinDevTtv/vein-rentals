--[[ Vein Rentals - Vehicle Data ]]--

local Vehicles = {}

-- Vehicle Categories
Vehicles.VehicleCategories = {
    economy = {
        label = "Economy",
        description = "Affordable and fuel-efficient vehicles for everyday use.",
        icon = "car-hatchback"
    },
    luxury = {
        label = "Luxury",
        description = "Premium vehicles with top-tier comfort and performance.",
        icon = "car-sports"
    },
    sports = {
        label = "Sports",
        description = "High-performance sports cars for thrill-seekers.",
        icon = "car-sports"
    },
    utility = {
        label = "Utility",
        description = "Practical vehicles for work and everyday utility.",
        icon = "truck"
    }
}

-- Vehicle Data
Vehicles.VehicleList = {
    -- Economy Category
    {
        name = "Asbo",
        model = "asbo",
        category = "economy",
        rentalPrice = 75,
        basePrice = 4500,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133486132549300284/asbo.png",
        description = "A budget compact car perfect for city driving. Good on fuel and easy to park.",
        stats = {
            speed = 35,
            acceleration = 30,
            braking = 40,
            handling = 45
        }
    },
    {
        name = "Blista",
        model = "blista",
        category = "economy",
        rentalPrice = 85,
        basePrice = 5500,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133486318486736966/blista.png",
        description = "A reliable compact hatchback with decent performance and fuel economy.",
        stats = {
            speed = 40,
            acceleration = 35,
            braking = 45,
            handling = 50
        }
    },
    {
        name = "Dilettante",
        model = "dilettante",
        category = "economy",
        rentalPrice = 90,
        basePrice = 6000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133486534183305297/dilettante.png",
        description = "A hybrid vehicle with excellent fuel economy and a quiet ride.",
        stats = {
            speed = 35,
            acceleration = 30,
            braking = 50,
            handling = 45
        }
    },
    
    -- Luxury Category
    {
        name = "Cognoscenti",
        model = "cognoscenti",
        category = "luxury",
        rentalPrice = 250,
        basePrice = 30000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133486802727436368/cognoscenti.png",
        description = "A premium luxury sedan with a smooth ride and elegant styling.",
        stats = {
            speed = 60,
            acceleration = 55,
            braking = 65,
            handling = 55
        }
    },
    {
        name = "Schafter",
        model = "schafter2",
        category = "luxury",
        rentalPrice = 200,
        basePrice = 25000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133487005634273311/schafter.png",
        description = "A stylish luxury sedan with a perfect balance of comfort and performance.",
        stats = {
            speed = 65,
            acceleration = 60,
            braking = 60,
            handling = 65
        }
    },
    
    -- Sports Category
    {
        name = "Comet",
        model = "comet2",
        category = "sports",
        rentalPrice = 350,
        basePrice = 45000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133487169334517840/comet.png",
        description = "A high-performance sports car with incredible handling and speed.",
        stats = {
            speed = 80,
            acceleration = 85,
            braking = 75,
            handling = 85
        }
    },
    {
        name = "9F",
        model = "ninef",
        category = "sports",
        rentalPrice = 325,
        basePrice = 40000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133487319855730708/9f.png",
        description = "A sleek sports car with excellent performance and German engineering.",
        stats = {
            speed = 75,
            acceleration = 80,
            braking = 70,
            handling = 80
        }
    },
    
    -- Utility Category
    {
        name = "Bison",
        model = "bison",
        category = "utility",
        rentalPrice = 150,
        basePrice = 15000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133487447803420852/bison.png",
        description = "A sturdy pickup truck perfect for hauling and off-road adventures.",
        stats = {
            speed = 50,
            acceleration = 45,
            braking = 40,
            handling = 45
        }
    },
    {
        name = "Rumpo",
        model = "rumpo",
        category = "utility",
        rentalPrice = 120,
        basePrice = 12000,
        image = "https://cdn.discordapp.com/attachments/1121732742838849626/1133487544469250189/rumpo.png",
        description = "A spacious van ideal for moving cargo or equipment.",
        stats = {
            speed = 40,
            acceleration = 35,
            braking = 40,
            handling = 35
        }
    }
}

-- Vehicle Helper Functions

-- Get all vehicles by category
function Vehicles.GetVehiclesByCategory(category)
    local vehicles = {}
    for _, vehicle in ipairs(Vehicles.VehicleList) do
        if vehicle.category == category then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

-- Get vehicle by model
function Vehicles.GetVehicleByModel(model)
    for _, vehicle in ipairs(Vehicles.VehicleList) do
        if vehicle.model == model then
            return vehicle
        end
    end
    return nil
end

-- Export the vehicles module
function GetVehicles()
    return Vehicles
end

return Vehicles 