fx_version 'cerulean'
game 'gta5'

author 'ykaa'
description 'Advanced Crafting Table For Craft Weapons'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}