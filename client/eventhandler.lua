local function handleReceivedSound(soundData)
    local plyPos = GetEntityCoords(cache.ped)

    local volume = GetSoundVolume(plyPos, soundData)

    if volume <= 0.0 then return end

    Cache.activeSounds[soundData.soundId] = soundData

    soundData.volume = volume

    SendNUIMessage({
        event = "PlaySound",
        data = soundData
    })

    UpdateSoundVolumeLoop()
end

RegisterNetEvent("zyke_sounds:PlaySound", function(soundData)
    handleReceivedSound(soundData)
end)

RegisterNUICallback("Eventhandler", function(passed, cb)
    local event = passed.event
    local data = passed.data

    if (event == "SoundEnded") then
        Cache.activeSounds[data.soundId] = nil
        cb("ok")
    end
end)

RegisterNetEvent("zyke_sounds:StopSound", function(soundId)
    Cache.activeSounds[soundId] = nil

    SendNUIMessage({
        event = "StopSound",
        data = soundId
    })
end)

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler('playSound', nil, function(bagName, key, soundData)
    local entityExists, entity = pcall(lib.waitFor, function()
        local entity = GetEntityFromStateBagName(bagName)

        if entity > 0 then return entity end
    end, '', 10000)

    if not entityExists then return end

    handleReceivedSound(soundData)
end)
