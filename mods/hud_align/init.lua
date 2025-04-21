-- HUD Align mod for Ashwake
-- Makes oxygen bubbles always visible and aligns UI elements

local orig_hud_flags = {}

-- Create our static bubble background HUD for players
local bubble_bg_huds = {}

-- Create our static heart background HUD for players
local heart_bg_huds = {}

-- Thirsty mod integration
local thirsty_mod_loaded = minetest.get_modpath("thirsty") ~= nil
local thirsty_huds = {}
local thirsty_values = {}
local original_thirsty_huds = {}

-- Stamina mod integration
local stamina_mod_loaded = minetest.get_modpath("stamina") ~= nil
local stamina_huds = {}
local stamina_values = {}
local original_stamina_huds = {}

-- Create static bubble background HUD for the player
local function create_bubble_bg_hud(player)
    local name = player:get_player_name()
    if not name then return end
    
    -- Check if the HUD already exists to prevent duplicates
    if bubble_bg_huds[name] then
        minetest.log("action", "[hud_align] Bubble background HUD already exists for " .. name)
        return
    end
    
    -- Create static background of 10 empty bubbles - totally static image
    bubble_bg_huds[name] = player:hud_add({
        name = "bubble_background",
        type = "image",
        position = {x = 0.5, y = 1},
        text = "bubble_bg_strip.png", -- Background texture strip (10 empty bubbles)
        alignment = {x = 0, y = -1},
        offset = {x = 146, y = -64},  -- Maintain original X position, adjust Y as needed
        scale = {x = 2, y = 2},      -- Scale to match default bubble size (adjusted for 120x12 image)
    })
    
    minetest.log("action", "[hud_align] Created static bubble background for " .. name)
end

-- Create static heart background HUD for the player
local function create_heart_bg_hud(player)
    local name = player:get_player_name()
    if not name then return end
    
    -- Check if the HUD already exists to prevent duplicates
    if heart_bg_huds[name] then
        minetest.log("action", "[hud_align] Heart background HUD already exists for " .. name)
        return
    end
    
    -- Create static background of 10 empty hearts - totally static image
    heart_bg_huds[name] = player:hud_add({
        name = "heart_background",
        type = "image",
        position = {x = 0.5, y = 1},
        text = "heart_strip_bg.png", -- Background texture strip (10 empty hearts)
        alignment = {x = 0, y = -1},
        offset = {x = -145, y = -64},  -- Position where default heart HUD appears
        scale = {x = 2, y = 2},      -- Scale to match default heart size
    })
    
    minetest.log("action", "[hud_align] Created static heart background for " .. name)
end

-- Create custom thirsty HUD for the player
local function create_thirsty_hud(player)
    if not thirsty_mod_loaded then return end
    
    local name = player:get_player_name()
    if not name then return end
    
    -- Check if the HUD already exists to prevent duplicates
    if thirsty_huds[name] then
        minetest.log("action", "[hud_align] Thirsty HUD already exists for " .. name)
        return
    end
    
    local pmeta = player:get_meta()
    local value = 0
    
    -- Get the hydration value from player metadata
    if pmeta:get_float("thirsty_hydro") then
        value = thirsty.hud_clamp(pmeta:get_float("thirsty_hydro"))
    end
    
    -- Create our custom thirsty HUD - keep original X position (25), only change Y to match stamina
    thirsty_huds[name] = player:hud_add({
        name = "custom_thirst",
        type = "statbar",
        position = {x = 0.5, y = 1},
        text = "thirsty_drop.png",
        number = value,
        text2 = "thirsty_drop_bg.png",
        item = 20, -- Max hydration is 20
        alignment = {x = -1, y = -1},
        offset = {x = 25, y = -110}, -- Keep X=25 (original position), only align Y with stamina's -110
        size = {x = 24, y = 24},
        max = 0,
        direction = 0,
    })
    
    -- Store the current value
    thirsty_values[name] = value
    
    minetest.log("action", "[hud_align] Created thirsty HUD for " .. name .. " with value " .. value .. "/20")
end

