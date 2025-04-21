# Ashwake Mod Development Tracker

This document tracks the development of custom mods for the Ashwake game, including implementation tasks, dependencies, and progress status.

---

## Core Mod Architecture

```
ashwake_core/
  ├── init.lua           # Core initialization
  ├── api.lua            # API functions
  ├── config.lua         # Configuration management
  ├── player.lua         # Player-related functionality
  ├── events.lua         # Event handling system
  ├── memory.lua         # Memory fragment system
  └── util.lua           # Utility functions
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Create core API structure | To Do | High | Base for all other mods |
| Implement configuration system | To Do | High | For game settings |
| Create event handling system | To Do | Medium | For mod communication |
| Implement memory fragment system | To Do | Medium | For lore discovery |
| Develop player state tracking | To Do | High | For progression |

---

## Velrot Corruption System

```
ashwake_velrot/
  ├── init.lua           # Initialization
  ├── api.lua            # Corruption-specific API
  ├── effects.lua        # Corruption effects definitions
  ├── detection.lua      # Detection tools and mechanics
  ├── player_effects.lua # Effects on the player
  ├── environment.lua    # Environmental effects
  ├── protection.lua     # Protection items and mechanics
  └── compat/            # Compatibility with other mods
      ├── default.lua    # Default mod effects
      └── [other].lua    # Other mod compatibility
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Design corruption effect system | To Do | Medium | How effects manifest |
| Implement corruption detection tools | To Do | High | For player awareness |
| Create environmental behavior changes | To Do | High | For basic areas |
| Implement protection items | To Do | Medium | Player survival |
| Add subtle environmental cues | To Do | Low | Enhances atmosphere |
| Create corruption resistance system | To Do | Medium | Player progression |

### Corruption Effect Types

- Environmental anomalies (resource behavior, sounds)
- Entity behavior alterations
- Player debuffs when in affected areas
- Time/weather anomalies
- Abnormal mob spawning
- Device/mechanism malfunctions

---

## Elemental Mob System

```
ashwake_mobs/
  ├── init.lua           # Initialization
  ├── api.lua            # Mob registration API
  ├── base_mob.lua       # Base mob entity definition
  ├── spawning.lua       # Spawn control system
  ├── elements/          # Element-specific mobs
  │   ├── terra.lua      # Earth element mobs
  │   ├── aqua.lua       # Water element mobs
  │   ├── ignis.lua      # Fire element mobs
  │   ├── aero.lua       # Air element mobs
  │   ├── lux.lua        # Light element mobs
  │   └── umbra.lua      # Shadow element mobs
  ├── bosses/            # Boss mob definitions
  │   ├── terra_prime.lua
  │   ├── aqua_nexus.lua
  │   ├── ignis_core.lua
  │   ├── aero_tempest.lua
  │   ├── lux_eternal.lua
  │   └── umbra_void.lua
  └── behaviors/         # Shared behaviors
      ├── attacks.lua
      ├── movement.lua
      └── special.lua
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Design base mob system | To Do | High | Foundation for all mobs |
| Implement mob API | To Do | High | For registration |
| Create basic elemental behaviors | To Do | Medium | Element-specific actions |
| Design spawn system | To Do | Medium | Based on corruption/time |
| Create basic mob variants | To Do | Medium | Start with 1-2 per element |
| Implement boss mob framework | To Do | Low | Late-game content |

### Mob List (Basic)

- Terra Fragment (basic earth mob)
- Terra Golem (advanced earth mob)
- Aqua Droplet (basic water mob)
- Aqua Tendril (advanced water mob)
- Ignis Spark (basic fire mob)
- Ignis Revenant (advanced fire mob)
- Aero Wisp (basic air mob)
- Aero Cyclone (advanced air mob)
- Lux Mote (basic light mob)
- Lux Sentinel (advanced light mob)
- Umbra Shade (basic shadow mob)
- Umbra Stalker (advanced shadow mob)

---

## Alchemical System

```
ashwake_alchemy/
  ├── init.lua             # Initialization
  ├── api.lua              # Alchemy API
  ├── crafting.lua         # Crafting system
  ├── recipes.lua          # Recipe definitions
  ├── stations/            # Crafting stations
  │   ├── extractor.lua
  │   ├── distillery.lua
  │   ├── infuser.lua
  │   ├── stabilizer.lua
  │   └── synth_chamber.lua
  ├── items/               # Alchemical items
  │   ├── essences.lua     # Elemental essences
  │   ├── compounds.lua    # Refined compounds
  │   ├── catalysts.lua    # Process catalysts
  │   └── components.lua   # Crafting components
  └── formspecs/           # UI for stations
      ├── extractor.lua
      ├── distillery.lua
      └── [others].lua
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Design crafting system | To Do | Medium | Multi-stage crafting |
| Create basic essences | To Do | Medium | From elemental mobs |
| Implement crafting stations | To Do | Medium | Need formspecs |
| Design recipe system | To Do | Medium | Progressive discovery |
| Create catalyst system | To Do | Low | For crafting enhancement |
| Implement byproduct system | To Do | Low | For crafting depth |

