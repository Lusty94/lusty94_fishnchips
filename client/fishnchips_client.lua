local QBCore = exports['qb-core']:GetCoreObject()
local NotifyType = Config.CoreSettings.Notify.Type
local InvType = Config.CoreSettings.Inventory.Type
local TargetType = Config.CoreSettings.Target.Type
local ClothingType = Config.CoreSettings.Clothing.Type
local onDuty, busy = false, false
PlayerJob = {}
local spawnedFishProps = {}

--dev mode keeps duty to true so you dont have to keep clocking in and out when testing - SET TO FALSE IN CONFIG FOR A LIVE SERVER
if Config.DevMode then
    onDuty = true
end


--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print("Lusty94_FishNChips: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Fish N Chips" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message.") return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'boii' then
        exports['boii_ui']:notify(title, msg, type, time)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    end
end


--clothing lockers
RegisterNetEvent('lusty94_fishnchips:client:changeClothes', function()
    if ClothingType == 'qb' then
        TriggerEvent('qb-clothing:client:openOutfitMenu')
    elseif ClothingType == 'illenium' then
        TriggerEvent('qb-clothing:client:openOutfitMenu') -- illenium has backwards compat built in just make sure you have followed docs for illenium    
    elseif ClothingType == 'custom' then
        -- insert your own custom code for opening outfit menu in your clothing script
    end
end)


--WASHING HANDS
RegisterNetEvent("lusty94_fishnchips:client:WashHands", function()
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
    else
        busy = true
        if Config.CoreSettings.Sound.UseInteractSound then
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.WashingHands, 0.5)
        end
        if lib.progressCircle({ 
            duration = Config.CoreSettings.Timers.WashHands,
            label = Config.Language.ProgressBar.WashHands,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { car = true, move = true, },
            anim = { clip = Config.Animations.WashingHands.Anim, dict = Config.Animations.WashingHands.AnimDict,}, 
        }) then  
            busy = false
        else 
            busy = false
            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
        end
    end
end)

------------------------------< DRINKS >------------------------
local drinksDict = Config.Animations.PourDrinks.AnimDict
local drinksAnim = Config.Animations.PourDrinks.Anim
local drinksFlag = Config.Animations.PourDrinks.Flags

--pour soft drinks
RegisterNetEvent('lusty94_fishnchips:client:PourSoftDrinks', function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Soft Drinks Machine', {
                { type = 'input', placeholder = 'How many do you want to pour?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
                { type = 'input', placeholder = 'What drink do you want?', disabled = true, icon = 'question', },
                { type = 'checkbox', label = 'E-Cola?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'E-Cola Light?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Orange Soda?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Sprunk?', checked = false, disabled = false, required = false, },
            })        
            if input then
                local amount = tonumber(input[2])
                local ecola = input[4]
                local ecolalight = input[5]
                local orangesoda = input[6]
                local sprunk = input[7]
                local drinkSelected = input[4] or input[5] or input[6] or input[7]
                if drinkSelected then
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:SoftDrinksCup', function(HasItems)
                            if HasItems then
                                busy = true
                                LockInventory(true)
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PourDrinks * amount,
                                    label = Config.Language.ProgressBar.PourDrinks,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = true, move = true, },
                                    anim = { dict = drinksDict, clip = drinksAnim, flag = drinksFlag,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:PourSoftDrinks', amount, ecola, ecolalight, orangesoda, sprunk)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount, ecola, ecolalight, orangesoda, sprunk)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
                else
                    SendNotify(Config.Language.Notifications.NoDrinkSelected, 'error', 2000)
                end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)


