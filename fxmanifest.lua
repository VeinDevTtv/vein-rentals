fx_version 'cerulean'
game 'gta5'

author 'vein'
description 'Vein Rentals - An advanced vehicle rental system for QBX/QBCore/ESX'
version '1.0.0'

shared_scripts {
    '@qbx_core/shared/locale.lua',
    'shared/config.lua',
    'shared/utils.lua',
    'shared/vehicles.lua'
}

client_scripts {
    'client/nui.lua',
    'client/framework/*.lua',
    'client/rentals.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/framework/*.lua',
    'server/database.lua',
    'server/main.lua'
}

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*'
}

lua54 'yes'

-- Export modules
exports {
    'GetConfig',
    'GetUtils',
    'GetVehicles',
    'GetActiveRentals',
    'GetDatabase',
    'GetQBXFramework',
    'GetQBCoreFramework',
    'GetESXFramework'
}

server_exports {
    'GetActiveRentals',
    'GetPlayerLoyaltyPoints'
}

dependencies {
    'qbx_core',
    'oxmysql'
} 