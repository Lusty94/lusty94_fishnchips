local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type


--notification function
local function SendNotify(src, msg, type, time, title)
    if not title then title = "Fish N Chips" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    end
end

--useable items for eating
for k,_ in pairs(Config.FoodItems) do
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent("lusty94_fishnchips:client:eatFood", source, item.name)
    end)
end


--useable items for drinking
for k,_ in pairs(Config.DrinkItems) do
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent("lusty94_fishnchips:client:Drink", source, item.name)
    end)
end

------------------< CALLBACKS >--------------------


--potatoes ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:Potatoes', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipspotato")
    local item2 = Player.Functions.GetItemByName("fishnchipskitchenknife")
    if item1 and item1.amount >= amount and item2 and item2.amount >= 1 then
        cb(true)
    else
        cb(false)
    end
end)


--burger buns ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BurgerBuns', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipsburgerbun")
    local item2 = Player.Functions.GetItemByName("fishnchipsbreadknife")
    if item1 and item1.amount >= amount and item2 and item2.amount >= 1 then
        cb(true)
    else
        cb(false)
    end
end)


--batter fish ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatterFish', function(source, cb, amount, cod, haddock, plaice, pollock, sole)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("battermix")
    local hasFish = true
    if cod then
        local item2 = Player.Functions.GetItemByName("frozen_cod_fillet")
        if not item2 or item2.amount < amount then
            hasFish = false
        end
    end    
    if haddock then
        local item3 = Player.Functions.GetItemByName("frozen_haddock_fillet")
        if not item3 or item3.amount < amount then
            hasFish = false
        end
    end
    if plaice then
        local item4 = Player.Functions.GetItemByName("frozen_plaice_fillet")
        if not item4 or item4.amount < amount then
            hasFish = false
        end
    end
    if pollock then
        local item5 = Player.Functions.GetItemByName("frozen_pollock_fillet")
        if not item5 or item5.amount < amount then
            hasFish = false
        end
    end
    if sole then
        local item6 = Player.Functions.GetItemByName("frozen_sole_fillet")
        if not item6 or item6.amount < amount then
            hasFish = false
        end
    end
    if item1 and item1.amount >= amount and hasFish then
        cb(true)
    else
        cb(false)
    end
end)


--sausages ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:Sausage', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_sausage")
    local item2 = Player.Functions.GetItemByName("battermix")
    if item1 and item1.amount >= amount and item2 and item2.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--chocolatebar ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:Chocolate', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchips_chocolate")
    local item2 = Player.Functions.GetItemByName("battermix")
    if item1 and item1.amount >= amount and item2 and item2.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--raw chicken strips ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:RawChickenStrips', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipsrawchickenstrips")
    local item2 = Player.Functions.GetItemByName("battermix")
    if item1 and item1.amount >= amount and item2 and item2.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)


--raw fries callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:Fries', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipsrawfries")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--raw nuggets callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:Nuggets', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipsrawnuggets")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered chickenstrips callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredChickenStrips', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipschickenstrips_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)


--frozen fish cake callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:FishCake', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_fishcake")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered sausasge callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredSausage', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_sausage_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered chocolate bar callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredChocolate', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchips_chocolate_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--cheese burger ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:CheeseBurger', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipsburgerpatty")
    local item2 = Player.Functions.GetItemByName("fishnchipsslicedburgerbun")
    local item3 = Player.Functions.GetItemByName("fishnchipscheeseslice")
    if item1 and item1.amount >= amount and item2 and item2.amount and item3 and item3.amount then
        cb(true)
    else
        cb(false)
    end
end)

--chicken burger ingredients callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:ChickenBurger', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipschickenpatty")
    local item2 = Player.Functions.GetItemByName("fishnchipsslicedburgerbun")
    local item3 = Player.Functions.GetItemByName("fishnchipscheeseslice")
    if item1 and item1.amount >= amount and item2 and item2.amount and item3 and item3.amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered cod callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredCod', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_cod_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered haddock callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredHaddock', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_haddock_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered plaice callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredPlaice', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_plaice_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered pollock callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredPollock', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_pollock_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--battered sole callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:BatteredSole', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("frozen_sole_battered")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

