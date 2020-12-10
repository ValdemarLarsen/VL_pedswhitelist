

local defaultModel = "mp_m_freemode_01"
local loaded = false

Citizen.CreateThread(function()
  local lastModel = nil
  local mhash = GetHashKey(defaultModel)
  while true do
    local ped = GetPlayerPed(-1)
    local currentModel = GetEntityModel(ped)
    if loaded == true and currentModel ~= nil and currentModel ~= lastModel and currentModel ~= 0 and currentModel ~= mhash then
      lastModel = GetEntityModel(ped)
      TriggerServerEvent("VL_pedswhitelist:verifyPed", tostring(lastModel))
    end
    Citizen.Wait(1000)
  end
end)

RegisterNetEvent("VL_pedswhitelist:setDefaultModel")
AddEventHandler("VL_pedswhitelist:setDefaultModel", function()
  local mhash = GetHashKey(defaultModel)
	RequestModel(mhash)
  while not HasModelLoaded(mhash) do
    Citizen.Wait(0)
  end
  SetPlayerModel(PlayerId(), mhash)
  SetModelAsNoLongerNeeded(mhash)
  drawNotification("Du har ikke adgang til denne ped model")
end)

function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

AddEventHandler("playerSpawned",function()
  Citizen.CreateThread(function()
    Citizen.Wait(30000)
    loaded = true
  end)
end)