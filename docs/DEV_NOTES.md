# Ashwake Development Notes

## CONFIDENTIAL - DEVELOPER ONLY

This document contains development notes, spoilers, and planning information for Ashwake. This file should never be included in public releases.

---

## Core Concepts & World Building

### Velrot Corruption
- **Nature**: Incorporeal disease that distorts consciousness, perception, and reality
- **Manifestation**: Invisible force, detected only through its effects on the environment and entities
- **Mechanics to implement**:
  - Effects on entities and mobs
  - Player debuffs when in corrupted areas
  - Corruption resistance/immunity items

### Amnesis Units
- **Background**: Biomechanical vessels created to store human memories
- **Player Identity**: The player is an awakened Amnesis Unit with no memory
- **Mechanics to implement**:
  - Visual player model representing biomechanical nature
  - Energy system instead of traditional food
  - Upgradeable parts that boost mechanics

---

## Gameplay Systems

### Technology Progression
- **Evolution Path**:
  - Stone Age (primitive tools, basic structures)
  - Simple Mechanisms (hand-powered, basic gears)
  - Steam Power (pressure-based systems, heat management)
  - Electricity (circuits, generators, batteries)
  - Thalosian Technology (energy cores, matter-energy conversion)
- **Progression System**:
  - Technologies unlock through exploration and discovery
  - Research component (finding ancient documents)
  - Experimentation system (combining elements to discover recipes)
  - Crafting station requirements (more advanced tech requires specialized stations)

### Light & Darkness Cycle
- **Core Mechanic**: Light is safety, darkness brings danger
- **Implementation Ideas**:
  - Increased mob spawning in darkness
  - Player debuffs in darkness
  - Light sources with different strengths/durations

### Crafting System
- **Components**:
  - Materials (raw resources and refined components)
  - Tools (degrade with use, different tiers for different tech levels)
  - Fuels (required for certain crafting stations)
  - Recipes (some known from beginning, others discovered)
- **Crafting Stations**:
  - Stone Age: Crafting Table, Stone Kiln
  - Simple Mechanisms: Woodworking Bench, Forge
  - Steam Age: Steam Press, Pressure Refiner
  - Electrical: Circuit Table, Electro-Assembler
  - Thalosian: Synth Chamber, Matter Reconstructor
- **Discovery System**:
  - Recipe experimentation (shapeless crafting allows trying combinations)
  - Ancient documents (find Thalosian texts containing advanced recipes)
  - Observation (certain world events can hint at possible recipes)

### Health & Survival System
- **Energy System**:
  - Food provides different energy levels (replaces traditional health)
  - Even with mechanical body, organic components require sustenance
  - Different food types provide different benefits/duration
- **Illness System**:
  - Various conditions can affect the player (malfunctions, corruptions, etc.)
  - Monster attacks can cause status effects (frozen, stunned, etc.)
  - Hidden factors influence illness development:
    - Sleep deprivation (too long without resting)
    - Sunlight deprivation (too long underground)
    - Diet monotony (eating the same food repeatedly)
    - Environmental hazards (certain areas cause specific conditions)
- **Treatment System**:
  - Each illness/condition has specific cures/treatments
  - Treatments scale with technology level
  - Some conditions require specific ingredients from dangerous areas

### Elemental Mobs
- **Types to Create**:
  1. Terra (Earth) - slow, high defense
  2. Aqua (Water) - fluid movement, water-based attacks
  3. Ignis (Fire) - aggressive, burning effect
  4. Aero (Air) - fast, difficult to hit
  5. Lux (Light) - rare, only in specific locations, special drops
  6. Umbra (Shadow) - only at night, invisibility abilities
- **Special Mobs**:
  - Corrupted Amnesis Unit - hostile version of the player, high intelligence, uses tools
- **Behavior System**:
  - Element-specific behaviors and attacks
  - Resistance to certain weapons/elements
  - Interaction with environment (fire mobs ignite flammable nodes, etc.)

### Alchemical Progression
- **Core Resources**:
  - Basic elemental essences
  - Refined elemental compounds
  - Ancient technology components
- **Crafting System**:
  - Multi-stage refinement process
  - Combining elements for new properties
  - Discovery-based recipes (no recipe book)

---

## Story Elements & Spoilers

### The Truth About the Player
- Amnesis Unit #437, originally designated to host the consciousness of Dr. Elian Thorus
- The transfer process was interrupted, resulting in corrupted/incomplete memory
- Player can discover their identity through memory fragments

### The Crucis Engine
- **Reality**: Origin of the Velrot disaster, not the solution
- **Development Plan**:
  - Create scattered blueprints for discovery
  - Implement component collection quest
  - Design the Engine construction interface
  - Program the consequences of activation (new invasion phase)
  - Create entry to Velmire dimension

### The Six Elemental Bosses
1. **Terra Prime**: Controls earth and stone, resides in deep underground ruins
2. **Aqua Nexus**: Controls water and ice, found in ancient waterworks
3. **Ignis Core**: Controls fire and heat, located in volcanic wasteland
4. **Aero Tempest**: Controls air and storms, dwells in floating ruins
5. **Lux Eternal**: Controls light and energy, hidden in sealed Thalosian vault
6. **Umbra Void**: Controls darkness and chaos, manifests only in deepest Velrot corruption

