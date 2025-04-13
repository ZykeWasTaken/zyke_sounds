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