-- Create custom stamina HUD for the player
local function create_stamina_hud(player)
    if not stamina_mod_loaded then return end
    
    local name = player:get_player_name()
    if not name then return end
    
    -- Check if the HUD already exists to prevent duplicates
    if stamina_huds[name] then
        minetest.log("action", "[hud_align] Stamina HUD already exists for " .. name)
        return
    end
    
    local value = 0
    
    -- Get the stamina value from player meta
    value = stamina.get_saturation(player) or 20
    
    -- Create our custom stamina HUD - use the original position but with our custom background
    stamina_huds[name] = player:hud_add({
        name = "custom_stamina",
        type = "statbar",
        position = {x = 0.5, y = 1},
        text = "stamina_hud_fg.png",
        number = value,
        text2 = "stamina_custom_bg.png", -- Our custom background
        item = 20, -- Visual max from stamina mod is 20 by default
        alignment = {x = -1, y = -1},
        offset = {x = -266, y = -110}, -- Original stamina position
        size = {x = 24, y = 24},
        max = 0,
        direction = 0,
    })
    
    -- Store the current value
    stamina_values[name] = value
    
    minetest.log("action", "[hud_align] Created stamina HUD for " .. name .. " with value " .. value .. "/20")
end

-- Update custom thirsty HUD
local function update_thirsty_hud(player)
    if not thirsty_mod_loaded then return end
    
    local name = player:get_player_name()
    if not name then return end
    
    -- If the HUD doesn't exist yet for this player, create it
    if not thirsty_huds[name] then
        create_thirsty_hud(player)
        return
    end
    
    local pmeta = player:get_meta()
    local value = 0
    
    -- Get the hydration value from player metadata
    if pmeta:get_float("thirsty_hydro") then
        value = thirsty.hud_clamp(pmeta:get_float("thirsty_hydro"))
    end
    
    -- If value has changed, update the HUD
    if value ~= thirsty_values[name] and thirsty_huds[name] then
        player:hud_change(thirsty_huds[name], "number", value)
        thirsty_values[name] = value
    end
end

-- Update custom stamina HUD
local function update_stamina_hud(player)
    if not stamina_mod_loaded then return end
    
    local name = player:get_player_name()
    if not name then return end
    
    -- If the HUD doesn't exist yet for this player, create it
    if not stamina_huds[name] then
        create_stamina_hud(player)
        return
    end
    
    local value = stamina.get_saturation(player) or 20
    
    -- If value has changed, update the HUD
    if value ~= stamina_values[name] and stamina_huds[name] then
        player:hud_change(stamina_huds[name], "number", value)
        stamina_values[name] = value
    end
    
    -- Check if player is poisoned and update the texture if needed
    if stamina.is_poisoned and stamina.is_poisoned(player) then
        player:hud_change(stamina_huds[name], "text", "stamina_hud_poison.png")
    else
        player:hud_change(stamina_huds[name], "text", "stamina_hud_fg.png")
    end
end

-- Hook into thirsty mod's HUD functions to override them
if thirsty_mod_loaded then
    -- Save the original function
    local original_thirsty_hud_init = thirsty.hud_init
    local original_thirsty_update = thirsty.hud_update
    
    -- Override the thirsty HUD init function
    thirsty.hud_init = function(player)
        -- If hudbars is active, call the original function
        if core.global_exists("hb") then
            return original_thirsty_hud_init(player)
        end
        
        -- Don't create the original HUD, we'll create our own
        local name = player:get_player_name()
        if not name then return end
        
        original_thirsty_huds[name] = 0 -- Just set a dummy value
        
        -- Our custom HUD will be created in the on_joinplayer handler
    end
    
    -- Override the thirsty HUD update function
    thirsty.hud_update = function(player, value)
        -- If hudbars is active, call the original function
        if core.global_exists("hb") then
            return original_thirsty_update(player, value)
        end
        
        -- Update our custom HUD
        local name = player:get_player_name()
        if not name then return end
        
        if thirsty_huds[name] then
            player:hud_change(thirsty_huds[name], "number", thirsty.hud_clamp(value))
            thirsty_values[name] = thirsty.hud_clamp(value)
        else
            -- If the HUD doesn't exist yet, create it
            create_thirsty_hud(player)
        end
    end
end

