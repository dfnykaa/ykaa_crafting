lib.callback.register('ykaa_crafting:checkItems', function(source, ingredients)
    for _, ingredient in ipairs(ingredients) do
        local count = exports.ox_inventory:GetItemCount(source, ingredient.item)
        if count < ingredient.count then return false end
    end
    return true
end)

RegisterNetEvent('ykaa_crafting:finishCraft', function(data)
    local src = source
    
    for _, ingredient in ipairs(data.ingredients) do
        local count = exports.ox_inventory:GetItemCount(src, ingredient.item)
        if count < ingredient.count then return end
    end

    for _, ingredient in ipairs(data.ingredients) do
        exports.ox_inventory:RemoveItem(src, ingredient.item, ingredient.count)
    end

    exports.ox_inventory:AddItem(src, data.item, 1)
    TriggerClientEvent('ox_lib:notify', src, { title = 'Succes', description = 'You made ' .. data.label, type = 'success' })
end)