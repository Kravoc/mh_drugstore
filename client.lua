keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
	['G'] = 0x5415BE48,
	['E'] = 0xDFF812F9
}



Citizen.CreateThread(function()
	WarMenu.CreateMenu('DrugMenu', 'Drug Store')
	WarMenu.CreateSubMenu('Health', 'DrugMenu', 'Health')
	WarMenu.CreateSubMenu('Pick Me Up', 'DrugMenu', 'Pick Me Up')
	WarMenu.CreateSubMenu('Mixtures', 'DrugMenu', 'Mixtures')
	WarMenu.CreateSubMenu('Poisons & Solutions', 'DrugMenu', 'Poisons & Solutions')
	WarMenu.SetSubTitle('DrugMenu', 'Drug list')
 	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if WarMenu.IsMenuOpened('DrugMenu') then
			    if WarMenu.MenuButton('Health', 'Health') then end
				if WarMenu.MenuButton('Pick Me Up', 'Pick Me Up') then end
				if WarMenu.MenuButton('Mixtures', 'Mixtures') then end
				if WarMenu.MenuButton('Poisons & Solutions', 'Poisons & Solutions') then end
				WarMenu.Display()
				elseif WarMenu.IsMenuOpened('Health') then 
				if WarMenu.Button('Bandage 18$ level require [0]') then
						TriggerServerEvent('mh:buydrug', 18, 'Bandage', 0)
					elseif WarMenu.Button('Health Kit 25$ level require [0]') then
						TriggerServerEvent('mh:buydrug', 25, 'Health Kit', 0)
					elseif WarMenu.Button('Dr. Batty Asthma Cigarettes 25$ level require [0]') then
						TriggerServerEvent('mh:buydrug', 25, 'Asthma Cigarettes', 0)
				end
				WarMenu.Display()
				elseif WarMenu.IsMenuOpened('Pick Me Up') then
				if WarMenu.Button('Cocaine Gum 60 $ level require [1]') then
						TriggerServerEvent('mh:buydrug', 60, 'Cocaine Gum', 1)
					elseif WarMenu.Button('Dr. Nagai Meth 120$ level require [10]') then
						TriggerServerEvent('mh:buydrug', 120, 'Meth', 10)
				end
				WarMenu.Display()
				elseif WarMenu.IsMenuOpened('Mixtures') then 
				if WarMenu.Button('Cod Liver Oil 50$ level require [5]') then
						TriggerServerEvent('mh:buydrug', 50, 'WEAPON_REVOLVER_DOUBLEACTION', 5)
					elseif WarMenu.Button('Dr Guertins Nerve Syrup 55$ level require [6]') then
						TriggerServerEvent('mh:buydrug', 55, 'Nerve Syrup', 6)
					elseif WarMenu.Button('Standard Radium  55$ level require [6]') then
						TriggerServerEvent('mh:buydrug', 55, 'Standard Radium', 6)
				end
				WarMenu.Display()
				elseif WarMenu.IsMenuOpened('Poisons & Solutions') then
				if WarMenu.Button('Arsenic 30 $ level require [1]') then
					TriggerServerEvent('mh:buydrug', 30, 'Arsenic', 1)
				end
				WarMenu.Display()
			end
	for k,v in pairs(Config.Coords) do
			local _distance = Vdist(coords, v)
			if _distance < 5 then
				DrawMarker(-1795314153, v.x, v.y + 0.5, v.z - 1, 0, 0, 0, 0, 0, 0, 1.3, 1.3, .5, 0, 93, 0, 155, 0, 0, 2, 0, 0, 0, 0)
			end

			if _distance < 2 then
				DrawTxt(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
				if IsControlJustReleased(0, keys['E']) then
					WarMenu.OpenMenu('DrugMenu')
				end
			end

			if _distance > 5 and _distance < 15 then
				if WarMenu.IsAnyMenuOpened() == true then
					WarMenu.CloseMenu()
				end
			end
		end
	end
end)


RegisterNetEvent('Message:cancel')	
AddEventHandler('Message:cancel', function()
local timer = 200
	while timer > 0 do
		Citizen.Wait(0)
		DrawTxt(Config.NoMoney, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
	end
end)

RegisterNetEvent('Message:missinglevel')	
AddEventHandler('Message:missinglevel', function()
local timer = 200
	while timer > 0 do
		Citizen.Wait(0)
		DrawTxt(Config.LevelMissing, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
	end
end)

RegisterNetEvent('give:weapon')
AddEventHandler('give:weapon', function(weapon)
    Citizen.CreateThread(function()
        local weapon = GetHashKey(weapon)
		local playerPed = PlayerPedId()
        Wait(1000)
		GiveDelayedWeaponToPed(playerPed, weapon, 100, true, 2)
    end)
end)

RegisterNetEvent('give:weaponammo')
AddEventHandler('give:weaponammo', function()
	Citizen.CreateThread(function()
		vintova = {
			'WEAPON_RIFLE_VARMINT',
			'WEAPON_RIFLE_BOLTACTION',
			'WEAPON_RIFLE_SPRINGFIELD',
			'WEAPON_SHOTGUN_DOUBLEBARREL',
			'WEAPON_SHOTGUN_SAWEDOFF',
			'WEAPON_SHOTGUN_PUMP',
			'WEAPON_SHOTGUN_SEMIAUTO',
			'WEAPON_SHOTGUN_REPEATING',
			'WEAPON_PISTOL_VOLCANIC',
			'WEAPON_PISTOL_SEMIAUTO',
			'WEAPON_PISTOL_MAUSER',
			'WEAPON_REVOLVER_DOUBLEACTION',
			'WEAPON_REVOLVER_CATTLEMAN',
			'WEAPON_REVOLVER_LEMAT',
			'WEAPON_REVOLVER_HIGHROLLER',
			'WEAPON_REVOLVER_SCHOFIELD',
			'WEAPON_BOW'
					}
		Wait(1000)
		for k,v in pairs(vintova) do
			local weapon = GetHashKey(v)
			SetPedAmmo(GetPlayerPed(), weapon, Config.DefaultAmmo)
		end
    end)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end

function DrawMarker(hash, x, y, z, dx, dy, dz, rx, ry, rz, sx, sy, sz, r,g ,b, a, bob, face, p19, rotate, tDict, tName, drawOnEnt)
	Citizen.InvokeNative(0x2A32FAA57B937173, hash, x, y, z, dx, dy, dz, rx, ry, rz, sx, sy, sz, r, g, b, a, bob, face, p19, rotate, tDict, tName, drawOnEnt)
end

Citizen.CreateThread(function()
	Wait(0)
	for k,v in pairs(Config.Coords) do
		Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v)
	end
end)