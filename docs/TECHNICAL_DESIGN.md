# Ashwake Technical Design Document

## Technical Architecture

This document outlines the technical implementation details for the Ashwake game. It serves as a reference for developers working on the project and should be updated as implementation progresses.

---

## Mod Structure

### Core API (`ashwake_core`)

The central API module that other mods will depend on.

```lua
-- Example API structure
ashwake = {}
ashwake.registered_corruptions = {}
ashwake.registered_artifacts = {}
ashwake.memory_fragments = {}

-- Register a corruption effect
function ashwake.register_corruption_effect(name, def)
    -- Implementation
end

-- Register an artifact
function ashwake.register_artifact(name, def)
    -- Implementation
end
```

#### Key Components:
- Global namespace and API registration
- Common utility functions
- Event handling system
- Configuration management
- Memory fragment management

---

## Velrot Corruption System (`ashwake_velrot`)

### Corruption Effects
Velrot is an invisible force that manifests through its effects on the environment and entities.

```lua
-- Example corruption effect registration
ashwake.register_corruption_effect("default:stone", {
    effect_type = "behavior_change",
    effect_radius = 10,
    effect_intensity = 2,
    triggers = {
        on_dig = function(pos, node, digger)
            -- Custom effect when node is dug in corrupted area
        end,
        on_timer = function(pos)
            -- Periodic effect in corrupted area
        end
    },
    player_effects = {
        "nausea",
        "weakness",
        -- other status effects
    }
})
```

### Detection Mechanics
- Environment abnormalities (strange sounds, entity behavior)
- Special detection tools/artifacts
- Player stat changes when in corrupted areas
- Subtle environmental cues (dead plants, unusual mob behavior)

### Corruption Influence
- Area effects without visible corruption
- Environmental behavior changes
- Mob spawning and behavior alteration
- Subtle atmospheric changes (sound, lighting)

---

## Elemental Mob System (`ashwake_mobs`)

### Base Mob Class
All elemental mobs inherit from a common base class with shared behaviors.

```lua
-- Example mob registration
ashwake.register_mob("ashwake_mobs:terra_fragment", {
    type = "monster",
    element = "terra",
    hp_max = 30,
    damage = 6,
    aggressive = true,
    spawn_conditions = {
        light_max = 7,
        corruption_level_min = 2,
    },
    weaknesses = {"aero"},
    resistances = {"terra", "ignis"},
    drops = {
        {name = "ashwake_alchemy:terra_essence", chance = 0.5, count = {1, 3}},
    },
    -- Other mob properties
})
```

### Element-Specific Behaviors
Each elemental type will have unique attacks and behaviors:
- Terra: Slow movement, high defense, ground slam attack
- Aqua: Fluid movement, water attacks that slow player
- Ignis: Aggressive, sets flammable objects on fire
- Aero: Fast movement, knockback attacks
- Lux: Emits light, blinding flash attack
- Umbra: Invisibility in darkness, shadow travel

### Spawning System
- Corruption level-based spawning
- Time-of-day influence (more at night)
- Proximity to artifacts or energy sources

---

## Alchemical Crafting System (`ashwake_alchemy`)

### Multi-Stage Crafting
Crafting will require multiple steps and specialized crafting stations.

```lua
-- Example multistage recipe
ashwake.register_alchemy_recipe({
    stage = "distillation",
    input = {"ashwake_alchemy:raw_terra_essence", "default:water_source"},
    catalyst = "ashwake_alchemy:purification_crystal",
    output = "ashwake_alchemy:refined_terra_essence",
    time = 60,
    byproduct = {
        item = "ashwake_alchemy:impurities",
        chance = 0.75,
    },
})
```

### Crafting Stations
- Extractor (basic material processing)
- Distillery (refinement and purification)
- Infuser (combining elemental essences)
- Stabilizer (creating advanced compounds)
- Synth Chamber (integrating technology with materials)

### Resource Types
- Raw materials (gathered from world)
- Elemental essences (extracted from mobs/environment)
- Refined compounds (processed from essences)
- Ancient components (found in ruins)
- Catalysts (reusable crafting accelerators)

---

## Artifact System (`ashwake_artifacts`)

### Artifact Types
- Passive (provide constant effects)
- Active (can be activated for special abilities)
- Component (used in crafting advanced items)
- Memory (reveals lore and story elements)

```lua
-- Example artifact registration
ashwake.register_artifact("ashwake_artifacts:flux_capacitor", {
    type = "active",
    description = "Ancient device that can manipulate time locally",
    use_cooldown = 120,
    charge_max = 5,
    charge_recovery = {
        time = 600,
        requirement = "near light source",
    },
    on_use = function(itemstack, user, pointed_thing)
        -- Implementation of time manipulation effect
    end,
})
```

### Discovery System
- Artifacts are found in ruins, not craftable
- Scanner device helps locate nearby artifacts
- Each has unique appearance and properties
- Some require special conditions to activate

---

## Dimension System (`ashwake_dimensions`)

### Velmire Dimension
- Separate mapgen for Velmire
- Portal/teleportation mechanics
- Unique resources and challenges
- Higher difficulty mobs and environments

```lua
-- Example dimension registration
ashwake.register_dimension("velmire", {
    description = "The source dimension of Velrot",
    mapgen = "ashwake_dimensions:velmire",
    gravity = 0.8, -- Lower gravity than normal world
    sky_properties = {
        -- Custom sky settings
    },
    ambient_light = 0.1,
    node_replacements = {
        ["default:stone"] = "ashwake_dimensions:velmire_stone",
        -- Other replacements
    },
    on_player_enter = function(player)
        -- Effects when player enters dimension
    end,
})
```

### Portal Mechanics
- Crucis Engine activation creates unstable portals
- Portal stabilization requires special items
- Two-way travel mechanics
- Portal decay over time

---

## Player Mechanics

### Amnesis Unit Functionality
- Energy system instead of hunger
- Memory fragment collection
- Special abilities unlocked through story progression
- Custom player model and animations

### Player HUD Elements
- Corruption detection meter (not showing corruption itself, but your exposure level)
- Energy level display
- Memory fragment tracker
- Active artifact indicators

---

## World Generation

### Corrupted Areas
- No visual corruption, but areas with different properties
- Environmental behavior changes in corrupted zones
- Special resources in corrupted areas
- Ruins and structures

### Ancient Structures
- Thalosian research facilities
- Memory storage chambers
- Power generation stations
- Crucis Engine components

---

## Performance Considerations

### Optimization Strategies
- Use distance-based updates for corruption effects
- Mob count limits and smart spawning
- Efficient storage of corruption data
- Local corruption effect processing

### Settings Control
- Graphic detail options
- Mob difficulty scaling
- Weather and environmental effects intensity
- Subtle effects intensity

---

## Mod Dependencies and Compatibility

### Required Base Mods
- default
- player_api
- weather (optional but recommended)

### Compatible Enhancement Mods
- 3d_armor (will need compatibility layer)
- unified_inventory (will need custom crafting integration)
- mesecons (can be used for advanced mechanisms)

---

## Data Storage

### Player Data
- Discovered artifacts and memories
- Corruption resistance level
- Unlocked abilities
- Quest/discovery progress

### World Data
- Corruption area markers (invisible to player)
- Artifact locations
- Generated structures
- Velmire portal locations

---

## Future Expansion Possibilities

- Additional dimensions beyond Velmire
- More elemental types and combinations
- Advanced technology tiers
- Multiplayer-specific features (if decided to support)

---

*This document should be updated as implementation details are finalized.* 