-- Hook into stamina mod's HUD functions
if stamina_mod_loaded then
    -- Create a local table to track our HUD IDs for stamina
    local stamina_hud_ids_by_player_name = {}
    
    -- Define our own get/set HUD ID functions
    local function get_hud_id(player)
        return stamina_hud_ids_by_player_name[player:get_player_name()]
    end
    
    local function set_hud_id(player, hud_id)
        stamina_hud_ids_by_player_name[player:get_player_name()] = hud_id
    end
    
    -- Save the original register_on_joinplayer callback
    local original_joinplayer = nil
    -- Find the stamina joinplayer callback in the registered callbacks
    for i, callback in ipairs(minetest.registered_on_joinplayers) do
        if type(callback) == "function" then
            local info = debug.getinfo(callback)
            if info and info.source and info.source:match("stamina/init.lua") then
                original_joinplayer = callback
                table.remove(minetest.registered_on_joinplayers, i)
                break
            end
        end
    end
    
    -- Backup original stamina functions
    local original_set_saturation = stamina.set_saturation
    local original_set_poisoned = stamina.set_poisoned
    
    -- Replace stamina.set_saturation
    stamina.set_saturation = function(player, level)
        local name = player:get_player_name()
        if not name then 
            return original_set_saturation(player, level)
        end
        
        -- Store the value in player metadata
        player:get_meta():set_string("stamina:level", tostring(level))
        
        -- Update our custom HUD if it exists
        if stamina_huds[name] then
            player:hud_change(stamina_huds[name], "number", math.min(20, level))
            stamina_values[name] = level
        else
            -- If our custom HUD doesn't exist, call the original function
            -- But first make sure there's a valid HUD ID for the original function to use
            local dummy_id = original_stamina_huds[name]
            if not dummy_id or dummy_id <= 0 then
                -- Need to create a dummy HUD first
                if player:is_player() then
                    dummy_id = player:hud_add({
                        type = "text",
                        position = {x = -10, y = -10},  -- Colocar fuera de la pantalla
                        text = "",
                        number = 0,
                        alignment = {x = 0, y = 0},
                        offset = {x = 0, y = 0},
                        scale = {x = 0, y = 0},
                    })
                    original_stamina_huds[name] = dummy_id
                    set_hud_id(player, dummy_id)
                end
            end
            
            if dummy_id and dummy_id > 0 then
                -- Update the dummy HUD directly
                pcall(function()
                    player:hud_change(dummy_id, "number", math.min(20, level))
                end)
            end
        end
    end
    
    -- Replace stamina.set_poisoned
    stamina.set_poisoned = function(player, poisoned)
        local name = player:get_player_name()
        if not name then 
            return original_set_poisoned(player, poisoned)
        end
        
        -- Update our custom HUD if it exists
        if stamina_huds[name] then
            if poisoned then
                player:hud_change(stamina_huds[name], "text", "stamina_hud_poison.png")
                player:get_meta():set_string("stamina:poisoned", "yes")
            else
                player:hud_change(stamina_huds[name], "text", "stamina_hud_fg.png")
                player:get_meta():set_string("stamina:poisoned", "")
            end
        else
            -- Set the poisoned status in metadata
            if poisoned then
                player:get_meta():set_string("stamina:poisoned", "yes")
            else
                player:get_meta():set_string("stamina:poisoned", "")
            end
            
            -- Update the dummy HUD if it exists
            local dummy_id = original_stamina_huds[name]
            if dummy_id and dummy_id > 0 then
                pcall(function()
                    if poisoned then
                        -- No cambiar el texto, solo el número para no mostrar el nombre del archivo
                        player:hud_change(dummy_id, "number", 0)
                        -- Asegurarse de que esté fuera de pantalla
                        player:hud_change(dummy_id, "position", {x = -10, y = -10})
                    else
                        -- No cambiar el texto, solo el número para no mostrar el nombre del archivo
                        player:hud_change(dummy_id, "number", 0)
                        -- Asegurarse de que esté fuera de pantalla
                        player:hud_change(dummy_id, "position", {x = -10, y = -10})
                    end
                end)
            end
        end
    end
    
    -- Override the stamina joinplayer function
    minetest.register_on_joinplayer(function(player)
        local name = player:get_player_name()
        if not name then return end
        
        -- Create a dummy HUD element for stamina to use
        local dummy_hud = player:hud_add({
            type = "text",
            position = {x = -10, y = -10},  -- Colocar fuera de la pantalla para asegurarse que no sea visible
            text = "",                      -- Mantener texto vacío
            number = 0,
            alignment = {x = 0, y = 0},
            offset = {x = 0, y = 0},
            scale = {x = 0, y = 0},         -- Escala cero para hacerlo invisible
        })
        
        -- Store this dummy HUD ID 
        set_hud_id(player, dummy_hud)
        original_stamina_huds[name] = dummy_hud
        
        -- Call the original stamina joinplayer function if available
        if original_joinplayer then
            pcall(function()
                original_joinplayer(player)
            end)
        else
            -- Fallback if we couldn't find the original joinplayer function
            local level = 20
            if stamina.get_saturation then
                level = stamina.get_saturation(player) or 20
            end
            player:get_meta():set_string("stamina:level", tostring(level))
            player:get_meta():set_string("stamina:poisoned", "")
        end
    end)
