local PertamaMendarat = true

AddEventHandler('playerSpawned', function()
    CreateThread(function()
        local IsLoaded = ESX.IsPlayerLoaded()
        local Loop     = 1500

        while not IsLoaded do
            Wait(Loop)
        end

        if PertamaMendarat then
            ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(sedangPingsan)
                if sedangPingsan == false then
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        if skin ~= nil then
                            TriggerEvent("Nzdx-Spawn:Display")
                        else
                            print("first-spawn , not displaying spawner choice")
                        end
                    end)
                end
            end)
            PertamaMendarat = false
        end
    end)
end)

RegisterNetEvent('Nzdx-Spawn:Display', function()
    NzdxCamSpawn()
    lib.registerContext({
        id          = 'nzdx:selector',
		title       = 'Nzdx-SpawnSelector',
        canClose    = false,
		options = {
			{
				title       = 'Bandara',
				event       = 'Nzdx-Spawn:ValidasiSpawn',
                args        = {
                    Status  = 'Bandara',
                    Lokasi  = Nzdx.LokasiBandara
                }
			},
			{
				title       = 'Pelabuhan',
				event       = 'Nzdx-Spawn:ValidasiSpawn',
                args        = {
                    Status  = 'Pelabuhan',
                    Lokasi  = Nzdx.LokasiPelabuhan
                }
			},
            {
				title       = 'Rumah',
				event       = 'Nzdx-Spawn:ValidasiSpawn',
                args        = {
                    Status  = 'Rumah',
                    Lokasi  = Nzdx.TitikRumah
                }
			},
            {
				title       = 'Lokasi Terakhir',
                event       = 'Nzdx-Spawn:ValidasiSpawn',
                args        = {
                    Status  = 'LastLoc',
                    Lokasi  = GetEntityCoords(cache.ped, 1)
                }
			},
		}
	})
	lib.showContext('nzdx:selector')
end)

function NzdxCamSpawn()
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 226.32,-1045.71,389.89, 300.00,0.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    SetEntityVisible(cache.ped, false, 0)
end

function NzdxEfekSpawn()
	PlaySoundFrontend(-1, "Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    Wait(0)
    
	SetEntityVisible(cache.ped, true, 0)
	FreezeEntityPosition(cache.ped, false)
    SetPlayerInvisibleLocally(cache.ped, false)
    SetPlayerInvincible(cache.ped, false)
    
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
end

function NzdxEfekPilih(Nzdx)
    Lokasi = Nzdx

    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam2, Lokasi.x, Lokasi.y, Lokasi.z)
    SetCamActiveWithInterp(cam2, cam, 1000, true, true)
end

RegisterNetEvent('Nzdx-Spawn:ValidasiSpawn', function(data)
    NzdxEfekPilih(data.Lokasi)

    lib.registerContext({
        id          = 'nzdx:public',
		title       = 'Nzdx-SpawnSelector',
        canClose    = false,
        menu        = 'nzdx:selector',
		options = {
			{
				title       = 'Spawn Now',
				event       = 'Nzdx-Spawn:publicturun',
                args        = {
                    Pilihan = data.Status
                }
			},
            {
				title       = 'Back',
				event       = 'Nzdx-Spawn:Display',
			},
		}
	})
	lib.showContext('nzdx:public')
end)

RegisterNetEvent('Nzdx-Spawn:publicturun', function(data)
    if data.Pilihan == 'Bandara' then
        local Lokasi = Nzdx.LokasiBandara

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 1500, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, Lokasi.x, Lokasi.y, Lokasi.z + 75)
        SetCamActiveWithInterp(cam, cam, 500, true, true)

        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end

        Wait(500)
    
        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, Lokasi.x, Lokasi.y, Lokasi.z)
        SetCamActiveWithInterp(cam2, cam, 1000, true, true)
        SetEntityCoords(cache.ped, Lokasi.x, Lokasi.y, Lokasi.z)
        SetEntityVisible(cache.ped, true, 0)
        NzdxEfekSpawn()
    elseif data.Pilihan == 'Pelabuhan' then
        local Lokasi = Nzdx.LokasiPelabuhan

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 1500, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, Lokasi.x, Lokasi.y, Lokasi.z + 75)
        SetCamActiveWithInterp(cam, cam, 500, true, true)

        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end

        Wait(500)
    
        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, Lokasi.x, Lokasi.y, Lokasi.z)
        SetCamActiveWithInterp(cam2, cam, 1000, true, true)
        SetEntityCoords(cache.ped, Lokasi.x, Lokasi.y, Lokasi.z)
        SetEntityVisible(cache.ped, true, 0)
        NzdxEfekSpawn()
    elseif data.Pilihan == 'LastLoc' then
        local Lokasi = GetEntityCoords(cache.ped, 1)

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 1500, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, Lokasi.x, Lokasi.y, Lokasi.z + 75)
        SetCamActiveWithInterp(cam, cam, 500, true, true)

        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end

        Wait(500)
    
        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, Lokasi.x, Lokasi.y, Lokasi.z)
        SetCamActiveWithInterp(cam2, cam, 1000, true, true)
        SetEntityCoords(cache.ped, Lokasi.x, Lokasi.y, Lokasi.z)
        SetEntityVisible(cache.ped, true, 0)
        NzdxEfekSpawn()
    elseif data.Pilihan == 'Rumah'then
        for a, b in pairs(Nzdx.RumahSpawn) do
            if b.NamaSteam == ESX.PlayerData.identifier then 
                local Lokasi = b.Lokasi

                cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 1500, 300.00,0.00,0.00, 110.00, false, 0)
                PointCamAtCoord(cam, Lokasi.x, Lokasi.y, Lokasi.z + 75)
                SetCamActiveWithInterp(cam, cam, 500, true, true)
    
                if DoesCamExist(cam) then
                    DestroyCam(cam, true)
                end
    
                Wait(500)
            
                cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Lokasi.x, Lokasi.y, Lokasi.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
                PointCamAtCoord(cam2, Lokasi.x, Lokasi.y, Lokasi.z)
                SetCamActiveWithInterp(cam2, cam, 1000, true, true)
                SetEntityCoords(cache.ped, Lokasi.x, Lokasi.y, Lokasi.z)
                SetEntityVisible(cache.ped, true, 0)
                NzdxEfekSpawn()
            else
                lib.notify({
                    title       = 'Nzdx-Spawn',
                    description = 'Kamu Tidak Memiliki Rumah',
                    type        = 'error'
                })
                lib.showContext('nzdx:selector')
            end
        end
    end
end)


RegisterCommand('a', function()
    TriggerEvent("Nzdx-Spawn:Display")
end)
