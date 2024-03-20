-- Author: Gerrxt
-- Version: alpha-0.0.1

fx_version 'cerulean'
game 'gta5'

author 'Gerrxt'
description 'Phantomscripts Playersystem'
version 'alpha-0.0.1'

server_scripts {
    'server/sv_*.lua'
}

shared_scripts {
    '@oxmysql/lib/MySQL.lua', -- Please install the latest version of oxmysql before using this script - Download it here: https://github.com/overextended/oxmysql/releases
    'shared/sh_*.lua'
}

dependencies {
    'oxmysql'
}

lua54 'yes'