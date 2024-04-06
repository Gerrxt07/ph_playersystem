RegisterCommand("id", function(source, args)
    if source == 0 then
        local playerId = GetPlayerServerId(PlayerId())
        TriggerEvent("chat:addMessage", {
            args = {Locales[ph.language]['cl_cmd_id'] .. playerId} 
        })
    end
end, false) 

AddEventHandler('playerConnecting', function(playerName)
    local source = source
    local playerName = GetPlayerName(source)
    local playerIngameID = GetPlayerServerId(source)
    MySQL.Async.execute("UPDATE phuser SET ingame_id = @ingameId WHERE player_name = @playerName", {
        ['@ingameId'] = playerIngameID,
        ['@playerName'] = playerName
    })
end)