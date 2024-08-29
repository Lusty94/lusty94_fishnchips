fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'Lusty94'

description 'Fish n Chips Restaurant Script For QB-Core'

version '1.0.0'


client_scripts {
    'client/fishnchips_client.lua',
    'shared/targets.lua',
    'shared/menus.lua',
}

server_scripts {
    'server/fishnchips_server.lua',
    'shared/billing.lua',
} 

shared_scripts { 
	'shared/config.lua',
    '@ox_lib/init.lua'
}


escrow_ignore {
    'shared/**.lua',
    'client/**.lua',
    'server/**.lua',
}

