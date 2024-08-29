Config = {}


--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


--Thank you for downloading this script!

--Below you can change multiple options to suit your server needs.




Config.DebugPoly = false
-- displays boxzone locations

Config.DevMode = false
-- enables onDuty = true so you dont have to keep clocking in / out when restarting the script for configuration - MAKE SURE TO SET TO FALSE FOR LIVE SERVER


Config.Blips = {
    {title = 'Fish n Chips', colour = 5, id = 280, coords = vector3(-1272.86, -1199.6, 5.35), scale = 0.7, useblip = true}, -- BLIP FOR FISH N CHIPS
}   

Config.CoreSettings = {
    Target = {
        Type = 'qb', -- support for qb-target and ox_target    
        --use 'qb' for qb-target
        --use 'ox' for ox_target
        --use 'custom' for your own target methods and edit targets.lua to suit
    },
    Notify = {
        Type = 'qb', -- notification type, support for qb-core notify, okokNotify, mythic_notify, boii_ui notify and ox_lib notify
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for myhthic_notify
        --use 'boii' for boii_ui notify
        --use 'ox' for ox_lib notify
    },
    Inventory = { -- support for qb-inventory and ox_inventory
        Type = 'qb',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
    },
    Clothing = {
        Type = 'qb' -- clothing type, support for qb-clothing and illenium-appearance
        --use 'qb' for qb-clothing
        --use 'illenium' for illenium-appearance
        --use 'custom' for your own clothing script - edit the following event: 'lusty94_fishnchips:client:changeClothes' and add your own methods
    }, 
    Sound = {
        UseInteractSound = false, -- set to true to play sound when performing certain actions 
        --[[ REQUIRES INTERACT-SOUND AND MUST BE STARTED BEFORE THIS RESOURCE TO WORK PROPERLY]]
        --[[ MAKE SURE YOU HAVE PUT THE .OGG FILES INSIDE OF [SOUNDS] IN YOUR INTERACT-SOUND/CLIENT/HTML/SOUNDS FOLDER TO WORK PROPERLY ]]

        -- [[  IF YOU CHANGE ANY SOUNDS BELOW THEN MAKE SURE THE .OGG FILE IS LOCATED IN YOUR INTERACT-SOUND/CLIENT/HTML/SOUNDS TO WORK PROPERLY ]]

        WashingHands = 'washinghands', -- sound to be played when washing hands
        PourDrinks = 'fizzydrinksmachine', -- sound to be played when pouring drinks
        PrepareIngredients = 'chopping', -- sound to be played when preparing ingredients
        UseFryer = 'deepfatfryer', -- sound to be played when using fryer
    },
    Timers = {
        WashHands = 5000, -- time it takes to wash hands
        PourDrinks = 5000, -- time it takes to pour drinks for 1 item - if making multiple then this is multiplied by the amount the player inputs
        PrepareIngredients = 5000, -- time it takes to prepare ingredients for 1 item - if making multiple then this is multiplied by the amount the player inputs 
        UseFryer = 5000, -- time it takes to use fryer for 1 item - if making multiple then this is multiplied by the amount the player inputs
        EatFood = 5000, -- time it takes to eat food items
        Drink = 5000, -- time it takes to consume drink items
    },    
}




