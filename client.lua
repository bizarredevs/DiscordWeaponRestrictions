--[[ 
    Made by Bizarre
    Discord Role Weapon Restriction Script for FiveM
]]

-- Check for player identifiers and fetch Discord ID
function GetDiscordIdentifier()
    local playerId = PlayerId()
    local identifiers = GetPlayerIdentifiers(playerId)

    for _, identifier in ipairs(identifiers) do
        if string.find(identifier, "discord:") then
            return identifier
        end
    end
    return nil
end

-- Main thread to check Discord roles
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Check every 5 seconds

        local discordId = GetDiscordIdentifier()

        if discordId then
            -- Print the Discord ID for debugging
            print("Discord ID found: " .. discordId)
            TriggerServerEvent('checkDiscordRoles', discordId)
        else
            print("No Discord ID found.")
        end
    end
end)

-- Server-side script to check the player's Discord roles
RegisterNetEvent('checkDiscordRoles')
AddEventHandler('checkDiscordRoles', function(discordId)
    local discordRoles = exports.DiscordRoles:GetRoles(discordId)

    -- Management roles, unrestricted
    if discordRoles["909667100963008552"] or discordRoles["1111495205384896512"] then
        -- CM has access to all weapons, including snipers and explosives
        return
    end

    -- Law enforcement roles, restricted access but can use Heavy Sniper and MK2
    if discordRoles["879196160064118844"] or discordRoles["878846101153808385"] or discordRoles["878841439092604988"] then
        RestrictLEOWeapons()
        return
    end

    -- Civilian Restriction Level 2 (only melee weapons)
    if discordRoles["1294730432012877906"] then
        RestrictWeaponsLevel2()
        return
    end

    -- Civilian Restriction Level 1 (only pistols and melee weapons)
    if discordRoles["1294730430792073347"] then
        RestrictWeaponsLevel1()
        return
    end

    -- Regular Civilian role (restricted access to realistic weapons only)
    if discordRoles["1041855685954109552"] then
        RestrictCivilianWeapons()
    end
end)

-- Function to restrict unrealistic weapons for LEO but allow Heavy Sniper and Heavy Sniper MK2
function RestrictLEOWeapons()
    local restrictedWeapons = {
        "WEAPON_GRENADE",
        "WEAPON_STICKYBOMB",
        "WEAPON_PROXMINE",
        "WEAPON_PIPEBOMB",
        "WEAPON_RPG",
        "WEAPON_HOMINGLAUNCHER",
        "WEAPON_MINIGUN",
        "WEAPON_RAILGUN",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_COMPACTLAUNCHER",
        "WEAPON_SNIPERRIFLE",
        "WEAPON_MARKSMANRIFLE"
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Function to restrict unrealistic weapons for Civilian Restriction Level 1
function RestrictWeaponsLevel1()
    local restrictedWeapons = {
        "WEAPON_ASSAULTRIFLE",
        "WEAPON_CARBINERIFLE",
        "WEAPON_SNIPERRIFLE",
        "WEAPON_MARKSMANRIFLE",
        "WEAPON_GRENADE",
        "WEAPON_STICKYBOMB",
        "WEAPON_PROXMINE",
        "WEAPON_PIPEBOMB",
        "WEAPON_RPG",
        "WEAPON_HOMINGLAUNCHER",
        "WEAPON_MINIGUN",
        "WEAPON_RAILGUN",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_COMPACTLAUNCHER",
        "WEAPON_BZGAS",
        "WEAPON_MOLOTOV"
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Function to restrict all weapons except melee for Civilian Restriction Level 2
function RestrictWeaponsLevel2()
    local restrictedWeapons = {
        "WEAPON_PISTOL",
        "WEAPON_SMG",
        "WEAPON_ASSAULTRIFLE",
        "WEAPON_CARBINERIFLE",
        "WEAPON_SNIPERRIFLE",
        "WEAPON_MARKSMANRIFLE",
        "WEAPON_GRENADE",
        "WEAPON_STICKYBOMB",
        "WEAPON_PROXMINE",
        "WEAPON_PIPEBOMB",
        "WEAPON_RPG",
        "WEAPON_HOMINGLAUNCHER",
        "WEAPON_MINIGUN",
        "WEAPON_RAILGUN",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_COMPACTLAUNCHER",
        "WEAPON_BZGAS",
        "WEAPON_MOLOTOV"
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Function to restrict regular civilians to realistic weapons, allowing Molotov and BZ Gas
function RestrictCivilianWeapons()
    local restrictedWeapons = {
        "WEAPON_ASSAULTRIFLE",
        "WEAPON_CARBINERIFLE",
        "WEAPON_SNIPERRIFLE",
        "WEAPON_MARKSMANRIFLE",
        "WEAPON_GRENADE",
        "WEAPON_STICKYBOMB",
        "WEAPON_PROXMINE",
        "WEAPON_PIPEBOMB",
        "WEAPON_RPG",
        "WEAPON_HOMINGLAUNCHER",
        "WEAPON_MINIGUN",
        "WEAPON_RAILGUN",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_COMPACTLAUNCHER"
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end
