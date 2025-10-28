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

-- Verify UI build
local hasUISrc = LoadResourceFile(GetCurrentResourceName(), "nui_source/index.html") ~= nil
local hasUIBuild = LoadResourceFile(GetCurrentResourceName(), "nui/index.html") ~= nil
if (hasUISrc and not hasUIBuild) then
    while (1) do
        print("> ^1UI source files found, but no UI build found. Please build the UI or download the build version from the GitHub repository.^7")
        print("> ^3https://docs.zykeresources.com/common-issues/downloading-source-files^7")

        Wait(1000)
    end
end