-- Spawn Fix mod
-- Ensures players spawn on solid ground above water and caves

local SPAWN_CHECK_RADIUS = 32  -- How far to check for safe ground
local MAX_UPWARD_CHECK = 50    -- How far up to check for ground
local MAX_DOWNWARD_CHECK = 50  -- How far down to check for ground

-- List of unsafe blocks to stand on
local unsafe_blocks = {
    ["air"] = true,
    ["ignore"] = true,
    ["default:water_source"] = true,
    ["default:river_water_source"] = true,
    ["default:lava_source"] = true,
    ["default:lava_flowing"] = true,
    ["default:water_flowing"] = true,
    ["default:river_water_flowing"] = true
}

-- Function to check if a position is safe to spawn
local function is_safe_spawn_pos(pos)
    -- Get the node at the position
    local node = minetest.get_node(pos)
    if not node or node.name == "ignore" then
        return false
    end

    local node_below = minetest.get_node(vector.new(pos.x, pos.y - 1, pos.z))
    if not node_below or node_below.name == "ignore" then
        return false
    end
    
    -- Check if we're in water or lava
    if node.name == "default:water_source" or 
       node.name == "default:lava_source" or
       node_below.name == "default:water_source" or
       node_below.name == "default:lava_source" then
        return false
    end

    -- Check if we're in air with any non-unsafe ground below
    if node.name == "air" and not unsafe_blocks[node_below.name] then
        -- Check if there's enough space above
        local space_above = true
        for y = 1, 2 do
            local node_above = minetest.get_node(vector.new(pos.x, pos.y + y, pos.z))
            if not node_above or node_above.name == "ignore" or node_above.name ~= "air" then
                space_above = false
                break
            end
        end
        return space_above
    end

    return false
end

-- Function to get world surface height at a position
local function get_surface_height(x, z)
    -- Find the surface by going from high to low
    for y = 100, -50, -1 do
        local pos = {x = x, y = y, z = z}
        local node = minetest.get_node(pos)
        if node.name ~= "air" and node.name ~= "ignore" and
           node.name ~= "default:water_source" and node.name ~= "default:lava_source" then
            -- Found surface, return the position above it
            return y + 1
        end
    end
    return 0  -- Default to 0 if no surface found
end

-- Function to find a safe spawn position with emerged area
local function find_safe_spawn_emerged(original_pos, callback)
    -- Define the area to emerge (a bit bigger to ensure we have room)
    local min_pos = vector.new(original_pos.x - 5, original_pos.y - 5, original_pos.z - 5)
    local max_pos = vector.new(original_pos.x + 5, 100, original_pos.z + 5)  -- Go up to y=100 to find surface
    
    -- Emerge the area first to make sure all nodes are loaded
    minetest.emerge_area(min_pos, max_pos, function(blockpos, action, remaining, param)
        if remaining == 0 then
            -- Get the surface height at the original position
            local surface_y = get_surface_height(original_pos.x, original_pos.z)
            
            -- Try positions based on surface height
            local check_pos = vector.new(original_pos.x, surface_y, original_pos.z)
            
            if is_safe_spawn_pos(check_pos) then
                callback(check_pos)
                return
            end
            
            -- Try positions near surface
            for y_offset = 1, 10 do
                check_pos.y = surface_y + y_offset
                if is_safe_spawn_pos(check_pos) then
                    callback(check_pos)
                    return
                end
                
                check_pos.y = surface_y - y_offset
                if is_safe_spawn_pos(check_pos) then
                    callback(check_pos)
                    return
                end
            end
            
            -- Try a small spiral pattern around surface
            local radius = 1
            while radius <= 5 do  -- Small radius for quick check
                for x = -radius, radius do
                    for z = -radius, radius do
                        if math.abs(x) == radius or math.abs(z) == radius then
                            check_pos.x = original_pos.x + x
                            check_pos.z = original_pos.z + z
                            check_pos.y = get_surface_height(check_pos.x, check_pos.z)
                            
                            if is_safe_spawn_pos(check_pos) then
                                callback(check_pos)
                                return
                            end
                        end
                    end
                end
                radius = radius + 1
            end
            
            -- If all else fails, use a default safe position at y=10
            local fallback_pos = vector.new(original_pos.x, 10, original_pos.z)
            callback(fallback_pos)
        end
    end)
end

-- Function to find a safe spawn position
local function find_safe_spawn_pos(original_pos)
    -- Try a few common spawn heights first
    local common_heights = {0, 1, 5, 10, 15, 20, 30, 40, 50}
    local check_pos = vector.new(original_pos.x, original_pos.y, original_pos.z)
    
    for _, height in ipairs(common_heights) do
        check_pos.y = height
        if is_safe_spawn_pos(check_pos) then
            return check_pos
        end
    end
    
    -- If no safe position found at common heights, try a simple up/down search
    -- Try going up first
    for y = 1, MAX_UPWARD_CHECK do
        check_pos.y = original_pos.y + y
        if is_safe_spawn_pos(check_pos) then
            return check_pos
        end
    end
    
    -- Then try going down
    for y = 1, MAX_DOWNWARD_CHECK do
        check_pos.y = original_pos.y - y
        if is_safe_spawn_pos(check_pos) then
            return check_pos
        end
    end
    
    -- If still no safe position found, try a simple spiral pattern
    local radius = 1
    while radius <= SPAWN_CHECK_RADIUS do
        for x = -radius, radius do
            for z = -radius, radius do
                if math.abs(x) == radius or math.abs(z) == radius then
                    check_pos.x = original_pos.x + x
                    check_pos.z = original_pos.z + z
                    check_pos.y = original_pos.y
                    
                    if is_safe_spawn_pos(check_pos) then
                        return check_pos
                    end
                end
            end
        end
        radius = radius + 1
    end
    
    -- If all else fails, try to find any position with air and solid ground
    for y = -50, 50 do
        check_pos.y = original_pos.y + y
        local node = minetest.get_node(check_pos)
        local node_below = minetest.get_node(vector.new(check_pos.x, check_pos.y - 1, check_pos.z))
        
        if node and node.name == "air" and node_below and node_below.name ~= "air" and
           not unsafe_blocks[node_below.name] then
            return check_pos
        end
    end
    
    return original_pos
end

-- Register the spawn fix callback
spawn.register_on_spawn(function(player, is_new)
    local pos = player:get_pos()
    
    -- Use emerged area approach for new players (where world might not be generated)
    if is_new then
        find_safe_spawn_emerged(pos, function(safe_pos)
            player:set_pos(safe_pos)
        end)
        return true
    else
        -- For respawns, use the direct approach (world should be loaded already)
        local safe_pos = find_safe_spawn_pos(pos)
        player:set_pos(safe_pos)
        return true
    end
end) 