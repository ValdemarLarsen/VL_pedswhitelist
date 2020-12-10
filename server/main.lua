

local debugPrints = false

RegisterServerEvent('VL_pedswhitelist:verifyPed')
AddEventHandler('VL_pedswhitelist:verifyPed', function(data)
  local _source = source
  local ids = GetPlayerIdentifiers(source)
  local steamid = getSteamID(ids)
  debugPrint(data)
  if ids ~= nil and #ids > 0 and steamid ~= nil then
    debugPrint(steamid)
    MySQL.Async.fetchAll("SELECT id FROM ped_access WHERE steamid = @steamid AND model = @model",
    {
      ['@steamid'] = steamid,
      ['@model'] = data
    },
    function(result)
      if #result > 0 then
        debugPrint(true)
      else
        debugPrint(false)
        TriggerClientEvent("VL_pedswhitelist:setDefaultModel", _source)
      end
    end)
  else
    debugPrint(false)
    TriggerClientEvent("VL_pedswhitelist:setDefaultModel", _source)
  end
end)

function getSteamID(ids)
  for k,v in ipairs(ids) do
      if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" then
          return v
      end
  end
  return nil
end

function debugPrint(text)
  if debugPrints then
    print(text)
  end
end