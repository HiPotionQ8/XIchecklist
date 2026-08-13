_addon.name     = 'xichecklist'
_addon.author   = 'HiPotion'
_addon.version  = '0.20.0'
_addon.commands = {'xichecklist', 'xic', 'checklist', 'clist'}

require('sets')
packets = require('packets')
local config = require('config')
res = require('resources')
require('chat')

-- Defaults
trackermenusettings = {}
trackermenusettings.ui_scale = 1
trackermenusettings.pos = {}
trackermenusettings.pos.x = 50
trackermenusettings.pos.y = 80
trackermenusettings.visibility = true
trackermenusettings.showcompleted = false -- true = display completed items listed in green
trackermenusettings.showexcluded = false -- true = display hidden RoEs and excluded Titles and Crafting shield KIs

trackermenusettings = config.load(trackermenusettings)

defaultplayertracker = {
	-- most initial values are zero, to be updated by addon
	mastery_rank = 0,
	playtime = 0,
	-- Missions
	bastokmissions_completed = 0,
	bastokmissions_total = 0,
	sandoriamissions_completed = 0,
	sandoriamissions_total = 0,
	windurstmissions_completed = 0,
	windurstmissions_total = 0,
	zilartmissions_completed = 0,
	zilartmissions_total = 0,
	copmissions_completed = 0,
	copmissions_total = 0,
	ahturhganmissions_completed = 0,
	ahturhganmissions_total = 0,
	wotgmissions_completed = 0,
	wotgmissions_total = 0,
	acpmissions_completed = 0,
	acpmissions_total = 0,
	mkdmissions_completed = 0,
	mkdmissions_total = 0,
	asamissions_completed = 0,
	asamissions_total = 0,
	soamissions_completed = 0,
	soamissions_total = 0,
	rovmissions_completed = 0,
	rovmissions_total = 0,
	tvrmissions_completed = 0,
	tvrmissions_total = 0,
	-- Quests
	bastok_completed = 0,
	bastok_total = 0,
	sandoria_completed = 0,
	sandoria_total = 0,
	windurst_completed = 0,
	windurst_total = 0,
	jeuno_completed = 0,
	jeuno_total = 0,
	ahturhgan_completed = 0,
	ahturhgan_total = 0,
	assaults_completed = 0,
	assaults_total = 0,
	crystalwar_completed = 0,
	crystalwar_total = 0,
	outlands_completed = 0,
	outlands_total = 0,
	other_completed = 0,
	other_total = 0,
	abyssea_completed = 0,
	abyssea_total = 0,
	adoulin_completed = 0,
	adoulin_total = 0,
	coalition_completed = 0,
	coalition_total = 0,
	campaign_completed = 0,
	campaign_total = 0,
	-- Key items
	Permanent_Key_Items_completed = 0,
	Permanent_Key_Items_total = 0,
	Magical_Maps_completed = 0,
	Magical_Maps_total = 0,
	Mounts_completed = 0,
	Mounts_total = 0,
	Claim_Slips_completed = 0,
	Claim_Slips_total = 0,
	Active_Effects_completed = 0,
	Active_Effects_total = 0,
	Abyssea_completed = 0,
	Abyssea_total = 0,
	Voidwatch_completed = 0,
	Voidwatch_total = 0,
	Mog_Garden_completed = 0,
	Mog_Garden_total = 0,
	-- Magic / Corsair Roll / PUP attachments
	WhiteMagic_completed = 0,
	WhiteMagic_total = 0,
	BlackMagic_completed = 0,
	BlackMagic_total = 0,
	SummonerPact_completed = 0,
	SummonerPact_total = 0,
	Ninjutsu_completed = 0,
	Ninjutsu_total = 0,
	BardSong_completed = 0,
	BardSong_total = 0,
	BlueMagic_completed = 0,
	BlueMagic_total = 0,
	Geomancy_completed = 0,
	Geomancy_total = 0,
	Trust_completed = 0,
	Trust_total = 0,
	CorsairRoll_completed = 0,
	CorsairRoll_total = 31,
	pupattachments_completed = 0,
	pupattachments_total = 127,
	-- Exp
	meritpoints_completed = 0,
	meritpoints_total = 919,
	jobpoints_completed = 0,
	jobpoints_total = 22,
	masterlevels_completed = 0,
	masterlevels_total = 1100,
	masterlevels_highest = 0,
	-- Skills
	craftingskills_completed = 0,
	craftingskills_total = 790,
	-- Alter Ego
	alteregopoint_completed = 0,
	alteregopoint_total = 550,
	-- Warps
	zones_completed = 0,
	zones_total = 0,
	homepoints_completed = 0,
	homepoints_total = 0,
	survivalguides_completed = 0,
	survivalguides_total = 0,
	waypoints_completed = 0,
	waypoints_total = 0,
	telepoints_completed = 0,
	telepoints_total = 0,
	cavernousmaws_completed = 0,
	cavernousmaws_total = 9,
	lycopodium_completed = 0,
	lycopodium_total = 3,
	eschanportals_completed = 0,
	eschanportals_total = 0,
	-- unknown warp/map-related
	unknownwarps_unlocked = 0, -- not using _completed or _total, to avoid being calculated in total checklist progress
	unknownwarps_unlockable = 0,
	-- Monstrosity
	racejobinstinct_completed = 0,
	racejobinstinct_total = 0,
	monsterlevels_completed = 0,
	monsterlevels_total = 0,
	monstervariants_completed = 0,
	monstervariants_total = 0,
	monsterinsincts_completed = 0,
	monsterinsincts_total = 0,
	-- RoE
	roe_completed = 0,
	roe_total = 0,
	-- MMM
	mmmvouchers_completed = 0,
	mmmvouchers_total = 0,
	mmmrunes_completed = 0,
	mmmrunes_total = 0,
	-- NPC Menus
	mmm_mazecount = 0,
	wingskill_completed = 0,
	wingskill_total = 100,
	Titles_completed = 0,
	Titles_total = 0,
	outposts_completed = 0,
	outposts_total = 0,
	protowaypoints_completed = 0,
	protowaypoints_total = 0,
	fishes_completed = 0,
	fishes_total = 164,
	meebleburrows_completed = 0,
	meebleburrows_total = 0,
	atmacite_completed = 0,
	atmacite_total = 600,
	sheola_completed = 0,
	sheola_total = 0,
	sheolb_completed = 0,
	sheolb_total = 0,
	sheolc_completed = 0,
	sheolc_total = 0,
	sheolgaoltiers_completed = 0,
	sheolgaoltiers_total = 425,
	vorseals_completed = 0,
	vorseals_total = 0,
	ergonlocus_completed = 0,
	ergonlocus_total = 30,
	emporox_completed = 0,
	emporox_total = 0,
	titles = {}, -- {TitleId = true}
	outposts_unlocks = {}, -- {Menu Parameter Byte = true}
	protowaypoints_unlocks = {}, -- {Menu Parameter Byte = true}
	fishes_caught = {}, -- {Fish_ItemId = true}
	meeble_completed = {
		Sauromugue_Champaign = {},
		Batallia_Downs = {},
	},
	atmacite_levels = {},
	sheolabc = { --['Option Index'] = {[menu byte index] = value,},
		['2'] = {},
		['4'] = {},
		['5'] = {},
		['7'] = {},
	},
	sheolgaol = { --['Option Index'] = {[menu byte index] = true,},
		['8'] = {},
		['9'] = {},
		['10'] = {},
	},
	vorseals = {}, -- {Menu Parameter nibble = value}
	ergonlocus = {},
	emporox_unlocks = {}, -- {Menu Parameter Byte = true}
	abysseaconflux_completed = 0,
	abysseaconflux_total = 75,
	abysseaconflux_unlocks = { -- [zone id] = {menu bit index}
		["15"] = {}, -- Abyssea - Konschtat
		["45"] = {}, -- Abyssea - Tahrongi
		["132"] = {}, -- Abyssea - La Theine
		["215"] = {}, -- Abyssea - Attohwa
		["216"] = {}, -- Abyssea - Misareaux
		["217"] = {}, -- Abyssea - Vunkerl
		["218"] = {}, -- Abyssea - Altepa
		["253"] = {}, -- Abyssea - Uleguerand
		["254"] = {}, -- Abyssea - Grauberg
	},
	--
	corsairrolls = {},
	pupattachments = {
		['Available_Heads'] = {},
		['Available_Bodies'] = {},
		['Fire_Attachments'] = {},
		['Ice_Attachments'] = {},
		['Wind_Attachments'] = {},
		['Earth_Attachments'] = {},
		['Thunder_Attachments'] = {},
		['Water_Attachments'] = {},
		['Light_Attachments'] = {},
		['Dark_Attachments'] = {},
	},
	talk_to_npc = {
		outpostnpc = false,
		chatnachoq = false,
		protowaypoint = false,
		meeble_sauromugue = false,
		meeble_batallia = false,
		katsunaga = false,
		atmacite_refiner = false,
		chocobokid = false,
		['Aligi-Kufongi'] = false,
		['Koyol-Futenol'] = false,
		['Tamba-Namba'] = false,
		['Bhio_Fehriata'] = false,
		['Cattah_Pamjah'] = false,
		['Moozo-Koozo'] = false,
		['Styi_Palneh'] = false,
		['Burute-Sorute'] = false,
		['Tuh_Almobankha'] = false,
		['Zuah_Lepahnyu'] = false,
		['Shupah_Mujuuk'] = false,
		['Yulon-Polon'] = false,
		['Willah_Maratahya'] = false,
		['Eron-Tomaron'] = false,
		['Quntsu-Nointsu'] = false,
		['Debadle-Levadle'] = false,
		sheola = false,
		sheolb = false,
		sheolc = false,
		sheolgaol = false,
		vorseals = false,
		ergonlocus = false,
		emporox = false,
		['veridicalconflux_15'] = false,
		['veridicalconflux_45'] = false,
		['veridicalconflux_132'] = false,
		['veridicalconflux_215'] = false,
		['veridicalconflux_216'] = false,
		['veridicalconflux_217'] = false,
		['veridicalconflux_218'] = false,
		['veridicalconflux_253'] = false,
		['veridicalconflux_254'] = false,
	},
}

