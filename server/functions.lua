---@param soundName string
function PlaySound(soundName)
    TriggerClientEvent("zyke_sounds:PlaySound", -1, soundName)
end

local soundIdCounter = 0

function GetDefaultSoundId()
    soundIdCounter += 1

    return "sound-" .. soundIdCounter
end

---@param entity integer
---@param id string? @Only needed if you want to manually stop the sound
---@param soundName string
---@param maxVolume number
---@param maxDistance number
---@param playCount integer? @If not looping, you can decide how many times the audio will play
---@return string
function PlaySoundOnEntity(entity, id, soundName, maxVolume, maxDistance, looped, playCount)
    local entityNetId = NetworkGetNetworkIdFromEntity(entity)

    id = id or GetDefaultSoundId()

    ---@type SoundDataWithEntity
    local soundData = {
        soundId = id,
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
    local id = GetDefaultSoundId()

    ---@type SoundDataWithLocation
    local soundData = {
        soundId = id,
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