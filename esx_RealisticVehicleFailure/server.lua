------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function checkWhitelist(id)
	for key, value in pairs(RepairWhitelist) do
		if id == value then
			return true
		end
	end	
	return false
end

RegisterCommand("repair", function(source, _, message)
	CancelEvent()
	if RepairEveryoneWhitelisted == true then
		TriggerClientEvent('iens:repair', source)
	else
		if checkWhitelist(identifier) then
			TriggerClientEvent('iens:repair', source)
		else
			TriggerClientEvent('iens:notAllowed', source)
		end
	end
end, false)

RegisterServerEvent('rvFailure:takemoney')
AddEventHandler('rvFailure:takemoney', function(repairCost)
	local xPlayer = ESX.GetPlayerFromId(source)			
	xPlayer.removeMoney(repairCost)
end)