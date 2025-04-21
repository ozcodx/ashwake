# Ashwake Health and Illness System

This document outlines the health and illness mechanics in Ashwake, including illness types, curing methods, hidden factors, and player state management.

---

## Core Health Mechanics

The health system in Ashwake goes beyond a simple health bar, incorporating various states that affect the player's capabilities.

### Health States

| State | Description | Visual Indicator | Effect on Gameplay |
|-------|-------------|------------------|-------------------|
| Healthy | Normal functioning | Green health bar | Normal abilities |
| Injured | Physical damage | Yellow health bar, bandage icon | Reduced movement speed, stamina penalty |
| Severely Injured | Critical physical state | Red health bar, blood icon | Major movement penalty, cannot sprint, vision effects |
| Ill | Disease affecting the body | Green health bar with purple spots | Varies by illness type |
| Corrupted | Velrot influence | Black patches on health bar | Varies by corruption level |

### Recovery Methods

- **Natural Healing**: Slow recovery when well-fed and rested
- **Bandages**: Treat injuries and stop bleeding
- **Medicine**: Treats specific illnesses (effectiveness varies by type)
- **Purification**: Removes corruption (requires special items)
- **Rest**: Accelerates all healing when sleeping
- **Food**: Different foods provide different healing benefits

---

## Illness System

Illnesses in Ashwake are contracted through various environmental factors and can progress if not treated properly.

### Illness Types

#### Respiratory Illnesses
- **Dust Lung**
  - **Cause**: Extended exposure to underground dust, especially in mines
  - **Symptoms**: Stamina reduction, occasional coughing (sound cue)
  - **Progression**: Mild → Moderate → Severe
  - **Treatment**: Clean air, special herbal tea, advanced breathing apparatus
  - **Gameplay Impact**: Mining speed reduction, louder player (attracts mobs)
  - **Prevention**: Masks, Helmets, Suits

- **Mist Sickness**
  - **Cause**: Exposure to Velmire mist without protection
  - **Symptoms**: Vision blurring, occasional weakness
  - **Progression**: Mild → Moderate → Severe (with hallucinations)
  - **Treatment**: Purification herbs, Lux essence potion
  - **Gameplay Impact**: Random blurred vision, occasional stamina drain
  - **Prevention**: Mask, Helmets, Suits

#### Digestion Illnesses
- **Food Poisoning**
  - **Cause**: Eating spoiled food or unclean water
  - **Symptoms**: Periodic stamina drain, hunger depletes faster
  - **Progression**: 1-2 day duration unless treated
  - **Treatment**: Clean water, charcoal tablets, rest
  - **Gameplay Impact**: Need to eat more frequently, occasional forced stopping

- **Parasites**
  - **Cause**: Eating raw meat, swimming in stagnant water
  - **Symptoms**: Constant minor hunger drain, occasional pain
  - **Progression**: Worsens over 3-5 days if untreated
  - **Treatment**: Special medical herbs, boiled preparation
  - **Gameplay Impact**: Food effectiveness reduced by 30%

#### Temperature-Related Conditions
- **Hypothermia**
  - **Cause**: Extended exposure to cold without protection
  - **Symptoms**: Shivering (visual effect), stamina reduction
  - **Progression**: Cold → Chilled → Hypothermic
  - **Treatment**: Fire, warm clothing, hot drinks
  - **Gameplay Impact**: Mining speed reduced, increased hunger, damage over time if severe

- **Heat Exhaustion**
  - **Cause**: Extended exposure to extreme heat
  - **Symptoms**: Vision effects, movement speed reduction
  - **Progression**: Hot → Overheated → Heat Stroke
  - **Treatment**: Cool water, shade, cooling herbs
  - **Gameplay Impact**: Vision wavers, increased thirst, damage over time if severe

#### Corruption-Related Illnesses
- **Velrot Touch**
  - **Cause**: Brief contact with corrupted materials
  - **Symptoms**: Black veins on screen edges, occasional whispers
  - **Progression**: Touch → Infection → Corruption
  - **Treatment**: Lux essence, purification ritual
  - **Gameplay Impact**: Minor hallucinations, attracts corrupted entities
  - **Prevention**: Gloves, Protection Devices

- **Mind Fog**
  - **Cause**: Exposure to memory-affecting corruption
  - **Symptoms**: UI elements occasionally disappear, map distortions
  - **Progression**: Confusion → Disorientation → Memory Loss
  - **Treatment**: Memory crystal focus, special Thalosian device
  - **Gameplay Impact**: Map randomly unavailable, crafting recipes temporarily forgotten

---

## Hidden Factors

The player's health is affected by several hidden factors that must be managed for optimal performance.

### Sleep

