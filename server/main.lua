---@param soundName string
function PlaySound(soundName)
    TriggerClientEvent("zyke_sounds:PlaySound", -1, soundName)
end

local soundIdCounter = 0

---@param entity integer
---@param id string? @Only needed if you want to manually stop the sound
---@param soundName string
---@param maxVolume number
---@param maxDistance number
---@param playCount integer? @If not looping, you can decide how many times the audio will play
---@return string
function PlaySoundOnEntity(entity, id, soundName, maxVolume, maxDistance, looped, playCount)
    local entityNetId = NetworkGetNetworkIdFromEntity(entity)
    soundIdCounter += 1

    ---@type SoundDataWithEntity
    local soundData = {
        soundId = id or ("sound-" .. soundIdCounter),
        soundName = soundName,
        entityNetId = entityNetId,
        soundType = "entity",
        maxVolume = maxVolume or 0.3,
        maxDistance = maxDistance or 10.0,
        looped = looped or false,
        playCount = playCount or 1
    }

    TriggerClientEvent("zyke_sounds:PlaySound", -1, soundData)

    return soundData.soundId
end

exports("PlaySoundOnEntity", PlaySoundOnEntity)

---@param location vector3
---@param soundName string
---@return string
function PlaySoundOnLocation(location, soundName)
    soundIdCounter += 1

    ---@type SoundDataWithLocation
    local soundData = {
        soundId = "sound-" .. soundIdCounter,
        soundName = soundName,
        location = location,
        soundType = "location",
        maxVolume = 0.3,
        maxDistance = 10.0,
        looped = false
    }

    TriggerClientEvent("zyke_sounds:PlaySound", -1, soundData)

    return soundData.soundId
end

exports("PlaySoundOnLocation", PlaySoundOnLocation)

---@param soundId string
---@param fade? number
function StopSound(soundId, fade)
    TriggerClientEvent("zyke_sounds:StopSound", -1, soundId, fade)
end

exports("StopSound", StopSound)

-- RegisterCommand("play_sound", function(source, args)
--     PlaySound(args[1])
-- end, false)

-- RegisterCommand("test_sound", function(source, args)
--     local ply = GetPlayerPed(source)
--     local pos = GetEntityCoords(ply)
--     -- local pos = vec3(222.4440612793, -879.39459228516, 30.49210357666)

--     PlaySoundOnLocation(pos, "flame.wav")
-- end, false)

-- RegisterCommand("test_sound_entity", function(source, args)
--     local pos = vec3(222.4440612793, -879.39459228516, 30.49210357666)
--     local ped = CreatePed(4, GetHashKey("a_m_m_skater_01"), pos.x, pos.y, pos.z, 0.0, false, false)

--     -- local ped = GetPlayerPed(source)

--     PlaySoundOnEntity(ped, nil, "inhale_bong.wav", 0.15, 5.0, true, nil)
-- end, false)

-- CreateThread(function()
--     Wait(100)

--     local pos = vec3(222.4440612793, -879.39459228516, 30.49210357666)
--     local ped = CreatePed(4, GetHashKey("a_m_m_skater_01"), pos.x, pos.y, pos.z, 0.0, false, false)

--     PlaySoundOnEntity(ped, "flame.wav")
-- end)