--soft drinks cup callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:SoftDrinksCup', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipssoftdrinkscup")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)
--coffee cup callback
QBCore.Functions.CreateCallback('lusty94_fishnchips:get:CoffeeCup', function(source, cb, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName("fishnchipscoffeecup")
    if item1 and item1.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)
------------------< EVENTS >--------------------

--eat food
RegisterNetEvent('lusty94_fishnchips:server:eatFood', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local fishFoods = nil
    for k in pairs(Config.FoodItems) do
        if k == item then
            fishFoods = k
            break
        end
    end
    if not fishFoods then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem(fishFoods, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[fishFoods], "remove", 1)
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src, fishFoods, 1)
    end
end)


--drink
RegisterNetEvent('lusty94_fishnchips:server:Drink', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local fishDrinks = nil
    for k in pairs(Config.DrinkItems) do
        if k == item then
            fishDrinks = k
            break
        end
    end
    if not fishDrinks then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem(fishDrinks, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[fishDrinks], "remove", 1)
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src, fishDrinks, 1)
    end
end)



--give knifes
RegisterNetEvent('lusty94_fishnchips:server:GiveKnife', function(knifeType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local knife = nil
    if knifeType == 'kitchen' then
        knife = 'fishnchipskitchenknife'
    elseif knifeType == 'bread' then
        knife = 'fishnchipsbreadknife'
    end
    if InvType == 'qb' then
            Player.Functions.AddItem(knife, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[knife], 'add', 1)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, knife, 1) then
            exports.ox_inventory:AddItem(src,knife, 1)
        else
            SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
        end
    end
end)

--give ingredients
RegisterNetEvent('lusty94_fishnchips:server:GiveIngredients', function(ingredient, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = nil
    if ingredient == 'burgerbun' then
        item = 'fishnchipsburgerbun'
    elseif ingredient == 'cheeseslice' then
        item = 'fishnchipscheeseslice'
    elseif ingredient == 'battermix' then
        item = 'battermix'
    elseif ingredient == 'frozencod' then
        item = 'frozen_cod_fillet'
    elseif ingredient == 'frozenhaddock' then
        item = 'frozen_haddock_fillet'
    elseif ingredient == 'frozenplaice' then
        item = 'frozen_plaice_fillet'
    elseif ingredient == 'frozenpollock' then
        item = 'frozen_pollock_fillet'
    elseif ingredient == 'frozensole' then
        item = 'frozen_sole_fillet'
    elseif ingredient == 'fishcake' then
        item = 'frozen_fishcake'
    elseif ingredient == 'frozensausage' then
        item = 'frozen_sausage'
    elseif ingredient == 'potato' then
        item = 'fishnchipspotato'
    elseif ingredient == 'burgerpatty' then
        item = 'fishnchipsburgerpatty'
    elseif ingredient == 'chickenpatty' then
        item = 'fishnchipschickenpatty'
    elseif ingredient == 'rawnuggets' then
        item = 'fishnchipsrawnuggets'
    elseif ingredient == 'rawstrips' then
        item = 'fishnchipsrawchickenstrips'
    elseif ingredient == 'chocolate' then
        item = 'fishnchips_chocolate'
    elseif ingredient == 'rimjob' then
        item = 'fishnchipsrimjob'
    elseif ingredient == 'creampie' then
        item = 'fishnchipscreampie'
    elseif ingredient == 'brownie' then
        item = 'fishnchipsbrownie'
    elseif ingredient == 'gelato' then
        item = 'fishnchipsgelato'
    end
    if InvType == 'qb' then
            Player.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, item, amount) then
            exports.ox_inventory:AddItem(src,item, amount)
        else
            SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
        end
    end
end)

