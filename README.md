# LENT-Drugrun
*Basic drugrun made for QBCore who is free. No more need to pay 20 bucks.*

## Dependencies
- QBCore
- LENT-PedSpawner
- PolyZone
- ps-dispatch
- qb-target

## How to install
- Add the code below to `LENT-PedSpawner/peds.lua`
```lua
    ["drugrunPed"] = {
        ["coords"] = vector4(43.12, -1451.81, 29.31, 52.35), 
        
        ["ped"] = "a_m_y_genstreet_01", 
        ["scenario"] = "WORLD_HUMAN_LEANING", 
        ["block_events"] = true, 
        ["invincible"] = true, 
        ["freeze"] = true, 
  
        ["weapon"] = false, 
        ["weapon_hash"] = "", 
        ["hostile"] = false, 

        ["target"] = true,
        ["type"] = "client",
        ["event"] = "LENT:START:DRUGRUN", 
        ["icon"] = "fa-solid fa-pills", 
        ["text"] = "Start Drug Run",

        ["clothing"] = false,
        ["mother"] = 0, ["father"] = 0, ["mix"] = 0.0,
        ["head"] = 1, ["HAIR_Texture"] = 3, ["HAIR_HIGHLIGHT"] = 0,
        ["hands"] = 1, ["HA_Texture"] = 0,
        ["undershirts"] = 1, ["U_Texture"] = 0,
        ["tops"] = 1, ["T_Texture"] = 0,
        ["kevlar"] = 1, ["K_Texture"] = 0,
        ["decal"] = 1, ["D_Texture"] = 0,
        ["accs"] = 1, ["A_Texture"] = 0,
        ["bags"] = 1, ["B_Texture"] = 0,
        ["pants"] = 1, ["P_Texture"] = 0,
        ["shoes"] = 1, ["S_Texture"] = 0,
    },
```
- Add the following to `QBCore/shared/items.lua`
```lua
		['cokebricks'] = {
			['name'] = 'cokebricks',
			['label'] = 'Brick of Coke',
			['weight'] = 1000,
			['type'] = 'item',
			['image'] = 'coke_brick.png',
			['unique'] = false,
			['useable'] = false,
			['shouldClose'] = false,
			['combinable'] = nil,
			['description'] = 'Interesting Brick....'
		},
```
- Add the image to your `inventory/html/images`

## Issues
|  Question |  Answer |
|----       |----     |
|           |         |

# Contributors
|  Rank       |  Member       | ID                 | Qualifications                       |
|----         |----           |----                |----                                  |
| Director    | [Lanzaned#2512](https://discordapp.com/users/871877975346405388) | [871877975346405388](https://discordapp.com/users/871877975346405388) | Javascript, XML, HTML, CSS, lua, SQL |

# Useful Links 
Discord: https://discord.gg/kmKcHWGqbP<br>
Github: https://github.com/Lanzaned-Enterprises<br>
Documentation: https://lanzaned-development.gitbook.io/lanzaned-development-or-documentation/