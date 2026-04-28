return {
	excluded = S{
		-- Non-player KIs
		347, -- Dynamis Debugger
		811, -- Replay Debugger
		619, -- All-You-Can-Ride Pass
		
		-- Unknown fishing flags
		1980, -- Spiffy Synth. (4)
		1981, -- Spiffy Synth. (5)
		1991, -- Spiffy Synth. (7)
		1999, -- Spiffy Synth. (7)
		2006, -- Spiffy Synth. (6)
		2007, -- Spiffy Synth. (7)
		2015, -- Spiffy Synth. (7)
		2022, -- Spiffy Synth. (6)
		2023, -- Spiffy Synth. (7)
		2030, -- Spiffy Synth. (6)
		2031, -- Spiffy Synth. (7)
		2047, -- Spiffy Synth. (7)
		
		-- Magical Maps
		1866, -- map of Leujaoam Sanctum
		1867, -- map of the Training Grounds
		1868, -- map of Lebros Cavern
		1869, -- map of Ilrusi Atoll
		1870, -- map of Periqia
		1871, -- map of Nyzul Isle
		1873, --map of the Colosseum
		
		1875, -- map of Zhayolm Remnants
		1876, -- map of Arrapago Remnants
		1877, -- map of Bhaflau Remnants
		1878, -- map of Silver Sea Remnants
		
		1880, -- map of Everbloom Hollow
		1882, -- map of Ruhotz Silvermines
		1884, -- map of Ghoyu's Reverie
		
		2302, -- map of Rala Waterways [U]
		2303, -- map of Yorcia Weald [U]
		2304, -- map of Cirdas Caverns [U]
		2305, -- map of Outer Ra'Kaznar [U]
		
		-- Active Effects
		-- Mog Enhancements
		512, -- Moghancement: Fire
		513, -- Moghancement: Ice
		514, -- Moghancement: Wind
		515, -- Moghancement: Earth
		516, -- Moghancement: Lightning
		517, -- Moghancement: Water
		518, -- Moghancement: Light
		519, -- Moghancement: Dark
		520, -- Moghancement: Experience
		521, -- Moghancement: Gardening
		522, -- Moghancement: Desynthesis
		523, -- Moghancement: Fishing
		524, -- Moghancement: Woodworking
		525, -- Moghancement: Smithing
		526, -- Moghancement: Goldsmithing
		527, -- Moghancement: Clothcraft
		528, -- Moghancement: Leathercraft
		529, -- Moghancement: Bonecraft
		530, -- Moghancement: Alchemy
		531, -- Moghancement: Cooking
		532, -- Moghancement: Conquest
		533, -- Moghancement: Region
		534, -- Moghancement: Fishing
		535, -- Moghancement: San. Conquest
		536, -- Moghancement: Bas. Conquest
		537, -- Moghancement: Win. Conquest
		538, -- Moghancement: Money
		539, -- Moghancement: Campaign
		540, -- Moghancement: Money II
		541, -- Moghancement: Skill Gains
		542, -- Moghancement: Bounty
		543, -- Moghancement: Mandragora Mania
		544, -- Moglification: Fishing
		545, -- Moglification: Woodworking
		546, -- Moglification: Smithing
		547, -- Moglification: Goldsmithing
		548, -- Moglification: Clothcraft
		549, -- Moglification: Leathercraft
		550, -- Moglification: Bonecraft
		551, -- Moglification: Alchemy
		552, -- Moglification: Cooking
		553, -- Mega Moglification: Fishing
		554, -- Mega Moglification: Woodwork.
		555, -- Mega Moglification: Smithing
		556, -- Mega Moglification: Goldsmith.
		557, -- Mega Moglification: Clothcraft
		558, -- Mega Moglification: Leathrcrft.
		559, -- Mega Moglification: Bonecraft
		560, -- Mega Moglification: Alchemy
		561, -- Mega Moglification: Cooking
		562, -- Moglification: Experience Boost
		563, -- Moglification: Capacity Boost
		564, -- Moglification: Synergy Skill Gains
		565, -- Moglification: Furnace Duration
		566, -- Moglification: Resist Death
		567, -- Moglification: A.M.A.N. Trove

		2848, -- Moglification: Resist Sleep
		2849, -- Moglification: Resist Poison
		2850, -- Moglification: Resist Paralysis
		2852, -- Moglification: Resist Silence
		2853, -- Moglification: Resist Petrification
		2854, -- Moglification: Resist Virus
		2855, -- Moglification: Resist Curse

		-- Cheers
		2716, -- Cheer: Lamb
		2717, -- Cheer: Sheep
		2718, -- Cheer: Karakul
		2719, -- Cheer: Ram
		2720, -- Cheer: Sapling
		2721, -- Cheer: G. Fol. Treant
		2722, -- Cheer: R. Fol. Treant
		2723, -- Cheer: Baby Rabbit
		2724, -- Cheer: Rabbit
		2725, -- Cheer: White Rabbit
		2726, -- Cheer: Baby Lizard
		2727, -- Cheer: Lizard
		2728, -- Cheer: Alabaster Lizard
		2729, -- Cheer: Baby Cockatrice
		2730, -- Cheer: Cockatrice
		2731, -- Cheer: Ziz
		2732, -- Cheer: Baby Raptor
		2733, -- Cheer: Raptor
		2734, -- Cheer: Red Raptor
		2735, -- Cheer: Baby Eft
		2736, -- Cheer: Eft
		2737, -- Cheer: Tarichuk
		2738, -- Cheer: Dhalmel Calf
		2739, -- Cheer: Dhalmel
		2740, -- Cheer: Great Dhalmel
		2741, -- Cheer: Sea Monk Larva
		2742, -- Cheer: Sea Monk
		2743, -- Cheer: Blue Sea Monk
		2744, -- Cheer: Uragnite Youngling
		2745, -- Cheer: Uragnite
		2746, -- Cheer: Limascabra
		2747, -- Cheer: Immature Crab
		2748, -- Cheer: Crab
		2749, -- Cheer: Porter Crab
		2750, -- Cheer: Baby Colibri
		2751, -- Cheer: Colibri
		2752, -- Cheer: Toucalibri
		2753, -- Cheer: Coeurl Cub
		2754, -- Cheer: Coeurl
		2755, -- Cheer: Lynx
		2756, -- Cheer: Buffalo Calf
		2757, -- Cheer: Buffalo
		2758, -- Cheer: Mini Slime
		2759, -- Cheer: Slime
		2760, -- Cheer: Clot
		2761, -- Cheer: Hecteyes
		2762, -- Cheer: Tiny Bugard
		2763, -- Cheer: Bugard
		2764, -- Cheer: Abyssobugard
		2765, -- Cheer: Baby Adamantoise
		2766, -- Cheer: Adamantoise
		2767, -- Cheer: Great Adamantoise
		2768, -- Cheer: White Adamantoise
		2769, -- Cheer: Ferromantoise
		2770, -- Cheer: Great Ferromantoise
		2771, -- Cheer: Cluster
		2772, -- Cheer: Bomb
		2773, -- Cheer: Djinn
		2774, -- Cheer: Snoll
		2775, -- Cheer: Behemoth Cub
		2776, -- Cheer: Behemoth
		2777, -- Cheer: King Behemoth
		2778, -- Cheer: Elasmoth
		2779, -- Cheer: Skormoth
		2780, -- Cheer: Dragon Hatchling
		2781, -- Cheer: Wyvern
		2782, -- Cheer: Blue Wyvern
		2783, -- Cheer: Green Wyvern
		2784, -- Cheer: Abyssal Wyrm
		2785, -- Cheer: Lunar Wyrm
		2786, -- Cheer: Blazing Wyrm
		2787, -- Cheer: Pequetender
		2788, -- Cheer: Sabotender
		2789, -- Cheer: Jumbotender

		3202, -- Cheer: Mandragora Sproutling
		3203, -- Cheer: Mandragora
		3204, -- Cheer: Elder Mandragora
		3205, -- Cheer: Lycopodium
		3206, -- Cheer: Ake-Ome
		3207, -- Cheer: Adenium
		3208, -- Cheer: Elder Adenium
		3209, -- Cheer: Korrigan
		3210, -- Cheer: Pachypodium
		3211, -- Cheer: Citrullus
		
		-- Voidwatch
		366, -- crimson stratum abyssite
		367, -- crimson stratum abyssite II
		368, -- crimson stratum abyssite III
		369, -- crimson stratum abyssite IV
		370, -- indigo stratum abyssite
		371, -- indigo stratum abyssite II
		372, -- indigo stratum abyssite III
		373, -- indigo stratum abyssite IV
		374, -- jade stratum abyssite
		375, -- jade stratum abyssite II
		376, -- jade stratum abyssite III
		377, -- jade stratum abyssite IV
		
		1444, -- white stratum abyssite
		1445, -- white stratum abyssite II
		1446, -- white stratum abyssite III
		1447, -- ashen stratum abyssite
		1448, -- ashen stratum abyssite II
		1449, -- ashen stratum abyssite III
		1450, -- white stratum abyssite IV
		1451, -- white stratum abyssite V
		1452, -- white stratum abyssite VI
		
		1539, -- voidstone
		1540, -- voidstone
		1541, -- voidstone
		1542, -- voidstone
		1543, -- voidstone
		1544, -- voidstone
		
		1556, -- beguiling petrifact
		1557, -- seductive petrifact
		1558, -- maddening petrifact
		
		1805, -- void cluster
		
		2048, -- Voidwatch alarum
		
		2060, -- hyacinth stratum abyssite
		2062, -- amber stratum abyssite
		
		2065, -- Kupofried's corundum
		2066, -- Kupofried's corundum
		2067, -- Kupofried's corundum
	},
	hidden = S{
		-- old events no longer playable
		3136, -- sheet of Shadow Lord tunes
		3181, -- tentacle touching ticket
		-- Crafting Shields
		1982, -- alchemist's argentum tome
		1983, -- alchemist's aurum tome
		1989, -- carpenter's argentum tome
		1990, -- carpenter's aurum tome
		1997, -- blacksmith's argentum tome
		1998, -- blacksmith's aurum tome
		2004, -- goldsmith's argentum tome
		2005, -- goldsmith's aurum tome
		2013, -- weaver's argentum tome
		2014, -- weaver's aurum tome
		2020, -- tanner's argentum tome
		2021, -- tanner's aurum tome
		2028, -- boneworker's argentum tome
		2029, -- boneworker's aurum tome
		2045, -- culinarian's argentum tome
		2046, -- culinarian's aurum tome
	},
}