end

-- Track whether we've already initialized HUDs for each player
local initialized_players = {}

-- Add the bubble background HUD and enable the default breath bubbles
minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    if not name then return end
    
    -- Store original HUD flags
    orig_hud_flags[name] = player:hud_get_flags()
    
    -- Enable the default breath HUD
    local flags = player:hud_get_flags()
    flags.breath = true
    flags.health = true  -- Keep the default health HUD visible
    player:hud_set_flags(flags)
    
    -- Track initialization to prevent duplicate HUDs
    initialized_players[name] = false
    
    -- Create our HUDs with a slight delay to ensure player is fully initialized
    minetest.after(1.0, function()
        -- Check if we've already initialized this player
        if initialized_players[name] then
            minetest.log("action", "[hud_align] HUD already initialized for " .. name)
            return
        end
        
        local player_obj = minetest.get_player_by_name(name)
        if player_obj then
            -- Make sure breath HUD is enabled
            local flags = player_obj:hud_get_flags()
            flags.breath = true
            flags.health = true  -- Keep the default health HUD visible
            player_obj:hud_set_flags(flags)
            
            -- Create our bubble background HUD
            create_bubble_bg_hud(player_obj)
            
            -- Create our heart background HUD
            create_heart_bg_hud(player_obj)
            
            -- Create thirsty HUD if mod is loaded and not using hudbars
            if thirsty_mod_loaded and not core.global_exists("hb") then
                create_thirsty_hud(player_obj)
            end
            
            -- Create stamina HUD if mod is loaded
            if stamina_mod_loaded then
                create_stamina_hud(player_obj)
            end
            
            -- Mark this player as initialized
            initialized_players[name] = true
            
            minetest.log("action", "[hud_align] HUD elements created for " .. name)
        end
    end)
end)

-- Clean up when player leaves
minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    if not name then return end
    
    bubble_bg_huds[name] = nil
    heart_bg_huds[name] = nil
    thirsty_huds[name] = nil
    thirsty_values[name] = nil
    original_thirsty_huds[name] = nil
    stamina_huds[name] = nil
    stamina_values[name] = nil
    original_stamina_huds[name] = nil
    orig_hud_flags[name] = nil
    initialized_players[name] = nil
    
    minetest.log("action", "[hud_align] Cleaned up HUD elements for " .. name)
end)

-- Prevent the globalstep function from creating duplicate HUDs
local creating_hud = {}

-- Update the thirsty and stamina HUDs
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        if player and player:is_player() then
            local name = player:get_player_name()
            
            -- Make sure breath HUD is enabled
            local flags = player:hud_get_flags()
            if not flags.breath then
                flags.breath = true
                player:hud_set_flags(flags)
            end
            
            -- Make sure health HUD is enabled
            if not flags.health then
                flags.health = true
                player:hud_set_flags(flags)
            end
            
            -- Prevent duplicate HUD creation
            if not creating_hud[name] then
                creating_hud[name] = true
                if thirsty_mod_loaded and not core.global_exists("hb") then
                    update_thirsty_hud(player)
                end
                if stamina_mod_loaded then
                    update_stamina_hud(player)
                end
                creating_hud[name] = false
            end
        end
    end
end)

-- Print success message when mod loads
minetest.log("action", "[hud_align] HUD alignment mod loaded successfully")

-- Log which features are active
if thirsty_mod_loaded then
    minetest.log("action", "[hud_align] Thirsty mod integration enabled")
end

if stamina_mod_loaded then
    minetest.log("action", "[hud_align] Stamina mod integration enabled")
end

-- Final safety check to enable all default breath HUDs
minetest.after(2.0, function()
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        if name then
            local flags = player:hud_get_flags()
            flags.breath = true
            flags.health = true  -- Keep health HUD visible
            player:hud_set_flags(flags)
        end
    end
    
    minetest.log("action", "[hud_align] Final breath HUD check completed")
end)

