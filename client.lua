local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

-- RegisterCommand("extras", function(s,a,r)
--     if IsPedInAnyVehicle(PlayerPedId()) then
--         local count = GetVehicleLiveryCount(GetVehiclePedIsIn(PlayerPedId()))
--        print(count,type(count))
--         SendNUIMessage({ action = "open", count = count })
--         SetNuiFocus(true, true)
--     end
-- end)

RegisterNUICallback("select", function(data,cb)
    if IsPedInAnyVehicle(PlayerPedId()) then
     --   SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId()), data.livery)
      SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId()), data.livery)
    end
end)

RegisterNUICallback("close", function(data,cb)
    SetNuiFocus(false, false)
end)






CreateThread(function()
    while true do
        local time = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k in pairs(config.locations) do
            local distance = #(pedCoords - config.locations[k].coords)
            local coords = vector3(config.locations[k].coords.x, config.locations[k].coords.y, config.locations[k].coords.z)
            local coordst = vector3(config.locations[k].coords.x, config.locations[k].coords.y, config.locations[k].coords.z -1)

            if distance <= 15.0 then
                time = 5
                if distance < 3 then
                    drawTxt("PRESSIONE ~r~E~w~ PARA ACESSAR O ~r~MENU EXTRAS", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
                end   

                DrawMarker(36, coords, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 0, 0, 150, 1, 0, 0, 1)
                DrawMarker(27, coordst, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.5, 255, 255,255, 300, 0, 0, 0, 1)
                if distance < 3 then
                    if IsControlJustPressed(0,38) and IsPedInAnyVehicle(PlayerPedId()) and vSERVER.verifyperm() then
                        local count = GetVehicleLiveryCount(GetVehiclePedIsIn(PlayerPedId()))
                         SendNUIMessage({ action = "open", count = count })
                         SetNuiFocus(true, true)
                    end       
                end    
            end
        end

        Wait( time )
    end
end)


function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end