### Crafting Stations

- Extractor (basic material processing)
- Distillery (refinement and purification)
- Infuser (combining elemental essences)
- Stabilizer (creating advanced compounds)
- Synth Chamber (integrating technology with materials)

---

## Artifact System

```
ashwake_artifacts/
  ├── init.lua           # Initialization
  ├── api.lua            # Artifact API
  ├── effects.lua        # Artifact effects
  ├── discovery.lua      # Artifact finding mechanics
  ├── artifacts/         # Individual artifacts
  │   ├── passive.lua    # Passive effect artifacts
  │   ├── active.lua     # Active usable artifacts
  │   ├── component.lua  # Component artifacts
  │   └── memory.lua     # Lore artifacts
  └── gui/               # UI elements
      ├── scanner.lua    # Artifact scanner interface
      └── memory.lua     # Memory fragment viewer
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Create artifact base system | To Do | Medium | For registration |
| Implement effect system | To Do | Medium | For artifact abilities |
| Design discovery mechanics | To Do | Medium | Finding artifacts |
| Create initial set of artifacts | To Do | Low | Start with 5-10 |
| Implement memory fragment viewer | To Do | Low | For lore display |
| Design artifact scanner | To Do | Low | Help finding artifacts |

### Initial Artifacts

- Lumina Lens (reveals hidden objects in light)
- Chronos Dial (slows time briefly)
- Terra Anchor (prevents knockback/movement effects)
- Aqua Filter (purifies water sources)
- Ignis Forge (portable crafting enhancement)
- Aero Boots (increased jump/movement)
- Flux Capacitor (stores energy for other artifacts)
- Void Mirror (reflects projectiles)
- Memory Resonator (helps locate memory fragments)
- Velrot Detector (detects nearby corruption effects)

---

## Dimension System

```
ashwake_dimensions/
  ├── init.lua           # Initialization
  ├── api.lua            # Dimension API
  ├── velmire/           # Velmire dimension
  │   ├── init.lua       # Velmire initialization
  │   ├── mapgen.lua     # Velmire map generation
  │   ├── nodes.lua      # Velmire-specific nodes
  │   ├── mobs.lua       # Velmire-specific mobs
  │   └── effects.lua    # Dimension effects
  ├── portals.lua        # Portal mechanics
  ├── portal_nodes.lua   # Portal node definitions
  └── teleport.lua       # Teleportation mechanics
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Research dimension implementation | To Do | Low | Technical research |
| Design Velmire biomes | To Do | Low | End-game content |
| Create portal mechanics | To Do | Low | For dimension travel |
| Implement Crucis Engine activation | To Do | Low | Portal trigger event |
| Design Velmire-specific resources | To Do | Low | Special materials |
| Create dimension effects system | To Do | Low | For atmospheric effects |