--pour hot drinks
RegisterNetEvent('lusty94_fishnchips:client:PourHotDrinks', function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to pour?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
                { type = 'input', placeholder = 'What drink do you want?', disabled = true, icon = 'question', },
                { type = 'checkbox', label = 'Coffee?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Tea?', checked = false, disabled = false, required = false, },
            })        
            if input then
                local amount = tonumber(input[2])
                local ecola = input[4]
                local ecolalight = input[5]
                local drinkSelected = input[4] or input[5]
                if drinkSelected then
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:CoffeeCup', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = true, move = true, },
                                    anim = { dict = drinksDict, clip = drinksAnim, flag = drinksFlag,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:PourHotDrinks', amount, ecola, ecolalight, orangesoda, sprunk)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount, ecola, ecolalight, orangesoda, sprunk)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
                else
                    SendNotify(Config.Language.Notifications.NoDrinkSelected, 'error', 2000)
                end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)
------------------------------< INGREDIENTS >------------------------

local ingredDict = Config.Animations.PrepareIngredients.AnimDict
local ingredAnim = Config.Animations.PrepareIngredients.Anim
local ingredFlag = Config.Animations.PrepareIngredients.Flags
local ingredProp = Config.Animations.PrepareIngredients.Prop
local ingredBone = Config.Animations.PrepareIngredients.Bone
local ingredPos = Config.Animations.PrepareIngredients.Pos
local ingredRot = Config.Animations.PrepareIngredients.Rot

