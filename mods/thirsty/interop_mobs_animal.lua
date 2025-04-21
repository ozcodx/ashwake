------------------------------------------------------------
--             _____ _    _        _                      --
--            |_   _| |_ (_)_ _ __| |_ _  _               --
--              | | | ' \| | '_(_-<  _| || |              --
--              |_| |_||_|_|_| /__/\__|\_, |              --
--                                     |__/               --
------------------------------------------------------------
--           Thirsty mod [interop_mobs_animal]            --
------------------------------------------------------------
--            Settings to support mobs_animal             --
------------------------------------------------------------
local E = thirsty.ext_nodes_items

----------------------------
-- Hydrate and Food Items --
----------------------------

E.glass_milk = 'mobs:glass_milk'

thirsty.register_food_drink(E.glass_milk, 1, 0, 4, 22, E.drinking_glass)
thirsty.register_food_drink("mobs:honey", 2, 0, 1, 20, nil)