-- Create strip image of 10 bubble outlines
local function create_bubble_bg_strip()
    -- Check if we already have the bubble background strip texture
    local file = io.open(minetest.get_modpath("hud_align") .. "/textures/bubble_bg_strip.png", "r")
    if file then
        file:close()
    else
        -- Try to create from default mod's bubble texture
        local default_path = minetest.get_modpath("default")
        if default_path then
            -- Check for bubble texture
            local bubble_path = default_path .. "/textures/bubble.png"
            
            -- If the file exists, create a background strip based on it
            local bubble_file = io.open(bubble_path, "rb")
            
            if bubble_file then
                -- Create the background version of a single bubble
                local our_bg = io.open(minetest.get_modpath("hud_align") .. "/textures/bubble_bg.png", "wb")
                if our_bg then
                    bubble_file:seek("set", 0)
                    our_bg:write(bubble_file:read("*all"))
                    our_bg:close()
                    
                    minetest.log("action", "[hud_align] Created bubble background texture")
                end
                
                bubble_file:close()
                
                -- The actual strip creation needs to be done manually by copying/editing the bubble_bg.png
                -- to create a strip of 10 empty bubbles side by side
                minetest.log("warning", "[hud_align] Please create bubble_bg_strip.png manually by placing 10 empty bubbles side by side")
            else
                minetest.log("warning", "[hud_align] Couldn't find bubble texture in default mod")
            end
        end
    end
    
    -- Check if we have the thirsty drop textures (only if thirsty mod is loaded)
    if thirsty_mod_loaded then
        local drop_file = io.open(minetest.get_modpath("hud_align") .. "/textures/thirsty_drop.png", "r")
        if drop_file then
            drop_file:close()
        else
            -- Try to copy from thirsty mod
            local thirsty_path = minetest.get_modpath("thirsty")
            if thirsty_path then
                -- Check for drop texture (renamed to thirsty_drop.png)
                local drop_path = thirsty_path .. "/textures/thirsty_drop.png"
                
                -- If the file exists, copy it to our mod
                local drop_src = io.open(drop_path, "rb")
                
                if drop_src then
                    local our_drop = io.open(minetest.get_modpath("hud_align") .. "/textures/thirsty_drop.png", "wb")
                    
                    if our_drop then
                        our_drop:write(drop_src:read("*all"))
                        our_drop:close()
                        
                        -- Also create a background version
                        local our_bg = io.open(minetest.get_modpath("hud_align") .. "/textures/thirsty_drop_bg.png", "wb")
                        if our_bg then
                            drop_src:seek("set", 0) -- Go back to start of file
                            our_bg:write(drop_src:read("*all"))
                            our_bg:close()
                        end
                    end
                    
                    drop_src:close()
                else
                    minetest.log("warning", "[hud_align] Couldn't find thirsty drop texture in thirsty mod")
                end
            end
        end
    end
    
    -- Check for stamina textures (only if stamina mod is loaded)
    if stamina_mod_loaded then
        -- Check if we already have the stamina foreground texture
        local fg_file = io.open(minetest.get_modpath("hud_align") .. "/textures/stamina_hud_fg.png", "r")
        if not fg_file then
            -- Try to copy from stamina mod
            local stamina_path = minetest.get_modpath("stamina")
            if stamina_path then
                local fg_path = stamina_path .. "/textures/stamina_hud_fg.png"
                local fg_src = io.open(fg_path, "rb")
                
                if fg_src then
                    local our_fg = io.open(minetest.get_modpath("hud_align") .. "/textures/stamina_hud_fg.png", "wb")
                    if our_fg then
                        our_fg:write(fg_src:read("*all"))
                        our_fg:close()
                        minetest.log("action", "[hud_align] Copied stamina foreground texture")
                    end
                    fg_src:close()
                else
                    minetest.log("warning", "[hud_align] Couldn't find stamina_hud_fg.png in stamina mod")
                end
            end
        else
            fg_file:close()
        end
        
        -- Check if we need to copy the poison texture
        local poison_file = io.open(minetest.get_modpath("hud_align") .. "/textures/stamina_hud_poison.png", "r")
        if not poison_file then
            -- Try to copy from stamina mod
            local stamina_path = minetest.get_modpath("stamina")
            if stamina_path then
                local poison_path = stamina_path .. "/textures/stamina_hud_poison.png"
                local poison_src = io.open(poison_path, "rb")
                
                if poison_src then
                    local our_poison = io.open(minetest.get_modpath("hud_align") .. "/textures/stamina_hud_poison.png", "wb")
                    if our_poison then
                        our_poison:write(poison_src:read("*all"))
                        our_poison:close()
                        minetest.log("action", "[hud_align] Copied stamina poison texture")
                    end
                    poison_src:close()
                else
                    minetest.log("warning", "[hud_align] Couldn't find stamina_hud_poison.png in stamina mod")
                end
            end
        else
            poison_file:close()
        end
    end
end

-- Run texture creation on mod load
create_bubble_bg_strip() 