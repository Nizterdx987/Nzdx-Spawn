--[[ FX Information ]] --
fx_version                'cerulean'
use_experimental_fxv2_oal 'yes'
lua54                     'yes'
game                      'gta5'

shared_script {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}


