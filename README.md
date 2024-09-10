## Lusty94_FishNChips


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

PLEASE MAKE SURE TO READ THIS ENTIRE FILE AS IT COVERS SOME IMPORTANT INFORMATION

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



======================================
SCRIPT SUPPORT VIA DISCORD: https://discord.gg/BJGFrThmA8
======================================



## Features

- Prepare fresh ingrediets ready to be cooked
- Pour hot and cold drinks
- Batter items such as fish, sausages and chocolate bar
- Fry various foods for customers
- Water dispenser which gives employees free water
- Input options for events allowing players to make multiple items at once
- Built in consumables system for food and drink
- Language section for custom translations

- Management menu system to hire / fire employees & much more
- Payment tills in the restaurant to charge customers for orders
- Clothing lockers to change outfits
- Custom sounds when performing certain actions [REQUIRES_INTERACT_SOUND]

- Extensive config file
- Change animations
- Change core settings to suit your server
- Support for [ANY] MLO or building - moveable target locations




## DEPENDENCIES

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [qb-clothing](https://github.com/qbcore-framework/qb-clothing)
- [interact-sound](https://github.com/plunkettscott/interact-sound)
- [Moreo Fish n Chips MLO](https://forum.cfx.re/t/free-mlo-fivem-fish-chip-restaurant/5262094)
- [ox_lib](https://github.com/overextended/ox_lib/releases/)




## INSTALLATION

- Add the ##ITEMS snippet below into your core/shared/items.lua file
- Add the ##JOB snippet below to your core/shared/jobs.lua
- Add all .png images inside [images] folder into your inventory/html/images folder - ox_inventory users place images inside inventory/web/images


## INTERACT SOUND

- If set to true in the config then this script uses custom sounds that need to be placed inside of interact-sound resource
- Place ALL .ogg files inside [sounds] folder into your interact-sound/client/html/sounds folder
- Interact sound must be started BEFORE this resource in order to work correctly




## OV_INVENTORY SHOPS / STASHES
-- items list is below in ##OX_INVENTORY ITEMS
-- this resource creates stashes automatically, to edit stash info head to fishnchips_server.lua and look for their functions



## JOB
-- if using ox_inventory and changing boss grade below make sure to change boss grade in the stashes functions too in server file


```

    fishnchips = {
		label = 'Fish N Chips',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Kitchen Porter', payment = 25 },
            ['1'] = { name = 'Team Member', payment = 50 },
            ['2'] = { name = 'Sales Manager', payment = 75 },
            ['3'] = { name = 'Restaurant Manager', isboss= true, payment = 100 },
			
        },
    },

```


## QB-CORE ITEMS

```
    --FISH N CHIPS

    fishnchipsbreadknife 			 = {name = 'fishnchipsbreadknife', 		    label = 'Bread Knife', 		     weight = 200, 		type = 'item', 	 image = 'fishnchipsbreadknife.png', 		    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipskitchenknife 			 = {name = 'fishnchipskitchenknife', 		label = 'Kitchen Knife', 		 weight = 200, 		type = 'item', 	 image = 'fishnchipskitchenknife.png', 		    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipssoftdrinkscup 		 = {name = 'fishnchipssoftdrinkscup', 		label = 'Soft Drinks Cup', 		 weight = 200, 		type = 'item', 	 image = 'fishnchipssoftdrinkscup.png', 		unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipscoffeecup 		     = {name = 'fishnchipscoffeecup', 		    label = 'Coffee Cup', 		     weight = 200, 		type = 'item', 	 image = 'fishnchipscoffeecup.png', 		    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchipsburgerbun 	         = {name = 'fishnchipsburgerbun', 	        label = 'Burger Bun', 	         weight = 200, 		type = 'item', 	 image = 'fishnchipsburgerbun.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsslicedburgerbun 	     = {name = 'fishnchipsslicedburgerbun', 	label = 'Sliced Burger Bun', 	 weight = 200, 		type = 'item', 	 image = 'fishnchipsslicedburgerbun.png', 	    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchipscheeseslice 	         = {name = 'fishnchipscheeseslice', 	    label = 'Cheese Slice', 	     weight = 200, 		type = 'item', 	 image = 'fishnchipscheeseslice.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},

    battermix 	                     = {name = 'battermix', 	                label = 'Batter Mix', 	         weight = 200, 		type = 'item', 	 image = 'battermix.png', 	                    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    
    frozen_cod_fillet 	             = {name = 'frozen_cod_fillet', 	        label = 'Frozen Cod', 	         weight = 200, 		type = 'item', 	 image = 'frozen_cod_fillet.png', 	            unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_cod_battered 	         = {name = 'frozen_cod_battered', 	        label = 'Battered Cod', 	     weight = 200, 		type = 'item', 	 image = 'frozen_cod_battered.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_cod 	                     = {name = 'fried_cod', 	                label = 'Fried Cod', 	         weight = 200, 		type = 'item', 	 image = 'fried_cod.png', 	                    unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_haddock_fillet 	         = {name = 'frozen_haddock_fillet', 	    label = 'Frozen Haddock', 	     weight = 200, 		type = 'item', 	 image = 'frozen_haddock_fillet.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_haddock_battered 	     = {name = 'frozen_haddock_battered', 	    label = 'Battered Haddock', 	 weight = 200, 		type = 'item', 	 image = 'frozen_haddock_battered.png', 	    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_haddock 	                 = {name = 'fried_haddock', 	            label = 'Fried Haddock', 	     weight = 200, 		type = 'item', 	 image = 'fried_haddock.png', 	                unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_plaice_fillet 	         = {name = 'frozen_plaice_fillet', 	        label = 'Frozen Plaice', 	     weight = 200, 		type = 'item', 	 image = 'frozen_plaice_fillet.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_plaice_battered 	         = {name = 'frozen_plaice_battered', 	    label = 'Battered Plaice', 	     weight = 200, 		type = 'item', 	 image = 'frozen_plaice_battered.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_plaice 	                 = {name = 'fried_plaice', 	                label = 'Fried Plaice', 	     weight = 200, 		type = 'item', 	 image = 'fried_plaice.png', 	                unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_pollock_fillet 	         = {name = 'frozen_pollock_fillet', 	    label = 'Frozen Pollock', 	     weight = 200, 		type = 'item', 	 image = 'frozen_pollock_fillet.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_pollock_battered 	     = {name = 'frozen_pollock_battered', 	    label = 'Battered Pollock', 	 weight = 200, 		type = 'item', 	 image = 'frozen_pollock_battered.png', 	    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_pollock 	                 = {name = 'fried_pollock', 	            label = 'Fried Pollock', 	     weight = 200, 		type = 'item', 	 image = 'fried_pollock.png', 	                unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_sole_fillet 	             = {name = 'frozen_sole_fillet', 	        label = 'Frozen Dover Sole', 	 weight = 200, 		type = 'item', 	 image = 'frozen_sole_fillet.png', 	            unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_sole_battered 	         = {name = 'frozen_sole_battered', 	        label = 'Battered Dover Sole', 	 weight = 200, 		type = 'item', 	 image = 'frozen_sole_battered.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_sole 	                     = {name = 'fried_sole', 	                label = 'Fried Dover Sole', 	 weight = 200, 		type = 'item', 	 image = 'fried_sole.png', 	                    unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_fishcake 	             = {name = 'frozen_fishcake', 	            label = 'Frozen Fish Cake', 	 weight = 200, 		type = 'item', 	 image = 'frozen_fishcake.png', 	            unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_fishcake 	                 = {name = 'fried_fishcake', 	            label = 'Fried Fish Cake', 	     weight = 200, 		type = 'item', 	 image = 'fried_fishcake.png', 	                unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_sausage 	                 = {name = 'frozen_sausage', 	            label = 'Frozen Sausage', 	     weight = 200, 		type = 'item', 	 image = 'frozen_sausage.png', 	                unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    frozen_sausage_battered 	     = {name = 'frozen_sausage_battered', 	    label = 'Battered Sausage', 	 weight = 200, 		type = 'item', 	 image = 'frozen_sausage_battered.png', 	    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_sausage 	                 = {name = 'fried_sausage', 	            label = 'Fried Sausage', 	     weight = 200, 		type = 'item', 	 image = 'fried_sausage.png', 	                unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchipspotato 	             = {name = 'fishnchipspotato', 	            label = 'Potato', 	             weight = 200, 		type = 'item', 	 image = 'fishnchipspotato.png', 	            unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsrawfries 	             = {name = 'fishnchipsrawfries', 	        label = 'RAW Fries', 	         weight = 200, 		type = 'item', 	 image = 'fishnchipsrawfries.png', 	            unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsfries 	             = {name = 'fishnchipsfries', 	            label = 'Cooked Fries', 	     weight = 200, 		type = 'item', 	 image = 'fishnchipsfries.png', 	            unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchipsburgerpatty 	         = {name = 'fishnchipsburgerpatty', 	    label = 'Burger Patty', 	     weight = 200, 		type = 'item', 	 image = 'fishnchipsburgerpatty.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipscheeseburger 	         = {name = 'fishnchipscheeseburger', 	    label = 'Cheese Burger', 	     weight = 200, 		type = 'item', 	 image = 'fishnchipscheeseburger.png', 	        unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipschickenpatty 	         = {name = 'fishnchipschickenpatty', 	    label = 'Chicken Burger Patty',  weight = 200, 		type = 'item', 	 image = 'fishnchipschickenpatty.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipschickenburger 	     = {name = 'fishnchipschickenburger', 	    label = 'Chicken Burger', 	     weight = 200, 		type = 'item', 	 image = 'fishnchipschickenburger.png', 	    unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchipsrawnuggets 	         = {name = 'fishnchipsrawnuggets', 	        label = 'RAW Chicken Nuggets', 	 weight = 200, 		type = 'item', 	 image = 'fishnchipsrawnuggets.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsnuggets 	             = {name = 'fishnchipsnuggets', 	        label = 'Chicken Nuggets', 	     weight = 200, 		type = 'item', 	 image = 'fishnchipsnuggets.png', 	            unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchipsrawchickenstrips 	     = {name = 'fishnchipsrawchickenstrips', 	         label = 'RAW Chicken Strips', 	        weight = 200, 		type = 'item', 	 image = 'fishnchipsrawchickenstrips.png', 	            unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipschickenstrips_battered = {name = 'fishnchipschickenstrips_battered', 	     label = 'Battered Chicken Strips', 	weight = 200, 		type = 'item', 	 image = 'fishnchipschickenstrips_battered.png', 	    unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsfriedchickenstrips 	 = {name = 'fishnchipsfriedchickenstrips', 	         label = 'Fried Chicken Strips',        weight = 200, 		type = 'item', 	 image = 'fishnchipsfriedchickenstrips.png', 	        unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    
    fishnchips_chocolate 	         = {name = 'fishnchips_chocolate', 	                 label = 'Chocolate Bar',               weight = 200, 		type = 'item', 	 image = 'fishnchips_chocolate.png', 	                unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchips_chocolate_battered 	 = {name = 'fishnchips_chocolate_battered', 	     label = 'Battered Chocolate Bar',      weight = 200, 		type = 'item', 	 image = 'fishnchips_chocolate_battered.png', 	        unique = false, 	useable = false, 	shouldClose = true,     combinable = nil,   description = ''},
    fried_chocolate 	             = {name = 'fried_chocolate', 	                     label = 'Fried Chocolate Bar',         weight = 200, 		type = 'item', 	 image = 'fried_chocolate.png', 	                    unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    
    
    fishnchipsrimjob 	     = {name = 'fishnchipsrimjob', 	     label = 'Rim Job', 	    weight = 200, 		type = 'item', 	 image = 'fishnchipsrimjob.png', 	unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipscreampie 	     = {name = 'fishnchipscreampie', 	 label = 'Cream Pie', 	    weight = 200, 		type = 'item', 	 image = 'fishnchipscreampie.png', 	unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsbrownie 	     = {name = 'fishnchipsbrownie', 	 label = 'Brownie', 	    weight = 200, 		type = 'item', 	 image = 'fishnchipsbrownie.png', 	unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},
    fishnchipsgelato 	     = {name = 'fishnchipsgelato', 	     label = 'Gelato', 	        weight = 200, 		type = 'item', 	 image = 'fishnchipsgelato.png', 	unique = false, 	useable = true, 	shouldClose = true,     combinable = nil,   description = ''},

    
    fishnchipsecolalight 				 		 	    = {name = 'fishnchipsecolalight', 			  	  		    label = 'E-Cola Light', 		    weight = 200, 		type = 'item', 					image = 'fishnchipsecolalight.png', 						unique = false, 	useable = true, 	shouldClose = true,	    combinable = nil,   description = ''},
    fishnchipsecola 				 		 			= {name = 'fishnchipsecola', 			  	  			    label = 'E-Cola', 					weight = 200, 		type = 'item', 					image = 'fishnchipsecola.png', 						        unique = false, 	useable = true, 	shouldClose = true,	    combinable = nil,   description = ''},
	fishnchipsorangesoda 				 		 		= {name = 'fishnchipsorangesoda', 			  	  			label = 'Orange Soda', 				weight = 200, 		type = 'item', 					image = 'fishnchipsorangesoda.png', 					    unique = false, 	useable = true, 	shouldClose = true,	    combinable = nil,   description = ''},
	fishnchipssprunk 				 		 			= {name = 'fishnchipssprunk', 			  	  				label = 'Sprunk', 					weight = 200, 		type = 'item', 					image = 'fishnchipssprunk.png', 						    unique = false, 	useable = true, 	shouldClose = true,	    combinable = nil,   description = ''},
	fishnchipscoffee 				 		 			= {name = 'fishnchipscoffee', 			  	  				label = 'Coffee', 					weight = 200, 		type = 'item', 					image = 'fishnchipscoffee.png', 						    unique = false, 	useable = true, 	shouldClose = true,	    combinable = nil,   description = ''},
	fishnchipstea 				 		 			    = {name = 'fishnchipstea', 			  	  					label = 'Tea', 						weight = 200, 		type = 'item', 					image = 'fishnchipstea.png', 							    unique = false, 	useable = true, 	shouldClose = true,	    combinable = nil,   description = ''},

```


## OX_IVNETORY ITEMS

```

	["frozen_sole_fillet"] = {
		label = "Frozen Dover Sole",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_sole_fillet.png",
		}
	},

	["frozen_cod_fillet"] = {
		label = "Frozen Cod",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_cod_fillet.png",
		}
	},

	["frozen_haddock_fillet"] = {
		label = "Frozen Haddock",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_haddock_fillet.png",
		}
	},

	["fishnchipstea"] = {
		label = "Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipstea.png",
		}
	},

	["fried_chocolate"] = {
		label = "Fried Chocolate Bar",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_chocolate.png",
		}
	},

	["battermix"] = {
		label = "Batter Mix",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "battermix.png",
		}
	},

	["frozen_pollock_battered"] = {
		label = "Battered Pollock",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_pollock_battered.png",
		}
	},

	["fried_sausage"] = {
		label = "Fried Sausage",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_sausage.png",
		}
	},

	["fishnchipschickenstrips_battered"] = {
		label = "Battered Chicken Strips",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipschickenstrips_battered.png",
		}
	},

	["fishnchipsfriedchickenstrips"] = {
		label = "Fried Chicken Strips",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsfriedchickenstrips.png",
		}
	},

	["fishnchipscoffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipscoffee.png",
		}
	},

	["fishnchipsecolalight"] = {
		label = "E-Cola Light",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsecolalight.png",
		}
	},

	["frozen_plaice_battered"] = {
		label = "Battered Plaice",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_plaice_battered.png",
		}
	},

	["fishnchipsrawfries"] = {
		label = "RAW Fries",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsrawfries.png",
		}
	},

	["frozen_sausage_battered"] = {
		label = "Battered Sausage",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_sausage_battered.png",
		}
	},

	["frozen_haddock_battered"] = {
		label = "Battered Haddock",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_haddock_battered.png",
		}
	},

	["frozen_cod_battered"] = {
		label = "Battered Cod",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_cod_battered.png",
		}
	},

	["fishnchipsslicedburgerbun"] = {
		label = "Sliced Burger Bun",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsslicedburgerbun.png",
		}
	},

	["fishnchipschickenpatty"] = {
		label = "Chicken Burger Patty",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipschickenpatty.png",
		}
	},

	["fishnchipsrawnuggets"] = {
		label = "RAW Chicken Nuggets",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsrawnuggets.png",
		}
	},

	["fishnchipsbreadknife"] = {
		label = "Bread Knife",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsbreadknife.png",
		}
	},

	["fried_haddock"] = {
		label = "Fried Haddock",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_haddock.png",
		}
	},

	["fishnchipscheeseburger"] = {
		label = "Cheese Burger",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipscheeseburger.png",
		}
	},

	["fishnchipskitchenknife"] = {
		label = "Kitchen Knife",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipskitchenknife.png",
		}
	},

	["fishnchips_chocolate"] = {
		label = "Chocolate Bar",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchips_chocolate.png",
		}
	},

	["fried_sole"] = {
		label = "Fried Dover Sole",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_sole.png",
		}
	},

	["fried_pollock"] = {
		label = "Fried Pollock",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_pollock.png",
		}
	},

	["fishnchipscoffeecup"] = {
		label = "Coffee Cup",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipscoffeecup.png",
		}
	},

	["fishnchips_chocolate_battered"] = {
		label = "Battered Chocolate Bar",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchips_chocolate_battered.png",
		}
	},

	["fishnchipschickenburger"] = {
		label = "Chicken Burger",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipschickenburger.png",
		}
	},

	["fishnchipsrimjob"] = {
		label = "Rim Job",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsrimjob.png",
		}
	},

	["fishnchipsgelato"] = {
		label = "Gelato",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsgelato.png",
		}
	},

	["fishnchipsfries"] = {
		label = "Cooked Fries",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsfries.png",
		}
	},

	["fishnchipsburgerbun"] = {
		label = "Burger Bun",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsburgerbun.png",
		}
	},

	["fishnchipsnuggets"] = {
		label = "Chicken Nuggets",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsnuggets.png",
		}
	},

	["fishnchipssprunk"] = {
		label = "Sprunk",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipssprunk.png",
		}
	},

	["fishnchipscreampie"] = {
		label = "Cream Pie",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipscreampie.png",
		}
	},

	["fishnchipssoftdrinkscup"] = {
		label = "Soft Drinks Cup",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipssoftdrinkscup.png",
		}
	},

	["frozen_sole_battered"] = {
		label = "Battered Dover Sole",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_sole_battered.png",
		}
	},

	["fishnchipsecola"] = {
		label = "E-Cola",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsecola.png",
		}
	},

	["fried_cod"] = {
		label = "Fried Cod",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_cod.png",
		}
	},

	["fishnchipscheeseslice"] = {
		label = "Cheese Slice",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipscheeseslice.png",
		}
	},

	["fishnchipsbrownie"] = {
		label = "Brownie",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsbrownie.png",
		}
	},

	["fried_fishcake"] = {
		label = "Fried Fish Cake",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_fishcake.png",
		}
	},

	["frozen_plaice_fillet"] = {
		label = "Frozen Plaice",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_plaice_fillet.png",
		}
	},

	["frozen_sausage"] = {
		label = "Frozen Sausage",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_sausage.png",
		}
	},

	["fishnchipsorangesoda"] = {
		label = "Orange Soda",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsorangesoda.png",
		}
	},

	["fried_plaice"] = {
		label = "Fried Plaice",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fried_plaice.png",
		}
	},

	["frozen_fishcake"] = {
		label = "Frozen Fish Cake",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_fishcake.png",
		}
	},

	["fishnchipsrawchickenstrips"] = {
		label = "RAW Chicken Strips",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsrawchickenstrips.png",
		}
	},

	["fishnchipspotato"] = {
		label = "Potato",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipspotato.png",
		}
	},

	["fishnchipsburgerpatty"] = {
		label = "Burger Patty",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fishnchipsburgerpatty.png",
		}
	},

	["frozen_pollock_fillet"] = {
		label = "Frozen Pollock",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frozen_pollock_fillet.png",
		}
	},

```

