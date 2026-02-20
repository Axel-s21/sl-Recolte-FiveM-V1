RegisterNetEvent('sl_gather:giveItem', function(item)
    local src = source
    local amount = math.random(2,4)

    if not item then return end

    exports.ox_inventory:AddItem(src, item, amount)
end)