defaulttab_logs = {
	sandoriamissions = {name = 'San d\'Oria Missions', completed = 0, total = 0, items = {}},
	bastokmissions = {name = 'Bastok Missions', completed = 0, total = 0, items = {}},
	windurstmissions = {name = 'Windurst Missions', completed = 0, total = 0, items = {}},
	zilartmissions = {name = 'RotZ Missions', completed = 0, total = 0, items = {}},
	copmissions = {name = 'CoP Missions', completed = 0, total = 0, items = {}},
	assaults = {name = 'Assault Missions', completed = 0, total = 0, items = {}},
	ahturhganmissions = {name = 'ToAU Missions', completed = 0, total = 0, items = {}},
	campaign = {name = 'Campaign Ops', completed = 0, total = 0, items = {}},
	wotgmissions = {name = 'WotG Missions', completed = 0, total = 0, items = {}},
	acpmissions = {name = 'ACP  Missions', completed = 0, total = 0, items = {}},
	mkdmissions = {name = 'MKD  Missions', completed = 0, total = 0, items = {}},
	asamissions = {name = 'ASA  Missions', completed = 0, total = 0, items = {}},
	soamissions = {name = 'SoA  Missions', completed = 0, total = 0, items = {}},
	rovmissions = {name = 'RoV  Missions', completed = 0, total = 0, items = {}},
	tvrmissions = {name = 'TVR  Missions', completed = 0, total = 0, items = {}},
	sandoria = {name = 'San d\'Oria Quests', completed = 0, total = 0, items = {}},
	bastok = {name = 'Bastok Quests', completed = 0, total = 0, items = {}},
	windurst = {name = 'Windurst Quests', completed = 0, total = 0, items = {}},
	jeuno = {name = 'Jeuno Quests', completed = 0, total = 0, items = {}},
	ahturhgan = {name = 'Aht Urhgan Quests', completed = 0, total = 0, items = {}},
	crystalwar = {name = 'Crystal War Quests', completed = 0, total = 0, items = {}},
	outlands = {name = 'Outlands Quests', completed = 0, total = 0, items = {}},
	other = {name = 'Other Quests', completed = 0, total = 0, items = {}},
	abyssea = {name = 'Abyssea Quests', completed = 0, total = 0, items = {}},
	adoulin = {name = 'Adoulin Quests', completed = 0, total = 0, items = {}},
	coalition = {name = 'Coalition Assignments', completed = 0, total = 0, items = {}},
	atmacite = {name = 'Atmacite Levels', completed = 0, total = 600, items = {}},
	zones = {name = 'Zones Visited', completed = 0, total = 0, items = {}},
	homepoints = {name = 'Home Points', completed = 0, total = 0, items = {}},
	survivalguides = {name = 'Survival Guides', completed = 0, total = 0, items = {}},
	waypoints = {name = 'Adoulin Waypoint', completed = 0, total = 0, items = {}},
	telepoints = {name = 'Telepoints', completed = 0, total = 0, items = {}},
	cavernousmaws = {name = 'Cavernous Maws', completed = 0, total = 0, items = {}},
	unknownwarps = {name = 'Unknown Warps/Map-related', completed = 0, total = 0, items = {}},
	lycopodium = {name = 'Lycopodium', completed = 0, total = 0, items = {}},
	eschanportals = {name = 'Eschan Portals', completed = 0, total = 0, items = {}},
	outposts = {name = 'Outpost Warps', completed = 0, total = 0, items = {}},
	protowaypoints = {name = 'Proto-Waypoints', completed = 0, total = 0, items = {}},
	titles = {name = 'Titles', completed = 0, total = 0, items = {}},
	titles_by_content = {name = 'Titles by content (Sum)', completed = 0, total = 0, items = {}},
	titles_by_content_detailed = {name = 'Titles by content', completed = 0, total = 0, items = {}},
	fishes = {name = 'Types of Fishes Caught', completed = 0, total = 164, items = {}},
	monsterlevels = {name = 'Species Levels', completed = 0, total = 0, items = {}},
	monstervariants = {name = 'Monster Variants', completed = 0, total = 0, items = {}},
	racejobinstincts = {name = 'Race / Job Instincts', completed = 0, total = 0, items = {}},
	monsterinstincts = {name = 'Monster Instincts', completed = 0, total = 0, items = {}},
	roe = {name = 'RoE', completed = 0, total = 0, items = {}},
	mmm_mazecount = {name = 'MMM Maze count', completed = 0, total = 1000, items = {}},
	mmmvouchers = {name = 'MMM Vouchers Unlocked', completed = 0, total = 0, items = {}},
	mmmrunes = {name = 'MMM Runes Unlocked', completed = 0, total = 0, items = {}},
	meebleburrows = {name = 'Meeble Burrows', completed = 0, total = 0, items = {}},
	sheola = {name = 'Sheol A', completed = 0, total = 0, items = {}},
	sheolb = {name = 'Sheol B', completed = 0, total = 0, items = {}},
	sheolc = {name = 'Sheol C', completed = 0, total = 0, items = {}},
	sheolgaol = {name = 'Sheol Gaol Vengeance', completed = 0, total = 425, items = {}},
	vorseals = {name = 'Eschan Vorseals', completed = 0, total = 0, items = {}},
	ergonlocus = {name = 'Ergon Locus', completed = 0, total = 0, items = {}},
	emporox = {name = 'Emporox Goodness', completed = 0, total = 0, items = {}},
	WhiteMagic = {name = 'White Magic', completed = 0, total = 0, items = {}},
	BlackMagic = {name = 'Black Magic', completed = 0, total = 0, items = {}},
	SummonerPact = {name = 'Summoner Pacts', completed = 0, total = 0, items = {}},
	Ninjutsu = {name = 'Ninjutsu', completed = 0, total = 0, items = {}},
	BardSong = {name = 'Bard Songs', completed = 0, total = 0, items = {}},
	BlueMagic = {name = 'Blue Magic', completed = 0, total = 0, items = {}},
	Geomancy = {name = 'Geomancy', completed = 0, total = 0, items = {}},
	Trust = {name = 'Trust Magic', completed = 0, total = 0, items = {}},
	CorsairRoll = {name = 'Corsair Rolls', completed = 0, total = 31, items = {}},
	pupattachments = {name = 'PUP Attachments', completed = 0, total = 127, items = {}},
	Permanent_Key_Items = {name = 'Permanent Key Items', completed = 0, total = 0, items = {}},
	Magical_Maps = {name = 'Magical Maps', completed = 0, total = 0, items = {}},
	Mounts = {name = 'Mounts', completed = 0, total = 0, items = {}},
	Active_Effects = {name = 'Active Effects', completed = 0, total = 0, items = {}},
	Voidwatch = {name = 'Voidwatch', completed = 0, total = 0, items = {}},
	Abyssea = {name = 'Abyssea', completed = 0, total = 0, items = {}},
	Mog_Garden = {name = 'Mog Garden', completed = 0, total = 0, items = {}},
	Claim_Slips = {name = 'Claim Slips', completed = 0, total = 0, items = {}},
	jobpoints = {name = 'Job Points', completed = 0, total = 46200, items = {}},
	masterlevels = {name = 'Master Levels', completed = 0, total = 1100, items = {}},
	abysseaconflux = {name = 'Abyssea Conflux', completed = 0, total = 75, items = {}},
	--combatskills = {name = 'Combat Skills', completed = 0, total = 0, items = {}},
}