--give drinks cups
RegisterNetEvent('lusty94_fishnchips:server:GiveDrinksCup', function(cupType, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local cup = nil
    if cupType == 'coffee' then
        cup = 'fishnchipscoffeecup'
    elseif cupType == 'soft' then
        cup = 'fishnchipssoftdrinkscup'
    end
    if InvType == 'qb' then
            Player.Functions.AddItem(cup, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[cup], 'add', amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, cup, amount) then
            exports.ox_inventory:AddItem(src,cup, amount)
        else
            SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
        end
    end
end)

--pour soft drinks
RegisterNetEvent('lusty94_fishnchips:server:PourSoftDrinks', function(amount, ecola, ecolalight, orangesoda, sprunk)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local requiredAmount = 1
    local returnAmount = 1 
    if not Player then return end
    local drinkType = nil
    if ecola then
        drinkType = 'fishnchipsecola'
    elseif ecolalight then
        drinkType = 'fishnchipsecolalight'
    elseif orangesoda then
        drinkType = 'fishnchipsorangesoda'
    elseif sprunk then
        drinkType = 'fishnchipssprunk'
    end
    if InvType == 'qb' then
        Player.Functions.RemoveItem('fishnchipssoftdrinkscup', requiredAmount * amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipssoftdrinkscup'], 'remove', requiredAmount * amount)
        Player.Functions.AddItem(drinkType, amount * returnAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[drinkType], 'add', amount * returnAmount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, drinkType, amount * returnAmount) then
            exports.ox_inventory:RemoveItem(src,'fishnchipssoftdrinkscup', requiredAmount * amount)
            exports.ox_inventory:AddItem(src,drinkType, amount * returnAmount)
        else
            SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
        end
    end
end)

--pour hot drinks
RegisterNetEvent('lusty94_fishnchips:server:PourHotDrinks', function(amount, coffee, tea)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local requiredAmount = 1
    local returnAmount = 1 
    if not Player then return end
    local drinkType = nil
    if coffee then
        drinkType = 'fishnchipscoffee'
    elseif tea then
        drinkType = 'fishnchipstea'
    end
    if InvType == 'qb' then
        Player.Functions.RemoveItem('fishnchipscoffeecup', requiredAmount * amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipscoffeecup'], 'remove', requiredAmount * amount)
        Player.Functions.AddItem(drinkType, amount * returnAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[drinkType], 'add', amount * returnAmount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, drinkType, amount * returnAmount) then
            exports.ox_inventory:RemoveItem(src,'fishnchipscoffeecup', requiredAmount * amount)
            exports.ox_inventory:AddItem(src,drinkType, amount * returnAmount)
        else
            SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
        end
    end
end)




------< INGREDIENTS >----

--slice potatoes
RegisterNetEvent('lusty94_fishnchips:server:SlicePotatoes', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 2
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipspotato', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipspotato'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipsrawfries', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsrawfries'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipspotato', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipsrawfries', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipsrawfries', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--slice burger buns
RegisterNetEvent('lusty94_fishnchips:server:SliceBuns', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 2
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipsburgerbun', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsburgerbun'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipsslicedburgerbun', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsslicedburgerbun'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipsburgerbun', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipsslicedburgerbun', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipsslicedburgerbun', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--make battered fish
RegisterNetEvent('lusty94_fishnchips:server:BatterFish', function(amount, cod, haddock, plaice, pollock, sole)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1    
    local fishType = nil
    if cod then
        fishType = 'frozen_cod_battered'
        if InvType == 'qb' then
            Player.Functions.RemoveItem('frozen_cod_fillet', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_cod_fillet'], 'remove', requiredAmount * amount)
        elseif InvType == 'ox' then
            exports.ox_inventory:RemoveItem(src,'frozen_cod_fillet', requiredAmount * amount)
        end
    elseif haddock then
        fishType = 'frozen_haddock_battered'
        if InvType == 'qb' then
            Player.Functions.RemoveItem('frozen_haddock_fillet', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_haddock_fillet'], 'remove', requiredAmount * amount)
        elseif InvType == 'ox' then
            exports.ox_inventory:RemoveItem(src,'frozen_haddock_fillet', requiredAmount * amount)
        end
    elseif plaice then
        fishType = 'frozen_plaice_battered'
        if InvType == 'qb' then
            Player.Functions.RemoveItem('frozen_plaice_fillet', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_plaice_fillet'], 'remove', requiredAmount * amount)
        elseif InvType == 'ox' then
            exports.ox_inventory:RemoveItem(src,'frozen_plaice_fillet', requiredAmount * amount)
        end
    elseif pollock then
        fishType = 'frozen_pollock_battered'
        if InvType == 'qb' then
            Player.Functions.RemoveItem('frozen_pollock_fillet', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_pollock_fillet'], 'remove', requiredAmount * amount)
        elseif InvType == 'ox' then
            exports.ox_inventory:RemoveItem(src,'frozen_pollock_fillet', requiredAmount * amount)
        end
    elseif sole then
        fishType = 'frozen_sole_battered'
        if InvType == 'qb' then
            Player.Functions.RemoveItem('frozen_sole_fillet', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_sole_fillet'], 'remove', requiredAmount * amount)
        elseif InvType == 'ox' then
            exports.ox_inventory:RemoveItem(src,'frozen_sole_fillet', requiredAmount * amount)
        end
    end
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('battermix', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['battermix'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem(fishType, amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[fishType], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'battermix', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, fishType, amount * returnAmount) then
                exports.ox_inventory:AddItem(src,fishType, amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--batter sausage
RegisterNetEvent('lusty94_fishnchips:server:BatterSausage', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('battermix', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['battermix'], 'remove', requiredAmount * amount)
            Player.Functions.RemoveItem('frozen_sausage', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_sausage'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('frozen_sausage_battered', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_sausage_battered'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'battermix', requiredAmount * amount) then
            exports.ox_inventory:RemoveItem(src,'frozen_sausage', requiredAmount * amount)
            if exports.ox_inventory:CanCarryItem(src, 'frozen_sausage_battered', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'frozen_sausage_battered', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--batter chocolate
RegisterNetEvent('lusty94_fishnchips:server:BatterChocolate', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('battermix', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['battermix'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchips_chocolate', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchips_chocolate'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchips_chocolate_battered', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchips_chocolate_battered'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'battermix', requiredAmount * amount) then
            exports.ox_inventory:RemoveItem(src,'fishnchips_chocolate', requiredAmount * amount)
            if exports.ox_inventory:CanCarryItem(src, 'fishnchips_chocolate_battered', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchips_chocolate_battered', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--batter chicken strips
RegisterNetEvent('lusty94_fishnchips:server:BatterChickenStrips', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('battermix', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['battermix'], 'remove', requiredAmount * amount)
            Player.Functions.RemoveItem('fishnchipsrawchickenstrips', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsrawchickenstrips'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipschickenstrips_battered', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipschickenstrips_battered'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipsrawchickenstrips', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipschickenstrips_battered', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipschickenstrips_battered', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


-------< COOKING >-------

--cook fries
RegisterNetEvent('lusty94_fishnchips:server:CookFries', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipsrawfries', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsrawfries'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipsfries', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsfries'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipsrawfries', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipsfries', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipsfries', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--cook nuggets
RegisterNetEvent('lusty94_fishnchips:server:CookNuggets', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipsrawnuggets', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsrawnuggets'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipsnuggets', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsnuggets'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipsrawnuggets', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipsnuggets', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipsnuggets', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--cook chickenstrips
RegisterNetEvent('lusty94_fishnchips:server:CookChickenStrips', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipschickenstrips_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipschickenstrips_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipsfriedchickenstrips', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsfriedchickenstrips'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipschickenstrips_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipsfriedchickenstrips', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipsfriedchickenstrips', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--cook fish cake
RegisterNetEvent('lusty94_fishnchips:server:CookFishCake', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_fishcake', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_fishcake'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_fishcake', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_fishcake'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_fishcake', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_fishcake', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_fishcake', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--cook sausage
RegisterNetEvent('lusty94_fishnchips:server:CookSausage', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_sausage_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_sausage_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_sausage', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_sausage'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_sausage_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_sausage', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_sausage', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--cook chocolate
RegisterNetEvent('lusty94_fishnchips:server:CookChocolate', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchips_chocolate_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchips_chocolate_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_chocolate', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_chocolate'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchips_chocolate_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_chocolate', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_chocolate', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--cook cheese burger
RegisterNetEvent('lusty94_fishnchips:server:CookCheeseBurger', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipsburgerpatty', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsburgerpatty'], 'remove', requiredAmount * amount)
            Player.Functions.RemoveItem('fishnchipsslicedburgerbun', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsslicedburgerbun'], 'remove', requiredAmount * amount)
            Player.Functions.RemoveItem('fishnchipscheeseslice', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipscheeseslice'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipscheeseburger', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipscheeseburger'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipsburgerpatty', requiredAmount * amount) then
            exports.ox_inventory:RemoveItem(src,'fishnchipsslicedburgerbun', requiredAmount * amount)
            exports.ox_inventory:RemoveItem(src,'fishnchipscheeseslice', requiredAmount * amount)
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipscheeseburger', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipscheeseburger', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--cook chicken burger
RegisterNetEvent('lusty94_fishnchips:server:CookChickenBurger', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('fishnchipschickenpatty', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipschickenpatty'], 'remove', requiredAmount * amount)
            Player.Functions.RemoveItem('fishnchipsslicedburgerbun', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipsslicedburgerbun'], 'remove', requiredAmount * amount)
            Player.Functions.RemoveItem('fishnchipscheeseslice', requiredAmount * amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipscheeseslice'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fishnchipschickenburger', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishnchipschickenburger'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'fishnchipschickenpatty', requiredAmount * amount) then
            exports.ox_inventory:RemoveItem(src,'fishnchipsslicedburgerbun', requiredAmount * amount)
            exports.ox_inventory:RemoveItem(src,'fishnchipscheeseslice', requiredAmount * amount)
            if exports.ox_inventory:CanCarryItem(src, 'fishnchipschickenburger', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fishnchipschickenburger', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--cook battered cod
RegisterNetEvent('lusty94_fishnchips:server:CookCod', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_cod_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_cod_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_cod', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_cod'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_cod_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_cod', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_cod', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--cook battered haddock
RegisterNetEvent('lusty94_fishnchips:server:CookHaddock', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_haddock_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_haddock_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_haddock', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_haddock'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_haddock_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_haddock', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_haddock', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)

--cook battered plaice
RegisterNetEvent('lusty94_fishnchips:server:CookPlaice', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_plaice_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_plaice_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_plaice', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_plaice'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_plaice_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_plaice', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_plaice', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--cook battered pollock
RegisterNetEvent('lusty94_fishnchips:server:CookPollock', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_pollock_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_pollock_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_pollock', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_pollock'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_pollock_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_pollock', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_pollock', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


--cook battered sole
RegisterNetEvent('lusty94_fishnchips:server:CookSole', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local requiredAmount = 1
    local returnAmount = 1
    if InvType == 'qb' then
        if Player.Functions.RemoveItem('frozen_sole_battered', requiredAmount * amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['frozen_sole_battered'], 'remove', requiredAmount * amount)
            Player.Functions.AddItem('fried_sole', amount * returnAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fried_sole'], 'add', amount * returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src,'frozen_sole_battered', requiredAmount * amount) then
            if exports.ox_inventory:CanCarryItem(src, 'fried_sole', amount * returnAmount) then
                exports.ox_inventory:AddItem(src,'fried_sole', amount * returnAmount)
            else
                SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 2000)
            end
        end
    end
end)


-------------< OX_INVENTORY STASHES >------------
--collection tray
function fishnchipscollection()
    local collectionTray = {
        id = 'fishnchipscollection',
        label = 'Fish N Chips Collection Tray',
        slots = 5,
        weight = 10000000,
        owner = false,
    }
    exports.ox_inventory:RegisterStash(collectionTray.id, collectionTray.label, collectionTray.slots, collectionTray.weight, collectionTray.owner, collectionTray.jobs)
    print('stash created: ', collectionTray.id, 'label: ', collectionTray.label, 'slots: ', collectionTray.slots, 'weight: ', collectionTray.weight)
end

--storage heater
function fishnchipsstorageheater()
    local storageFridge = {
        id = 'fishnchipsstorageheater',
        label = 'Fish N Chips Storage Heater',
        slots = 64,
        weight = 100000000,
        owner = true,
        jobs = {["fishnchips"] = 0},
    }
    exports.ox_inventory:RegisterStash(storageFridge.id, storageFridge.label, storageFridge.slots, storageFridge.weight, storageFridge.owner, storageFridge.jobs)
    print('stash created: ', storageFridge.id, 'label: ', storageFridge.label, 'slots: ', storageFridge.slots, 'weight: ', storageFridge.weight)
end

--service counter
function fishnchipsservicecounter()
    local serviceCounter = {
        id = 'fishnchipsservicecounter',
        label = 'Fish N Chips Service Counter',
        slots = 64,
        weight = 100000000,
        owner = true,
        jobs = {["fishnchips"] = 0},
    }
    exports.ox_inventory:RegisterStash(serviceCounter.id, serviceCounter.label, serviceCounter.slots, serviceCounter.weight, serviceCounter.owner, serviceCounter.jobs)
    print('stash created: ', serviceCounter.id, 'label: ', serviceCounter.label, 'slots: ', serviceCounter.slots, 'weight: ', serviceCounter.weight)
end

-- dont touch this is for ox stashes and shops
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if InvType == 'ox' then
            print('^5--<^3!^5>-- ^7| Lusty94_FishNChips |^5 ^5--<^3!^5>--^7')
            print('^5--<^3!^5>-- ^7| Inventory Type is set to ox |^5 ^5--<^3!^5>--^7')
            print('^5--<^3!^5>-- ^7| Registering shops and stashes |^5 ^5--<^3!^5>--^7')
            fishnchipscollection()
            fishnchipsstorageheater()
            fishnchipsservicecounter()
            print('^5--<^3!^5>-- ^7| Shops and stashes registered successfully |^5 ^5--<^3!^5>--^7')
        end
    end
end)


local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/FishNChips/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^2Current^7: "..currentVersion.." ^2Latest^7: "..newestVersion..advice) end
		--print(advice)
	end)
end
CheckVersion()