RegisterCommand("id", function(source, args)
    if source == 0 then
        local playerId = GetPlayerServerId(PlayerId())
        TriggerEvent("chat:addMessage", {
            args = {Locales[ph.language]['cl_cmd_id'] .. playerId} 
        })
    end
end, false) 