### Velmire Features

- Distorted physics (gravity, movement)
- Unique ore and material types
- Pure elemental zones
- Advanced corruption phenomena
- Dimensional stabilizers (required for permanent solution)
- Velmire-exclusive creatures

---

## UI Enhancements

```
ashwake_ui/
  ├── init.lua           # Initialization
  ├── hud.lua            # HUD element definitions
  ├── corruption_meter.lua # Corruption detection meter
  ├── energy_display.lua # Player energy system
  ├── memory_tracker.lua # Memory fragment progress
  ├── artifact_hud.lua   # Active artifact display
  └── formspecs/         # Custom UI screens
      ├── memory_viewer.lua
      ├── artifact_info.lua
      └── crucis_engine.lua
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Design HUD layout | To Do | Medium | For player information |
| Implement corruption detection meter | To Do | Medium | For player safety |
| Create energy display | To Do | Medium | Replace hunger system |
| Design memory fragment interface | To Do | Low | For lore viewing |
| Implement artifact status display | To Do | Low | For active artifacts |
| Create Crucis Engine interface | To Do | Low | End-game content |

---

## Environmental Enhancements

```
ashwake_environment/
  ├── init.lua             # Initialization
  ├── structures.lua       # Structure generation
  ├── ruins/               # Ruin definitions
  │   ├── research_lab.lua
  │   ├── archive.lua
  │   ├── power_station.lua
  │   └── residential.lua
  ├── corruption_effects/  # Environmental effects
  │   ├── subtle_cues.lua
  │   ├── sounds.lua
  │   └── behavior.lua
  ├── day_night.lua        # Enhanced day/night cycle
  └── weather.lua          # Enhanced weather effects
```

### Development Tasks

| Task | Status | Priority | Notes |
|------|--------|----------|-------|
| Design basic ruins | To Do | Medium | For exploration |
| Implement structure generation | To Do | Medium | Placement algorithm |
| Create corruption environmental cues | To Do | Low | Atmosphere |
| Enhance day/night cycle | To Do | Medium | Core gameplay mechanic |
| Implement enhanced weather | To Do | Low | For atmosphere |
| Create special landmarks | To Do | Low | Points of interest |

### Initial Structures

- Small Research Outpost
- Archive Access Point
- Power Relay Station
- Thalosian Housing Unit
- Elemental Containment Vault
- Environmental Anomaly (unique per element)

---

## Compatibility and Dependencies

### Required Base Mods
- default
- player_api
- weather (modified)
- beds (modified for no night skip)
- 3d_armor (optional, needs compatibility layer)

### Compatibility Patches

| Mod | Status | Priority | Notes |
|-----|--------|----------|-------|
| default | To Do | High | Core game mod |
| doors | To Do | Medium | For structure entrances |
| beds | To Do | Medium | Modify for no night skip |
| weather | To Do | Medium | Enhance for atmosphere |
| 3d_armor | To Do | Low | Optional enhancement |
| unified_inventory | To Do | Low | Optional enhancement |
| mesecons | To Do | Low | For mechanisms |

---

## Testing and Feedback

Use this section to track testing notes and feedback on implemented features.

| Feature | Tester | Date | Feedback | Status |
|---------|--------|------|----------|--------|
| | | | | |

---

## Version Planning

### v0.1 - Core Foundation
- Basic world mechanics
- Day/night cycle with danger scaling
- Player survival mechanics
- Initial resource gathering and crafting

### v0.2 - Progression Systems
- Alchemical crafting basics
- Initial artifacts
- Basic elemental mobs
- Corruption effect detection

### v0.3 - Exploration and Discovery
- Memory fragment system
- Expanded artifacts
- Enhanced structures
- UI improvements

### v0.4 - End Game
- Crucis Engine mechanics
- Velmire dimension access
- Elemental bosses
- Multiple endings

---

*This document should be updated as development progresses.* 