addonhelptext = {
	titles = {
		{'You must talk to \\cs(255,255,255)Aligi-Kufongi\\cr @ \\cs(50,150,255)Tavnazian Safehold (H-9)\\cr', 'Aligi-Kufongi'},
		{'You must talk to \\cs(255,255,255)Koyol-Futenol\\cr @ \\cs(50,150,255)Aht Urhgan Whitegate (E-9)\\cr', 'Koyol-Futenol'},
		{'You must talk to \\cs(255,255,255)Tamba-Namba\\cr @ \\cs(50,150,255)Southern San d\'Oria (S) (L-8)\\cr', 'Tamba-Namba'},
		{'You must talk to \\cs(255,255,255)Bhio Fehriata\\cr @ \\cs(50,150,255)Bastok Markets (S) (I-10)\\cr', 'Bhio_Fehriata'},
		{'You must talk to \\cs(255,255,255)Cattah Pamjah\\cr @ \\cs(50,150,255)Windurst Waters (S) (G-10)\\cr', 'Cattah_Pamjah'},
		{'You must talk to \\cs(255,255,255)Moozo-Koozo\\cr @ \\cs(50,150,255)Southern San d\'Oria (K-6)\\cr', 'Moozo-Koozo'},
		{'You must talk to \\cs(255,255,255)Styi Palneh\\cr @ \\cs(50,150,255)Port Bastok (I-7)\\cr', 'Styi_Palneh'},
		{'You must talk to \\cs(255,255,255)Burute-Sorute\\cr @ \\cs(50,150,255)Windurst Walls (H-10)\\cr', 'Burute-Sorute'},
		{'You must talk to \\cs(255,255,255)Tuh Almobankha\\cr @ \\cs(50,150,255)Lower Jeuno (I-8)\\cr', 'Tuh_Almobankha'},
		{'You must talk to \\cs(255,255,255)Zuah Lepahnyu\\cr @ \\cs(50,150,255)Port Jeuno (J-8)\\cr', 'Zuah_Lepahnyu'},
		{'You must talk to \\cs(255,255,255)Shupah Mujuuk\\cr @ \\cs(50,150,255)Rabao (G-8)\\cr', 'Shupah_Mujuuk'},
		{'You must talk to \\cs(255,255,255)Yulon-Polon\\cr @ \\cs(50,150,255)Selbina (I-9)\\cr', 'Yulon-Polon'},
		{'You must talk to \\cs(255,255,255)Willah Maratahya\\cr @ \\cs(50,150,255)Mhaura (I-8)\\cr', 'Willah_Maratahya'},
		{'You must talk to \\cs(255,255,255)Eron-Tomaron\\cr @ \\cs(50,150,255)Kazham (G-7)\\cr', 'Eron-Tomaron'},
		{'You must talk to \\cs(255,255,255)Quntsu-Nointsu\\cr @ \\cs(50,150,255)Norg (G-7)\\cr', 'Quntsu-Nointsu'},
		{'You must talk to \\cs(255,255,255)Debadle-Levadle\\cr @ \\cs(50,150,255)Western Adoulin (H-8)\\cr', 'Debadle-Levadle'},
	},
	meebleburrows = {
		{'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', 'meeble_sauromugue'},
		{'Menu: Review expedition specifics -> \\cs(255,255,255)Sauromugue Champaign\\cr', 'meeble_sauromugue'},
		{'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', 'meeble_batallia'},
		{'Menu: Review expedition specifics -> \\cs(255,255,255)Batallia Downs\\cr', 'meeble_batallia'},
	},
	sheola = {
		{'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', 'sheola'},
	},
	sheolb = {
		{'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', 'sheolb'},
	},
	sheolc = {
		{'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', 'sheolc'},
	},
	sheolgaol = {
		{'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Sheol Gaol)', 'sheolgaol'},
	},
	vorseals = {
		{'You must talk to \\cs(255,255,255)Shiftrix\\cr @ \\cs(50,150,255)Reisenjima (F-12)\\cr', 'vorseals'},
	},
	outposts = {
		{'You must talk to any \\cs(255,255,255)Outpost Teleporter NPC\\cr @ \\cs(50,150,255)three nations\\cr.', 'outpostnpc'},
	},
	protowaypoints = {
		{'You must talk to any \\cs(255,255,255)Proto-Waypoint\\cr.', 'protowaypoint'},
	},
	fishes = {
		{'You must talk to \\cs(255,255,255)Katsunaga\\cr @ \\cs(50,150,255)Mhuaura (H-9)\\cr \\cs(255,255,255)(Menu: Types of fishes caught)\\cr', 'katsunaga'},
	},
	atmacite = {
		{'You must talk to any \\cs(255,255,255)Atmacite Refiner\\cr \\cs(50,150,255)(Menu: Enrich Atmas)\\cr', 'atmacite_refiner'},
	},
	ergonlocus = {
		{'You must talk to \\cs(255,255,255)Rienne\\cr @ \\cs(50,150,255)Western Adoulin (J-9)\\cr', 'ergonlocus'},
	},
	emporox = {
		{'You must talk to \\cs(255,255,255)Emporox\\cr @ \\cs(50,150,255)Reisenjima #8\\cr', 'emporox'},
	},
	abysseaconflux = {
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Konschtat\\cr', 'veridicalconflux_15'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Tahrongi\\cr', 'veridicalconflux_45'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - La Theine\\cr', 'veridicalconflux_132'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Attohwa\\cr', 'veridicalconflux_215'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Misareaux\\cr', 'veridicalconflux_216'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Vunkerl\\cr', 'veridicalconflux_217'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Altepa\\cr', 'veridicalconflux_218'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Uleguerand\\cr', 'veridicalconflux_253'},
		{'You must talk to \\cs(255,255,255)Veridical Conflux #01\\cr @ \\cs(50,150,255)Abyssea - Grauberg\\cr', 'veridicalconflux_254'},
	},
}

require('util/ui')
util = require('util/util')
quest_util = require('util/quests')
warps_util = require('util/warps')
mons_util = require('util/monstrosity')
roe_util = require('util/roe')
mmm_util = require('util/mmm')
menus_util = require('util/menus')

local cmds = {
	help = S{'help','h'},
	hide = S{'hide'},
	show = S{'show'},
	copy = S{'copy'},
	log = S{'log'},
	showcompleted = S{'showcompleted'},
	showexcluded = S{'showexcluded'},
	scale = S{'scale'},
}

addon_setup = function()
	-- setup value instead of recalling/filtering them everytime
	local keyitem_exclusions = require('maps/keyitems_exclusions')
	local spells_exclusions = require('maps/spells_exclusions')
	
	res_keyitems = res.key_items:filter(function(keyitem)
		local hidden = trackermenusettings.showexcluded and keyitem_exclusions.hidden or S{}
		return not keyitem_exclusions.excluded:contains(keyitem.id) and not hidden:contains(keyitem.id)
	end)
	corsairrollsids = L(res.job_abilities:filter(function(job_ability)
		return job_ability.type == "CorsairRoll"
	end):keyset()):sort()
	spellids = L(res.spells:filter(function(spell)
		return (not spell.unlearnable) and (not spells_exclusions[spell.id])
	end):keyset()):sort()
end

addon_setup()

