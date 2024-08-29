
lib.registerContext({
    id = 'FishnChipsPrepareIngredients',
    title = 'Prepare Fresh Ingredients',
    options = {
        {
            icon = 'bars',
            arrow = true,
            title = 'Get Knife',
            event = 'lusty94_fishnchips:client:GiveKnife'
        },
        {
            icon = ItemImage('fishnchipsrawfries'),
            image = ItemImage('fishnchipsrawfries'),
            arrow = true,
            title = 'Slice Potato Into Fries',
            event = 'lusty94_fishnchips:client:SlicePotatoes',
            description = 'Requires: Potatoes & Kitchen Knife',
        },        
        {
            icon = ItemImage('fishnchipsslicedburgerbun'),
            image = ItemImage('fishnchipsslicedburgerbun'),
            arrow = true,
            title = 'Slice Burger Buns',
            event = 'lusty94_fishnchips:client:SliceBuns',
            description = 'Requires: Burger Buns & Bread Knife',
        },        
        {
            icon = ItemImage('battermix'),
            image = ItemImage('battermix'),
            arrow = true,
            title = 'Batter Fish Fillets',
            event = 'lusty94_fishnchips:client:BatterFish',
            description = 'Requires: Batter Mix',
        },        
        {
            icon = ItemImage('frozen_sausage_battered'),
            image = ItemImage('frozen_sausage_battered'),
            arrow = true,
            title = 'Batter Sausages',
            event = 'lusty94_fishnchips:client:BatterSausage',
            description = 'Requires: Batter Mix & Frozen Sausage',
        },        
        {
            icon = ItemImage('fishnchips_chocolate_battered'),
            image = ItemImage('fishnchips_chocolate_battered'),
            arrow = true,
            title = 'Batter Chocolate Bar',
            event = 'lusty94_fishnchips:client:BatterChocolate',
            description = 'Requires: Batter Mix & Chocolate Bar',
        },        
        {
            icon = ItemImage('fishnchipschickenstrips_battered'),
            image = ItemImage('fishnchipschickenstrips_battered'),
            arrow = true,
            title = 'Batter Chicken Strips',
            event = 'lusty94_fishnchips:client:BatterChickenStrips',
            description = 'Requires: Batter Mix & Raw Chicken Strips',
        },        
    }
})



lib.registerContext({
    id = 'FishnChipsFryer1',
    title = 'Cook Hot Food',
    options = {
        {
            icon = ItemImage('fishnchipsfries'),
            image = ItemImage('fishnchipsfries'),
            arrow = true,
            title = 'Cook Fries',
            event = 'lusty94_fishnchips:client:CookFries',
            description = 'Requires: \n Raw fries',
        },
        {
            icon = ItemImage('fishnchipsnuggets'),
            image = ItemImage('fishnchipsnuggets'),
            arrow = true,
            title = 'Cook Nuggets',
            event = 'lusty94_fishnchips:client:CookNuggets',
            description = 'Requires: \n Raw nuggets',
        },
        {
            icon = ItemImage('fishnchipsfriedchickenstrips'),
            image = ItemImage('fishnchipsfriedchickenstrips'),
            arrow = true,
            title = 'Cook Chicken Strips',
            event = 'lusty94_fishnchips:client:CookChickenStrips',
            description = 'Requires: \n Battered chicken strips',
        },
        {
            icon = ItemImage('fried_fishcake'),
            image = ItemImage('fried_fishcake'),
            arrow = true,
            title = 'Cook Fish Cake',
            event = 'lusty94_fishnchips:client:CookFishCake',
            description = 'Requires: \n Frozen fish cake',
        },
        {
            icon = ItemImage('fried_chocolate'),
            image = ItemImage('fried_chocolate'),
            arrow = true,
            title = 'Cook Chocolate',
            event = 'lusty94_fishnchips:client:CookChocolate',
            description = 'Requires: \n Battered chocolate bar',
        },
        {
            icon = ItemImage('fried_sausage'),
            image = ItemImage('fried_sausage'),
            arrow = true,
            title = 'Cook Sausage',
            event = 'lusty94_fishnchips:client:CookSausage',
            description = 'Requires: \n Battered sausage',
        },
        {
            icon = ItemImage('fishnchipscheeseburger'),
            image = ItemImage('fishnchipscheeseburger'),
            arrow = true,
            title = 'Cook Cheese Burger',
            event = 'lusty94_fishnchips:client:CookCheeseBurger',
            description = 'Requires: \n Burger Patty \n Burger Buns \n Cheese Slice',
        },
        {
            icon = ItemImage('fishnchipschickenburger'),
            image = ItemImage('fishnchipschickenburger'),
            arrow = true,
            title = 'Cook Chicken Burger',
            event = 'lusty94_fishnchips:client:CookChickenBurger',
            description = 'Requires: \n Chicken Patty \n Burger Buns \n Cheese Slice',
        },
    }
})


lib.registerContext({
    id = 'FishnChipsFryer2',
    title = 'Cook Hot Food',
    options = {
        {
            icon = ItemImage('fried_cod'),
            image = ItemImage('fried_cod'),
            arrow = true,
            title = 'Cook Cod',
            event = 'lusty94_fishnchips:client:CookCod',
            description = 'Requires: \n Battered cod',
        },
        {
            icon = ItemImage('fried_haddock'),
            image = ItemImage('fried_haddock'),
            arrow = true,
            title = 'Cook Haddock',
            event = 'lusty94_fishnchips:client:CookHaddock',
            description = 'Requires: \n Battered haddock',
        },
        {
            icon = ItemImage('fried_plaice'),
            image = ItemImage('fried_plaice'),
            arrow = true,
            title = 'Cook Plaice',
            event = 'lusty94_fishnchips:client:CookPlaice',
            description = 'Requires: \n Battered plaice',
        },
        {
            icon = ItemImage('fried_pollock'),
            image = ItemImage('fried_pollock'),
            arrow = true,
            title = 'Cook Pollock',
            event = 'lusty94_fishnchips:client:CookPollock',
            description = 'Requires: \n Battered pollock',
        },
        {
            icon = ItemImage('fried_sole'),
            image = ItemImage('fried_sole'),
            arrow = true,
            title = 'Cook Dover Sole',
            event = 'lusty94_fishnchips:client:CookSole',
            description = 'Requires: \n Battered sole',
        },
    }
})


--ingredients menu
RegisterNetEvent('lusty94_fishnchips:client:IngredientsMenu', function()
    lib.showContext('FishnChipsPrepareIngredients')
end)

--fryer menu 1
RegisterNetEvent('lusty94_fishnchips:client:FryerMenu1', function()
    lib.showContext('FishnChipsFryer1')
end)

--fryer menu 2
RegisterNetEvent('lusty94_fishnchips:client:FryerMenu2', function()
    lib.showContext('FishnChipsFryer2')
end)