-- Trigger once a sound plays, will run once and keep running until sounds are done

local volumeUpdateInterval = Config.Settings.volumeUpdateInterval
local isUpdatingVolume = false
function UpdateSoundVolumeLoop()
    if (isUpdatingVolume) then return end

    isUpdatingVolume = true

    local function countTbl(tbl)
        local count = 0
        for _ in pairs(tbl) do count = count + 1 end
        return count
    end

    while (countTbl(Cache.activeSounds) > 0) do
        for soundId, soundData in pairs(Cache.activeSounds) do
            UpdateSoundVolume(soundId)
        end

        Wait(volumeUpdateInterval)
    end

    isUpdatingVolume = false
end

---@param plyPos vector3
---@param soundData SoundData | SoundDataWithLocation | SoundDataWithEntity
function GetSoundVolume(plyPos, soundData)
    if (soundData.soundType == "default") then return soundData.maxVolume end

    if (soundData.soundType == "location") then
        local dst = #(plyPos - soundData.location)
        local maxDst = soundData.maxDistance

        if (Config.Settings.debug) then
            Cache.activeSounds[soundData.soundId].pos = soundData.location
        end

        if (dst > maxDst) then return 0.0 end

        return soundData.maxVolume * (1.0 - (dst / maxDst))
    elseif (soundData.soundType == "entity") then
        if (not NetworkDoesNetworkIdExist(soundData.entityNetId)) then return 0.0 end

        local entity = NetworkGetEntityFromNetworkId(soundData.entityNetId)
        local entityPos = GetEntityCoords(entity)

        if (Config.Settings.debug) then
            Cache.activeSounds[soundData.soundId].pos = entityPos
        end

        local dst = #(plyPos - entityPos)
        local maxDst = soundData.maxDistance

        if (dst > maxDst) then return 0.0 end

        return soundData.maxVolume * (1.0 - (dst / maxDst))
    end
end

---@param soundId string
function UpdateSoundVolume(soundId)
    local soundData = Cache.activeSounds[soundId]
    if (not soundData) then return end

    local plyPos = GetEntityCoords(PlayerPedId())
    local volume = GetSoundVolume(plyPos, soundData)

    SendNUIMessage({
        event = "UpdateSoundVolume",
        data = {
            soundId = soundId,
            volume = volume
        }
    })
end