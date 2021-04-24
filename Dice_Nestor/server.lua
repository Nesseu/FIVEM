ESX						= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_dice:removemoney')
AddEventHandler('esx_dice:removemoney', function(amount)
	local amount = amount
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('Casino_El_Valle', amount)
end)

RegisterServerEvent('esx_dice:givemoney')
AddEventHandler('esx_dice:givemoney', function(amount)
	local amount = amount
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local win = amount*2
        xPlayer.addInventoryItem('Casino_El_Valle', win)
	
end)


--RegisterServerEvent('esx_dice:check_money')
--AddEventHandler('esx_dice:check_money', function(source, cb)
ESX.RegisterServerCallback('esx_dice:check_money', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem('Casino_El_Valle').count
	
	cb(quantity)
end)