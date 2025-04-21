------------------------------------------------------------
--             _____ _    _        _                      --
--            |_   _| |_ (_)_ _ __| |_ _  _               --
--              | | | ' \| | '_(_-<  _| || |              --
--              |_| |_||_|_|_| /__/\__|\_, |              --
--                                     |__/               --
------------------------------------------------------------
--                 Thirsty mod [thirsty]                  --
------------------------------------------------------------
-- A mod that adds a "thirst" mechanic, similar to hunger --
--  Copyright (C) 2015 Ben Deutsch <ben@bendeutsch.de>    --
------------------------------------------------------------
-- name idea thirsty_revive or thirsty_renew
---------------
--[[ License --
---------------

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
USA

--Media/Images--
See Readme.MD - Mix of:
CC BY-SA 3.0
CC BY-SA 4.0
CC0 1.0 Universal

-------------------------------------------
-- Terminology: "Thirst" vs. "hydration" --
-------------------------------------------

"Thirst" is the absence of "hydration" (a term suggested by
everamzah on the Luanti forums, thanks!). The overall mechanic
is still called "thirst", but the visible bar is that of
"hydration", filled with "hydro points".
]] --

thirsty = {}

thirsty.version = '1.1.0'

-- Configuration variables
thirsty.config = {
	-- configuration in Settings>>Mods>>Thirsty
	-- Best to not change defaults here
	-- [General]
	tick_time                   = core.settings:get("thirsty_tick_time") or 0.5,
	start                       = core.settings:get("thirsty_starting_value") or 20,
	thirst_per_second           = core.settings:get("thirst_per_second") or (1.0 / 30),
	damage_per_second           = core.settings:get("damage_per_second") or (1.0 / 10.0),
	stand_still_for_drink       = core.settings:get("stand_still_for_drink") or 1.0,
	stand_still_for_afk         = core.settings:get("stand_still_for_afk") or 120.0,
	enable_damage               = core.settings:get_bool("enable_damage"),

	-- [Water Fountain]
	regen_from_fountain         = core.settings:get("regen_from_fountain") or 0.5,
	fountain_height             = core.settings:get("fountain_height") or 4,
	fountain_max_level          = core.settings:get("fountain_max_level") or 20,
	fountain_distance_per_level = core.settings:get("fountain_distance_per_level") or 5,

	-- [Thirsty Mod Items]
	register_bowl               = core.settings:get_bool("register_bowl", true),
	register_canteens           = core.settings:get_bool("register_canteens", true),
	register_drinking_fountain  = core.settings:get_bool("register_drinking", true),
	register_fountains          = core.settings:get_bool("register_fountains", true),
	register_amulets            = core.settings:get_bool("register_amulets", true),

	-- [Other Mods]
	register_vessels            = core.settings:get_bool("register_vessels", true),

	-- [Node/Item Tables] Do not change names without code updates.
	-- Use API functions to register to these tables
	regen_from_node             = {},
	node_drinkable              = {},
	drink_from_container        = {},
	container_capacity          = {},
	drink_from_node             = {},
	fountain_type               = {},
	extraction_for_item         = {},
	injection_for_item          = {},
	thirst_adjust_item          = {},
}

-- water fountains
thirsty.fountains = {
	--[[
	x:y:z = {
		pos = { x=x, y=y, z=z },
		level = 4,
		time_until_check = 20,
		-- something about times
	}
	]]
}

thirsty.ext_nodes_items = {
	--[[ acts as an internal
		mod aliasing for ingredients
		used in Canteen/Fountain recipes.
		to change edit:
		components_external_nodes_items.lua
		
		steel_ingot = default:steel_ingot
	]]
}

-- general settings
thirsty.time_next_tick = 0.0

thirsty.player = {}

core.register_on_joinplayer(function(player)
	thirsty.player[player:get_player_name()] = {
		thirst_per_second = thirsty.config.thirst_per_second
	}
end)

core.register_on_respawnplayer(function(player)
	thirsty.player[player:get_player_name()].thirst_per_second = thirsty.config.thirst_per_second
end)

core.register_on_leaveplayer(function(player)
	tempsurvive.player[player:get_player_name()] = nil
end)

local M = thirsty
local C = M.config
local modpath = core.get_modpath("thirsty")

thirsty.time_next_tick = thirsty.config.tick_time

dofile(modpath .. '/hud.lua')
dofile(modpath .. '/functions.lua')

core.register_on_joinplayer(thirsty.on_joinplayer)
core.register_on_dieplayer(thirsty.on_dieplayer)
core.register_globalstep(thirsty.main_loop)

dofile(modpath .. '/components_external_nodes_items.lua')
dofile(modpath .. '/components.lua')
dofile(modpath .. '/interop_a_functions.lua')

-- dungeon_loot for Aumlets of Thirst
if core.get_modpath("dungeon_loot") then
	dofile(modpath .. '/interop_dungeon_loot.lua')
end

-- mobs_animal specific config
if core.get_modpath("mobs_animal") then
	dofile(modpath .. '/interop_mobs_animal.lua')
end

-- farming(redo) specific config
if core.global_exists("farming") and farming.mod == "redo" then
	dofile(modpath .. '/interop_farming_redo.lua')
end

-- ethereal specific config
if core.get_modpath("ethereal") then
	dofile(modpath .. '/interop_ethereal.lua')
end

-- tempsurvive or thermometer
if core.global_exists('tempsurvive') then
	dofile(modpath .. '/interop_tempsurvive.lua')
end
