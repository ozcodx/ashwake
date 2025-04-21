# Thirsty [thirsty]

A Luanti mod that adds a "thirst" mechanic.

## Description

This is a mod for Luanti. It adds a thirst mechanic to the game, similar to many hunger mods (but independent of them). Players will slowly get thirstier over time, and will need to drink or suffer damage.

The point of this mod is not to make the game more realistic, or harder. The point is to have another mechanic that rewards preparation and infrastructure. Players will now have an incentive to build their base next to water (or add some water to their base), and/or take some water with them when mining or traveling.

## Terminology: "Thirst" vs. "hydration"

"Thirst" is the absence of "hydration" (a term suggested by everamzah on the Luanti forums, thanks!). The overall mechanic is still called "thirst", but the visible bar is that of "hydration", meaning a full bar represents full hydration, not full thirst. Players lose hydration (or "hydro points") over time, and gain hydration when drinking.

## Current behavior

### Tier 0

Stand in water (running or standing) to slowly drink. You may not move during drinking (or you would be able to cross an ocean without getting thirsty).

### Tier 1

Use a container (e.g. from `vessels`) on water to instantly fill your hydration. Craftable wooden bowl included.

### Tier 2

Pre-made drinks and craftable canteens

### Tier 3

Placeable drinking fountain / wash basin node: instantly fills your hydration when used.

### Tier 4

Placeable fountain node(s) to fill the hydration of all players within range. Placing more nodes increases the range.

#### How To Use Water Fountains

(Taken from [forum posts](https://forum.luanti.org/viewtopic.php?p=177400&sid=c0839ee0172e6ec297d3f102d2f502a7#p177400))

Water fountains are placeable, but these are not usable. Instead, they constantly fill the hydration of all players within a 5 node radius, as if they were standing in water. Water fountains need actual water (source or flowing) near them to work.

You can extend the radius of water fountains with "water extenders", placeable nodes without any function of their own.

Specifically, a water fountain will check all the nodes in a 5-node-high pyramid starting one node above itself. It will count all water nodes (source or flowing), and count all water fountains / water extenders. The smaller of these numbers is the "level" of the fountain, up to 20 (in other words, you need an equal amount of water and fountain blocks). Each level adds 5 more nodes to the working radius. A large fountain should cover a city block or two.

I'd recommend placing one water source above the "fountain" node, and arranging extenders under it, but the plan is to allow many working designs.

### Tier 5

Craftable trinkets/gadgets/amulets that constantly keep your hydration filled when in your inventory, solving your thirst problem once and for all.

* Amulet of Moisture - Absorbs moisture from the surrounding environment places it into a canteen or other water holding item. Must be held in Inventory.

* Amulet of Hydration - Feeds water from a Canteen or other water holding item directly into the player to keep them always hydrated. Must be held in Inventory.

The above two Amulets can be used in combination with each other plus a canteen. However this does permanently fill 3 inventory slots the deliberate downside to offset the significant bonus.

* Amulets of Thirst - Three versions - lesser, normal and greater - each will slower the rate at which a player becomes thirsty. Normal thirst factor is 1, however a "cursed" version could be created which makes a player become thirsty faster.

Note: Included Amulets of Thirst have no craft recipes and are only available as dungeon loot with more powerful versions only found in deeper dungeons.

## Future plans

Continued tidy and updating

## Dependencies

* default (optional but needed for included components)
* bucket (optional but needed for some included components)
* hudbars (optional): <https://forum.luanti.org/viewtopic.php?t=11153>
* vessels (optional): <https://forum.luanti.org/viewtopic.php?t=2574>

## Credit

Original thirsty mod is by Ben and has been contributed to by Nathan.S and sirrobzeroone: <https://forum.luanti.org/viewtopic.php?t=11820>

## License

### Code

LGPL 2.1 (see included LICENSE file)

### Textures

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) Copyright (C) 2012-2016 Vanessa Ezekowitz, 2016 Thomas-S

* vessels_glass_bottle_full_cc_by_sa_3.png
* modified from vessels_glass_bottle.png

Public Domain CC0 1.0 Universal Sirrobzeroone

* thirsty_drop_100_24_cc0.png +.xcf
* thirsty_drop_100_16_cc0.png
* thirsty_wooden_bowl_cc0.png +.xcf
* thirsty_bronze_canteen_cc0.png +.xcf
* thirsty_steel_canteen_cc0.png
* thirsty_amulet_moisture_cc0.png +.xcf
* thirsty_amulet_hydration_cc0.png +.xcf

All other Images CC BY-SA 4.0 (see <http://creativecommons.org/licenses/by-sa/4.0/>)

### Sounds

thirsty_breviceps_drink-drinking-liquid.ogg <https://freesound.org/people/Breviceps/sounds/445970/> Public Domain CC0 1.0 Universal

Report bugs or request help on the forum topic or git repo.
