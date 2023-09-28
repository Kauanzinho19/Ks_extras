
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Ks = {}
Tunnel.bindInterface(GetCurrentResourceName(),Ks)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION CHECK PERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Ks.verifyperm()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,config.perm) then
        return true  
    else
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",5000)
    end
 end