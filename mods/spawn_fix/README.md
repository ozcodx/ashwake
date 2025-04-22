# Spawn Fix

A Luanti mod that ensures players spawn on solid ground above water and caves.

## Features

- Prevents spawning in water or lava
- Ensures players spawn on solid ground
- Checks for adequate headroom above spawn point
- Searches in a spiral pattern to find the nearest safe spawn location
- Works with any mapgen
- Compatible with the default spawn mod

## Dependencies

- `spawn` (default Luanti mod)

## Configuration

The mod has several configurable parameters in `init.lua`:

- `SPAWN_CHECK_RADIUS = 32` - How far to search horizontally for safe ground
- `MAX_UPWARD_CHECK = 50` - How far up to check for ground
- `MAX_DOWNWARD_CHECK = 50` - How far down to check for ground

## How it Works

1. When a player spawns, the mod checks if the position is safe by verifying:
   - The player is not in water or lava
   - The player is in air with solid ground below
   - There's enough space above for the player to stand

2. If the spawn position is not safe, it searches for a safe position by:
   - First checking upward from the original position
   - Then checking downward
   - Finally, if needed, searching in a spiral pattern around the original position

3. If no safe location is found within the search radius, it falls back to the original spawn position

## License

This mod is licensed under the MIT License. See the LICENSE file for details.

## Author

- ozcodx 