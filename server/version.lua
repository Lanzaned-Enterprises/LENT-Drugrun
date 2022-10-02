--[[ Version Checker ]] --
local version = "1.0.1"

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        checkResourceVersion()
    end
end)

function checkUpdateEmbed(color, name, message, footer)
    local content = {
        {
            ["color"] = color,
            ["title"] = " " .. name .. " ",
            ["description"] = message,
            ["footer"] = {
                ["text"] = " " .. footer .. " ",
            },
        }
    }
    PerformHttpRequest(Config.DISCORD_WEBHOOK, function(err, text, headers) end, 
    'POST', json.encode({
        username = Config.DISCORD_NAME, 
        embeds = content, 
        avatar_url = Config.DISCORD_IMAGE
    }), { ['Content-Type'] = 'application/json '})
end

function checkResourceVersion()
    PerformHttpRequest("https://raw.githubusercontent.com/Lanzaned-Enterprises/LENT-Drugrun/main/version.txt", function(err, text, headers)
        if string.match(text, version) then
            print(" ")
            print("------------ LANZANED DRUG RUN ------------")
            print("Drugrun is up to date and ready to go!")
            print("Running on Version: " .. version)
            print("https://github.com/Lanzaned-Enterprises/LENT-Drugrun")
            print("-------------------------------------------")
            print(" ")
            checkUpdateEmbed(20480, "Drugrun Update Checker", "Drugrun is up to date and ready to go!\nRunning on Version: " .. version .. "\nhttps://github.com/Lanzaned-Enterprises/LENT-Drugrun", "Script created by: https://discord.gg/kmKcHWGqbP")
        else
            print(" ")
            print("------------ LANZANED DRUG RUN ------------")
            print("Drugrun is not up to date! Please update!")
            print("Curent Version: " .. version .. " Latest Version: " .. text)
            print("https://github.com/Lanzaned-Enterprises/LENT-Drugrun")
            print("-------------------------------------------")
            print(" ")
            checkUpdateEmbed(5242880, "Drugrun Update Checker", "Drugrun is not up to date! Please update!\nCurent Version: " .. version .. " Latest Version: " .. text .. "\nhttps://github.com/Lanzaned-Enterprises/LENT-Drugrun", "Script created by: https://discord.gg/kmKcHWGqbP")
        end
    end, "GET", "", {})
end