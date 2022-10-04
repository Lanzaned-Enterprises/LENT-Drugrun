Config = {}

Config.Payment = math.random(10000, 23000)

Config.SpawnCoords = {
    vector4(19.56, -1775.84, 29.32, 52.67), -- Mega Mall
    vector4(567.39, -1799.19, 29.19, 353.52), -- Little Bighorn
    vector4(853.15, -906.27, 25.31, 271.49), -- Vespucci Blv
    vector4(15.01, -1320.37, 29.26, 174.17), -- Innocence
    vector4(-333.55, -1495.17, 30.64, 5.66), -- Innocence 2
}

Config.DropCoords = {
    vector4(1218.1, -3232.35, 5.56, 177.23), -- Docks
    vector4(-674.36, -2391.29, 13.89, 254.9), -- Airport
    vector4(138.35, 317.1, 112.14, 294.14), -- las Lagunas
}

Config.DropLocations = {
    ["Docks"] = {
        ["name"] = "Docks",
        ["coords"] = vector3(1218.38, -3236.22, 5.56),
        ["height"] = 1.0,
        ["width"] = 5.6,
        ["heading"] = 0,
        ["debug"] = false,
        ["minZ"] = 4.56,
        ["maxZ"] = 9.56,
        ["icon"] = "fa-solid fa-sack-dollar",
        ["label"] = "Deliver Goods",
    },
    ["Airport"] = {
        ["name"] = "Airport",
        ["coords"] = vector3(1218.38, -3236.22, 5.56),
        ["height"] = 1.0,
        ["width"] = 5.6,
        ["heading"] = 0,
        ["debug"] = false,
        ["minZ"] = 4.56,
        ["maxZ"] = 9.56,
        ["icon"] = "fa-solid fa-sack-dollar",
        ["label"] = "Deliver Goods",
    },
    ["LasLagunas"] = {
        ["name"] = "LasLagunas",
        ["coords"] = vector3(150.95, 322.85, 112.14),
        ["height"] = 0.6,
        ["width"] = 1.6,
        ["heading"] = 295,
        ["debug"] = false,
        ["minZ"] = 111.14,
        ["maxZ"] = 113.74,
        ["icon"] = "fa-solid fa-sack-dollar",
        ["label"] = "Deliver Goods",
    },
}

Config.Plate = {
    "Runnerss",
    "MAAAMANN",
    "00000000",
    "IIIIIIII",
    "MMMMMMMM",
    "MNMNMNMN",
}

Config.Vehicles = {
    `xls2`,
    `baller6`,
    `baller5`,
    `Schafter5`,
    `Schafter6`,
    `Cognoscenti2`,
}


Config.ItemAmount = 22 -- You can add as many slots below aslong as the total does NOT exceed this amount
Config.RunItems = {
    [1] = {
        name = "cokebricks",
        amount = 5,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "cokebricks",
        amount = 4,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "cokebricks",
        amount = 2,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "cokebricks",
        amount = 7,
        info = {},
        type = "item",
        slot = 4,
    },
    [5] = {
        name = "cokebricks",
        amount = 4,
        info = {},
        type = "item",
        slot = 5,
    },
}

Config.DISCORD_WEBHOOK = ""
Config.DISCORD_NAME = "LENT - Testing"
Config.DISCORD_IMAGE = "https://cdn.discordapp.com/attachments/1026175982509506650/1026176123928842270/Lanzaned.png"
