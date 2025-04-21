------------------------------------------------------------
--             _____ _    _        _                      --
--            |_   _| |_ (_)_ _ __| |_ _  _               --
--              | | | ' \| | '_(_-<  _| || |              --
--              |_| |_||_|_|_| /__/\__|\_, |              --
--                                     |__/               --
------------------------------------------------------------
--              HUD definitions for Thirsty               --
------------------------------------------------------------
--                See init.lua for license                --
------------------------------------------------------------

--[[
Optionally from one of the supported mods

Any hud needs to define the following functions:

- thirsty.hud_init(player)
  Initialize the HUD for a new player.

- thirsty.hud_update(player, value)
  Display the new value "value" for the given player. "value" is
  a floating point number, not necessarily bounded. You can use the
  "thirsty.hud_clamp(value)" function to get an integer between 0
  and 20.

]] --

function thirsty.hud_clamp(value)
    if value < 0 then
        return 0
    elseif value > 20 then
        return 20
    else
        return math.ceil(value)
    end
end

if core.global_exists("hb") then
    hb.register_hudbar('thirst', 0xffffff, "Hydration", {
        bar = 'thirsty_hudbars_bar.png',
        icon = 'thirsty_drop_100_24_cc0.png'
    }, 20, 20, false)
    function thirsty.hud_init(player)
        if thirsty.config.enable_damage then
            local pmeta = player:get_meta()
            hb.init_hudbar(player, 'thirst',
                thirsty.hud_clamp(pmeta:get_float("thirsty_hydro")),
                20, false)
        end
    end

    function thirsty.hud_update(player, value)
        if thirsty.config.enable_damage then
            hb.change_hudbar(player, 'thirst', thirsty.hud_clamp(value), 20)
        end
    end
else
    -- 'builtin' hud
    local thirsty_hud
    function thirsty.hud_init(player)
        if thirsty.config.enable_damage then
            -- above breath bar, for now
            local pmeta = player:get_meta()

            thirsty_hud = player:hud_add({
                type = "statbar",
                position = { x = 0.5, y = 1 },
                text = "thirsty_drop_100_24_cc0.png",
                number = thirsty.hud_clamp(pmeta:get_float("thirsty_hydro")),
                direction = 0,
                size = { x = 24, y = 24 },
                offset = { x = 25, y = -(48 + 24 + 16 + 32) },
            })
        end
    end

    function thirsty.hud_update(player, value)
        if thirsty.config.enable_damage then
            local hud_id = thirsty_hud
            player:hud_change(hud_id, 'number', thirsty.hud_clamp(value))
        end
    end
end
