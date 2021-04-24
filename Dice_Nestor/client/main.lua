local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local booltrue                = false

--- esx
local GUI = {}
ESX                           = nil
GUI.Time                      = 0
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
 	PlayerData = ESX.GetPlayerData()
  end
end)


----markers
AddEventHandler('esx_duty:hasEnteredMarker', function (zone)
  if zone == 'Dice' or zone== 'Dice2' then
    CurrentAction     = 'dice_zone'
    CurrentActionData = {}
  end
  if zone == 'Dice3' then
    CurrentAction     = 'dice_apuesta'
    CurrentActionData = {}
  end
  if zone == 'Dice4' then
    CurrentAction     = 'dice_apuesta2'
    CurrentActionData = {}
  end
  if zone == 'Dice5' then
    CurrentAction     = 'dice_apuesta3'
    CurrentActionData = {}
  end
end)

AddEventHandler('esx_duty:hasExitedMarker', function (zone)
  CurrentAction = nil
end)


--keycontrols
Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)

      local playerPed = GetPlayerPed(-1)

    if CurrentAction ~= nil then
      --SetTextComponentFormat('STRING')
      --AddTextComponentString(CurrentActionMsg)
      --DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      DisplayHelpText("Presiona ~INPUT_CONTEXT~   ~y~para lanzar los dados")
      if IsControlPressed(0, Keys['E']) then
        if CurrentAction == 'dice_zone' then
            -- Interpret the number of sides
            local die = 6
            if 6 ~= nil and tonumber(6) then
                die = tonumber(6)
            end
        
            -- Interpret the number of rolls
            rolls = 1
            if 2 ~= nil and tonumber(2) then
                rolls = tonumber(2)
            end
        
            -- Roll and add up rolls
            local number = 0
            for i = rolls,1,-1
            do
                number = number + math.random(1,die)
            end
        
            --loadAnimDict("anim@mp_player_intcelebrationmale@wank")
            ExecuteCommand ("do Lanza dos dados")
            TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Citizen.Wait(3000)
            ClearPedTasks(GetPlayerPed(-1))
            --TriggerServerEvent('3dme:shareDisplay', 'Rolled a d' .. die .. ' ' .. rolls .. ' time(s): ' .. number)
            TriggerEvent('chatMessage', "[CASINO] ", {0, 128, 255}, 'Has tirado 2 dados, total: ' .. number)
            ExecuteCommand ("do Total de los dados " .. number)
              

          elseif CurrentAction == 'dice_apuesta' then
            local amount = 100
            TriggerEvent('dice:start')
            if booltrue == true then
              TriggerServerEvent('esx_dice:removemoney', amount)
                -- Interpret the number of sides
                local die = 6
                if 6 ~= nil and tonumber(6) then
                    die = tonumber(6)
                end
            
                -- Interpret the number of rolls
                rolls = 1
                if 2 ~= nil and tonumber(2) then
                    rolls = tonumber(2)
                end
            
                -- Roll and add up rolls
                local number = 0
                for i = rolls,1,-1
                do
                    number = number + math.random(1,die)
                end

                if number == 2 or number == 4 or number == 6 or number == 8 or number == 10 or number == 12 then
                local win = amount * 2
				        ESX.ShowNotification('Has ganado '..win..' fichas!')
				        TriggerServerEvent('esx_dice:givemoney', amount)
			          else
				          ESX.ShowNotification('No esta vez. Prueba otra vez! Buena suerte!')
			          end
              else
                ESX.ShowNotification('Necesitas 100 fichas!')
              end

              elseif CurrentAction == 'dice_apuesta2' then
                local amount = 300
                TriggerEvent('dice:start')
                if booltrue == true then
                  TriggerServerEvent('esx_dice:removemoney', amount)
                    -- Interpret the number of sides
                    local die = 6
                    if 6 ~= nil and tonumber(6) then
                        die = tonumber(6)
                    end
                
                    -- Interpret the number of rolls
                    rolls = 1
                    if 2 ~= nil and tonumber(2) then
                        rolls = tonumber(2)
                    end
                
                    -- Roll and add up rolls
                    local number = 0
                    for i = rolls,1,-1
                    do
                        number = number + math.random(1,die)
                    end
    
                    if number == 2 or number == 4 or number == 6 or number == 8 or number == 10 or number == 12 then
                    local win = amount * 2
                    --loadAnimDict("anim@mp_player_intcelebrationmale@wank")
                ExecuteCommand ("do Lanza dos dados")
                  TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                  Citizen.Wait(3000)
                  ClearPedTasks(GetPlayerPed(-1))
                  --TriggerServerEvent('3dme:shareDisplay', 'Rolled a d' .. die .. ' ' .. rolls .. ' time(s): ' .. number)
                  TriggerEvent('chatMessage', "[CASINO] ", {0, 128, 255}, 'Has tirado 2 dados, total: ' .. number)
                  ExecuteCommand ("do Total de los dados " .. number)     
                    ESX.ShowNotification('Has ganado '..win..' fichas!')
                    TriggerServerEvent('esx_dice:givemoney', amount)
                    else
                      ESX.ShowNotification('No esta vez. Prueba otra vez! Buena suerte!')
                    end
                  else
                    ESX.ShowNotification('Necesitas 300 fichas!')
                  end

                  elseif CurrentAction == 'dice_apuesta3' then
                    local amount = 600
                    TriggerEvent('dice:start')
                    if booltrue == true then
                      TriggerServerEvent('esx_dice:removemoney', amount)
                        -- Interpret the number of sides
                        local die = 6
                        if 6 ~= nil and tonumber(6) then
                            die = tonumber(6)
                        end
                    
                        -- Interpret the number of rolls
                        rolls = 1
                        if 2 ~= nil and tonumber(2) then
                            rolls = tonumber(2)
                        end
                    
                        -- Roll and add up rolls
                        local number = 0
                        for i = rolls,1,-1
                        do
                            number = number + math.random(1,die)
                        end
        
                        if number == 2 or number == 4 or number == 6 or number == 8 or number == 10 or number == 12 then
                        local win = amount * 2
                        --loadAnimDict("anim@mp_player_intcelebrationmale@wank")
                ExecuteCommand ("do Lanza dos dados")
                  TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                  Citizen.Wait(3000)
                  ClearPedTasks(GetPlayerPed(-1))
                  --TriggerServerEvent('3dme:shareDisplay', 'Rolled a d' .. die .. ' ' .. rolls .. ' time(s): ' .. number)
                  TriggerEvent('chatMessage', "[CASINO] ", {0, 128, 255}, 'Has tirado 2 dados, total: ' .. number)
                  ExecuteCommand ("do Total de los dados " .. number)     
                        ESX.ShowNotification('Has ganado '..win..' fichas!')
                        TriggerServerEvent('esx_dice:givemoney', amount)
                        else
                          ESX.ShowNotification('No esta vez. Prueba otra vez! Buena suerte!')
                        end
                      else
                        ESX.ShowNotification('Necesitas 600 fichas!')
                      end
                
            
                --loadAnimDict("anim@mp_player_intcelebrationmale@wank")
                ExecuteCommand ("do Lanza dos dados")
                TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                Citizen.Wait(3000)
                ClearPedTasks(GetPlayerPed(-1))
                --TriggerServerEvent('3dme:shareDisplay', 'Rolled a d' .. die .. ' ' .. rolls .. ' time(s): ' .. number)
                TriggerEvent('chatMessage', "[CASINO] ", {0, 128, 255}, 'Has tirado 2 dados, total: ' .. number)
                ExecuteCommand ("do Total de los dados " .. number)     

                
              end          
        function loadAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                RequestAnimDict( dict )
                Citizen.Wait(5)
            end
        
        
        end
      end
    end
  end       
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
-- Display markers
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_duty:hasExitedMarker', LastZone)
    end
  end
end)

--notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "duty",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end


RegisterNetEvent('dice:start')
AddEventHandler('dice:start', function()
	ESX.TriggerServerCallback('esx_dice:check_money', function(quantity)
		if quantity >= 10 then
            booltrue = true
			
		else
			--ESX.ShowNotification('You need at least 10 chips to play!!')
			booltrue = false
			
		end
	end, '')
end)