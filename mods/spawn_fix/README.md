# Spawn Fix

A Luanti mod that ensures players spawn on solid ground above water and caves.

## Features

- Prevents spawning in water, lava or any unsafe locations
- Ensures players spawn on solid ground with enough headroom
- Uses a smart algorithm to find safe spawn positions
- Different strategies for new players vs respawning players
- Works with any mapgen
- Compatible with the default spawn mod

## Key Functions

The mod uses several strategies to find safe spawn locations:

1. **For new players**: Uses `minetest.emerge_area` to ensure the world is properly generated around spawn point before selecting a position
2. **For respawns**: Uses a direct position search

The search algorithm tries:
- Finding the surface level at the spawn coordinates
- Checking common spawn heights
- Searching above and below the spawn position
- Searching in a spiral pattern around the spawn point
- Using a fallback position if all else fails

## Configuration

The mod has several configurable parameters in `init.lua`:

- `SPAWN_CHECK_RADIUS = 32` - How far to search horizontally for safe ground
- `MAX_UPWARD_CHECK = 50` - How far up to check for ground
- `MAX_DOWNWARD_CHECK = 50` - How far down to check for ground
- `unsafe_blocks` - List of block types not suitable to spawn on

## Compatible Ground Types

The mod will consider any solid ground safe for spawning except for:
- Air
- Water (all types)
- Lava (all types)
- Unloaded chunks ("ignore" nodes)

This means it works with all types of terrain including sand, desert sand, dirt, stone, etc.

## License

This mod is licensed under the MIT License. See the LICENSE file for details.

## Author

- ozcodx 