- **Sleep Debt**: Accumulates when player doesn't rest regularly
- **Sleep Quality**: Affected by bed type, safety of location, noise
- **Effects of Poor Sleep**:
  - Reduced stamina recovery
  - Slower healing
  - Increased susceptibility to illness
  - Visual effects (screen darkening at edges)
- **Tracking**: Yawning sounds and visual indicators when sleep is needed

### Nutrition

- **Nutrient Types**:
  - Proteins (meat, eggs, beans)
  - Carbohydrates (grains, fruits)
  - Vitamins (vegetables, fruits)
  - Fats (animal products, nuts)
- **Diet Balance**: Maintaining balanced diet improves:
  - Stamina recovery rate
  - Disease resistance
  - Carry capacity
  - Work speed
- **Tracking**: Food items show nutrient content, player status shows overall nutrition balance

### Mental State

- **Factors Affecting Mental State**:
  - Time spent underground
  - Exposure to corruption
  - Discovering new locations (positive)
  - Completing goals (positive)
  - Social interaction with NPCs (positive)
- **Effects of Poor Mental State**:
  - Increased susceptibility to corruption
  - Hallucinations
  - Reduced crafting efficiency
  - Slower research speed
- **Tracking**: Subtle visual and audio cues, dream content when sleeping

---

## Medicine and Treatment

### Medicinal Plants

| Plant | Location | Effect | Preparation |
|-------|----------|--------|-------------|
| Redleaf | Forest edges | Pain relief, minor healing | Tea, poultice |
| Bluecap Mushroom | Cave systems | Anti-corruption, mental clarity | Dried powder, tincture |
| Sunbloom | Open meadows | Fever reduction, anti-infection | Tea, salve |
| Dustweed | Rocky areas | Respiratory treatment | Smoked, tea |
| Marshroot | Wetlands | Digestive remedy, parasite treatment | Boiled extract |

### Crafting Medicines

#### Basic Herbal Remedies
- **Crafting Station**: Cooking pot or alchemy table
- **Required Tools**: Mortar and pestle, cutting knife
- **Process**: Combine herbs with base liquid (water, alcohol, oil)

#### Advanced Medicines
- **Crafting Station**: Alchemy station
- **Required Tools**: Distillation apparatus, precision scales
- **Process**: Multi-stage refinement of basic remedies

#### Thalosian Medical Technology
- **Crafting Station**: Thalosian synthesis chamber
- **Required Tools**: Energy manipulator, element harmonizer
- **Process**: Combine herbal essence with elemental energies and Thalosian compounds

---

## Medical Equipment

### Diagnostic Tools
- **Basic**: Observation of symptoms
- **Advanced**: Thermometer, stethoscope
- **Thalosian**: Aura scanner, corruption detector

### Treatment Tools
- **Basic**: Bandages, splints, herbal wraps
- **Advanced**: Surgical kit, sterilization equipment
- **Thalosian**: Cellular regenerator, corruption purifier

---

## Implementation Details

### Tracking System
- Hidden variables for each health factor
- Regular interval checks for environmental exposures
- Random chance system for illness contraction based on exposure and resistance
- Threshold-based progression system

### UI Elements
- Primary health bar with visual modifications based on state
- Secondary indicators for specific illnesses
- Subtle visual effects that increase with severity
- Journal entries describing symptoms and potential treatments

### Gameplay Impact
- Each illness affects specific gameplay mechanics rather than just dealing generic damage
- Multiple simultaneous conditions create compound effects
- Treatment methods require player engagement and resource management
- Knowledge of medicines becomes a valuable progression path

---

## Corrupted Amnesis Units

Corrupted Amnesis Units represent a unique threat that combines combat, corruption, and illness mechanics.

### Corruption Types
- **Physical Corruption**: Twisted metal, black growth, mechanical malfunction
- **Memory Corruption**: Distorted or malicious Thalosian memories
- **Energy Corruption**: Unstable energy patterns, harmful emissions

### Encounter Effects
- **Proximity Corruption**: Being near corrupted units slowly increases player corruption
- **Memory Disruption**: UI elements temporarily malfunction, map glitches
- **Energy Exposure**: Can cause unique radiation-like illness

### Combat Mechanics
- **Vulnerability**: Weak points exposed when using purification items
- **Corruption Bursts**: Area denial attacks that leave temporary corruption zones
- **Memory Fragments**: Defeating them releases both corrupted and pure memory fragments

### Purification Process
- **Containment**: Special tools to temporarily neutralize
- **Analysis**: Research station to identify corruption type
- **Treatment**: Specific purification method based on corruption type
- **Restoration**: Potential to restore to functioning Amnesis Unit (high-tier reward)

---

*This document should be updated as illness mechanics are implemented and balanced during development.* 