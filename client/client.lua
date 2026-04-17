local spawnedProps = {}

local function startCrafting(data)
    local ped = PlayerPedId()

    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)

    if lib.progressBar({
        duration = data.duration,
        label = 'Creating: ' .. data.label,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            mouse = false,
            combat = true,
        },
    }) then
        ClearPedTasks(ped)
        TriggerServerEvent('ykaa_crafting:finishCraft', data)
    else
        ClearPedTasks(ped)
        lib.notify({ title = 'Cancelled', description = 'You interrupted work.', type = 'error' })
    end
end

function openCraftMenu()
    local options = {}
    for _, v in ipairs(Config.Items) do
        table.insert(options, {
            title = v.label,
            description = "Materials: " .. v.ingredients[1].count .. "x scrap",
            icon = 'hammer',
            onSelect = function()
                lib.callback('ykaa_crafting:checkItems', false, function(hasItems)
                    if hasItems then
                        startCrafting(v)
                    else
                        lib.notify({ title = 'Error', description = 'You dont have enough scrap.!', type = 'error' })
                    end
                end, v.ingredients)
            end
        })
    end

    lib.registerContext({
        id = 'craft_menu',
        title = 'Crafting Menu',
        options = options
    })
    lib.showContext('craft_menu')
end

local function spawnCraftingBenches()
    for i, data in ipairs(Config.Locations) do
        lib.requestModel(data.model)
        local bench = CreateObject(data.model, data.coords.x, data.coords.y, data.coords.z - 1.0, false, false, false)
        SetEntityHeading(bench, data.heading)
        FreezeEntityPosition(bench, true)
        SetEntityInvincible(bench, true)
        
        table.insert(spawnedProps, bench)

        exports.ox_target:addLocalEntity(bench, {
            {
                name = 'open_crafting_' .. i,
                icon = 'fa-solid fa-wrench',
                label = 'Craft Weapon',
                onSelect = function()
                    openCraftMenu()
                end
            }
        })
    end
end

CreateThread(function()
    spawnCraftingBenches()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, prop in ipairs(spawnedProps) do DeleteEntity(prop) end
    end
end)