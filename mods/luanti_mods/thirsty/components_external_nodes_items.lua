------------------------------------------------------------
--             _____ _    _        _                      --
--            |_   _| |_ (_)_ _ __| |_ _  _               --
--              | | | ' \| | '_(_-<  _| || |              --
--              |_| |_||_|_|_| /__/\__|\_, |              --
--                                     |__/               --
------------------------------------------------------------
--            Thirsty mod external nodes items            --
------------------------------------------------------------
--                See init.lua for license                --
------------------------------------------------------------

--[[
These are nodes and items required to make canteens and
fountains. Simply change the name here to change the reference
across the whole mod.
]] --
local E          = thirsty.ext_nodes_items

-- item and node mod aliases, change these as needed.
-- if item doesn't exist as either Ingredient or Augmented
-- item it won't register.

-- Ingredients
E.group_wood     = "group:wood"
E.stone          = "group:stone"

-- Augumented Items
E.drinking_glass = "vessels:drinking_glass"
E.glass_bottle_f = "vessels_glass_bottle_full_cc_by_sa_3.png" -- image for registering full version of above
E.steel_bottle   = "vessels:steel_bottle"
-- E.glass_milk         = "mobs:glass_milk" -- note needs E.drinking_glass for empty return item

if core.global_exists('default') then
    -- Basic Water, change here or register
    -- using thirsty.register_hydrate_node()
    -- and leave these unchanged.
    E.water_source       = "default:water_source"
    E.water_source_f     = "default:water_flowing"
    E.water_source_riv   = "default:river_water_source"
    E.water_source_riv_f = "default:river_water_flowing"
    E.glass_bottle       = "vessels:glass_bottle" -- looks like glass potion bottle
    E.steel_ingot        = "default:steel_ingot"
    E.bronze_ingot       = "default:bronze_ingot"
    E.copper_ingot       = "default:copper_ingot"
    E.mese_crystal       = "default:mese_crystal"
    E.diamond            = "default:diamond"
    E.bucket_water       = "bucket:bucket_water"
    E.bucket_empty       = "bucket:bucket_empty"
    E.wood_bowl          = "farming:bowl"
end
if core.global_exists('mcl_vars') then -- Mineclone-compatible
    -- Basic Water, change here or register
    -- using thirsty.register_hydrate_node()
    -- and leave these unchanged.
    E.water_source       = "mcl_core:water_source"
    E.water_source_f     = "mcl_core:water_flowing"
    E.water_source_riv   = "mclx_core:river_water_source"
    E.water_source_riv_f = "mclx_core:river_water_flowing"
    E.glass_bottle       = 'mcl_potions:glass_bottle'
    E.steel_ingot        = "mcl_core:iron_ingot"
    E.bronze_ingot       = "mcl_copper:copper_ingot"
    E.copper_ingot       = "mcl_copper:copper_ingot"
    E.mese_crystal       = "mcl_redstone:redstone"
    E.diamond            = "mcl_core:diamond"
    E.bucket_water       = "mcl_buckets:bucket_water"
    E.bucket_empty       = "mcl_buckets:bucket_empty"
    E.wood_bowl          = "mcl_core:bowl"
end
