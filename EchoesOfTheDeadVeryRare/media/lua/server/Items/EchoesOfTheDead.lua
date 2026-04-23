--[[
-------------------------------------------------------------------------------------
               Echoes of the Dead Mod for Project Zomboid - Main Logic
-------------------------------------------------------------------------------------
    Author: Stormbox
    Description: An active contributor and modder for Project Zomboid.

    Purpose: The "Echoes of the Dead" mod amplifies the eeriness of Project Zomboid by
             playing randomized, haunting zombie screams whenever a zombie is killed.
             The chilling echoes serve as a stark reminder of the apocalyptic setting,
             enhancing the game's atmosphere and immersion.

    Support Me: If you value my modding endeavors and wish to support me, consider
                commissioning a mod. I offer this service for a modest fee under $50,
                adjusted depending on the mod's complexity. Your support allows me
                to continue creating and refining mods for the community.
                If you feel grateful or just fancy buying me a coffee, visit: https://ko-fi.com/stormboxoriginal

    Contact: I always appreciate feedback, innovative ideas, or collaborative opportunities.
             Don't hesitate to reach out if you have any suggestions or are curious about
             potential modding projects. Connecting with fellow PZ enthusiasts is a joy!
-------------------------------------------------------------------------------------
]]

-- EchoesOfTheDead.lua Very Rare Version

local zombieSounds = {
    "EchoScream1", "EchoScream2", "EchoScream3", "EchoScream4", "EchoScream5",
    "EchoScream6", "EchoScream7", "EchoScream8", "EchoScream9", "EchoScream10", "EchoScream11", "EchoScream12"
}

local function EchoesOfTheDead(zombie)
    if not zombie then return end

    local screamChanceRoll = ZombRand(1, 101)
    local screamLoudness = ZombRand(50, 111)
    local screamDistance = ZombRand(70, 251)

    if screamChanceRoll <= 1 then
        local soundToPlay = zombieSounds[ZombRand(#zombieSounds) + 1]

        local emitter = zombie:getEmitter()
        if emitter then
            emitter:playSound(soundToPlay)
        end

        local zombieLocation = zombie:getCurrentSquare()
        if zombieLocation then
            getWorldSoundManager():addSound(zombie, zombieLocation:getX(), zombieLocation:getY(),
                zombieLocation:getZ(), screamDistance, screamLoudness)
        end
    end
end

Events.OnZombieDead.Add(EchoesOfTheDead)
