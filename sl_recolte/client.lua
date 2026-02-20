local spawnedProps = {}

local function spawnProp(zoneName, zone)
    local model = joaat(zone.prop)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local angle = math.random() * 2 * math.pi
    local radius = math.random() * zone.radius
    local x = zone.coords.x + math.cos(angle) * radius
    local y = zone.coords.y + math.sin(angle) * radius
    local z = zone.coords.z

    local prop = CreateObject(model, x, y, z - 1.0, true, true, false)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)

    if not spawnedProps[zoneName] then
        spawnedProps[zoneName] = {}
    end

    table.insert(spawnedProps[zoneName], prop)

    exports.ox_target:addLocalEntity(prop, {
        {
            label = zone.label,
            icon = "fa-solid fa-hammer",
            onSelect = function()
                harvestProp(prop, zoneName)
            end
        }
    })
end

function harvestProp(prop, zoneName)
    local zone = Config.Zones[zoneName]
    if not zone then return end
    if not DoesEntityExist(prop) then return end

    local harvestTime = Config.HarvestTime or 5000 -- sécurité anti-nil

    local success = lib.progressBar({
        duration = harvestTime,
        label = zone.label or "Récolte...",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            combat = true,
            car = true
        },
        anim = {
            scenario = "WORLD_HUMAN_HAMMERING"
        }
    })

    if success then
        TriggerServerEvent('sl_gather:giveItem', zone.item)
        DeleteEntity(prop)

        SetTimeout((zone.respawnTime or 600) * 1000, function()
            spawnProp(zoneName, zone)
        end)
    end
end

CreateThread(function()
    Wait(1000)

    for zoneName, zone in pairs(Config.Zones) do
        for i = 1, zone.spawnAmount do
            spawnProp(zoneName, zone)
        end
    end
end)

-- =========================
-- BLIPS
-- =========================

CreateThread(function()
    Wait(1000)

    for zoneName, zone in pairs(Config.Zones) do
        if zone.blip and zone.blip.enabled then
            local blip = AddBlipForCoord(zone.coords)

            SetBlipSprite(blip, zone.blip.sprite)
            SetBlipScale(blip, zone.blip.scale)
            SetBlipColour(blip, zone.blip.color)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(zone.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

