function SendWebhook(webhookURL, message)
  local webhookURL = ph.discordwebhooklog
  if webhookURL ~= "" then
      local postData = {
          content = message,
      } 
      PerformHttpRequest(webhookURL, function(_, _, _) end, 'POST', json.encode(postData), { ['Content-Type']= 'application/json' })
  end
end

AddEventHandler("onResourceStart", function()
    if ph.check_for_updates == true then
      local currentVersion = ph.version
  
      PerformHttpRequest("https://api.github.com/repos/Gerrxt07/ph_playersystem/releases/latest", function(responseCode, resultData, resultHeaders)
        if responseCode == 200 then
          local releaseData = json.decode(resultData)
          local latestVersion = releaseData.tag_name
  
          if currentVersion < latestVersion then
            if ph.discordwebhooklog ~= "" and ph.logging and currentVersion < latestVersion then 
              local message = Locales[ph.language]['new_update']
              local discordmessage = string.sub(message, 9)
              SendWebhook(ph.discordwebhooklog, discordmessage)
            end
            local message = Locales[ph.language]['new_update']
            print(message)
          else
            print(Locales[ph.language]['no_update_server'])
          end
        end
      end, "GET", "", {})
    end
  
    print(Locales[ph.language]['script_started'])
end)

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
  local source = source
  local identifiers = GetPlayerIdentifiers(source)
  local discordId = nil

  for _, identifier in ipairs(identifiers) do
      if string.find(identifier, "discord:") then
          discordId = string.sub(identifier, 9)
          break
      end
  end

  if discordId then
    deferrals.defer()
    local playerName = GetPlayerName(source)
    local playerIP = GetPlayerEndpoint(source)

    local function CheckWhitelist(discordId, deferrals)
        MySQL.Async.fetchAll("SELECT * FROM whitelist WHERE discord_id = @discordId AND player_name = @playerName", {
            ["@discordId"] = discordId,
            ["@playerName"] = playerName 
        }, function(result)

        if result and #result > 0 then
          if ph.maintenance == true then
            MySQL.Async.fetchAll("SELECT admin FROM whitelist WHERE discord_id = @discordid", {
              ["@discordid"] = discordId
          }, function(adminResult)
              if adminResult[1].admin == "true" then
                MySQL.Async.execute("UPDATE whitelist SET ip = @ip WHERE player_name = @playerName", {
                  ['@ip'] = playerIP,
                  ['@playerName'] = playerName
                })
                  print("^2[PH]: " .. GetPlayerName(source) .. " (Admin) " .. Locales[ph.language]['player_joined'])
                  deferrals.done()
              else
                  deferrals.done(Locales[ph.language]['maintenance_mode'])
              end
          end)
      else
          MySQL.Async.execute("UPDATE whitelist SET ip = @ip WHERE player_name = @playerName", {
          ['@ip'] = playerIP,
          ['@playerName'] = playerName
            })
            print("^2[PH]: " .. GetPlayerName(source) .. Locales[ph.language]['player_joined'])
            deferrals.done()
          end
        else
            deferrals.done(Locales[ph.language]['player_notwhitelisted'])
        end
    end)
    end
    CheckWhitelist(discordId, deferrals)
  else
      deferrals.done(Locales[ph.language]['player_nodiscord'])
      return
  end
end)