---

## Development Roadmap

### Phase 1: Core Mechanics & Modifications (Current Phase)
1. **Player Spawn & Base Mechanics**
   - ✅ Create `spawn_fix` to ensure proper spawn locations
   - Utilize `skinsdb` to create Amnesis Unit appearances.
   - Create custom skins that match the game's aesthetic and lore

2. **Survival Mechanics**
   - ✅ Implement `thirst_damage` for basic hydration needs
   - ✅ Customize HUD with `hud_align` for better aesthetics
   - Create `vitality_system` mod to integrate thirsty and stamina while maintaining human-like needs

3. **World and Environment**
   - Create `corrupted_biomes` mod to add Velrot-affected areas
   - Modify `weather` to include corruption particles/effects
   - Enhance night dangers by adjusting mob spawning parameters
   - Utilize existing dungeons as Thalosian ruins through `dungeon_loot` modifications

### Phase 2: Entity & Creature Development
1. **Custom Mobs Framework**
   - Create `elemental_core` as base for all elemental creatures
   - Study `mobs_monster` and `mobs_npc` as reference, to be replaced later
   - Develop AI patterns for different elemental types

2. **Element-Specific Mobs**
   - Create `terra_creatures` mod for earth-based entities (including Terra Prime boss)
   - Create `aqua_creatures` mod for water-based entities (including Aqua Nexus boss)
   - Create `ignis_creatures` mod for fire-based entities (including Ignis Core boss)
   - Create `aero_creatures` mod for air-based entities (including Aero Tempest boss)
   - Later stages: Create `lux_entities` and `umbra_entities` with respective bosses

3. **Hazards & Special Entities**
   - Create `velrot_entities` for corruption-based creatures
   - Create `corrupted_units` for hostile player-like entities
   - Add specialized boss entity framework

### Phase 3: Technology & Progression
1. **Crafting System Enhancement**
   - Create `tech_crafting` mod to implement progressive tech levels
   - Convert existing crafting to shapeless discovery-based system
   - Add specialized crafting stations for each tech level

2. **Technology Tiers**
   - Create `primitive_tech` for Stone Age mechanics, migrating appropriate existing recipes
   - Create `mechanical_tech` for Simple Mechanisms level with new and migrated recipes
   - Create `steam_tech` for Steam Power mechanics with new and migrated recipes
   - Create `electrical_tech` for Electricity level with new and migrated recipes
   - Create `thalosian_tech` for advanced ancient technology with new recipes

3. **Research & Discovery**
   - Develop `thalosian_crystals` system for storing and retrieving memories/knowledge
   - Modify `dungeon_loot` to include blueprints, crystal fragments, and ancient parts
   - Implement experiment-based recipe discovery within the shapeless crafting system

### Phase 4: Corruption & Alchemy
1. **Corruption Mechanics**
   - Create `velrot_core` to handle corruption spread and effects
   - Implement corruption resistance items
   - Add corruption detection tools

2. **Alchemical System**
   - Develop `alchemy_basics` for elemental essences
   - Create `advanced_alchemy` for compound crafting
   - Implement `purification_methods` for treating corruption

3. **Environmental Hazards**
   - Add corruption-based environmental effects
   - Create special structures that appear in corrupted areas
   - Implement cleansing mechanics for corrupted areas

### Phase 4.5: Advanced Entities
1. **NPC Implementation**
   - Create `awakened_units` mod to replace `mobs_npc`
   - Design NPCs as awakened Amnesis Units or ancient functional machines
   - Implement interaction and trading mechanics specific to the game's lore

### Phase 5: End Game Content
1. **Boss Development**
   - Finalize all elemental bosses within their respective mods
   - Develop the Crucis Engine assembly quest
   - Implement multiple ending paths based on player choices

2. **Velmire Dimension**
   - Create separate dimension accessed through the Crucis Engine
   - Develop unique environment and challenges
   - Add special resources only available in Velmire

3. **Narrative Completion**
   - Finalize Thalosian crystal collection system
   - Implement revelation of player's true identity
   - Create closing cinematic for each ending path

### Phase 6: Polishing & Balancing
1. **Performance Optimization**
   - Audit all custom mods for performance issues
   - Optimize entity rendering and behavior
   - Ensure compatibility across different systems

2. **UI & Experience**
   - Finalize all custom HUD elements
   - Ensure consistent visual language across all interfaces
   - Add tutorial elements for complex systems

3. **Balancing**
   - Test and adjust difficulty progression
   - Balance resource availability and crafting requirements
   - Fine-tune combat mechanics and mob difficulty

---

## Asset Tracking

### Textures Needed
- Environmental effect indicators (not directly showing corruption)
- Alchemical ingredients and components
- Ancient technology artifacts
- Elemental mob textures
- Amnesis Unit player textures
- Technology progression items and stations
- Illness/condition status icons

### Sounds Needed
- Ambient sounds for corrupted areas
- Elemental mob sounds
- Ancient technology activation sounds
- Subtle environmental cues for Velrot presence
- Crafting station operation sounds
- Illness/condition effect sounds

---

## Testing Notes

*Add testing feedback, bugs, and balance issues here as development progresses*

---

## Random Ideas

*Use this section for brainstorming and ideas that don't fit elsewhere* 