update_maintab = function()
	
	tabs[1].items = L{}
	
	append_maintab('Mastery Rank: %d', playertracker.mastery_rank)
	append_maintab('Playtime: %d Days', playertracker.playtime)
	append_maintab('Checklist Progress %d/%d', util.totalpoints())
	tabs[1].items:append(util.list_item(nil, '======= General ======='))
	append_maintab('RoE %d/%d', playertracker.roe_completed, playertracker.roe_total)
	append_maintab('Zones visited %d/%d', playertracker.zones_completed, playertracker.zones_total)
	append_maintab('Titles %d/%d', playertracker.Titles_completed, playertracker.Titles_total)
	append_maintab('Missions %d/%d', (playertracker.sandoriamissions_completed+playertracker.bastokmissions_completed+playertracker.windurstmissions_completed+playertracker.zilartmissions_completed+playertracker.copmissions_completed+playertracker.ahturhganmissions_completed+playertracker.assaults_completed+playertracker.wotgmissions_completed+playertracker.acpmissions_completed+playertracker.mkdmissions_completed+playertracker.asamissions_completed+playertracker.soamissions_completed+playertracker.rovmissions_completed+playertracker.tvrmissions_completed+playertracker.campaign_completed), (playertracker.sandoriamissions_total+playertracker.bastokmissions_total+playertracker.windurstmissions_total+playertracker.zilartmissions_total+playertracker.copmissions_total+playertracker.ahturhganmissions_total+playertracker.assaults_total+playertracker.wotgmissions_total+playertracker.acpmissions_total+playertracker.mkdmissions_total+playertracker.asamissions_total+playertracker.soamissions_total+playertracker.rovmissions_total+playertracker.tvrmissions_total+playertracker.campaign_total))
	append_maintab('Quests %d/%d', (playertracker.bastok_completed+playertracker.sandoria_completed+playertracker.windurst_completed+playertracker.jeuno_completed+playertracker.ahturhgan_completed+playertracker.crystalwar_completed+playertracker.outlands_completed+playertracker.other_completed+playertracker.abyssea_completed+playertracker.adoulin_completed+playertracker.coalition_completed), (playertracker.bastok_total+playertracker.sandoria_total+playertracker.windurst_total+playertracker.jeuno_total+playertracker.ahturhgan_total+playertracker.crystalwar_total+playertracker.outlands_total+playertracker.other_total+playertracker.abyssea_total+playertracker.adoulin_total+playertracker.coalition_total))
	append_maintab('Magic %d/%d', (playertracker.WhiteMagic_completed+playertracker.BlackMagic_completed+playertracker.SummonerPact_completed+playertracker.Ninjutsu_completed+playertracker.BardSong_completed+playertracker.BlueMagic_completed+playertracker.Geomancy_completed+playertracker.Trust_completed), (playertracker.WhiteMagic_total+playertracker.BlackMagic_total+playertracker.SummonerPact_total+playertracker.Ninjutsu_total+playertracker.BardSong_total+playertracker.BlueMagic_total+playertracker.Geomancy_total+playertracker.Trust_total))
	append_maintab('Warps %d/%d', (playertracker.homepoints_completed+playertracker.survivalguides_completed+playertracker.waypoints_completed+playertracker.telepoints_completed+playertracker.cavernousmaws_completed+playertracker.lycopodium_completed+playertracker.eschanportals_completed+playertracker.outposts_completed+playertracker.protowaypoints_completed+playertracker.abysseaconflux_completed), (playertracker.homepoints_total+playertracker.survivalguides_total+playertracker.waypoints_total+playertracker.telepoints_total+playertracker.cavernousmaws_total+playertracker.lycopodium_total+playertracker.eschanportals_total+playertracker.outposts_total+playertracker.protowaypoints_total+playertracker.abysseaconflux_total))
	
	tabs[1].items:append(util.list_item(nil, '======= Story ======='))
	append_maintab('San d\'Oria Missions %d/%d', playertracker.sandoriamissions_completed, playertracker.sandoriamissions_total)
	append_maintab('Bastok Missions %d/%d', playertracker.bastokmissions_completed, playertracker.bastokmissions_total)
	append_maintab('Windurst Missions %d/%d', playertracker.windurstmissions_completed, playertracker.windurstmissions_total)
	append_maintab('RotZ Missions %d/%d', playertracker.zilartmissions_completed, playertracker.zilartmissions_total)
	append_maintab('CoP Missions %d/%d', playertracker.copmissions_completed, playertracker.copmissions_total)
	append_maintab('Assaults %d/%d', playertracker.assaults_completed, playertracker.assaults_total)
	append_maintab('ToAU Missions %d/%d', playertracker.ahturhganmissions_completed, playertracker.ahturhganmissions_total)
	append_maintab('Campaign Ops %d/%d', playertracker.campaign_completed, playertracker.campaign_total)
	append_maintab('WoTG Missions %d/%d', playertracker.wotgmissions_completed, playertracker.wotgmissions_total)
	append_maintab('ACP Missions %d/%d', playertracker.acpmissions_completed, playertracker.acpmissions_total)
	append_maintab('MKD Missions %d/%d', playertracker.mkdmissions_completed, playertracker.mkdmissions_total)
	append_maintab('ASA Missions %d/%d', playertracker.asamissions_completed, playertracker.asamissions_total)
	append_maintab('SoA Missions %d/%d', playertracker.soamissions_completed, playertracker.soamissions_total)
	append_maintab('RoV Missions %d/%d', playertracker.rovmissions_completed, playertracker.rovmissions_total)
	append_maintab('TVR Missions %d/%d', playertracker.tvrmissions_completed, playertracker.tvrmissions_total)
	append_maintab('San d\'Oria Quests %d/%d', playertracker.sandoria_completed, playertracker.sandoria_total)
	append_maintab('Bastok Quests %d/%d', playertracker.bastok_completed, playertracker.bastok_total)
	append_maintab('Windurst Quests %d/%d', playertracker.windurst_completed, playertracker.windurst_total)
	append_maintab('Jeuno Quests %d/%d', playertracker.jeuno_completed, playertracker.jeuno_total)
	append_maintab('Other Quests %d/%d', playertracker.other_completed, playertracker.other_total)
	append_maintab('Outlands Quests %d/%d', playertracker.outlands_completed, playertracker.outlands_total)
	append_maintab('Aht Urhgan Quests %d/%d', playertracker.ahturhgan_completed, playertracker.ahturhgan_total)
	append_maintab('Crystal War Quests %d/%d', playertracker.crystalwar_completed, playertracker.crystalwar_total)
	append_maintab('Abyssea Quests %d/%d', playertracker.abyssea_completed, playertracker.abyssea_total)
	append_maintab('Adoulin Quests %d/%d', playertracker.adoulin_completed, playertracker.adoulin_total)
	append_maintab('Coalition Assignments %d/%d', playertracker.coalition_completed, playertracker.coalition_total)
	
	tabs[1].items:append(util.list_item(nil, '======= Key Items ======='))
	append_maintab('Permanent Key Items %d/%d', playertracker.Permanent_Key_Items_completed, playertracker.Permanent_Key_Items_total)
	append_maintab('Magical Maps %d/%d', playertracker.Magical_Maps_completed, playertracker.Magical_Maps_total)
	append_maintab('Mounts %d/%d', playertracker.Mounts_completed, playertracker.Mounts_total)
	append_maintab('Claim Slips %d/%d', playertracker.Claim_Slips_completed, playertracker.Claim_Slips_total)
	append_maintab('Abyssea %d/%d', playertracker.Abyssea_completed, playertracker.Abyssea_total)
	append_maintab('Voidwatch  %d/%d', playertracker.Voidwatch_completed, playertracker.Voidwatch_total)
	append_maintab('Mog Garden  %d/%d', playertracker.Mog_Garden_completed, playertracker.Mog_Garden_total)
	append_maintab('Active Effects %d/%d', playertracker.Active_Effects_completed, playertracker.Active_Effects_total)
	append_maintab('Atmacite Levels %d/%d', playertracker.atmacite_completed, playertracker.atmacite_total)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Atmacite Refiner\\cr \\cs(50,150,255)(Menu: Enrich Atmas)\\cr', playertracker.talk_to_npc.atmacite_refiner)
	
	tabs[1].items:append(util.list_item(nil, '======= Magic ======='))
	append_maintab('White Magic %d/%d', playertracker.WhiteMagic_completed, playertracker.WhiteMagic_total)
	append_maintab('Black Magic %d/%d', playertracker.BlackMagic_completed, playertracker.BlackMagic_total)
	append_maintab('Summoner Pacts %d/%d', playertracker.SummonerPact_completed, playertracker.SummonerPact_total)
	append_maintab('Ninjutsu %d/%d', playertracker.Ninjutsu_completed, playertracker.Ninjutsu_total)
	append_maintab('Bard Songs %d/%d', playertracker.BardSong_completed, playertracker.BardSong_total)
	append_maintab('Blue Magic %d/%d', playertracker.BlueMagic_completed, playertracker.BlueMagic_total)
	append_maintab('Geomancy %d/%d', playertracker.Geomancy_completed, playertracker.Geomancy_total)
	append_maintab('Trusts %d/%d', playertracker.Trust_completed, playertracker.Trust_total)
	append_maintab('Corsair Rolls %d/%d', playertracker.CorsairRoll_completed, playertracker.CorsairRoll_total)
	append_maintab('Puppetmaster Attachments %d/%d', playertracker.pupattachments_completed, playertracker.pupattachments_total)

	tabs[1].items:append(util.list_item(nil, '======= Leveling ======='))
	append_maintab('Craft Skills %d/%d', playertracker.craftingskills_completed, 790)
	append_maintab('Wing Skill %d/%d', playertracker.wingskill_completed, 100)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Chocobo stats NPC\\cr @ \\cs(50,150,255)Nations Chocobo Stables\\cr', playertracker.talk_to_npc.chocobokid)
	append_maintab('Merit Points %d/%d', playertracker.meritpoints_completed, 919)
	append_maintab('Job Points Maxed %d/%d', playertracker.jobpoints_completed, 22)
	append_maintab('Master Levels %d/%d (Highest: %d)', playertracker.masterlevels_completed, 1100, playertracker.masterlevels_highest)
	append_maintab('Alter Ego Points %d/%d', playertracker.alteregopoint_completed, playertracker.alteregopoint_total)
	
	tabs[1].items:append(util.list_item(nil, '======= Warps ======='))
	append_maintab('Home Points %d/%d', playertracker.homepoints_completed, playertracker.homepoints_total)
	append_maintab('Survival Guides %d/%d', playertracker.survivalguides_completed, playertracker.survivalguides_total)
	append_maintab('Waypoints %d/%d', playertracker.waypoints_completed, playertracker.waypoints_total)
	append_maintab('Telepoints %d/%d', playertracker.telepoints_completed, playertracker.telepoints_total)
	append_maintab('Cavernous Maws %d/%d', playertracker.cavernousmaws_completed, playertracker.cavernousmaws_total)
	append_maintab('Lycopodium %d/%d', playertracker.lycopodium_completed, playertracker.lycopodium_total)
	append_maintab('Eschan Portals %d/%d', playertracker.eschanportals_completed, playertracker.eschanportals_total)
	append_maintab('Outposts %d/%d', playertracker.outposts_completed, playertracker.outposts_total)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Outpost Teleporter NPC\\cr @ \\cs(50,150,255)three nations\\cr.', playertracker.talk_to_npc.outpostnpc)
	append_maintab('Proto-Waypoints %d/%d', playertracker.protowaypoints_completed, playertracker.protowaypoints_total)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Proto-Waypoint\\cr.', playertracker.talk_to_npc.protowaypoint)
	append_maintab('Abyssea Conflux %d/%d', playertracker.abysseaconflux_completed, playertracker.abysseaconflux_total)
	
	tabs[1].items:append(util.list_item(nil, '======= Other Content ======='))
	append_maintab('Fishes Caught %d/%d', playertracker.fishes_completed, 164)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Katsunaga\\cr @ \\cs(50,150,255)Mhuaura (H-9)\\cr \\cs(255,255,255)(Menu: Types of fishes caught)\\cr', playertracker.talk_to_npc.katsunaga)
	append_maintab('Ergon Locus %d/%d', playertracker.ergonlocus_completed, playertracker.ergonlocus_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Rienne\\cr @ \\cs(50,150,255)Western Adoulin (J-9)\\cr', playertracker.talk_to_npc.ergonlocus)
	
	tabs[1].items:append(util.list_item(nil, '======= Monstrosity ======='))
	append_maintab('Monster Levels Maxed %d/%d', playertracker.monsterlevels_completed, playertracker.monsterlevels_total)
	append_maintab('Race/Job Instincts %d/%d', playertracker.racejobinstinct_completed, playertracker.racejobinstinct_total)
	append_maintab('Monster Variants %d/%d', playertracker.monstervariants_completed, playertracker.monstervariants_total)
	append_maintab('Monster Instincts %d/%d', playertracker.monsterinsincts_completed, playertracker.monsterinsincts_total)
	
	tabs[1].items:append(util.list_item(nil, '======= Battle Content ======='))
	append_maintab('MMM Vouchers Unlocked %d/%d', playertracker.mmmvouchers_completed, playertracker.mmmvouchers_total)
	append_maintab('MMM Runes Unlocked %d/%d', playertracker.mmmrunes_completed, playertracker.mmmrunes_total)
	append_maintab('MMM Maze count %d/%d', playertracker.mmm_mazecount, 1000)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Chatnachoq\\cr @ \\cs(50,150,255)Lower Jeuno (H-9) \\cr', playertracker.talk_to_npc.chatnachoq)
	append_maintab('Meeble Burrows Goal #3 %d/%d', playertracker.meebleburrows_completed, playertracker.meebleburrows_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc.meeble_sauromugue)
	append_addonhelp(1, 'Menu: Review expedition specifics -> \\cs(255,255,255)Sauromugue Champaign\\cr', playertracker.talk_to_npc.meeble_sauromugue)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc.meeble_batallia)
	append_addonhelp(1, 'Menu: Review expedition specifics -> \\cs(255,255,255)Batallia Downs\\cr', playertracker.talk_to_npc.meeble_batallia)
	append_maintab('Sheol A (%d/%d)', playertracker.sheola_completed, playertracker.sheola_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc.sheola)
	append_maintab('Sheol B (%d/%d)', playertracker.sheolb_completed, playertracker.sheolb_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc.sheolb)
	append_maintab('Sheol C (%d/%d)', playertracker.sheolc_completed, playertracker.sheolc_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc.sheolc)
	append_maintab('Sheol Gaol Vengeance (%d/%d)', playertracker.sheolgaoltiers_completed, playertracker.sheolgaoltiers_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Sheol Gaol)', playertracker.talk_to_npc.sheolgaol)
	append_maintab('Eschan Vorseals (%d/%d)', playertracker.vorseals_completed, playertracker.vorseals_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Shiftrix\\cr @ \\cs(50,150,255)Reisenjima (F-12)\\cr', playertracker.talk_to_npc.vorseals)
	append_maintab('Emporox Goodness %d/%d', playertracker.emporox_completed, playertracker.emporox_total)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Emporox\\cr @ \\cs(50,150,255)Reisenjima #8\\cr', playertracker.talk_to_npc.emporox)
	
	tabs[1].items:append(util.list_item(nil, '======= Titles ======='))
	append_maintab('Titles %d/%d', playertracker.Titles_completed, playertracker.Titles_total)
	append_items(tabs[1].items, tab_logs.titles_by_content.items)
end

windower.register_event('incoming chunk', function(id, data, modified, injected, blocked)
	if injected then return end
	
	if (id == 0x008) then
		-- do visited zones
		warps_util.log_visitedzones(data)
	elseif id == 0x00A then
		local parseddata = packets.parse('incoming', data)
		playertracker.playtime = math.floor(parseddata['Abyssea Timestamp']/86400)
	elseif id == 0x01B then
		-- check current mastery rank
		local parseddata = packets.parse('incoming', data)
		if (parseddata['Mastery Rank'] > playertracker.mastery_rank) then
			if (playertracker.mastery_rank > 0) then
				util.addon_log('Mastery Rank increase: '..parseddata['Mastery Rank'])
			end
			playertracker.mastery_rank = parseddata['Mastery Rank']
			playertracker:save()
		elseif (parseddata['Mastery Rank'] < playertracker.mastery_rank) then
			util.addon_log('Mastery Rank decrease: '..parseddata['Mastery Rank'])
			playertracker.mastery_rank = parseddata['Mastery Rank']
			playertracker:save()
		end
	elseif id == 0x044 then
		-- PUP attachments
		local parseddata = packets.parse('incoming', data)
		if parseddata.Job == 18 and not parseddata.Subjob then -- if PUP main
			update_pupattachments(data)
		end
	elseif id == 0x056 then
		-- do quests
		local p = packets.parse('incoming', data)
		local log = quest_logs[p.Type]
		if log then
			if (p.Type == 0x0080) then -- if Aht Urhgan Current Quests
				quests[log.type][log.area] = p['Current TOAU Quests']
			elseif (p.Type == 0x00C0) then -- if Aht Urhgan Completed Quests / Assaults
				quests[log.type][log.area] = p['Completed TOAU Quests']
				quests.completed.assaults = p['Completed Assaults']
				quest_util.log_quests(log.area)
				quest_util.log_quests('assaults')
			elseif (p.Type == 0x00D0) then -- if Nation, Zilart Completed Missions
				quests.completed.sandoriamissions = p['Completed San d\'Oria Missions']
				quests.completed.bastokmissions = p['Completed Bastok Missions']
				quests.completed.windurstmissions = p['Completed Windurst Missions']
				quests.completed.zilartmissions = p['Completed Zilart Missions']
				quest_util.log_quests('sandoriamissions')
				quest_util.log_quests('bastokmissions')
				quest_util.log_quests('windurstmissions')
				quest_util.log_quests('zilartmissions')
			elseif (p.Type == 0x00D8) then -- if TOAU, WOTG Completed Missions
				quests.completed.ahturhganmissions = p['Completed TOAU Missions']
				quests.completed.wotgmissions = p['Completed WOTG Missions']
				quest_util.log_quests('ahturhganmissions')
				quest_util.log_quests('wotgmissions')
			elseif (p.Type == 0xFFFE) then -- if TVR Current Missions
				quest_util.log_missions('tvrmissions', p['Current TVR Mission'])
			elseif (p.Type == 0xFFFF) then -- if Other Current Missions
				quest_util.log_missions('copmissions', p['Current COP Mission'])
				quest_util.log_missions('acpmissions', p['Current ACP Mission'])
				quest_util.log_missions('mkdmissions', p['Current MKD Mission'])
				quest_util.log_missions('asamissions', p['Current ASA Mission'])
				quest_util.log_missions('soamissions', p['Current SOA Mission'])
				quest_util.log_missions('rovmissions', p['Current ROV Mission'])
			else
				quests[log.type][log.area] = p['Quest Flags']
				quest_util.log_quests(log.area)
			end
		end
    elseif id == 0x062 then
		-- crafting skills
		local p = packets.parse('incoming', data)
		playertracker.craftingskills_completed = p['Fishing Level']+p['Woodworking Level']+p['Smithing Level']+p['Goldsmithing Level']+p['Clothcraft Level']
		+p['Leathercraft Level']+p['Bonecraft Level']+p['Alchemy Level']+p['Cooking Level']+p['Synergy Level']
	elseif id == 0x063 then
		local parseddata = packets.parse('incoming', data)
		-- do warps
		if (parseddata.Order == 6) then
			warps_util.warps_data = data
			warps_util.log_warps('homepoints')
			warps_util.log_warps('survivalguides')
			warps_util.log_warps('waypoints')
			warps_util.log_warps('telepoints')
			warps_util.log_warps('cavernousmaws')
			warps_util.log_unknownwarps('unknownwarps')
			warps_util.log_warps('lycopodium')
			warps_util.log_warps('eschanportals')
		end
		-- do monstrosity
		if (parseddata.Order == 3) then
			mons_util.monster_levelspacket[1] = parseddata['Monster Level Char field']
			mons_util.monsterinstincts = util.twobits_to_table(parseddata['Instinct Bitfield 1'])
			mons_util.log_monsterlevels()
			mons_util.log_monsterinstincts()
		end
		if (parseddata.Order == 4) then
			mons_util.monster_levelspacket[2] = data:sub(0x08+1, 0x87+1)
			mons_util.racejobinstincts = parseddata['Instinct Bitfield 3']
			mons_util.variants_bitfield = parseddata['Variants Bitfield']
			mons_util.log_monsterlevels()
			mons_util.log_variants()
			mons_util.log_racejobinstincts()
		end
	elseif (id == 0x033) or (id == 0x034) then
		-- handle npc menu
		menus_util.handle_npc_menu(data)
		xichecklist_updatemenulogs()
	elseif id == 0x061 then
		-- check player info (updated when opening menu)
		local parseddata = packets.parse('incoming', data)
		menus_util.add_title(parseddata.Title)
		xichecklist_updatemenulogs()
	elseif id == 0x05C then
		if menu_current.npcindex then menus_util.handle_npc_submenu(data) end
		xichecklist_updatemenulogs()
	elseif id == 0x112 then
		-- do RoE
		if (not ROE_DATA) then ROE_DATA = {} end
		local parseddata = packets.parse('incoming', data)
		-- the packet will be repeated four times, gather the data first
		ROE_DATA[parseddata.Order + 1] = parseddata['RoE Quest Bitfield']
		if #ROE_DATA == 4 then
			local roe_data = ''
			for _, roe_datum in ipairs(ROE_DATA) do
				roe_data = roe_data .. roe_datum
			end
			roe_util.log_roe(roe_data)
		end
	elseif id == 0x0AD then
		-- do MMM
		local parseddata = packets.parse('incoming', data)
		mmm_util.handle_mmm_data(data)
		mmm_util.log_vouchers()
		mmm_util.log_runes()
	elseif id == 0x052 then
		-- clear npc menu
		menus_util.reset_current_menu()
	elseif id == 0x08E then
		-- do Alter Ego Points
		local alteregopoint_completed = 0
		--local alteregopoint_total = 0
		for i = 17, 27 do -- Bytes 17 to 27 for HP MP etc etc -> Magic Skill (update when they add more)
			alteregopoint_completed = alteregopoint_completed + string.byte(data, i)
			--alteregopoint_total = alteregopoint_total + 50
		end
		playertracker.alteregopoint_completed = alteregopoint_completed
		--playertracker.alteregopoint_total = alteregopoint_total
	else
		return
	end
	throttled_update()
end)

THROTTLED = false
throttled_update = function()
	if THROTTLED then return end
	THROTTLED = true
	coroutine.sleep(0.1)
	-- Drop errors on the ground so we're never locked in THROTTLED = true
	pcall(function ()
		update_maintab()
		xichecklist_updatetabs()
		if trackermenusettings.visibility then draw() end
	end)
	THROTTLED = false
end

windower.register_event('outgoing chunk', function(id, data, modified, injected, blocked)
	-- listen to menu options
	if (id==0x05B) then
		menus_util.handle_menu_options(data) -- READ outgoing menu selection to determine which submenu
	end
end)

xichecklist_updatemenulogs = function()
	menus_util.log_outposts()
	menus_util.log_protowaypoints()
	menus_util.log_fishes()
	menus_util.log_atmacitelevels()
	menus_util.log_meeble_burrows()
	menus_util.log_titles()
	menus_util.list_titles_bycontent()
	menus_util.list_titles_bycontent_detailed()
	menus_util.log_sheolabc('sheola')
	menus_util.log_sheolabc('sheolb')
	menus_util.log_sheolabc('sheolc')
	menus_util.log_sheolgaol()
	menus_util.log_vorseals()
	menus_util.log_ergonlocus()
	menus_util.log_emporox()
	menus_util.log_abyssea_conflux()
end

xichecklist_updatetabs = function()
	if not player then return false end
	--setup
	local playerspells = windower.ffxi.get_spells()
	local playerkeyitems = S(windower.ffxi.get_key_items())
	local playerjobabilities = S(windower.ffxi.get_abilities().job_abilities)
	
	log_spells('WhiteMagic', playerspells)
	log_spells('BlackMagic', playerspells)
	log_spells('SummonerPact', playerspells)
	log_spells('Ninjutsu', playerspells)
	log_spells('BardSong', playerspells)
	log_spells('BlueMagic', playerspells)
	log_spells('Geomancy', playerspells)
	log_spells('Trust', playerspells)
	
	log_keyitems('Permanent Key Items', playerkeyitems)
	log_keyitems('Magical Maps', playerkeyitems)
	log_keyitems('Mounts', playerkeyitems)
	log_keyitems('Active Effects', playerkeyitems)
	log_keyitems('Voidwatch', playerkeyitems)
	log_keyitems('Abyssea', playerkeyitems)
	log_keyitems('Mog Garden', playerkeyitems)
	log_keyitems('Claim Slips', playerkeyitems)
	
	log_corsairrolls(playerjobabilities)
	log_pupattachments()
	log_exp()
	
	tab_logs.mmm_mazecount.completed = playertracker.mmm_mazecount
end

log_keyitems = function(category, playerkeyitems)
	local output_list = {}
	local total, obtained = 0, 0
	for id, keyitem in pairs(res_keyitems) do
		if res.key_items[id].category == category then
			total = total + 1
			local completion = false
			if playerkeyitems[id] then
				-- key item obtained
				obtained = obtained + 1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, res.key_items[id].en, completion))
		end
	end
	playertracker[util.cleanspaces(category)..'_completed'] = obtained
	playertracker[util.cleanspaces(category)..'_total'] = total
	tab_logs[util.cleanspaces(category)] = {
		name = tab_logs[util.cleanspaces(category)].name,
		completed = obtained,
		total = total,
		items = output_list
	}
