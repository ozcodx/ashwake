# HUD Alignment Mod

This mod improves the HUD (Heads-Up Display) elements in Minetest by:

1. **Making oxygen bubbles always visible** - Shows empty indicators when you're not underwater
2. **Aligning the thirsty mod's display** with the stamina mod's display - Providing visual symmetry
3. **Adding background indicators** for empty elements rather than having them disappear

## Features

- Symmetrical alignment of thirst and stamina bars
- Always-visible oxygen bubbles (even when full)
- Consistent style across all HUD elements
- **Non-invasive implementation** - Makes no changes to the original mods

## Dependencies

- **Required**: default
- **Optional**: stamina, thirsty

## How It Works

The mod creates custom HUD elements that replace or enhance the default ones:

- **Oxygen Bubbles**: Replaces the default breath HUD with a custom one that's always visible
- **Thirst Indicator**: 
  - Hooks into the thirsty mod's API without modifying its files
  - Creates a custom thirsty HUD positioned symmetrically with the stamina HUD
  - Maintains all original functionality while improving the visual appearance

## Installation

1. Place this mod in your `mods/` directory
2. Enable it in your world settings
3. Start or restart the game

## Technical Details

This mod uses a combination of techniques to achieve its effects:

1. **For oxygen bubbles**:
   - Disables the default breath HUD
   - Creates a custom breath HUD with background textures for empty bubbles
   - Updates the HUD when breath values change

2. **For thirsty integration**:
   - Hooks into the thirsty mod's API functions using function overrides
   - Creates a custom thirsty HUD element at the proper position
   - Keeps the original functionality for HUDbars support
   - Updates the HUD when hydration values change

## License

MIT License 