local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Finish the Heist ]] --
RegisterServerEvent("LENT:SERVER:DRUGRUN:END", function()
    local sender = "The Boss"
    local subject = "Mission Completed"
    local text = "Thank you for that run! It's greatly appreciated. Standby for further details."
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney('cash', Config.Payment, "Random Payment")
    Player.Functions.RemoveItem("cokebricks", Config.ItemAmount)
    TriggerClientEvent("SEND:EMAIL", source, sender, subject, text)
end)