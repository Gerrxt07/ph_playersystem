ph = {}
ph.version = "alpha-0.0.1"

ph.check_for_updates = true -- Set to true by default. If true, you will receive a notification in the console that there is a new update.
ph.maintenance = false -- Set to false by default. If set to true, only database registered admins can join. Other non-admin players will be kicked in-game if necessary.
ph.language = "en" -- Set to "en" by default. Available languages: en (English), de (German), es (Spanish), fr (French), ru (Russian).
ph.logging = true -- Set to true by default. If set to true, all actions will be logged in the console.

ph.vpncheck = false -- Set to false by default. If set to true, players with a VPN connection will be kicked. Not 100% accurate.

ph.discordwebhooklog = "" -- Set to "" by default. If set to "", the webhook will be disabled. Only working if logging is true.