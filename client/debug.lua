if (not Config.Settings.debug) then return end

CreateThread(function()
    while (true) do
        for soundId, soundData in pairs(Cache.activeSounds) do
            if (soundData.pos) then
                DrawMarker(28, soundData.pos.x, soundData.pos.y, soundData.pos.z, 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 255, 255, 255, 200, false, false, 2, nil, nil, false)

                -- Max distance
                DrawMarker(28, soundData.pos.x, soundData.pos.y, soundData.pos.z, 0, 0, 0, 0, 0, 0, soundData.maxDistance, soundData.maxDistance, soundData.maxDistance, 255, 255, 255, 100, false, false, 2, nil, nil, false)
            end
        end

        Wait(1)
    end
end)