end

log_spells = function(spelltype, playerspells)
	local output_list = {}
	local total, obtained = 0, 0
	for id in spellids:it() do
		local completion = false
		if res.spells[id].type == spelltype then
			total = total + 1
			if (playerspells[id] == true) then
				-- spell learned
				obtained = obtained + 1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, res.spells[id].en, completion))
		end
	end
	playertracker[spelltype..'_completed'] = obtained
	playertracker[spelltype..'_total'] = total
	tab_logs[spelltype] = {
		name = tab_logs[spelltype].name,
		completed = obtained,
		total = total,
		items = output_list
	}
end

log_exp = function()
	local jp_output_list = {}
	local ml_output_list = {}
	local total_merit_upgrades = 0
	local total_jp_spent = 0
	local total_master_levels = 0
	local highest_master_level = 0
	local playerinfo = windower.ffxi.get_player()
	-- merits points
	if (type(playerinfo.merits) == 'table') then
		for merit, value in pairs(playerinfo.merits) do
			total_merit_upgrades = total_merit_upgrades + value
		end
	end
	playertracker.meritpoints_completed = total_merit_upgrades
	-- job points
	if (type(playerinfo.job_points) == 'table') then
		for job, value in pairs(playerinfo.job_points) do
			local completion = false
			total_jp_spent = total_jp_spent + playerinfo.job_points[job].jp_spent
			if playerinfo.job_points[job].jp_spent == 2100 then completion = true end
			table.insert(jp_output_list, util.list_item(nil, job..' '..playerinfo.job_points[job].jp_spent..'/2100', completion))
		end
	end
	playertracker.jobpoints_completed = math.floor(total_jp_spent/2100)
	playertracker.jobpoints_total = 22
	-- master levels
	if (type(playerinfo.master_levels) == 'table') then
		for job, value in pairs(playerinfo.master_levels) do
			local completion = false
			total_master_levels = total_master_levels + playerinfo.master_levels[job]
			if playerinfo.master_levels[job] == 50 then completion = true end
			table.insert(ml_output_list, util.list_item(nil, job..' '..playerinfo.master_levels[job]..'/50', completion))
			if (playerinfo.master_levels[job] > highest_master_level) then highest_master_level = playerinfo.master_levels[job] end
		end
	end
	playertracker.masterlevels_completed = total_master_levels
	playertracker.masterlevels_highest = highest_master_level
	tab_logs.jobpoints = {
		name = tab_logs.jobpoints.name,
		completed = total_jp_spent,
		total = 46200,
		items = jp_output_list
	}
	tab_logs.masterlevels = {
		name = tab_logs.masterlevels.name,
		completed = total_master_levels,
		total = 1100,
		items = ml_output_list
	}
