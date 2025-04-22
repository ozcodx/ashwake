# Ashwake Mods Documentation

This document provides information about all mods used in the Ashwake game, categorized by their origin and purpose.

## Base Mods (From Minetest Game)

These mods are part of the standard Minetest Game and provide core functionality:

- **beds**: Adds beds for skipping the night and setting spawn point
- **binoculars**: Adds craftable binoculars for zooming view
- **boats**: Allows crafting and using boats for water travel
- **bones**: Creates a bones node with player inventory upon death
- **bucket**: Adds buckets for transporting liquids
- **butterflies**: Adds decorative butterflies to the environment
- **carts**: Adds minecarts and rails for transportation
- **creative**: Provides creative mode inventory and functionality
- **default**: Core game content and mechanics
- **doors**: Adds doors, trapdoors, and fence gates
- **dungeon_loot**: Controls random loot found in dungeons
- **dye**: Adds various dyes for coloring other items
- **env_sounds**: Provides environmental sounds based on biome
- **farming**: Basic farming mechanics for growing crops
- **fire**: Adds fire and flammable materials
- **fireflies**: Adds decorative fireflies to the environment
- **flowers**: Adds various decorative flowers to the world
- **game_commands**: Adds basic game commands
- **give_initial_stuff**: Gives new players configurable initial items
- **keys**: Adds keys for locking and unlocking objects
- **map**: Adds a minimap to the HUD
- **mtg_craftguide**: In-game crafting reference
- **player_api**: API for player model/animation handling
- **screwdriver**: Tool for rotating nodes
- **sethome**: Allows players to set and teleport to home positions
- **sfinv**: Simple inventory formspec for players
- **spawn**: Core player spawning functionality
- **stairs**: Adds stairs and slabs for various materials
- **tnt**: Adds TNT for explosives
- **vessels**: Adds glass vessels/bottles and brass
- **walls**: Adds walls made from various materials
- **weather**: Provides weather effects like rain
- **wool**: Adds colored wool blocks
- **xpanes**: Adds glass and metal bars that connect automatically

## Custom Mods (Created for Ashwake)

These mods were created specifically for Ashwake:

- **spawn_fix**: Ensures players spawn on solid ground rather than in caves, water, or other unsafe areas. Uses emerging area technique for new players and handles terrain generation issues.

- **thirst_damage**: Implements a thirst system where players must drink water regularly to avoid taking damage. Part of the survival mechanics.

- **hud_align**: Modifies the heads-up display (HUD) alignment and appearance to better fit the Ashwake aesthetic and gameplay needs.

## Third-Party Mods (Created by Community)

These additional mods are created by the Minetest community and enhance gameplay:

- **3d_armor**: Adds wearable armor with protection values
- **atl_path**: Path-finding and path visualization library
- **bees**: Adds bees, beehives, and honey collection
- **bonemeal**: Adds bone meal for accelerating plant growth
- **bows**: Adds bows and arrows for ranged combat
- **bucket_wooden**: Adds wooden buckets as primitive liquid containers
- **composting**: Adds composting functionality for organic materials
- **headanim**: Adds head animation to player models
- **leads**: Adds leads/ropes for managing animals
- **mob_horse**: Adds rideable horses to the game
- **mobs**: Core library for mobile entities (animals, monsters, NPCs)
- **mobs_animal**: Adds various animals to the world
- **mobs_monster**: Adds various hostile monsters
- **mobs_npc**: Adds non-player characters with basic interaction
- **mobs_sky**: Adds flying creatures to the sky
- **mobs_water**: Adds aquatic creatures
- **objectuuids**: Library for assigning unique IDs to objects
- **signs_lib**: Enhanced sign functionality
- **skinsdb**: Player skin customization system
- **stamina**: Adds a stamina/exhaustion system for player actions
- **thirsty**: More advanced thirst mechanics and water sources
- **wield3d**: Shows wielded items in 3D on player model
- **wielded_light**: Makes held light sources illuminate the area

## Mod Interactions and Dependencies

Many mods depend on each other to function correctly. Here are the key dependencies:

- Most custom content depends on the **default** mod
- Mob-related mods depend on the core **mobs** API
- Most HUD mods work with or modify the **sfinv** inventory system
- Water-related functionality often requires the **bucket** mod

## Notes for Developers

When creating new mods or modifying existing ones, keep in mind:

1. Try to maintain compatibility with the core API
2. Follow the established naming conventions and code style
3. Document dependencies clearly
4. Custom mods should overload rather than directly modify base mods when possible
5. For world-altering mods, ensure they won't break existing player worlds

This document will be updated as new mods are added or modified. 