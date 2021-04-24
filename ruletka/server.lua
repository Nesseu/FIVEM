ESX						= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_roulette:removemoney')
AddEventHandler('esx_roulette:removemoney', function(amount)
	local amount = amount
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('Casino_El_Valle', amount)
end)

RegisterServerEvent('esx_roulette:givemoney')
AddEventHandler('esx_roulette:givemoney', function(action, amount)
	local aciton = aciton
	local amount = amount
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if action == 'black' or action == 'red' then
		local win = amount*2
		xPlayer.addInventoryItem('Casino_El_Valle', win)
	elseif action == 'green' then
		local win = amount*14
		xPlayer.addInventoryItem('Casino_El_Valle', win)
	else
	end
end)

ESX.RegisterServerCallback('esx_roulette:check_money', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem('Casino_El_Valle').count
	
	cb(quantity)
end)