end

log_corsairrolls = function(playerjobabilities)
	local output_list = {}
	local total, obtained = 0, 0
	for id in corsairrollsids:it() do
		local completion = false
		total = total + 1
		if (playerjobabilities[id] == true) or (playertracker.corsairrolls[id] == true) then
			-- roll learned
			obtained = obtained + 1
			playertracker.corsairrolls[id] = true
			completion = true
		end
		table.insert(output_list, util.list_item(nil, res.job_abilities[id].en, completion))
	end
	playertracker.CorsairRoll_total = total
	if obtained > playertracker.CorsairRoll_completed then -- to avoid spam save()
		playertracker.CorsairRoll_completed = obtained
		playertracker:save()
	end
	tab_logs.CorsairRoll = {
		name = tab_logs.CorsairRoll.name,
		completed = obtained,
		total = total,
		items = output_list
	}
end

update_pupattachments = function(data)
	local total, obtained = 0, 0
	local pup_map = require('maps/pup')
	local pup_bitfields = {
		['Available_Heads'] = data:sub(0x018+1, 0x018+4),
		['Available_Bodies'] = data:sub(0x01C+1, 0x01C+4),
		['Fire_Attachments'] = data:sub(0x038+1, 0x038+4),
		['Ice_Attachments'] = data:sub(0x03C+1, 0x03C+4),
		['Wind_Attachments'] = data:sub(0x040+1, 0x040+4),
		['Earth_Attachments'] = data:sub(0x044+1, 0x044+4),
		['Thunder_Attachments'] = data:sub(0x048+1, 0x048+4),
		['Water_Attachments'] = data:sub(0x04C+1, 0x04C+4),
		['Light_Attachments'] = data:sub(0x050+1, 0x050+4),
		['Dark_Attachments'] = data:sub(0x054+1, 0x054+4),
	}
	for pupattachments_category, bitfield in pairs(pup_bitfields) do
		for id, name in pairs(pup_map[pupattachments_category]) do
			total = total + 1
			if util.has_bit(bitfield, id) then
				obtained = obtained + 1
				playertracker.pupattachments[pupattachments_category][id] = true
			end
		end
	end
	playertracker.pupattachments_total = total
	if obtained > playertracker.pupattachments_completed then -- to avoid spam save()
		playertracker.pupattachments_completed = obtained
		playertracker:save()
	end
