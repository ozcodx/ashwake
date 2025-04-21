# Thirst Damage Mod

This mod for Minetest modifies the behavior of the thirst system (thirsty mod) to prevent negative hydration values and apply damage when the player's hydration level reaches zero.

## Features

- Prevents hydration level from falling below zero
- Applies damage to players when their hydration reaches zero
- Plays the default player damage sound when dehydration damage begins
- Fixes existing negative hydration values

## Configuration

You can adjust the following values at the top of the `init.lua` file:

```lua
local damage_interval = 1.0  -- How often to check for damage (in seconds)
local damage_amount = 1      -- How much damage to apply per interval
```

## Dependencies

- Requires the "thirsty" mod to function

## License

MIT License 