-- Webhook-Funktion zum Senden von Nachrichten an einen Discord-Webhook
function SendWebhook(webhookURL, message)
  local webhookURL = ph.discordwebhooklog
  if webhookURL ~= "" then
      local postData = {
          content = message,
      } 
      PerformHttpRequest(webhookURL, function(_, _, _) end, 'POST', json.encode(postData), { ['Content-Type']= 'application/json' })
  end
end

-- Event, der beim Start der Ressource ausgeführt wird
AddEventHandler("onResourceStart", function()
  -- Update-Check
    if ph.check_for_updates == true then
      local currentVersion = ph.version
  
      PerformHttpRequest("https://api.github.com/repos/Gerrxt07/ph_system/releases/latest", function(responseCode, resultData, resultHeaders)
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

-- Wird ausgelöst, wenn ein Spieler versucht sich zu verbinden
AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
  local source = source
  local identifiers = GetPlayerIdentifiers(source)
  local discordId = nil
  -- Suche nach der Discord-ID des Spielers
  for _, identifier in ipairs(identifiers) do
      if string.find(identifier, "discord:") then
          discordId = string.sub(identifier, 9)
          break
      end
  end

  if discordId then
    deferrals.defer() -- Verbindung pausieren
    local playerName = GetPlayerName(source)
    local playerIP = GetPlayerEndpoint(source)
    -- Prüft, ob der Spieler auf der Whitelist steht (innerhalb einer Funktion, um die Whitelist-Überprüfung zu kapseln)
    local function CheckWhitelist(discordId, deferrals)
        MySQL.Async.fetchAll("SELECT * FROM phuser WHERE discord_id = @discordId AND player_name = @playerName", {
            ["@discordId"] = discordId,
            ["@playerName"] = playerName 
        }, function(result)
          -- Wenn der Spieler gefunden wurde:
        if result and #result > 0 then
          if ph.maintenance == true then -- Wenn Wartungsmodus aktiv ist
            MySQL.Async.fetchAll("SELECT admin FROM phuser WHERE discord_id = @discordid", {
              ["@discordid"] = discordId
          }, function(adminResult) -- Prüfen, ob Spieler Admin-Rechte hat
              if adminResult[1].admin == "true" then -- Wenn Spieler Admin ist
                  print("^2[PH]: " .. GetPlayerName(source) .. " (Admin) " .. Locales[ph.language]['player_joined'])
                  deferrals.done()
              else -- Wenn Spieler kein Admin ist
                  deferrals.done(Locales[ph.language]['maintenance_mode'])
              end
          end)
      else -- Wenn Wartungsmodus nicht aktiv
        
        -- // VPN CHECK // --
        print("before vpn check")
        if ph.vpncheck == true then
          print("vpn check")
          PerformHttpRequest("http://ip-api.com/json/" .. playerIP, function(errorCode, resultData, resultHeaders)
            if errorCode == 200 then
              print("after vpn check")
              local result = json.decode(resultData)
              print(result.proxy)
              if result.proxy == true then
                print("^1[PH]: " .. GetPlayerName(source) .. Locales[ph.language]['player_triedjoin'] .. " (IP: " .. playerIP .. ", Discord: " .. discordId .. ")")
                deferrals.done(Locales[ph.language]['vpn_detected'])
                return
              end
            end
          end)
        end

        -- IP aktualisieren und Spieler normal verbinden lassen
          MySQL.Async.execute("UPDATE phuser SET ip = @ip WHERE player_name = @playerName", {
          ['@ip'] = playerIP,
          ['@playerName'] = playerName
            })
            print("^2[PH]: " .. GetPlayerName(source) .. Locales[ph.language]['player_joined'] .. " (IP: " .. playerIP .. ")")
            deferrals.done()
          end
        else -- Wenn Spieler nicht gefunden wurde
            print("^1[PH]: " .. GetPlayerName(source) .. Locales[ph.language]['player_triedjoin'] .. " (IP: " .. playerIP .. ", Discord: " .. discordId .. ")")
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