end

log_pupattachments = function()
	local output_list = {}
	local total, obtained = 0, 0
	local pup_map = require('maps/pup')
	for pupattachments_category, attachments in pairs(pup_map) do
		for id, name in pairs(attachments) do
			local completion = false
			total = total + 1
			if playertracker.pupattachments[pupattachments_category][id] == true then
				obtained = obtained + 1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, name, completion))
		end
	end
	tab_logs.pupattachments = {
		name = tab_logs.pupattachments.name,
		completed = obtained,
		total = total,
		items = output_list
	}
end

draw()

windower.register_event('addon command', function(...)
	local quests_location = S{'sandoria', 'bastok', 'windurst', 'jeuno', 'ahturhgan', 'assaults', 'crystalwar', 'outlands', 'other', 'abyssea', 'adoulin', 'coalition', 'sandoriamissions', 'bastokmissions', 'windurstmissions', 'zilartmissions', 'ahturhganmissions', 'wotgmissions', 'copmissions', 'acpmissions', 'mkdmissions', 'asamissions', 'soamissions', 'rovmissions', 'tvrmissions'}
	if arg[1] == 'eval' then
		assert(loadstring(table.concat(arg, ' ',2)))()
	elseif cmds.help:contains(arg[1]) then
		windower.add_to_chat(161,'==== xichecklist / xic ====')
		windower.add_to_chat(161,'//xic [show|hide] to show / hide UI')
		windower.add_to_chat(161,'//xic copy to copy current tab to clipboard')
		windower.add_to_chat(161,'//xic showcompleted to toggle show completed items on-off')
		windower.add_to_chat(161,'//xic showexcluded to toggle show hidden RoE/Titles items on-off')
		windower.add_to_chat(161,'//xic log <category> to log in chat')
		windower.add_to_chat(161,'==== ==== ==== ====')
		windower.add_to_chat(161,'Require zoning to update Quests / Warps / Monstrosity / MMM')
		windower.add_to_chat(161,'==== ==== ==== ====')
		windower.add_to_chat(161,'Require talking to NPCs to register the following (Check README)')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Titles', 261)..'-> 16 Title Changer NPCs')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Fish caught', 261)..'-> Katsunaga in Mhaura (Menu: Types of fish caught)')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Meeble Burrows', 261)..'-> any Burrow Researcher or Burrow Investigator')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Outpost Warps', 261)..'-> any Nation Teleporter')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('MMM Maze Count', 261)..'-> Chatnachoq (LowerJeuno)')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Proto-Waypoint', 261)..'-> any Proto-Waypoints')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Atmacite Levels', 261)..'-> any Atmacite Refiner (Enrich Atmacite)')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Wing Skill', 261)..'-> Nation Chocobo Stable kids')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Sheol Gaol Vengeance', 261)..'-> ??? in Rabao (Status Report: Sheol Gaol)')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Escha Vorseals', 261)..'-> Shiftrix in Reisenjima')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Ergon Locus', 261)..'-> Rienne in Western Adoulin')
		windower.add_to_chat(161,string.char(0x81, 0xA1)..string.color('Emporox Goodness', 261)..'-> Emporox in Reisenjima')
	elseif cmds.show:contains(arg[1]) then
		trackermenusettings.visibility = true
		subtabs_drawn = false
		trackermenusettings:save()
		draw()
		ui.menu:show()
	elseif cmds.hide:contains(arg[1]) then
		trackermenusettings.visibility = false
		subtabs_drawn = false
		trackermenusettings:save()
		ui.menu:hide()
	elseif cmds.showcompleted:contains(arg[1]) then
		trackermenusettings.showcompleted = not trackermenusettings.showcompleted
		util.addon_log('showcompleted: '..tostring(trackermenusettings.showcompleted))
		trackermenusettings:save()
		xichecklist_updatemenulogs()
		draw()
	elseif cmds.showexcluded:contains(arg[1]) then
		trackermenusettings.showexcluded = not trackermenusettings.showexcluded
		util.addon_log('showexcluded: '..tostring(trackermenusettings.showexcluded))
		trackermenusettings:save()
		xichecklist_updatemenulogs()
		draw()
	elseif cmds.copy:contains(arg[1]) then
		windower.copy_to_clipboard(util.table_to_clipboard(tabs[active_tab].items, trackermenusettings.showcompleted))
		windower.add_to_chat(100, 'Copy to clipboard')
	elseif cmds.scale:contains(arg[1]) then
		UI_SCALE 	= tonumber(arg[2]) or 1
		subtabs_drawn = false
		ui.menu:size(FONT_SIZE())
		ui.menu:pad(PADDING())
		trackermenusettings.ui_scale = UI_SCALE
		trackermenusettings:save()
		util.addon_log('UI Scale: '..trackermenusettings.ui_scale)
	elseif cmds.log:contains(arg[1]) then
		if (arg[2]) then
			arg[2] = arg[2]:lower()
			if arg[2] == 'titles' then
				util.log_tablog(tab_logs.titles.items)
				windower.add_to_chat(160, '=== Titles (%d/%d) ===':format(playertracker.Titles_completed, playertracker.Titles_total))
			elseif arg[2] == 'monstrosity' then
				windower.add_to_chat(160, '=== Species Levels (%d/%d) ===':format(playertracker.monsterlevels_completed, playertracker.monsterlevels_total))
				util.log_tablog(tab_logs.monsterlevels.items)
				windower.add_to_chat(160, '=== Monster Variants (%d/%d) ===':format(playertracker.monstervariants_completed, playertracker.monstervariants_total))
				util.log_tablog(tab_logs.monstervariants.items)
				windower.add_to_chat(160, '=== Race / Job Instincts (%d/%d) ===':format(playertracker.racejobinstinct_completed, playertracker.racejobinstinct_total))
				util.log_tablog(tab_logs.racejobinstincts.items)
				windower.add_to_chat(160, '=== Monster Instincts (%d/%d) ===':format(playertracker.monsterinsincts_completed, playertracker.monsterinsincts_total))
				util.log_tablog(tab_logs.monsterinstincts.items)
			elseif arg[2] == 'mmm' then
				windower.add_to_chat(160, '=== MMM Vouchers Unlocks (%d/%d) ===':format(playertracker.mmmvouchers_completed, playertracker.mmmvouchers_total))
				util.log_tablog(tab_logs.mmmvouchers.items)
				windower.add_to_chat(160, '=== MMM Runes Unlocks (%d/%d) ===':format(playertracker.mmmrunes_completed, playertracker.mmmrunes_total))
				util.log_tablog(tab_logs.mmmrunes.items)
			elseif arg[2] == 'meeble' then
				windower.add_to_chat(160, '=== Meeble Burrows (%d/%d) ===':format(playertracker.meebleburrows_completed, playertracker.meebleburrows_total))
				util.log_tablog(tab_logs.meebleburrows.items)
			elseif arg[2] == 'zones' then
				windower.add_to_chat(160, '=== Zones (%d/%d) ===':format(playertracker.zones_completed, playertracker.zones_total))
				util.log_tablog(tab_logs.zones.items)
			elseif arg[2] == 'warps' then
				windower.add_to_chat(160, '=== Home Points (%d/%d) ===':format(playertracker.homepoints_completed, playertracker.homepoints_total))
				util.log_tablog(tab_logs.homepoints.items)
				windower.add_to_chat(160, '=== Survival Guides (%d/%d) ===':format(playertracker.survivalguides_completed, playertracker.survivalguides_total))
				util.log_tablog(tab_logs.survivalguides.items)
				windower.add_to_chat(160, '=== Adoulin Waypoints (%d/%d) ===':format(playertracker.waypoints_completed, playertracker.waypoints_total))
				util.log_tablog(tab_logs.waypoints.items)
				windower.add_to_chat(160, '=== Outpost Warps (%d/%d) ===':format(playertracker.outposts_completed, playertracker.outposts_total))
				util.log_tablog(tab_logs.outposts.items)
				windower.add_to_chat(160, '=== Proto-Waypoints (%d/%d) ===':format(playertracker.protowaypoints_completed, playertracker.protowaypoints_total))
				util.log_tablog(tab_logs.protowaypoints.items)
				windower.add_to_chat(160, '=== Cavernous Maws (%d/%d) ===':format(playertracker.cavernousmaws_completed, playertracker.cavernousmaws_total))
				util.log_tablog(tab_logs.cavernousmaws.items)
				windower.add_to_chat(160, '=== Lycopodium (%d/%d) ===':format(playertracker.lycopodium_completed, playertracker.lycopodium_total))
				util.log_tablog(tab_logs.lycopodium.items)
				windower.add_to_chat(160, '=== Eschan Portals (%d/%d) ===':format(playertracker.eschanportals_completed, playertracker.eschanportals_total))
				util.log_tablog(tab_logs.eschanportals.items)
			elseif arg[2] == 'fish' then
				windower.add_to_chat(160, '=== Type of Fish (%d/%d) ===':format(playertracker.fishes_completed, playertracker.fishes_total))
				util.log_tablog(tab_logs.fishes.items)
			elseif arg[2] == 'missions' then
				windower.add_to_chat(160, '=== San d\'Oria Missions (%d/%d) ===':format(playertracker.sandoriamissions_completed, playertracker.sandoriamissions_total))
				util.log_tablog(tab_logs.sandoriamissions.items)
				windower.add_to_chat(160, 'Bastok Missions (%d/%d) ===':format(playertracker.bastokmissions_completed, playertracker.bastokmissions_total))
				util.log_tablog(tab_logs.bastokmissions.items)
				windower.add_to_chat(160, 'Windurst Missions (%d/%d) ===':format(playertracker.windurstmissions_completed, playertracker.windurstmissions_total))
				util.log_tablog(tab_logs.windurstmissions.items)
				windower.add_to_chat(160, 'Zilart Missions (%d/%d) ===':format(playertracker.zilartmissions_completed, playertracker.zilartmissions_total))
				util.log_tablog(tab_logs.zilartmissions.items)
				windower.add_to_chat(160, 'CoP Missions (%d/%d) ===':format(playertracker.copmissions_completed, playertracker.copmissions_total))
				util.log_tablog(tab_logs.copmissions.items)
				windower.add_to_chat(160, 'TOAU Missions (%d/%d) ===':format(playertracker.ahturhganmissions_completed, playertracker.ahturhganmissions_total))
				util.log_tablog(tab_logs.ahturhganmissions.items)
				windower.add_to_chat(160, 'Assaults (%d/%d) ===':format(playertracker.assaults_completed, playertracker.assaults_total))
				util.log_tablog(tab_logs.assaults.items)
				windower.add_to_chat(160, 'WOTG Missions (%d/%d) ===':format(playertracker.wotgmissions_completed, playertracker.wotgmissions_total))
				util.log_tablog(tab_logs.wotgmissions.items)
				windower.add_to_chat(160, 'ACP Missions (%d/%d) ===':format(playertracker.acpmissions_completed, playertracker.acpmissions_total))
				util.log_tablog(tab_logs.acpmissions.items)
				windower.add_to_chat(160, 'MKD Missions (%d/%d) ===':format(playertracker.mkdmissions_completed, playertracker.mkdmissions_total))
				util.log_tablog(tab_logs.mkdmissions.items)
				windower.add_to_chat(160, 'ASA Missions (%d/%d) ===':format(playertracker.asamissions_completed, playertracker.asamissions_total))
				util.log_tablog(tab_logs.asamissions.items)
				windower.add_to_chat(160, 'SoA Missions (%d/%d) ===':format(playertracker.soamissions_completed, playertracker.soamissions_total))
				util.log_tablog(tab_logs.soamissions.items)
				windower.add_to_chat(160, 'RoV Missions (%d/%d) ===':format(playertracker.rovmissions_completed, playertracker.rovmissions_total))
				util.log_tablog(tab_logs.rovmissions.items)
				windower.add_to_chat(160, 'TVR Missions (%d/%d) ===':format(playertracker.tvrmissions_completed, playertracker.tvrmissions_total))
				util.log_tablog(tab_logs.tvrmissions.items)
			elseif arg[2] == 'quests' then
				windower.add_to_chat(160, '=== San d\'Oria Quests (%d/%d) ===':format(playertracker.sandoria_completed, playertracker.sandoria_total))
				util.log_tablog(tab_logs.sandoria.items)
				windower.add_to_chat(160, '=== Bastok Quests (%d/%d) ===':format(playertracker.bastok_completed, playertracker.bastok_total))
				util.log_tablog(tab_logs.bastok.items)
				windower.add_to_chat(160, '=== Windurst Quests (%d/%d) ===':format(playertracker.windurst_completed, playertracker.windurst_total))
				util.log_tablog(tab_logs.windurst.items)
				windower.add_to_chat(160, '=== Jeuno Quests (%d/%d) ===':format(playertracker.jeuno_completed, playertracker.jeuno_total))
				util.log_tablog(tab_logs.jeuno.items)
				windower.add_to_chat(160, '=== Aht Urhgan Quests (%d/%d) ===':format(playertracker.ahturhgan_completed, playertracker.ahturhgan_total))
				util.log_tablog(tab_logs.ahturhgan.items)
				windower.add_to_chat(160, '=== Crystal War Quests (%d/%d) ===':format(playertracker.crystalwar_completed, playertracker.crystalwar_total))
				util.log_tablog(tab_logs.crystalwar.items)
				windower.add_to_chat(160, '=== Outlands Quests (%d/%d) ===':format(playertracker.outlands_completed, playertracker.outlands_total))
				util.log_tablog(tab_logs.outlands.items)
				windower.add_to_chat(160, '=== Other Quests (%d/%d) ===':format(playertracker.other_completed, playertracker.other_total))
				util.log_tablog(tab_logs.other.items)
				windower.add_to_chat(160, '=== Abyssea Quests (%d/%d) ===':format(playertracker.abyssea_completed, playertracker.abyssea_total))
				util.log_tablog(tab_logs.abyssea.items)
				windower.add_to_chat(160, '=== Adoulin Quests (%d/%d) ===':format(playertracker.adoulin_completed, playertracker.adoulin_total))
				util.log_tablog(tab_logs.adoulin.items)
				windower.add_to_chat(160, '=== Coalition Assignments (%d/%d) ===':format(playertracker.coalition_completed, playertracker.coalition_total))
				util.log_tablog(tab_logs.coalition.items)
				windower.add_to_chat(160, '=== Campaign Ops (%d/%d) ===':format(playertracker.campaign_completed, playertracker.campaign_total))
				util.log_tablog(tab_logs.campaign.items)
			elseif arg[2] == 'campaign' then
				windower.add_to_chat(160, '=== Campaign Ops (%d/%d) ===':format(playertracker.campaign_completed, playertracker.campaign_total))
				util.log_tablog(tab_logs.campaign.items)
			elseif quests_location:contains(arg[2]) then
				windower.add_to_chat(160, '=== '.. arg[2] ..' (%d/%d) ===':format(playertracker[arg[2]..'_completed'], playertracker[arg[2]..'_total']))
				util.log_tablog(tab_logs[arg[2]])
			elseif (arg[2] == 'main') or (arg[2] == 'summary') then
				for key, item in ipairs(tabs[1].items) do
					local text = item.text
					text = text:gsub('\\cs%(%d+,%d+,%d+%)', '')
					text = text:gsub('\\cr', '')
					windower.add_to_chat(160, text)
				end
			elseif (arg[2] == 'sheol') or (arg[2] == 'odyssey') then
				windower.add_to_chat(160, '=== Sheol A (%d/%d) ===':format(playertracker.sheola_completed, playertracker.sheola_total))
				util.log_tablog(tab_logs.sheola.items)
				windower.add_to_chat(160, '=== Sheol B (%d/%d) ===':format(playertracker.sheolb_completed, playertracker.sheolb_total))
				util.log_tablog(tab_logs.sheolb.items)
				windower.add_to_chat(160, '=== Sheol C (%d/%d) ===':format(playertracker.sheolc_completed, playertracker.sheolc_total))
				util.log_tablog(tab_logs.sheolc.items)
				windower.add_to_chat(160, '=== Sheol Gaol (%d/%d) ===':format(playertracker.sheolgaoltiers_completed, playertracker.sheolgaoltiers_total))
				util.log_tablog(tab_logs.sheolgaol.items)
			elseif tab_logs[arg[2]] then
				if not (arg[2] == 'titles_by_content') then
					windower.add_to_chat(160, '=== '.. tab_logs[arg[2]].name .. ' (%d/%d) ===':format(playertracker[arg[2]..'_completed'], playertracker[arg[2]..'_total']))
				end
				util.log_tablog(tab_logs[arg[2]].items)
			end
		else
			windower.add_to_chat(160, 'Must specify category')
			windower.add_to_chat(160, 'Example: //xic log '..string.color('titles', 221))
			windower.add_to_chat(160, 'Available categories: main summary titles titles_by_content roe monstrosity mmm meeble zones warps fish odyssey missions quests')
			windower.add_to_chat(160, 'homepoints survivalguides waypoints telepoints cavernousmaws lycopodium eschanportals outposts protowaypoints atmacite vorseals ergonlocus emporox')
			windower.add_to_chat(160, 'monsterlevels monstervariants racejobinstincts monsterinstincts mmmvouchers mmmrunes sheola sheolb sheolc sheolgaol')
			windower.add_to_chat(160, 'sandoria bastok windurst jeuno ahturhgan crystalwar outlands other abyssea adoulin coalition campaign')
			windower.add_to_chat(160, 'sandoriamissions bastokmissions windurstmissions zilartmissions ahturhganmissions wotgmissions copmissions acpmissions mkdmissions asamissions soamissions rovmissions tvrmissions')
		end
	end
end)

-- Init & Cleanup
addon_clear = function()
	playertracker = defaultplayertracker
	tab_logs = defaulttab_logs
	player = nil
	ui.menu:hide()
end

addon_init = function()
	addon_clear() -- clear on (re)load
	player = windower.ffxi.get_player()
	if not player then return end
	playertracker = config.load('data/'.. windower.ffxi.get_player().name .. '.xml', playertracker)
	xichecklist_updatemenulogs()
	if (trackermenusettings.visibility and player) then
		ui.menu:show()
	end
end

windower.register_event('load', 'login', 'logout', addon_init)
windower.register_event('logout', addon_clear)
windower.register_event('unload', function()
	ui.menu:destroy()
end)
