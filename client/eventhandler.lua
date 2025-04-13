RegisterNetEvent("zyke_sounds:PlaySound", function(soundData)
    local plyPos = GetEntityCoords(PlayerPedId())

    Cache.activeSounds[soundData.soundId] = soundData

    local volume = GetSoundVolume(plyPos, soundData)

    soundData.volume = volume

    SendNUIMessage({
        event = "PlaySound",
        data = soundData
    })

    UpdateSoundVolumeLoop()
end)

RegisterNUICallback("Eventhandler", function(passed, cb)
    local event = passed.event
    local data = passed.data

    if (event == "SoundEnded") then
        Cache.activeSounds[data.soundId] = nil
        cb("ok")
    end
end)

---@param soundId string
---@param fade? number
---@param forceFull? boolean
RegisterNetEvent("zyke_sounds:StopSound", function(soundId, fade, forceFull)
    Cache.activeSounds[soundId] = nil

    SendNUIMessage({
        event = "StopSound",
        data = {
            soundId = soundId,
            fade = fade,
            forceFull = forceFull
        }
    })
end)