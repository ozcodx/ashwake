# API

## Tier 0

To register additional drinkable nodes use the function:

```lua
thirsty.register_hydrate_node(node_name, also_drinkable_with_cup, regen_rate_per_second)
```

* `node_name` - registered node name
* `also_drinkable_with_cup` - optional will default to true, if true registers as per `thirsty.register_drinkable_node()` with `max_hydration` equal to `thirsty.config.start` (default `20`)
* `regen_rate_per_second` - optional will default to `0.5` hydration points per second standing still in the liquid.

Example:

```lua
thirsty.register_hydrate_node('default:water_source')
```

## Tier 1

### Nodes

Configure nodes that can be drunk from using a cup/glass etc assuming this was not done as part of Tier 0 or if you wish to override `max_hydration` to be more than the default value (normally `20`):

```lua
thirsty.register_drinkable_node(node_name, max_hydration)
```

* `item_name` registered node name
* `max_hydration` optional will default to `thirsty.config.start` (default `20`) max hydration can be set above `20` to encourage use of drinking fountains or hydration/drinking infrastructure.

Example:

```lua
thirsty.register_drinkable_node('thirsty:drinking_fountain', 30)
```

### Items

Configure cups/glasses/bowls etc that can be used to scoop up water and then drink from:

```lua
thirsty.augment_item_for_drinking(item_name, max_hydration)
```

* `item_name` registered item name
* `max_hydration` optional will default to thirsty.config.start (default 20) max hydration can be set above 20 to encourage use of items to drink with.

Example:

```lua
thirsty.augment_item_for_drinking('vessels:drinking_glass', 20)
```

Integrate thirsty into item custom `on_use` code:

```lua
thirsty.on_use(old_on_use)
```

* `old_on_use` If you are overriding an item that has an on_use function, set old_on_use to that function so it isn't overridden.

```lua
core.register_craftitem("mod_name:empty_cup", {
    description = S("Empty Cup"),
    inventory_image = "mod_name_empty_cup.png",
    liquids_pointable = true,
    on_use = function(itemstack,player,pointed_thing)
        local pos = pointed_thing.under
        local node_name
        if pointed_thing.type == "node" then
            local node = core.get_node(pos)
            node_name = node.name
        end

        if thirsty.config.node_drinkable[node_name] then
            thirsty.on_use()
        else
        -- do something else
        end
    end,
})
```

## Tier 2

### Premade Drinks

Pre-made drinks can include anything the player may have had to craft or cook and you wish the player to restore some hydration `on_use`:

```lua
thirsty.drink(player, amount, max_hydration, empty_vessel)
```

* `player` player object see Luanti player object
* `amount` number of hydration points to restore
* `max hydration` - optional will default to thirsty.config.start (default 20) max hydration can be set above 20 to encourage use of items to drink with.
* `empty_vessel` - optional empty vessel or item to return to player.

Example:

```lua
core.register_craftitem("mod_name:cup_of_soup", {
    description = S("Cup of Soup"),
    inventory_image = "mod_name_cup_of_soup.png",
    on_use = function(itemstack, player, pointed_thing)
        thirsty.drink(player, 2, 20, "mod_name:empty_cup")
        itemstack:take_item()
        return itemstack
    end,
})
```

### Canteens, Flasks or Bottles

Craftable items that you may wish to configure to hold a certain amount of liquid hydration points. If used these items are converted to registered tools rather than straight registered items with stack maximum of `1` so that current full/empty value is displayed to the player (using wear). Thirsty includes a Steel canteen with 40 hydration point capacity and a Bronze canteen with `60` hydration point capacity. These can be refilled by clicking on any thirsty registered `hydrate_node`.

```lua
thirsty.register_canteen(item_name, hydrate_capacity, max_hydration, on_use)
```

* `item_name` Registered item name to convert to canteen type container
* `hydrate_capacity` How many hydration points the container holds 1 full bar = `20`
* `max_hydration` Optional will default to `thirsty.config.start` (default `20`) `max_hydration` can be set above `20` to encourage use of items to drink with.
* `on_use` Optional default is true. Will set `item.on_use` function to: `thirsty.on_use()`, however if set to false on_use wont be over written. Mod registering item will need to manually include `thirsty.on_use()` inside its on_use item definition or canteen will not work note see Tier 1 - `thirsty.on_use()`

Example:

