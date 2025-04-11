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
    'client/main.lua',
    'client/rentals.lua',
    'client/nui.lua',
    'client/framework/*.lua'
}

server_scripts {
    'server/main.lua',
    'server/database.lua',
    'server/framework/*.lua'
}

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*'
}

lua54 'yes'

dependencies {
    'qbx_core'
} 