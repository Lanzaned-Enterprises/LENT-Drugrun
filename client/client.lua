local QBCore = exports['qb-core']:GetCoreObject()

Objectives = {}
Objectives.RunStarted = false
Objectives.RunCompleted = false
Objectives.ThreadTriggered = false
Objectives.VehicleDistanceTriggered = false

Events = {}
Events.DrugRunAlert = false

-- [[ Sending EMAIL to player and deleting vehicle ]] --
RegisterNetEvent("LENT:SEND:EMAIL:FINAL", function(sender, subject, text)
    local coords = GetEntityCoords(PlayerPedId())
    local closestVehicle, distance = QBCore.Functions.GetClosestVehicle(coords)
    print(closestVehicle, distance)
    if distance < 100 then 
        local isDrugRunCar = isHeistVehicle(closestVehicle)
        if isDrugRunCar then
            print("Deleting vehicle")
            NetworkRequestControlOfEntity(closestVehicle)
            QBCore.Functions.DeleteVehicle(closestVehicle)
        else
            print("closest vehicle was not the right car")
        end        
    else
        print("no vehicle was nearby")
    end

    TriggerServerEvent("qb-phone:server:sendNewMail", {
        sender = sender,
        subject = subject,
        message = text,
        button = {}
    })
end)

RegisterNetEvent("LENT:START:DRUGRUN", function()
    if Objectives.RunCompleted or Objectives.RunStarted then
        MissionText("~r~Sketchy Guy: ~w~Hey! This mission won't complete itself!", 5000)
    else
        MissionText("~r~Sketchy Guy: ~w~I left a location on your ~g~GPS~w~!", 5000)
        local GetCoords = Config.SpawnCoords
        local SetCoords = (GetCoords[math.random(#GetCoords)])
        SetWaypointOff()
        SetNewWaypoint(SetCoords) -- vector3(-1289.83, 288.94, 64.81)
        TriggerEvent("LENT:DRUGRUN:VEHICLE:SPAWN", SetCoords)
        Objectives.RunStarted = true
    end
end)

RegisterNetEvent("LENT:END:DRUGRUN", function()
    
    if Objectives.RunStarted then
        if QBCore.Functions.HasItem('cokebricks', Config.ItemAmount) then
            TriggerServerEvent("LENT:SERVER:DRUGRUN:END")
            Objectives.RunCompleted = true
            Objectives.RunStarted = false
        end
    end
end)

RegisterNetEvent("LENT:DRUGRUN:VEHICLE:SPAWN", function(SetCoords)
    local cars = Config.Vehicles

    local vehicleCode = (cars[math.random(#cars)])
    
    if not IsModelInCdimage(vehicleCode) then 
        return 
    end
    
    RequestModel(vehicleCode)
    
    while not HasModelLoaded(vehicleCode) do
        Citizen.Wait(10)
    end

    local MyPed = PlayerPedId()
    local PlateSet = Config.Plate
    local plate = (PlateSet[math.random(#PlateSet)])

    local vehicle = CreateVehicle(vehicleCode, SetCoords.x, SetCoords.y, SetCoords.z-1, SetCoords.w, true, false) -- Spawns a networked vehicle on your current coords

    SetVehicleNumberPlateText(vehicle, plate)
    SetCarItemsInfo()
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(vehicle), Config.RunItems)
    SetVehicleDirtLevel(veh, 0.0)
    PerformanceUpgrades(vehicle)

    exports['LegacyFuel']:SetFuel(vehicle, 100.0)

    SetModelAsNoLongerNeeded(vehicleCode) -- removes model from game memory as we no longer need it    
end)

RegisterNetEvent("LENT:SETCOORDS", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true)
    local GetCoords = Config.DropCoords
    local SetCoords = (GetCoords[math.random(#GetCoords)])
    SetWaypointOff()
    SetNewWaypoint(SetCoords) -- vector3(-1289.83, 288.94, 64.81)
    exports['ps-dispatch']:methRunReport(vehicle)
end)

-- [[ Functions ]] --
function MissionText(text, time)
    BeginTextCommandPrint("STRING")
    AddTextComponentString(text)
    EndTextCommandPrint(time, false)
end

local performanceModIndices = { 11, 12, 13, 15, 16 }

function PerformanceUpgrades(vehicle)
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
	    SetVehicleFixed(vehicle)
    end
end

function isDrugRunCar(vehicle)
    for k, v in pairs(Config.Vehicles) do
        if GetEntityModel(vehicle) == joaat(v) then
            return true
        end
    end
    return false
end

function SetCarItemsInfo()
	local items = {}
	for k, item in pairs(Config.RunItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.RunItems = items
end

CreateThread(function()
    while true do
        Wait(0)
        for k, v in pairs(Config.DropLocations) do
            exports['qb-target']:AddBoxZone(v["name"], v["coords"], v["height"], v["width"], {
                name = v["name"],
                heading = v["heading"],
                debugPoly = v["debug"],
                minZ = v["minZ"],
                maxZ = v["maxZ"],
                }, {
                    options = {
                        {
                            type = 'client',
                            event = 'LENT:END:DRUGRUN',
                            icon = v["icon"],
                            label = v["label"],
                        },
                    },
                distance = 3.5
            })
        end
    end
end)

-- [[ Create Threads ]] -- 
CreateThread(function()
    while true do
        Wait(0)
        if Objectives.RunStarted then
            local GetCoords = Config.SpawnCoords
            local SetCoords = (GetCoords[math.random(#GetCoords)])

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local VehicleDistance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, SetCoords.x, SetCoords.y, SetCoords.z)

            if VehicleDistance <= 20.0 and IsPedGettingIntoAVehicle(GetPlayerPed(-1)) then
                Wait(5000)
                if not Objectives.VehicleDistanceTriggered then
                    if not Events.DrugRunAlert then
                        TriggerEvent("LENT:SETCOORDS")
                        MissionText("~d~Radio: ~w~Keys are in the vehicle for you!", 5000)
                        MissionText("~d~Radio: ~w~I've left a new location on your ~g~GPS~w~!", 5000)
                        Objectives.VehicleDistanceTriggered = true
                    end
                end
            end
        end
    end
end) 

CreateThread(function()
    while true do
        Wait(60000)
        if Objectives.RunCompleted then
            Objectives.RunStarted = false
            Objectives.RunCompleted = false
            Objectives.ThreadTriggered = false
            Objectives.VehicleDistanceTriggered = false
            Events.DrugRunAlert = false
        end
    end
end)