```lua
thirsty.register_canteen("thirsty:bronze_canteen", 60, 25)
```

### Complex Canteens, Flasks or Bottles

Using the above will mean items can no longer be stacked most importantly when they are empty. The below function will overcome this as it will register a full version of the empty vessel as a tool. Naturally if you do not wish or need the empty containers to stack just use `thirsty.register_canteen`. Once a container is empty it will be replaced with the empty version.

```lua
thirsty.register_canteen_complex(item_name/node_name, hydrate_capacity, max_hydration, full_image)
```

* `item_name` or `node_name` Registered item name to convert to canteen type tool container
* `hydrate_capacity` How many hydration points the container holds 1 full bar = `20`
* `max_hydration`  Optional will default to `thirsty.config.start` (default `20`) `max_hydration` can be set above `20` to encourage use of items to drink with.
* `full_image` The full image of the empty item used for inventory image and wield image

Example:

```lua
thirsty.register_canteen_complex("vessels:glass_bottle", 10, 22, "vessels_glass_bottle_full.png")
```

## Tier 3

Add the below to the `on_rightclick` function inside your node definition, you'll also need to register the node as a drinkable node so you'll need to also run `thirsty.register_drinkable_node(node_name)`. Recommended that the `node.drop` for your node doesn't equal itself otherwise players will simply use these as endless canteens/bottles.

```lua
thirsty.on_rightclick()
```

Example:

```lua
core.register_node('thirsty:drinking_fountain', {
    description = 'Drinking fountain',
    -- ...
    drop = "default:stone 4",
    on_rightclick = thirsty.on_rightclick(),
})

core.register_craft({
    output = "thirsty:drinking_fountain",
    recipe = {
        { "default:stone", "bucket:bucket_water", "default:stone"},
        { ""             , "default:stone"      ,              ""},
        { ""             , "default:stone"      ,              ""}
    },
    replacements = {
        {"bucket:bucket_water", "bucket:bucket_empty"}
    }
})

thirsty.register_drinkable_node("thirsty:drinking_fountain", 30)
```

## Tier 4

```lua
thirsty.register_water_fountain(node_name)
```

Example:

```lua
thirsty.register_water_fountain("thirsty:water_fountain")
```

## Tier 5

```lua
thirsty.register_amulet_extractor(item_name,value)
```

* `item_name` Registered item name
* `value` Number of Hydration points extracted per half second (`thirsty.config.tick_time`)

Note: Container must be available in Inventory with available space to add hydration points to.

Example:

```lua
thirsty.register_amulet_extractor("thirsty:amulet_of_moisture", 0.6)
```

* Amulet of Moisture - Absorbs moisture from the surrounding environment places it into a canteen or other water holding item. Must be held in Inventory.

```lua
thirsty.register_amulet_supplier(item_name,value)
```

* `item_name` Registered item name
* `value` Number of Hydration points supplied to player per half second. (`thirsty.config.tick_time`)

Note: Container must be available in Inventory with available space to add hydration points to.

Example:

```lua
thirsty.register_amulet_supplier("thirsty:amulet_of_hydration", 0.5)
```

* Amulet of Hydration - Feeds water from a Canteen or other water holding item directly into the player to keep them always hydrated. Must be held in Inventory.

The above two Amulets can be used in combination with each other plus a canteen. However this does permanently fill 3 inventory slots the deliberate downside to offset the significant bonus.

* Amulets of Thirst - Three versions - lesser, normal and greater - each will slower the rate at which a player becomes thirsty. Normal thirst factor is 1, however a "cursed" version could be created which makes a player become thirsty faster.

```lua
thirsty.register_amulet_thirst(item_name, thirst_factor)
```

* `item_name` Registered item name
* `thirst_factor` Float value that represents the speed at which a player uses hydration points

Example:

```lua
core.register_craftitem("thirsty:greater_amulet_thirst", {
    description = "Greater Amulet of Thirst",
    inventory_image = "thirsty_amulet_of_thirst_greater_cc0.png",
})

thirsty.register_amulet_thirst("thirsty:lesser_amulet_thirst", 0.85)
```

Note: Included Amulets of Thirst have no craft recipes and are only available as dungeon loot with more powerful versions only found in deeper dungeons.

### Additional Functions

`thirsty.get_hydro(player)`: returns the current hydration of a player

* `player` refers to a player object, i.e. with a `get_player_name()` method.
