-- NUI Message handler
local nuiReady = false

-- Export functions for NUI
exports('GetVehicles', function()
    return require('shared.vehicles')
end)

exports('GetUtils', function()
    return require('shared.utils')
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