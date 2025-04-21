core.register_globalstep(function(dtime)
    if tempsurvive.step_timer > tempsurvive.step_time then
        tempsurvive.step_timer = 0
    else
        tempsurvive.step_timer = tempsurvive.step_timer + dtime
        return
    end
    for _, player in ipairs(core.get_connected_players()) do
        local name = player:get_player_name()
        local ptemp = tempsurvive.player[name]
        if ptemp and not ptemp.full_resistance then
            thirsty.player[name].thirst_per_second = 0.01 * math.pow(1.05, math.abs(ptemp.temp - 36.5)) 
        end
    end
end)
