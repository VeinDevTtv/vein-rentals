-- NUI Message handler
local nuiReady = false
-- Config is loaded as a global
local Utils = nil
local Vehicles = nil

-- Store module references when they are loaded
RegisterNetEvent('vein-rentals:client:setModules', function(utils, vehicles)
    Utils = utils
    Vehicles = vehicles
    -- Config is already available globally
end)

-- Initialize NUI when ready
RegisterNUICallback('nuiReady', function(_, cb)
    nuiReady = true
    cb({
        colors = Config.UIColors
    })
end)

-- Send debug message to NUI (for dev purposes)
function SendDebugMessage(message)
    if Config.Debug and nuiReady then
        SendNUIMessage({
            action = 'debug',
            data = message
        })
    end
end

-- Show notification through NUI
function ShowNotification(message, type)
    if nuiReady then
        SendNUIMessage({
            action = 'notification',
            data = {
                message = message,
                type = type or 'info' -- 'info', 'success', 'warning', 'error'
            }
        })
    end
end

-- Update UI when config changes
RegisterNetEvent('vein-rentals:client:updateConfig', function(newConfig)
    Config = newConfig
    
    if nuiReady then
        SendNUIMessage({
            action = 'updateConfig',
            data = {
                colors = Config.UIColors
            }
        })
    end
end)

-- Register exports
exports('ShowNotification', ShowNotification) 