--slice potatoes
RegisterNetEvent("lusty94_fishnchips:client:SlicePotatoes", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to slice?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:Potatoes', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PrepareIngredients, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = ingredDict, clip = ingredAnim, flag = ingredFlag, },
                                    prop = { model = ingredProp, bone = ingredBone, pos = ingredPos, rot = ingredRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:SlicePotatoes', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--slice burger buns
RegisterNetEvent("lusty94_fishnchips:client:SliceBuns", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to slice?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BurgerBuns', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PrepareIngredients, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = ingredDict, clip = ingredAnim, flag = ingredFlag, },
                                    prop = { model = ingredProp, bone = ingredBone, pos = ingredPos, rot = ingredRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:SliceBuns', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)


--batter fish types
RegisterNetEvent('lusty94_fishnchips:client:BatterFish', function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to batter?', disabled = true, icon = 'fish', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
                { type = 'input', placeholder = 'What fish do you want to batter?', disabled = true, icon = 'fish', },
                { type = 'checkbox', label = 'Cod?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Haddock?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Plaice?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Pollock?', checked = false, disabled = false, required = false, },
                { type = 'checkbox', label = 'Dover Sole?', checked = false, disabled = false, required = false, },
            })        
            if input then
                local amount = tonumber(input[2])
                local cod = input[4]
                local haddock = input[5]
                local plaice = input[6]
                local pollock = input[7]
                local sole = input[8]
                local fishSelected = input[4] or input[5] or input[6] or input[7] or input[8]
                if fishSelected then
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatterFish', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = true, move = true, },
                                    anim = { dict = ingredDict, clip = ingredAnim, flag = ingredFlag,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:BatterFish', amount, cod, haddock, plaice, pollock, sole)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount, cod, haddock, plaice, pollock, sole)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
                else
                    SendNotify(Config.Language.Notifications.NoFishSelected, 'error', 2000)
                end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--batter sausages
RegisterNetEvent("lusty94_fishnchips:client:BatterSausage", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to batter?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:Sausage', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = ingredDict, clip = ingredAnim, flag = ingredFlag, },
                                    prop = { model = ingredProp, bone = ingredBone, pos = ingredPos, rot = ingredRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:BatterSausage', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)


--batter chocolate
RegisterNetEvent("lusty94_fishnchips:client:BatterChocolate", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to batter?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:Chocolate', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = ingredDict, clip = ingredAnim, flag = ingredFlag, },
                                    prop = { model = ingredProp, bone = ingredBone, pos = ingredPos, rot = ingredRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:BatterChocolate', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--batter chicken strips
RegisterNetEvent("lusty94_fishnchips:client:BatterChickenStrips", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to batter?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:RawChickenStrips', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.PrepareIngredients * amount,
                                    label = Config.Language.ProgressBar.PrepareIngredients,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = ingredDict, clip = ingredAnim, flag = ingredFlag, },
                                    prop = { model = ingredProp, bone = ingredBone, pos = ingredPos, rot = ingredRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:BatterChickenStrips', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)


----------------------------< FRYER >----------------------------
local fryDict = Config.Animations.UseFryer.AnimDict
local fryAnim = Config.Animations.UseFryer.Anim
local fryFlag = Config.Animations.UseFryer.Flags
local fryProp = Config.Animations.UseFryer.Prop
local fryBone = Config.Animations.UseFryer.Bone
local fryPos = Config.Animations.UseFryer.Pos
local fryRot = Config.Animations.UseFryer.Rot


--cook fries
RegisterNetEvent("lusty94_fishnchips:client:CookFries", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:Fries', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookFries', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook nuggets
RegisterNetEvent("lusty94_fishnchips:client:CookNuggets", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:Nuggets', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookNuggets', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook chicken strips
RegisterNetEvent("lusty94_fishnchips:client:CookChickenStrips", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredChickenStrips', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookChickenStrips', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook fish cake
RegisterNetEvent("lusty94_fishnchips:client:CookFishCake", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:FishCake', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookFishCake', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook sausage
RegisterNetEvent("lusty94_fishnchips:client:CookSausage", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredSausage', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookSausage', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook chocolate bar
RegisterNetEvent("lusty94_fishnchips:client:CookChocolate", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredChocolate', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookChocolate', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook cheese burger
RegisterNetEvent("lusty94_fishnchips:client:CookCheeseBurger", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:CheeseBurger', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookCheeseBurger', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook chicken burger
RegisterNetEvent("lusty94_fishnchips:client:CookChickenBurger", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:ChickenBurger', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookChickenBurger', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook cod
RegisterNetEvent("lusty94_fishnchips:client:CookCod", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredCod', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookCod', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook haddock
RegisterNetEvent("lusty94_fishnchips:client:CookHaddock", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredHaddock', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookHaddock', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook plaice
RegisterNetEvent("lusty94_fishnchips:client:CookPlaice", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredPlaice', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookPlaice', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook pollock
RegisterNetEvent("lusty94_fishnchips:client:CookPollock", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredPollock', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookPollock', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--cook sole
RegisterNetEvent("lusty94_fishnchips:client:CookSole", function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            local input = lib.inputDialog('Fish N Chips', {
                { type = 'input', placeholder = 'How many do you want to cook?', disabled = true, icon = 'question', },
                { type = 'slider', required = true, default = 1, min = 1, max = 10, },
            })        
            if input then
                local amount = tonumber(input[2])
                    if amount > 0 then
                        QBCore.Functions.TriggerCallback('lusty94_fishnchips:get:BatteredSole', function(HasItems)
                            if HasItems then                                
                                busy = true
                                LockInventory(true)
                                if Config.CoreSettings.Sound.UseInteractSound then
                                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.UseFryer, 0.5)
                                end
                                if lib.progressCircle({
                                    duration = Config.CoreSettings.Timers.UseFryer * amount,
                                    label = Config.Language.ProgressBar.UseFryer,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = { car = false, move = true, },
                                    anim = { dict = fryDict, clip = fryAnim, flag = fryFlag, },
                                    prop = { model = fryProp, bone = fryBone, pos = fryPos, rot = fryRot,},
                                }) then                                    
                                    TriggerServerEvent('lusty94_fishnchips:server:CookSole', amount)
                                    busy = false
                                    LockInventory(false)
                                else 
                                    busy = false
                                    LockInventory(false)
                                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                                end                                
                            else
                                SendNotify(Config.Language.Notifications.MissingItems, 'error', 2000)
                            end
                        end, amount)
                    else
                        SendNotify(Config.Language.Notifications.InvalidAmount, 'error', 2000)
                    end
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)



---------------------< STASHES >------------------------


--collection tray
RegisterNetEvent("lusty94_fishnchips:client:OpenTray", function()
    if InvType == 'qb' then
        local stashinfo = { maxweight = 100000, slots = 6, }
        TriggerEvent("inventory:client:SetCurrentStash", "fishnchipscollection")
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "fishnchipscollection", {
            maxweight = stashinfo.maxweight,
            slots = stashinfo.slots,
        })
    elseif InvType == 'ox' then
        exports.ox_inventory:openInventory('stash', 'fishnchipscollection')
    end
end)


--storage heater
RegisterNetEvent("lusty94_fishnchips:client:OpenStorageHeater", function()
    if onDuty then
        local stashinfo = { maxweight = 10000000, slots = 64, }
        if InvType == 'qb' then
            TriggerEvent("inventory:client:SetCurrentStash", "fishnchipsstorageheater")
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "fishnchipsstorageheater", {
                maxweight = stashinfo.maxweight,
            slots = stashinfo.slots,
            })
        elseif InvType == 'ox' then
            exports.ox_inventory:openInventory('stash', 'fishnchipsstorageheater')
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)


--service counter
RegisterNetEvent("lusty94_fishnchips:client:OpenServiceCounter", function()
    if onDuty then
        if InvType == 'qb' then
            local stashinfo = { maxweight = 10000000, slots = 64, }
            TriggerEvent("inventory:client:SetCurrentStash", "fishnchipsservicecounter")
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "fishnchipsservicecounter", {
                maxweight = stashinfo.maxweight,
            slots = stashinfo.slots,
            })
        elseif InvType == 'ox' then
            exports.ox_inventory:openInventory('stash', 'fishnchipsservicecounter')
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)



-------------< OTHER STUFF >---------------
--give knives
RegisterNetEvent('lusty94_fishnchips:client:GiveKnife', function()
    if onDuty then
        local input = lib.inputDialog('Knife Drawer', {
            {
                type = 'select',
                label = 'Knife Type',
                description = 'What knife do you want?',
                icon = 'arrow-right', 
                options = { 
                    {value = 'kitchen', label = 'Kitchen Knife', },
                    {value = 'bread', label = 'Bread Knife', },
                }, 
            },
        })
        if input then
            local knifeType = tostring(input[1])
            TriggerServerEvent('lusty94_fishnchips:server:GiveKnife', knifeType)
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

-- soft drinks cups
RegisterNetEvent('lusty94_fishnchips:client:GetDrinksCups', function()
    if onDuty then
        local input = lib.inputDialog('Fish N Chips', {
            {
                type = 'select',
                label = 'Cup Type',
                description = 'What cup do you want?',
                icon = 'arrow-right', 
                options = { 
                    {value = 'coffee', label = 'Coffee Cup', },
                    {value = 'soft', label = 'Soft Drinks Cup', },
                }, 
            },
            {type = 'number', label = 'Soft Drinks Cups', description = 'How many do you want?', icon = 'arrow-right'},
        })
        if input then
            local cupType = tostring(input[1])
            local amount = input[2]
            TriggerServerEvent('lusty94_fishnchips:server:GiveDrinksCup', cupType, amount)
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--get a drink from water dispenser
RegisterNetEvent('lusty94_fishnchips:client:WaterDispenser', function()
    if onDuty then
        if busy then
            SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        else
            busy = true
            if lib.progressCircle({
                duration = 3000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { car = false, move = false, },
                anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
                prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            }) then 
                busy = false
                TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + math.random(25,30))
                SendNotify('Thtirst quenched!', 'success', 2000)
            else
                busy = false
            end
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--ingredients freezer
RegisterNetEvent('lusty94_fishnchips:client:GiveIngredients', function()
    if onDuty then
        local input = lib.inputDialog('Ingredients Freezer', {
            {
                type = 'select',
                label = 'Ingredients Freezer',
                description = 'Select ingredients from the list below',
                icon = 'arrow-down', 
                options = { 
                    {value = 'burgerbun',           label = 'Burger Bun', },
                    {value = 'cheeseslice',         label = 'Cheese Slice', },
                    {value = 'battermix',           label = 'Batter Mix', },
                    {value = 'frozencod',           label = 'Frozen Cod Fillet', },
                    {value = 'frozenhaddock',       label = 'Frozen Haddock Fillet', },
                    {value = 'frozenplaice',        label = 'Frozen Plaice Fillet', },
                    {value = 'frozenpollock',       label = 'Frozen Pollock Fillet', },
                    {value = 'frozensole',          label = 'Frozen Dover Sole Fillet', },
                    {value = 'fishcake',            label = 'Frozen Fish Cake', },
                    {value = 'frozensausage',       label = 'Frozen Sausage', },
                    {value = 'potato',              label = 'Potato', },
                    {value = 'burgerpatty',         label = 'Frozen Burger Patty', },
                    {value = 'chickenpatty',        label = 'Frozen Chicken Patty', },
                    {value = 'rawnuggets',          label = 'RAW Chicken Nuggets', },
                    {value = 'rawstrips',           label = 'RAW Chicken Strips', },
                    {value = 'chocolate',           label = 'Chocolate Bar', },
                    {value = 'rimjob',              label = 'Rim Job', },
                    {value = 'creampie',            label = 'Cream Pie', },
                    {value = 'brownie',             label = 'Brownie', },
                    {value = 'gelato',              label = 'Gelato', },
                }, 
            },
            { type = 'slider', required = true, default = 1, min = 1, max = 25, }, -- increase the max amount of ingredients player can get each time when selecting which one they want
        })
        if input then
            local ingredients = lib.progressCircle({
                duration = 1000,
                label = 'Getting ingredients',
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { car = false, move = true, },
                anim = { dict = 'mini@repair', clip = 'fixing_a_ped', flag = 49, },
            })
            if ingredients then
                local ingredient = tostring(input[1])
                local amount = tonumber(input[2])
                TriggerServerEvent('lusty94_fishnchips:server:GiveIngredients', ingredient, amount)
            else
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        else
            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)

--billing input for tills
RegisterNetEvent("lusty94_fishnchips:client:bill")
AddEventHandler("lusty94_fishnchips:client:bill", function()
    if onDuty then
        local bill = lib.inputDialog('Fish N Chips Payment Till', {
            {type = 'input', label = 'Citizen ID', description = 'Players Citizen ID', icon = 'hashtag'},
            {type = 'number', label = 'Bill Price', description = 'The Bills Total Price', icon = 'dollar-sign'}
        })
        if bill ~= nil then
            if bill[1] == nil or bill[2] == nil then
                return
            end
            TriggerServerEvent('lusty94_fishnchips:server:bill:player', bill[1], bill[2])
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)



--eat food items
RegisterNetEvent('lusty94_fishnchips:client:eatFood', function(itemName)
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
    else
        busy = true
        LockInventory(true)
        if lib.progressCircle({
            duration = Config.CoreSettings.Timers.EatFood,
            label = 'Eating food..',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { car = false, move = false, },
            anim = { dict = Config.Animations.Eat.AnimDict, clip = Config.Animations.Eat.Anim, flag = Config.Animations.Eat.Flag,},
            prop = { model = Config.Animations.Eat.Prop, bone = Config.Animations.Eat.Bone, pos = Config.Animations.Eat.Pos, rot = Config.Animations.Eat.Rot,},
        }) then
            TriggerServerEvent("lusty94_fishnchips:server:eatFood", itemName)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.FoodItems[itemName])
            busy = false
            LockInventory(false)
        else 
            busy = false
            LockInventory(false)
            SendNotify(Config.Language.Notifications.CancelledName, 'error', 2000)
        end
    end
end)

--drink
RegisterNetEvent('lusty94_fishnchips:client:Drink', function(itemName)
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
    else
        busy = true
        LockInventory(true)
        if lib.progressCircle({
            duration = Config.CoreSettings.Timers.Drink,
            label = 'Taking a sip..',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { car = false, move = false, },
            anim = { dict = Config.Animations.Drink.AnimDict, clip = Config.Animations.Drink.Anim, flag = Config.Animations.Drink.Flag,},
            prop = { model = Config.Animations.Drink.Prop, bone = Config.Animations.Drink.Bone, pos = Config.Animations.Drink.Pos, rot = Config.Animations.Drink.Rot,},
        }) then
            TriggerServerEvent("lusty94_fishnchips:server:Drink", itemName)
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.DrinkItems[itemName])
            busy = false
            LockInventory(false)
        else 
            busy = false
            LockInventory(false)
            SendNotify(Config.Language.Notifications.CancelledName, 'error', 2000)
        end
    end
end)

---------------------------< DONT TOUCH >-----------------------
-- function to lock inventory to prevent exploits
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true) -- used by qb, ps and ox
        --this is the old method below
        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set("inv_busy", false, true) -- used by qb, ps and ox
        --this is the old method below
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", false, true)
        end        
        ]]
    end
end

--function to display item images for ox_lib menu
function ItemImage(img)
	if InvType == 'ox' then
		return "nui://ox_inventory/web/images/".. img.. '.png'
	elseif InvType == 'qb' then
		return "nui://qb-inventory/html/images/".. QBCore.Shared.Items[img].image
	end
end

--BLIPS
CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.useblip then
            v.blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(v.blip, v.id)
            SetBlipDisplay(v.blip, 4)
            SetBlipScale(v.blip, v.scale)
            SetBlipColour(v.blip, v.colour)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.title)
            EndTextCommandSetBlipName(v.blip)
        end
    end
end)

--spawned props
CreateThread(function()
    for k,v  in pairs(Config.InteractionLocations.Props) do
        lib.requestModel(v.Model, 5000)
        fishProps = CreateObject(v.Model, v.Coords.x, v.Coords.y, v.Coords.z - 1, true, false, false)
        PlaceObjectOnGroundProperly(fishProps, true)
        SetEntityHeading(fishProps, v.Coords.w - 180)
        spawnedFishProps[#spawnedFishProps+1] = fishProps
        FreezeEntityPosition(fishProps, true)
        if TargetType == 'qb' then
            exports['qb-target']:AddTargetEntity(fishProps, { options = { { type = "client", job = v.Job, event = v.Event, icon = v.Icon, label = v.Label, }, }, distance = v.Distance })
        elseif TargetType == 'ox' then
            exports.ox_target:addLocalEntity(fishProps, { { name = 'fishProps', groups = v.Job, icon = v.Icon, label = v.Label, event = v.Event, distance = v.Distance} })
        end
    end
end)

--dont touch
RegisterNetEvent("lusty94_fishnchips:client:ToggleDuty", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

--dont touch
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    for _, v in pairs(spawnedFishProps) do SetEntityAsMissionEntity(v, false, true) DeleteObject(v) end print('Fish N Chips Props - Objects Deleted')
    spawnedFishProps = {}
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerJob.type == 'fishnchips' then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)    
end)
--dont touch
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)
--dont touch
RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

--dont touch
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        busy = false
        LockInventory(false)
        for _, v in pairs(spawnedFishProps) do SetEntityAsMissionEntity(v, false, true) DeleteObject(v) end
        spawnedFishProps = {}
        for k,v in pairs(Config.InteractionLocations.Props) do if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(fishProps, 'fishProps') elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(fishProps, 'fishProps') end end
        for k, v in pairs(Config.InteractionLocations.JobAreas) do if TargetType == 'qb' then exports['qb-target']:RemoveZone(v.Name) elseif TargetType == 'ox' then exports.ox_target:removeZone(v.Name) end end
        for k, v in pairs(Config.InteractionLocations.PreparationAreas) do if TargetType == 'qb' then exports['qb-target']:RemoveZone(v.Name) elseif TargetType == 'ox' then exports.ox_target:removeZone(v.Name) end end
        for k, v in pairs(Config.InteractionLocations.StorageAreas) do if TargetType == 'qb' then exports['qb-target']:RemoveZone(v.Name) elseif TargetType == 'ox' then exports.ox_target:removeZone(v.Name) end end              
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Up & Fish N Chips V1.0.0 Stopped Successfully ^5--<^3!^5>--^7')
    end
end)
