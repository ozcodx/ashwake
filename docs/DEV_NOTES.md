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

### Phase 1: Core Mechanics
- Basic world generation
- Day/night cycle with danger scaling
- Player survival mechanics
- Initial resource gathering and crafting

### Phase 2: Velrot & Corruption
- Corrupted biomes and areas (with subtle environmental clues)
- Basic elemental mobs
- Corruption detection tools
- Protection/resistance items

### Phase 3: Progression Systems
- Alchemical crafting
- Ancient technology discovery
- Memory fragment collection
- Ability unlocks

### Phase 4: End Game
- Crucis Engine assembly
- Velmire dimension
- Elemental bosses
- Multiple endings based on player choices

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