-- Thirst Damage Mod for Ashwake
-- Makes players take damage when their thirst level reaches zero instead of going negative

local damage_interval = 2.0  -- How often to check for damage (in seconds)
local damage_amount = 1      -- How much damage to apply per interval
local damage_timer = 0       -- Global timer for damage checks
local warned_players = {}    -- Keep track of players who have been warned about thirst

-- Check if the thirsty mod is available
if not minetest.get_modpath("thirsty") then
    minetest.log("error", "[thirst_damage] This mod requires the thirsty mod to be installed!")
    return
end

-- Original thirsty.drink function
local original_drink_func = thirsty.drink

-- Override the thirsty.drink function to prevent negative thirst values
thirsty.drink = function(player, value)
    if not player or not player:is_player() then return end
    
    local name = player:get_player_name()
    local pmeta = player:get_meta()
    local hydro = pmeta:get_float("thirsty_hydro")
    
    -- Calculate the new hydration value
    local new_hydro = hydro + value
    
    -- Prevent the hydration level from falling below 0
    if new_hydro < 0 then
        new_hydro = 0
        minetest.log("action", "[thirst_damage] Prevented " .. name .. "'s thirst from going negative")
    end
    
    -- Call the original function with the adjusted value
    return original_drink_func(player, new_hydro - hydro)
end

-- Check if a player needs to take damage from thirst and apply it
local function check_thirst_damage(player)
    if not player or not player:is_player() then return end
    
    local name = player:get_player_name()
    local pmeta = player:get_meta()
    local hydro = pmeta:get_float("thirsty_hydro")
    
    -- If hydration is at or below 0, cause damage
    if hydro <= 0 then
        -- Set it exactly to 0 to prevent negative values
        if hydro < 0 then
            pmeta:set_float("thirsty_hydro", 0)
            if thirsty.hud_update then
                thirsty.hud_update(player, 0)
            end
        end
        
        -- Apply damage
        player:set_hp(player:get_hp() - damage_amount)
        
        -- Play the damage sound (but don't show warning message)
        if not warned_players[name] then
            warned_players[name] = true
            
            -- Play the existing damage sound
            minetest.sound_play("default_player_damage", {
                to_player = name,
                gain = 1.0,
            })
            
            -- Reset the warning status after a delay
            minetest.after(30, function()
                warned_players[name] = nil
            end)
        end
        
        minetest.log("action", "[thirst_damage] " .. name .. " took damage from dehydration")
    end
end

-- Register globalstep to check for thirst damage
minetest.register_globalstep(function(dtime)
    damage_timer = damage_timer + dtime
    
    -- Check for thirst damage at regular intervals
    if damage_timer >= damage_interval then
        for _, player in ipairs(minetest.get_connected_players()) do
            if player:is_player() then
                check_thirst_damage(player)
            end
        end
        damage_timer = 0
    end
end)

-- Reset damage warnings when a player leaves
minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    warned_players[name] = nil
end)

-- Check if the player is deshidrated on join and fix negative values
minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local pmeta = player:get_meta()
    local hydro = pmeta:get_float("thirsty_hydro")
    
    -- Fix negative hydration values
    if hydro < 0 then
        pmeta:set_float("thirsty_hydro", 0)
        if thirsty.hud_update then
            thirsty.hud_update(player, 0)
        end
        minetest.log("action", "[thirst_damage] Fixed negative thirst for " .. name)
    end
end)

-- Monitor all thirst reductions to prevent them from going negative
local original_set_thirst_func = nil
if thirsty.set_thirst then
    original_set_thirst_func = thirsty.set_thirst
    
    thirsty.set_thirst = function(player, value)
        if not player or not player:is_player() then return end
        
        -- Prevent negative values
        if value < 0 then
            value = 0
        end
        
        return original_set_thirst_func(player, value)
    end
end

-- Print success message
minetest.log("action", "[thirst_damage] Thirst damage mod loaded successfully")
minetest.log("action", "[thirst_damage] Players will now take " .. damage_amount .. " damage every " .. damage_interval .. " seconds when dehydrated") 