Config.InteractionLocations = {
    JobAreas = {
        { Name = "fishnchipclothinglocker",      Location = vector3(-1255.47, -1216.82, 5.0),     Width = 0.75,   Height = 2.0,       Heading = 291.71, MinZ = 4.5, MaxZ = 6.0,   Icon = 'fa-solid fa-shirt',         Label = 'Change Clothing',          Job = 'fishnchips',      Size = vec3(2.0,0.75,1.5),       Event = 'lusty94_fishnchips:client:changeClothes', Distance = 1.5,},
        { Name = "fishnchippayment1",            Location = vector3(-1261.85, -1208.64, 5.0),     Width = 0.5,    Height = 0.5,       Heading = 19.99,  MinZ = 4.5, MaxZ = 5.5,   Icon = 'fa-solid fa-money-bill',    Label = 'Charge Customer',          Job = 'fishnchips',      Size = vec3(0.5,0.5,0.5),        Event = 'lusty94_fishnchips:client:bill', Distance = 1.5,},
        { Name = "fishnchippayment2",            Location = vector3(-1264.92, -1209.81, 5.0),     Width = 0.5,    Height = 0.5,       Heading = 19.99,  MinZ = 4.5, MaxZ = 5.5,   Icon = 'fa-solid fa-money-bill',    Label = 'Charge Customer',          Job = 'fishnchips',      Size = vec3(0.5,0.5,0.5),        Event = 'lusty94_fishnchips:client:bill', Distance = 1.5,},
        { Name = "fishnchipingredientsfreezer",  Location = vector3(-1258.96, -1216.31, 5.0),     Width = 0.75,   Height = 1.25,      Heading = 200.64, MinZ = 4.5, MaxZ = 5.5,   Icon = 'fa-solid fa-box',           Label = 'Open Ingredients Freezer', Job = 'fishnchips',      Size = vec3(1.25,0.75,1.5),      Event = 'lusty94_fishnchips:client:GiveIngredients', Distance = 1.5,},
        { Name = "fishnchipwaterdispenser",      Location = vector3(-1267.16, -1208.31, 5.0),     Width = 0.5,    Height = 0.5,       Heading = 109.48, MinZ = 4.5, MaxZ = 5.5,   Icon = 'fa-solid fa-bottle-water',  Label = 'Get A Drink',              Job = 'fishnchips',      Size = vec3(0.5,0.5,1.0),        Event = 'lusty94_fishnchips:client:WaterDispenser', Distance = 1.5,},
    },
    PreparationAreas = {
        { Name = "fishnchiphandwash",            Location = vector3(-1260.43, -1213.56, 5.0),     Width = 0.75,   Height = 1.0,       Heading = 108.9,  MinZ = 4.5, MaxZ = 5.50,   Icon = 'fa-solid fa-hands',         Label = 'Wash Hands',           Job = 'fishnchips',    Size = vec3(1.0,0.75,0.5),   Event = 'lusty94_fishnchips:client:WashHands', Distance = 1.0,},
        { Name = "fishnchipprepareingredients",  Location = vector3(-1262.0, -1214.17, 5.0),      Width = 1.25,   Height = 1.25,      Heading = 200.28, MinZ = 4.5, MaxZ = 5.5,    Icon = 'fa-solid fa-bowl-food',     Label = 'Prepare Ingredients',  Job = 'fishnchips',    Size = vec3(1.25,1.25,1.0),  Event = 'lusty94_fishnchips:client:IngredientsMenu', Distance = 2.0,},
        { Name = "fishnchipfryer1",              Location = vector3(-1257.43, -1210.6, 5.0),      Width = 1.0,    Height = 1.0,       Heading = 289.13, MinZ = 4.5, MaxZ = 5.5,    Icon = 'fa-solid fa-hand',          Label = 'Use Fryer',            Job = 'fishnchips',    Size = vec3(1.25,1.0,1.0),   Event = 'lusty94_fishnchips:client:FryerMenu1', Distance = 1.5,},
        { Name = "fishnchipfryer2",              Location = vector3(-1256.44, -1213.85, 5.0),     Width = 1.0,    Height = 1.0,       Heading = 289.13, MinZ = 4.5, MaxZ = 5.5,    Icon = 'fa-solid fa-hand',          Label = 'Use Fryer',            Job = 'fishnchips',    Size = vec3(1.25,1.0,1.0),   Event = 'lusty94_fishnchips:client:FryerMenu2', Distance = 1.5,},
    },
    StorageAreas = {
        { Name = "fishnchipcollection",          Location = vector3(-1263.08, -1209.21, 5.0),     Width = 0.5,    Height = 0.5,   Heading = 18.88,  MinZ = 4.5, MaxZ = 5.0,   Icon = 'fa-solid fa-box', Label = 'Open Collection Tray',         Job = nil,                   Size = vec3(0.5,0.5,0.5),     Event = 'lusty94_fishnchips:client:OpenTray', Distance = 2.0,},
        { Name = "fishnchipstorage",             Location = vector3(-1257.21, -1212.32, 5.0),     Width = 1.0,    Height = 1.0,   Heading = 289.13, MinZ = 4.5, MaxZ = 5.5,   Icon = 'fa-solid fa-box', Label = 'Open Storage Heater',          Job = 'fishnchips',          Size = vec3(1.0,1.0,1.0),     Event = 'lusty94_fishnchips:client:OpenStorageHeater', Distance = 2.0,},
        { Name = "fishnchipservicecounter",      Location = vector3(-1262.91, -1211.63, 5.0),     Width = 1.0,    Height = 1.0,   Heading = 19.73,  MinZ = 4.5, MaxZ = 5.5,   Icon = 'fa-solid fa-box', Label = 'Open Service Counter',         Job = 'fishnchips',          Size = vec3(1.0,1.0,0.75),    Event = 'lusty94_fishnchips:client:OpenServiceCounter', Distance = 2.0,},
    },
    Props = {
        { Model = 'bkr_prop_fakeid_clipboard_01a',      Coords = vector4(-1264.51, -1215.13, 6.01, 234),    Icon = 'fa-solid fa-hand-point-up', Label = 'Clock on Duty',            Event = 'lusty94_fishnchips:client:ToggleDuty',         Job = 'fishnchips', Distance = 2.0, },
        { Model = 'v_corp_officedesk003',               Coords = vector4(-1264.80, -1214.2, 5.13, 291.38),  Icon = 'fa-solid fa-hand-point-up', Label = 'Open Management Computer', Event = 'qb-bossmenu:client:OpenMenu',                  Job = 'fishnchips', Distance = 1.5, },
        { Model = 'prop_food_bs_soda_01',               Coords = vector4(-1260.37, -1210.7, 6.07, 200.0),   Icon = 'fa-solid fa-hand-point-up', Label = 'Pour Soft Drinks',         Event = 'lusty94_fishnchips:client:PourSoftDrinks',         Job = 'fishnchips', Distance = 1.0, },
        { Model = 'prop_coffee_mac_01',                 Coords = vector4(-1261.7, -1211.27, 6.08, 200.0),   Icon = 'fa-solid fa-hand-point-up', Label = 'Pour Hot Drinks',          Event = 'lusty94_fishnchips:client:PourHotDrinks',      Job = 'fishnchips', Distance = 1.0, },
        { Model = 'prop_food_cups2',                    Coords = vector4(-1261.04, -1211.01, 6.08, 22.33),  Icon = 'fa-solid fa-hand-point-up', Label = 'Get Drinks Cups',          Event = 'lusty94_fishnchips:client:GetDrinksCups',  Job = 'fishnchips', Distance = 1.0, },
    },    
}


