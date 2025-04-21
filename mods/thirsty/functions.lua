------------------------------------------------------------
--             _____ _    _        _                      --
--            |_   _| |_ (_)_ _ __| |_ _  _               --
--              | | | ' \| | '_(_-<  _| || |              --
--              |_| |_||_|_|_| /__/\__|\_, |              --
--                                     |__/               --
------------------------------------------------------------
--                 Thirsty mod [functions]                --
------------------------------------------------------------
--                See init.lua for license                --
------------------------------------------------------------

--------------------------
-- Tier 0 API Functions --
--------------------------
-- regen_from_node is a table defining, for each node type, the
-- amount of hydro per second a player drinks by standing in it.
-- Default is 0.5 of a hydration per second
function thirsty.register_hydrate_node(node_name, drink_cup, regen)
    local drink_cup = drink_cup or true
    local regen = regen or 0.5

    thirsty.config.regen_from_node[node_name] = regen
    thirsty.config.fountain_type[node_name] = "w"

    if drink_cup then
        thirsty.register_drinkable_node(node_name)
    end
end

--------------------------
-- Tier 1 API Functions --
--------------------------
-- node_drinkable: which nodes can we drink from, given a
-- container (a cup, a bowl etc.)
function thirsty.register_drinkable_node(node_name, max_hydrate)
    local max_hydrate = max_hydrate or nil

    thirsty.config.node_drinkable[node_name] = true

    if max_hydrate then
        thirsty.config.drink_from_node[node_name] = max_hydrate
    end
end

function thirsty.on_use(old_on_use)
    return function(itemstack, player, pointed_thing)
        local node = nil
        if pointed_thing and pointed_thing.type == 'node' then
            node = core.get_node(pointed_thing.under)
        end

        thirsty.drink_handler(player, itemstack, node)

        -- call original on_use, if provided
        if old_on_use ~= nil then
            return old_on_use(itemstack, player, pointed_thing)
        else
            return itemstack
        end
    end
end

function thirsty.augment_item_for_drinking(itemname, level)
    local new_definition = {}
    local old_definition = table.copy(core.registered_items[itemname])
    local level = level or thirsty.config.start
    -- we need to be able to point at the water
    new_definition.liquids_pointable = true
    -- call closure generator with original on_use handler
    new_definition.on_use = thirsty.on_use(old_definition.on_use)
    -- overwrite the node definition with almost the original
    core.override_item(itemname, new_definition)

    -- add configuration settings
    thirsty.config.drink_from_container[itemname] = level
end

--------------------------
-- Tier 2 API Functions --
--------------------------
function thirsty.drink(player, value, max_hyd, empty_vessel)
    local max_hyd = max_hyd or 20
    local value = value or 2
    local pmeta = player:get_meta()
    local hydro = pmeta:get_float("thirsty_hydro")
    -- test whether we're not *above* max_hyd;
    -- this function should not remove any overhydration
    if hydro < max_hyd then
        hydro = math.min(hydro + value, max_hyd)
        --print("Drinking by "..value.." to "..hydro)
        pmeta:set_float("thirsty_hydro", hydro)
        core.sound_play("thirsty_breviceps_drink-drinking-liquid", { to_player = player:get_player_name(), gain = 2.0, })

        if empty_vessel then
            player:get_inventory():add_item("main", empty_vessel .. " 1")
        end

        return true
    end
    return false
end

function thirsty.register_canteen(item_name, hydrate_capacity, max_hydrate, on_use)
    local on_use = on_use or true
    local max_hydrate = max_hydrate or thirsty.config.start

    thirsty.config.container_capacity[item_name] = hydrate_capacity
    thirsty.config.drink_from_container[item_name] = max_hydrate

    local def = table.copy(core.registered_items[item_name])
    def.liquids_pointable = true
    def.stack_max = 1
    def.type = "tool"

    if on_use then
        def.on_use = thirsty.on_use(nil)
    end

    core.register_tool(":" .. item_name, def)
end

function thirsty.register_canteen_complex(item_name, hydrate_capacity, max_hydrate, full_image)
    local full_item_name = item_name .. "_full"
    local max_hydrate = max_hydrate or thirsty.config.start

    -- register new full version of item into thirsty tables and as tool.
    thirsty.config.container_capacity[full_item_name] = hydrate_capacity
    thirsty.config.drink_from_container[full_item_name] = max_hydrate

    local def_f = table.copy(core.registered_items[item_name])
    def_f.inventory_image = full_image or def_f.inventory_image
    def_f.wield_image = full_image or def_f.inventory_image
    def_f.liquids_pointable = true
    def_f.stack_max = 1
    def_f.type = "tool"
    def_f.description = "Full " .. def_f.description
    def_f.on_use = thirsty.on_use(nil)
    def_f.thirsty_empty = item_name

    core.register_tool(":" .. full_item_name, def_f)

    -- modify empty_vessel registration
    local def_e = table.copy(core.registered_items[item_name])

    def_e.on_use = thirsty.on_use_empty()
    def_e.liquids_pointable = true
    def_e.name = nil
    def_e.type = nil
    core.override_item(item_name, def_e)
end

-- note not offically exposed to API yet, use with caution may change
function thirsty.on_use_empty()
    return function(itemstack, player, pointed_thing)
        local node = nil

        if pointed_thing and pointed_thing.type == 'node' then
            node = core.get_node(pointed_thing.under)
        end


        if node and thirsty.config.node_drinkable[node.name] then
            local new_stack = { name = itemstack:get_name() .. "_full", count = 1, wear = 1, metadata = "" }
            player:get_inventory():add_item("main", new_stack)
            itemstack:take_item()
            return itemstack
        end
    end
end

--------------------------
-- Tier 3 API Functions --
--------------------------
function thirsty.on_rightclick(old_on_rightclick)
    return function(pos, node, player, itemstack, pointed_thing)
        thirsty.drink_handler(player, itemstack, node)

        -- call original on_rightclick, if provided
        if old_on_rightclick ~= nil then
            return old_on_rightclick(pos, node, player, itemstack, pointed_thing)
        else
            return itemstack
        end
    end
end

--------------------------
-- Tier 4 API Functions --
--------------------------
function thirsty.register_water_fountain(node_name)
    thirsty.config.fountain_type[node_name] = "f"
end

--------------------------
-- Tier 5 API Functions --
--------------------------
function thirsty.register_amulet_extractor(item_name, value)
    thirsty.config.extraction_for_item[item_name] = value
end

function thirsty.register_amulet_supplier(item_name, value)
    thirsty.config.injection_for_item[item_name] = value
end

function thirsty.register_amulet_thirst(item_name, value)
    thirsty.config.thirst_adjust_item[item_name] = value
end

function thirsty.get_thirst_factor(player)
    local pmeta = player:get_meta()
    local pl = core.deserialize(pmeta:get_string("thirsty_values"))
    return pl.thirst_factor
end

function thirsty.set_thirst_factor(player, factor)
    local pmeta = player:get_meta()
    local pl = core.deserialize(pmeta:get_string("thirsty_values"))
    pl.thirst_factor = factor
    pmeta:set_string("thirsty_values", core.serialize(pl))
end

-------------------------
-- Other API Functions --
-------------------------
function thirsty.get_hydro(player)
    local pmeta = player:get_meta()
    local hydro = pmeta:get_float("thirsty_hydro")
    return hydro
end

----------------------------
-- Mod Internal Functions --
----------------------------


function thirsty.on_joinplayer(player)
    local pmeta = player:get_meta()

    -- setup initial thirst player meta value if not present   	
    if pmeta:get_float("thirsty_hydro") == 0 then
        pmeta:set_float("thirsty_hydro", thirsty.config.start)
    end

    -- default entry for joining players
    if pmeta:get_string("thirsty_values") == "" then
        local pos = player:get_pos()
        pmeta:set_string("thirsty_values", core.serialize({
            last_pos = math.floor(pos.x) .. ':' .. math.floor(pos.z),
            time_in_pos = 0.0,
            pending_dmg = 0.0,
            thirst_factor = 1.0
        }))
    end

    thirsty.hud_init(player)
end

function thirsty.on_dieplayer(player)
    local pos = player:get_pos()
    local pmeta = player:get_meta()

    pmeta:set_float("thirsty_hydro", thirsty.config.start)
    pmeta:set_string("thirsty_values", core.serialize({
        last_pos = math.floor(pos.x) .. ':' .. math.floor(pos.z),
        time_in_pos = 0.0,
        pending_dmg = 0.0,
        thirst_factor = 1.0
    }))
end

function thirsty.main_loop(dtime)
    -- get thirsty
    thirsty.time_next_tick = thirsty.time_next_tick - dtime
    while thirsty.time_next_tick < 0.0 do
        -- time for thirst
        thirsty.time_next_tick = thirsty.time_next_tick + thirsty.config.tick_time
        for _, player in ipairs(core.get_connected_players()) do
            -- dead players don't get thirsty, or full for that matter :-P
            if player:get_hp() <= 0 then
                break
            end

            local pos      = player:get_pos()
            local pmeta    = player:get_meta()
            local hydro    = pmeta:get_float("thirsty_hydro")
            local pl       = core.deserialize(pmeta:get_string("thirsty_values"))

            -- how long have we been standing "here"?
            -- (the node coordinates in X and Z should be enough)
            local pos_hash = math.floor(pos.x) .. ':' .. math.floor(pos.z)
            if pl.last_pos == pos_hash then
                pl.time_in_pos = pl.time_in_pos + thirsty.config.tick_time
            else
                -- you moved!
                pl.last_pos = pos_hash
                pl.time_in_pos = 0.0
            end
            local pl_standing      = pl.time_in_pos > thirsty.config.stand_still_for_drink
            local pl_afk           = pl.time_in_pos > thirsty.config.stand_still_for_afk
            --print("Standing: " .. (pl_standing and 'true' or 'false' ) .. ", AFK: " .. (pl_afk and 'true' or 'false'))

            pos.y                  = pos.y + 0.1
            local node             = core.get_node(pos)
            local drink_per_second = thirsty.config.regen_from_node[node.name] or 0

            -- fountaining (uses pos, slight changes ok)
            for k, fountain in pairs(thirsty.fountains) do
                local dx = fountain.pos.x - pos.x
                local dy = fountain.pos.y - pos.y
                local dz = fountain.pos.z - pos.z
                local dist2 = dx * dx + dy * dy + dz * dz
                local fdist = fountain.level * thirsty.config.fountain_distance_per_level -- max 100 nodes radius
                --print (string.format("Distance from %s (%d): %f out of %f", k, fountain.level, math.sqrt(dist2), fdist ))
                if dist2 < fdist * fdist then
                    -- in range, drink as if standing (still) in water
                    drink_per_second = math.max(thirsty.config.regen_from_fountain or 0, drink_per_second)
                    pl_standing = true
                    break -- no need to check the other fountains
                end
            end

            -- amulets
            -- TODO: I *guess* we need to optimize this, but I haven't
            --       measured it yet. No premature optimizations!
            local pl_inv = player:get_inventory()
            local extractor_max = 0.0
            local injector_max = 0.0
            local amulet_thirst = false
            local container_not_full = nil
            local container_not_empty = nil
            local inv_main = pl_inv:get_list('main')

            for i, itemstack in ipairs(inv_main) do
                local name = itemstack:get_name()
                -- Amulets Hydration/Moisture
                local injector_this = thirsty.config.injection_for_item[name]
                if injector_this and injector_this > injector_max then
                    injector_max = injector_this
                end

                local extractor_this = thirsty.config.extraction_for_item[name]
                if extractor_this and extractor_this > extractor_max then
                    extractor_max = extractor_this
                end

                if thirsty.config.container_capacity[name] then
                    local wear = itemstack:get_wear()
                    -- can be both!
                    if wear == 0 or wear > 1 then
                        container_not_full = { i, itemstack }
                    end
                    if wear > 0 and wear < 65534 then
                        container_not_empty = { i, itemstack }
                    end
                end
                -- Amulets of Thirst
                local is_thirst_amulet = thirsty.config.thirst_adjust_item[name]
                if is_thirst_amulet then
                    amulet_thirst = true
                    pl.thirst_factor = thirsty.config.thirst_adjust_item[name]
                end
            end

            if amulet_thirst ~= true and pl.thirst_factor ~= 1.0 then
                pl.thirst_factor = 1.0
            end

            if extractor_max > 0.0 and container_not_full then
                local i = container_not_full[1]
                local itemstack = container_not_full[2]
                local capacity = thirsty.config.container_capacity[itemstack:get_name()]
                local wear = itemstack:get_wear()
                if wear == 0 then wear = 65535.0 end
                local drink = extractor_max * thirsty.config.tick_time
                local drinkwear = drink / capacity * 65535.0
                wear = wear - drinkwear
                if wear < 1 then wear = 1 end
                itemstack:set_wear(wear)
                pl_inv:set_stack("main", i, itemstack)
            end

            if injector_max > 0.0 and container_not_empty then
                local i = container_not_empty[1]
                local itemstack = container_not_empty[2]
                local capacity = thirsty.config.container_capacity[itemstack:get_name()]
                local wear = itemstack:get_wear()
                if wear == 0 then wear = 65535.0 end
                local drink = injector_max * thirsty.config.tick_time
                local drink_missing = 20 - hydro
                drink = math.max(math.min(drink, drink_missing), 0)
                local drinkwear = drink / capacity * 65535.0
                wear = wear + drinkwear
                if wear > 65534 then wear = 65534 end
                itemstack:set_wear(wear)
                thirsty.drink(player, drink, 20)
                hydro = pmeta:get_float("thirsty_hydro")
                pl_inv:set_stack("main", i, itemstack)
            end


            if drink_per_second > 0 and pl_standing then
                -- Drinking from the ground won't give you more than max
                thirsty.drink(player, (drink_per_second * thirsty.config.tick_time) * 2, 20)
                pl.time_in_pos = 0.0
                -- core.log('info', "Raising hydration by "..(drink_per_second*thirsty.config.tick_time).." to "..PPA.get_value(player, 'thirsty_hydro'))
            else
                if not pl_afk then
                    -- only get thirsty if not AFK
                    local amount = thirsty.player[player:get_player_name()].thirst_per_second * thirsty.config.tick_time *
                        pl.thirst_factor
                    pmeta:set_float("thirsty_hydro", (hydro - amount))

                    hydro = pmeta:get_float("thirsty_hydro")
                    core.log('info', "Lowering hydration by " .. amount .. " to " .. hydro)
                end
            end


            -- should we only update the hud on an actual change?
            -- core.debug(player:get_player_name().." "..hydro)
            thirsty.hud_update(player, hydro)

            -- damage, if enabled
            if thirsty.config.damage_enabled then
                -- maybe not the best way to do this, but it does mean
                -- we can do anything with one tick loop
                if hydro <= 0.0 and not pl_afk then
                    pl.pending_dmg = pl.pending_dmg + thirsty.config.damage_per_second * thirsty.config.tick_time
                    --print("Pending damage at " .. pl.pending_dmg)
                    if pl.pending_dmg > 1.0 then
                        local dmg = math.floor(pl.pending_dmg)
                        pl.pending_dmg = pl.pending_dmg - dmg
                        player:set_hp(player:get_hp() - dmg)
                    end
                else
                    -- forget any pending damage when not thirsty
                    pl.pending_dmg = 0.0
                end
            end
            pmeta:set_string("thirsty_values", core.serialize(pl))
        end -- for players

        -- check fountains for expiration
        for k, fountain in pairs(thirsty.fountains) do
            fountain.time_until_check = fountain.time_until_check - thirsty.config.tick_time
            if fountain.time_until_check <= 0 then
                -- remove fountain, the abm will set it again
                --print("Removing fountain at " .. k)
                thirsty.fountains[k] = nil
            end
        end
    end
end

function thirsty.drink_handler(player, itemstack, node)
    local pmeta = player:get_meta()
    local hydro = pmeta:get_float("thirsty_hydro")
    local pl = core.deserialize(pmeta:get_string("thirsty_values"))
    local old_hydro = hydro

    -- selectors, always true, to make the following code easier
    local item_name = itemstack and itemstack:get_name() or ':'
    local node_name = node and node.name or ':'

    if thirsty.config.node_drinkable[node_name] then
        -- we found something to drink!
        local cont_level = thirsty.config.drink_from_container[item_name] or 0
        local node_level = thirsty.config.drink_from_node[node_name] or 0
        -- drink until level
        local level = math.max(cont_level, node_level)
        --print("Drinking to level " .. level)
        thirsty.drink(player, level, level)

        -- fill container, if applicable
        if thirsty.config.container_capacity[item_name] then
            --print("Filling a " .. item_name .. " to " .. thirsty.config.container_capacity[item_name])
            itemstack:set_wear(1) -- "looks full"
        end
    elseif thirsty.config.container_capacity[item_name] then
        -- drinking from a container
        if itemstack:get_wear() ~= 0 then
            local capacity = thirsty.config.container_capacity[item_name]
            local hydro_missing = 20 - hydro;
            if hydro_missing > 0 then
                local wear_missing = hydro_missing / capacity * 65535.0;
                local wear         = itemstack:get_wear()
                local new_wear     = math.ceil(math.max(wear + wear_missing, 1))
                if (new_wear > 65534) then
                    wear_missing = 65534 - wear
                    new_wear = 65534
                end

                -- deal with full/empty vessels, when empty remove
                -- tool version and supply empty name to thirsty.drink
                -- so player recieves empty version back
                local empty_vessel_name

                if new_wear >= 65534 then
                    if core.registered_items[item_name].thirsty_empty then
                        itemstack:take_item(1)
                        empty_vessel_name = core.registered_items[item_name].thirsty_empty
                    else
                        itemstack:set_wear(new_wear)
                    end
                    -- end full/empty vessel code block	
                else
                    itemstack:set_wear(new_wear)
                end

                if wear_missing > 0 then -- rounding glitches?
                    thirsty.drink(player, wear_missing * capacity / 65535.0, 20, empty_vessel_name)
                    hydro = pmeta:get_float("thirsty_hydro")
                end
            end
        end
    end

    -- update HUD if value changed
    if hydro ~= old_hydro then
        thirsty.hud_update(player, hydro)
    end
end

function thirsty.fountain_abm(pos, node)
    local fountain_count = 0
    local water_count = 0
    local total_count = 0
    for y = 0, thirsty.config.fountain_height do
        for x = -y, y do
            for z = -y, y do
                local n = core.get_node({
                    x = pos.x + x,
                    y = pos.y - y + 1, -- start one *above* the fountain
                    z = pos.z + z
                })
                if n then
                    --print(string.format("%s at %d:%d:%d", n.name, pos.x+x, pos.y-y+1, pos.z+z))
                    total_count = total_count + 1
                    local type = thirsty.config.fountain_type[n.name] or ''
                    if type == 'f' then
                        fountain_count = fountain_count + 1
                    elseif type == 'w' then
                        water_count = water_count + 1
                    end
                end
            end
        end
    end
    local level = math.min(thirsty.config.fountain_max_level, math.min(fountain_count, water_count))
    --print(string.format("Fountain (%d): %d + %d / %d", level, fountain_count, water_count, total_count))
    thirsty.fountains[string.format("%d:%d:%d", pos.x, pos.y, pos.z)] = {
        pos = { x = pos.x, y = pos.y, z = pos.z },
        level = level,
        -- time until check is 20 seconds, or twice the average
        -- time until the abm ticks again. Should be enough.
        time_until_check = 20,
    }
end
