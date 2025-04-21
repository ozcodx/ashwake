# Ashwake Resource System

This document details the resource gathering, processing, and management systems in Ashwake, including tool mechanics, resource types, processing methods, and storage solutions.

---

## Resource Gathering

### Tool Mechanics

Tools in Ashwake have specific properties that affect resource gathering:

#### Tool Properties

| Property | Description | Gameplay Impact |
|----------|-------------|----------------|
| Durability | How many uses before breaking | Tools need repair/replacement |
| Efficiency | Speed of resource gathering | Faster gathering with better tools |
| Harvest Level | Ability to gather certain resources | Some materials require higher tier tools |
| Special Abilities | Unique tool properties | Unlocks special gathering methods |

#### Tool Degradation

- Tools lose durability with each use
- Degradation visual indicators show on the tool icon


#### Tool Repair

- Simple tools: Repair at crafting bench with basic materials
- Complex tools: Require specialized repair stations
- Repair cost increases with tool complexity and technology tier
- Some high-tier tools require special components to repair

### Resource Types

#### Geological Resources

| Resource | Gathering Method | Tool Required | Found In | Special Properties |
|----------|------------------|--------------|----------|-------------------|
| Stone | Mining | Pick | Surface, caves | Varies by region |
| Copper Ore | Mining | Stone pick or better | Underground | Visible oxide streaks |
| Iron Ore | Mining | Copper pick or better | Deep underground | Magnetic properties |
| Coal | Mining | Stone pick or better | Underground veins | Can be burned directly |
| Clay | Digging | Shovel | Riverbeds, lakes | Needs processing |
| Sand | Digging | Shovel | Beaches, deserts | Various colors by region |
| Crystal | Mining | Metal pick | Deep caves | Emits faint light |
| Thalosium | Mining | Steel pick or better | Ancient ruins, deep caves | Glows, strange properties |

#### Biological Resources

| Resource | Gathering Method | Tool Required | Found In | Special Properties |
|----------|------------------|--------------|----------|-------------------|
| Wood | Chopping | Axe | Forests | Varies by tree type |
| Fiber | Collecting | Knife | Plains, forests | Used for basic crafting |
| Herbs | Harvesting | Knife/Bare hands | Various biomes | Medicinal properties |
| Animal Hide | Hunting | Knife | From animals | Needs processing |
| Meat | Hunting | Knife | From animals | Spoils over time |
| Feathers | Hunting | Knife | From birds | Light, delicate |
| Bones | Hunting | - | From animals | Structural material |
| Mushrooms | Collecting | Bare hands | Caves, forests | Some are toxic |

#### Memory Fragments

| Type | Gathering Method | Tool Required | Found In | Special Properties |
|------|------------------|--------------|----------|-------------------|
| Minor Fragment | Collecting | Memory Resonator | Ancient devices, ruins | Basic knowledge |
| Coherent Fragment | Excavating | Advanced Resonator | Thalosian ruins | Specific knowledge |
| Corrupted Fragment | Purification | Purifier | Corrupted areas | Needs cleaning |
| Pristine Core | Special excavation | Thalosian tools | Hidden vaults | Complete memory |

### Gathering Mechanics

#### Mining
- Different tools for optimal resource extraction
- Varying hardness requiring different tool types
- Visual cracks showing progress
- Chance for bonus materials based on tool quality

#### Harvesting
- Growth stages affecting yield quantity and quality
- Regrowth mechanics for sustainable collection
- Specialized tools improving yield

#### Hunting
- Animal behaviors affecting hunting strategies
- Tool efficiency affecting meat and hide quality
- Tracking mechanics for finding prey
- Preservation needs for gathered materials

---

## Implementation Notes

### Resource Distribution
- Region-specific resources encouraging exploration
- Depth-based rarity for mining
- Seasonal availability for biological resources
- Hidden resource nodes requiring special detection

### Balance Considerations
- Resource scarcity driving player choices
- Processing time vs. reward balance
- Tool progression gating certain resources
- Resource respawn rates tuned to gameplay pace

### Player Progression
- Knowledge discovery unlocking efficient gathering
- Skill development reducing resource waste
- Tool upgrades improving yield quality and quantity
- Station upgrades enabling new processing methods

---

*This document should be updated as resource systems are implemented and balanced during development.* 