Config.Animations = {
    WashingHands = {
        AnimDict = "mp_arresting",
        Anim = "a_uncuff",
        Flags = 8,
    },
    PourDrinks = {
        AnimDict = "amb@prop_human_bbq@male@idle_a",
        Anim = "idle_a",
        Flags = 41,
    },
    PrepareIngredients = {
        AnimDict = "amb@prop_human_bbq@male@idle_a",
        Anim = "idle_b",
        Flags = 41,
        Prop = 'v_ind_cfknife',
        Bone = 57005,
        Pos = vec3(0.2, 0.14, -0.01),
        Rot = vec3(1.0, 4.0, 57.0),
    },
    UseFryer = {
        AnimDict = "amb@prop_human_bbq@male@idle_a",
        Anim = "idle_b",
        Flags = 41,
        Prop = 'prop_fish_slice_01',
        Bone = 28422,
        Pos = vec3(0.0,0.0,0.0),
        Rot = vec3(0.0,0.0,0.0),
    },
    Eat = {
        AnimDict = "mp_player_inteat@burger",
        Anim = "mp_player_int_eat_burger", 
        Flags = 49,
        Prop = 'prop_cs_burger_01',
        Bone = 60309,
        Pos = vec3(0.0, 0.0, 0.0),
        Rot = vec3(0.0, 0.0, 0.0),
    },
    Drink = {
        AnimDict = "amb@world_human_drinking@coffee@male@idle_a",
        Anim = "idle_c", 
        Flags = 49,
        Prop = 'p_ing_coffeecup_02',
        Bone = 28422,
        Pos = vec3(0.01, -0.01, 0.0),
        Rot = vec3(0.0, 0.0, 0.0),
    },
}
Config.FoodItems = { -- add or remove food items and change hunger replenishment values below
    ['fried_cod'] = math.random(40,60),
    ['fried_haddock'] = math.random(40,60),
    ['fried_plaice'] = math.random(40,60),
    ['fried_pollock'] = math.random(40,60),
    ['fried_sole'] = math.random(40,60),
    ['fried_fishcake'] = math.random(40,60),
    ['fried_sausage'] = math.random(40,60),
    ['fishnchipsfries'] = math.random(40,60),
    ['fishnchipscheeseburger'] = math.random(40,60),
    ['fishnchipschickenburger'] = math.random(40,60),
    ['fishnchipsnuggets'] = math.random(40,60),
    ['fishnchipsfriedchickenstrips'] = math.random(40,60),
    ['fishnchips_chocolate'] = math.random(40,60),
    ['fried_chocolate'] = math.random(40,60),
    ['fishnchipsrimjob'] = math.random(40,60),
    ['fishnchipscreampie'] = math.random(40,60),
    ['fishnchipsbrownie'] = math.random(40,60),
    ['fishnchipsgelato'] = math.random(40,60),
}
Config.DrinkItems = { -- add or remove drink items and change thirst replenishment values below
    ['fishnchipsecolalight'] = math.random(20,40),
    ['fishnchipsecola'] = math.random(20,40),
    ['fishnchipsorangesoda'] = math.random(20,40),
    ['fishnchipssprunk'] = math.random(20,40),
    ['fishnchipscoffee'] = math.random(20,40),
    ['fishnchipstea'] = math.random(20,40),
}

Config.Language = {
    ProgressBar = {
        WashHands = 'Washing hands',
        PourDrinks = 'Pouring drink',
        PrepareIngredients = 'Preparing ingredients',
        UseFryer = 'Using fryer',
    },
    Notifications = {
        Duty = 'You must be clocked on duty to proceed',
        Busy = 'You are already doing something!',
        Cancelled = 'Action cancelled!',
        Failed = 'Action failed!',
        CantCarry = 'You cant carry anymore!',
        NoFishSelected = 'You must select a fish to batter!',
        NoDrinkSelected = 'You must select which drink you want to pour!',
        InvalidAmount = 'You have entered an invalid amount!',
        MissingItems = 'You are missing items. check the requirements!',
        DrinkMade = 'Drink prepared!',
        IngredientPrepared = 'Ingredient prepared!',
        ItemCooked = 'Item cooked!',
    },
}