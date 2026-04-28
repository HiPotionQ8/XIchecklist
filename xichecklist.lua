_addon.name     = 'xichecklist'
_addon.author   = 'Anokata'
_addon.version  = '0.17.1'
_addon.commands = {'xichecklist', 'xic'}

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
trackermenusettings.chat_logroe = false -- true = display chat log when new RoE is completed (to track when a hidden RoE is completed)

trackermenusettings = config.load(trackermenusettings)

defaultplayertracker = {
	-- most initial values are zero, to be updated by addon
	['mastery_rank'] = 0,
	-- Missions
	['bastokmissions_completed'] = 0,
	['bastokmissions_total'] = 0,
	['sandoriamissions_completed'] = 0,
	['sandoriamissions_total'] = 0,
	['windurstmissions_completed'] = 0,
	['windurstmissions_total'] = 0,
	['zilartmissions_completed'] = 0,
	['zilartmissions_total'] = 0,
	['copmissions_completed'] = 0,
	['copmissions_total'] = 0,
	['ahturhganmissions_completed'] = 0,
	['ahturhganmissions_total'] = 0,
	['wotgmissions_completed'] = 0,
	['wotgmissions_total'] = 0,
	['acpmissions_completed'] = 0,
	['acpmissions_total'] = 0,
	['mkdmissions_completed'] = 0,
	['mkdmissions_total'] = 0,
	['asamissions_completed'] = 0,
	['asamissions_total'] = 0,
	['soamissions_completed'] = 0,
	['soamissions_total'] = 0,
	['rovmissions_completed'] = 0,
	['rovmissions_total'] = 0,
	['tvrmissions_completed'] = 0,
	['tvrmissions_total'] = 0,
	-- Quests
	['bastok_completed'] = 0,
	['bastok_total'] = 0,
	['sandoria_completed'] = 0,
	['sandoria_total'] = 0,
	['windurst_completed'] = 0,
	['windurst_total'] = 0,
	['jeuno_completed'] = 0,
	['jeuno_total'] = 0,
	['ahturhgan_completed'] = 0,
	['ahturhgan_total'] = 0,
	['crystalwar_completed'] = 0,
	['crystalwar_total'] = 0,
	['outlands_completed'] = 0,
	['outlands_total'] = 0,
	['other_completed'] = 0,
	['other_total'] = 0,
	['abyssea_completed'] = 0,
	['abyssea_total'] = 0,
	['adoulin_completed'] = 0,
	['adoulin_total'] = 0,
	['coalition_completed'] = 0,
	['coalition_total'] = 0,
	['campaign_completed'] = 0,
	['campaign_total'] = 0,
	-- Key items
	['Permanent_Key_Items_completed'] = 0,
	['Permanent_Key_Items_total'] = 0,
	['Magical_Maps_completed'] = 0,
	['Magical_Maps_total'] = 0,
	['Mounts_completed'] = 0,
	['Mounts_total'] = 0,
	['Claim_Slips_completed'] = 0,
	['Claim_Slips_total'] = 0,
	['Active_Effects_completed'] = 0,
	['Active_Effects_total'] = 0,
	['Voidwatch_completed'] = 0,
	['Voidwatch_total'] = 0,
	-- Magic
	['WhiteMagic_completed'] = 0,
	['WhiteMagic_total'] = 0,
	['BlackMagic_completed'] = 0,
	['BlackMagic_total'] = 0,
	['SummonerPact_completed'] = 0,
	['SummonerPact_total'] = 0,
	['Ninjutsu_completed'] = 0,
	['Ninjutsu_total'] = 0,
	['BardSong_completed'] = 0,
	['BardSong_total'] = 0,
	['BlueMagic_completed'] = 0,
	['BlueMagic_total'] = 0,
	['Geomancy_completed'] = 0,
	['Geomancy_total'] = 0,
	['Trust_completed'] = 0,
	['Trust_total'] = 0,
	-- Exp
	['Meritpoints_completed'] = 0,
	['Meritpoints_total'] = 919,
	['Jobpoints_completed'] = 0,
	['Jobpoints_total'] = 22,
	['Masterlevels_completed'] = 0,
	['Masterlevels_total'] = 1100,
	['Masterlevels_highest'] = 0,
	-- Warps
	['zones_completed'] = 0,
	['zones_total'] = 0,
	['homepoints_completed'] = 0,
	['homepoints_total'] = 0,
	['survivalguides_completed'] = 0,
	['survivalguides_total'] = 0,
	['waypoints_completed'] = 0,
	['waypoints_total'] = 0,
	['telepoints_completed'] = 0,
	['telepoints_total'] = 0,
	['cavernousmaws_completed'] = 0,
	['cavernousmaws_total'] = 9,
	['eschanportals_completed'] = 0,
	['eschanportals_total'] = 0,
	-- Monstrosity
	['Racejobinstinct_completed'] = 0,
	['Racejobinstinct_total'] = 0,
	['MonsterLevels_completed'] = 0,
	['MonsterLevels_total'] = 0,
	['MonsterVariants_completed'] = 0,
	['MonsterVariants_total'] = 0,
	['MonsterInsincts_completed'] = 0,
	['MonsterInsincts_total'] = 0,
	-- RoE
	['RoE_completed'] = 0,
	['RoE_total'] = 0,
	-- MMM
	['mmmvouchers_completed'] = 0,
	['mmmvouchers_total'] = 0,
	['mmmrunes_completed'] = 0,
	['mmmrunes_total'] = 0,
	-- NPC Menus
	['mmm_mazecount'] = 0,
	['wingskill_completed'] = 0,
	['wingskill_total'] = 100,
	['Titles_completed'] = 0,
	['Titles_total'] = 0,
	['outposts_completed'] = 0,
	['outposts_total'] = 0,
	['protowaypoints_completed'] = 0,
	['protowaypoints_total'] = 0,
	['fishes_completed'] = 0,
	['fishes_total'] = 164,
	['meebleburrows_completed'] = 0,
	['meebleburrows_total'] = 0,
	['craftingskills_completed'] = 0,
	['craftingskills_total'] = 790,
	['atmacite_completed'] = 0,
	['atmacite_total'] = 600,
	['sheola_completed'] = 0,
	['sheola_total'] = 0,
	['sheolb_completed'] = 0,
	['sheolb_total'] = 0,
	['sheolc_completed'] = 0,
	['sheolc_total'] = 0,
	['sheolgaoltiers_completed'] = 0,
	['sheolgaoltiers_total'] = 425,
	['vorseals_completed'] = 0,
	['vorseals_total'] = 0,
	titles = {}, -- {TitleId = true}
	roe = {}, -- {RoeId = true}
	outposts_unlocks = {}, -- {Menu Parameter Byte = true}
	protowaypoints_unlocks = {}, -- {Menu Parameter Byte = true}
	fishes_caught = {}, -- {Fish_ItemId = true}
	meeble_completed = {
		['Sauromugue_Champaign'] = {},
		['Batallia_Downs'] = {},
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
	},
}

defaulttab_logs = {
	quests = {
		sandoria = {},
		bastok = {},
		windurst = {},
		jeuno = {},
		ahturhgan = {},
		crystalwar = {},
		outlands = {},
		other = {},
		abyssea = {},
		adoulin = {},
		coalition = {},
		campaign2 = {},
		sandoriamissions = {},
		bastokmissions = {},
		windurstmissions = {},
		zilartmissions = {},
		ahturhganmissions = {},
		wotgmissions = {},
		copmissions = {},
		acpmissions = {},
		mkdmissions = {},
		asamissions = {},
		soamissions = {},
		rovmissions = {},
		tvrmissions = {},
	},
	atmacite = {},
	zones = {},
	homepoints = {},
	survivalguides = {},
	waypoints = {},
	telepoints = {},
	cavernousmaws = {},
	eschanportals = {},
	outposts = {},
	protowaypoints = {},
	titles = {},
	titles_by_content = {},
	fishes = {},
	monsterlevels = {},
	monstervariants = {},
	racejobinstincts = {},
	monster_instincts = {},
	roe = {},
	mmmvouchers = {},
	mmmrunes = {},
	meebleburrows = {},
	sheola = {},
	sheolb = {},
	sheolc = {},
	sheolgaol = {},
	vorseals = {},
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

function update_maintab()
	
	tabs[1].items = {}
	
	append_maintab('Checklist Progress %d/%d', util.totalpoints())
	table.insert(tabs[1].items, '======= General =======')
	append_maintab('Mastery Rank: %d', playertracker['mastery_rank'])
	append_maintab('RoE %d/%d', playertracker['RoE_completed'], playertracker['RoE_total'])
	append_maintab('Zones visited %d/%d', playertracker['zones_completed'], playertracker['zones_total'])
	
	table.insert(tabs[1].items, '======= Story =======')
	append_maintab('San d\'Oria Missions %d/%d', playertracker['sandoriamissions_completed'], playertracker['sandoriamissions_total'])
	append_maintab('Bastok Missions %d/%d', playertracker['bastokmissions_completed'], playertracker['bastokmissions_total'])
	append_maintab('Windurst Missions %d/%d', playertracker['windurstmissions_completed'], playertracker['windurstmissions_total'])
	append_maintab('Zilart Missions %d/%d', playertracker['zilartmissions_completed'], playertracker['zilartmissions_total'])
	append_maintab('CoP Missions %d/%d', playertracker['copmissions_completed'], playertracker['copmissions_total'])
	append_maintab('TOAU Missions %d/%d', playertracker['ahturhganmissions_completed'], playertracker['ahturhganmissions_total'])
	append_maintab('WOTG Missions %d/%d', playertracker['wotgmissions_completed'], playertracker['wotgmissions_total'])
	append_maintab('ACP Missions %d/%d', playertracker['acpmissions_completed'], playertracker['acpmissions_total'])
	append_maintab('MKD Missions %d/%d', playertracker['mkdmissions_completed'], playertracker['mkdmissions_total'])
	append_maintab('ASA Missions %d/%d', playertracker['asamissions_completed'], playertracker['asamissions_total'])
	append_maintab('SoA Missions %d/%d', playertracker['soamissions_completed'], playertracker['soamissions_total'])
	append_maintab('RoV Missions %d/%d', playertracker['rovmissions_completed'], playertracker['rovmissions_total'])
	append_maintab('TVR Missions %d/%d', playertracker['tvrmissions_completed'], playertracker['tvrmissions_total'])
	append_maintab('Campaign Ops %d/%d', playertracker['campaign_completed'], playertracker['campaign_total'])
	append_maintab('Bastok Quests %d/%d', playertracker['bastok_completed'], playertracker['bastok_total'])
	append_maintab('San d\'Oria Quests %d/%d', playertracker['sandoria_completed'], playertracker['sandoria_total'])
	append_maintab('Windurst Quests %d/%d', playertracker['windurst_completed'], playertracker['windurst_total'])
	append_maintab('Jeuno Quests %d/%d', playertracker['jeuno_completed'], playertracker['jeuno_total'])
	append_maintab('Aht Urhgan Quests %d/%d', playertracker['ahturhgan_completed'], playertracker['ahturhgan_total'])
	append_maintab('Crystal War Quests %d/%d', playertracker['crystalwar_completed'], playertracker['crystalwar_total'])
	append_maintab('Outlands Quests %d/%d', playertracker['outlands_completed'], playertracker['outlands_total'])
	append_maintab('Other Quests %d/%d', playertracker['other_completed'], playertracker['other_total'])
	append_maintab('Abyssea Quests %d/%d', playertracker['abyssea_completed'], playertracker['abyssea_total'])
	append_maintab('Adoulin Quests %d/%d', playertracker['adoulin_completed'], playertracker['adoulin_total'])
	append_maintab('Coalition Assignments %d/%d', playertracker['coalition_completed'], playertracker['coalition_total'])
	
	table.insert(tabs[1].items, '======= Key Items =======')
	append_maintab('Permanent Key Items %d/%d', playertracker['Permanent_Key_Items_completed'], playertracker['Permanent_Key_Items_total'])
	append_maintab('Magical Maps %d/%d', playertracker['Magical_Maps_completed'], playertracker['Magical_Maps_total'])
	append_maintab('Mounts %d/%d', playertracker['Mounts_completed'], playertracker['Mounts_total'])
	append_maintab('Claim Slips %d/%d', playertracker['Claim_Slips_completed'], playertracker['Claim_Slips_total'])
	append_maintab('Active Effects %d/%d', playertracker['Active_Effects_completed'], playertracker['Active_Effects_total'])
	append_maintab('Atmacite Levels %d/%d', playertracker['atmacite_completed'], playertracker['atmacite_total'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Atmacite Refiner\\cr \\cs(50,150,255)(Menu: Enrich Atmas)\\cr', playertracker.talk_to_npc['atmacite_refiner'])
	
	table.insert(tabs[1].items, '======= Magic =======')
	append_maintab('White Magic %d/%d', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
	append_maintab('Black Magic %d/%d', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
	append_maintab('Summoner Pacts %d/%d', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
	append_maintab('Ninjutsu %d/%d', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
	append_maintab('Bard Songs %d/%d', playertracker['BardSong_completed'], playertracker['BardSong_total'])
	append_maintab('Blue Magic %d/%d', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
	append_maintab('Geomancy %d/%d', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
	append_maintab('Trusts %d/%d', playertracker['Trust_completed'], playertracker['Trust_total'])

	table.insert(tabs[1].items, '======= Leveling =======')
	append_maintab('Craft Skills %d/%d', playertracker['craftingskills_completed'], 790)
	append_maintab('Wing Skill %d/%d', playertracker['wingskill_completed'], 100)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Chocobo stats NPC\\cr @ \\cs(50,150,255)Nations Chocobo Stables\\cr', playertracker.talk_to_npc['chocobokid'])
	append_maintab('Merit Points %d/%d', playertracker['Meritpoints_completed'], 919)
	append_maintab('Job Points Maxed %d/%d', playertracker['Jobpoints_completed'], 22)
	append_maintab('Master Levels %d/%d (Highest: %d)', playertracker['Masterlevels_completed'], 1100, playertracker['Masterlevels_highest'])
	
	table.insert(tabs[1].items, '======= Warps =======')
	append_maintab('Home Points %d/%d', playertracker['homepoints_completed'], playertracker['homepoints_total'])
	append_maintab('Survival Guides %d/%d', playertracker['survivalguides_completed'], playertracker['survivalguides_total'])
	append_maintab('Waypoints %d/%d', playertracker['waypoints_completed'], playertracker['waypoints_total'])
	append_maintab('Telepoints %d/%d', playertracker['telepoints_completed'], playertracker['telepoints_total'])
	append_maintab('WoTG Unlocks %d/%d', playertracker['cavernousmaws_completed'], playertracker['cavernousmaws_total'])
	append_maintab('Eschan Portals %d/%d', playertracker['eschanportals_completed'], playertracker['eschanportals_total'])
	append_maintab('Outposts %d/%d', playertracker['outposts_completed'], playertracker['outposts_total'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Outpost Teleporter NPC\\cr @ \\cs(50,150,255)three nations\\cr.', playertracker.talk_to_npc['outpostnpc'])
	append_maintab('Proto-Waypoints %d/%d', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Proto-Waypoint\\cr.', playertracker.talk_to_npc['protowaypoint'])
	
	table.insert(tabs[1].items, '======= Fishing =======')
	append_maintab('Fishes Caught %d/%d', playertracker['fishes_completed'], 164)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Katsunaga\\cr @ \\cs(50,150,255)Mhuaura (H-9)\\cr \\cs(255,255,255)(Menu: Types of fishes caught)\\cr', playertracker.talk_to_npc['katsunaga'])
	
	table.insert(tabs[1].items, '======= Monstrosity =======')
	append_maintab('Monster Levels %d/%d', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
	append_maintab('Race/Job Instincts %d/%d', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
	append_maintab('Monster Variants %d/%d', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
	append_maintab('Monster Instincts %d/%d', playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total'])
	
	table.insert(tabs[1].items, '======= Battle Content =======')
	append_maintab('MMM Vouchers Unlocked %d/%d', playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total'])
	append_maintab('MMM Runes Unlocked %d/%d', playertracker['mmmrunes_completed'], playertracker['mmmrunes_total'])
	append_maintab('MMM Maze count %d', playertracker['mmm_mazecount'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Chatnachoq\\cr @ \\cs(50,150,255)Lower Jeuno (H-9) \\cr', playertracker.talk_to_npc['chatnachoq'])
	append_maintab('Meeble Burrows Goal #3 %d/%d', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp(1, 'Menu: Review expedition specifics -> \\cs(255,255,255)Sauromugue Champaign\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_batallia'])
	append_addonhelp(1, 'Menu: Review expedition specifics -> \\cs(255,255,255)Batallia Downs\\cr', playertracker.talk_to_npc['meeble_batallia'])
	append_maintab('Sheol A (%d/%d)', playertracker['sheola_completed'], playertracker['sheola_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc['sheola'])
	append_maintab('Sheol B (%d/%d)', playertracker['sheolb_completed'], playertracker['sheolb_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc['sheolb'])
	append_maintab('Sheol C (%d/%d)', playertracker['sheolc_completed'], playertracker['sheolc_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc['sheolc'])
	append_maintab('Sheol Gaol Vengeance (%d/%d)', playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Sheol Gaol)', playertracker.talk_to_npc['sheolgaol'])
	append_maintab('Eschan Vorseals (%d/%d)', playertracker['vorseals_completed'], playertracker['vorseals_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Shiftrix\\cr @ \\cs(50,150,255)Reisenjima (F-12)\\cr', playertracker.talk_to_npc['vorseals'])
	
	table.insert(tabs[1].items, '======= Titles =======')
	append_maintab('Titles %d/%d', playertracker['Titles_completed'], playertracker['Titles_total'])
	append_items(tabs[1].items, tab_logs.titles_by_content)
end

windower.register_event('incoming chunk', function(id, data, modified, injected, blocked)
	if injected then return end
	
	-- do visited zones
	if (id == 0x008) then
		tab_logs.zones = warps_util.log_visitedzones(data)
	end
	
	if id == 0x01B then
		local parseddata = packets.parse('incoming', data)
		if (parseddata['Mastery Rank'] > playertracker['mastery_rank']) then
			if (playertracker['mastery_rank'] > 0) then
				util.addon_log('Mastery Rank increase: '..parseddata['Mastery Rank'])
			end
			playertracker['mastery_rank'] = parseddata['Mastery Rank']
			playertracker:save()
		elseif (parseddata['Mastery Rank'] < playertracker['mastery_rank']) then
			util.addon_log('Mastery Rank decrease: '..parseddata['Mastery Rank'])
			playertracker['mastery_rank'] = parseddata['Mastery Rank']
			playertracker:save()
		end
	end
	
	-- do quests
	if id == 0x056 then
		local p = packets.parse('incoming', data)
		local log = quest_logs[p.Type]
		if log then
			if (p.Type == 128) then -- if Aht Urhgan Current Quests
				quests[log.type][log.area] = p["Current TOAU Quests"]
			elseif (p.Type == 192) then -- if Aht Urhgan Completed Quests
				quests[log.type][log.area] = p["Completed TOAU Quests"]
				tab_logs.quests[log.area] = quest_util.log_quests(log.area)
			elseif (p.Type == 208) then -- if Nation, Zilart Completed Missions
				quests.completed['sandoriamissions'] = p['Completed San d\'Oria Missions']
				quests.completed['bastokmissions'] = p['Completed Bastok Missions']
				quests.completed['windurstmissions'] = p['Completed Windurst Missions']
				quests.completed['zilartmissions'] = p['Completed Zilart Missions']
				tab_logs.quests['sandoriamissions'] = quest_util.log_quests('sandoriamissions')
				tab_logs.quests['bastokmissions'] = quest_util.log_quests('bastokmissions')
				tab_logs.quests['windurstmissions'] = quest_util.log_quests('windurstmissions')
				tab_logs.quests['zilartmissions'] = quest_util.log_quests('zilartmissions')
			elseif (p.Type == 216) then -- if TOAU, WOTG Completed Missions
				quests.completed['ahturhganmissions'] = p['Completed TOAU Missions']
				quests.completed['wotgmissions'] = p['Completed WOTG Missions']
				tab_logs.quests['ahturhganmissions'] = quest_util.log_quests('ahturhganmissions')
				tab_logs.quests['wotgmissions'] = quest_util.log_quests('wotgmissions')
			elseif (p.Type == 65534) then -- if TVR Current Missions
				tab_logs.quests['tvrmissions'] = quest_util.log_missions('tvrmissions', p['Current TVR Mission'])
			elseif (p.Type == 65535) then -- if Other Current Missions
				tab_logs.quests['copmissions'] = quest_util.log_missions('copmissions', p['Current COP Mission'])
				tab_logs.quests['acpmissions'] = quest_util.log_missions('acpmissions', p['Current ACP Mission'])
				tab_logs.quests['mkdmissions'] = quest_util.log_missions('mkdmissions', p['Current MKD Mission'])
				tab_logs.quests['asamissions'] = quest_util.log_missions('asamissions', p['Current ASA Mission'])
				tab_logs.quests['soamissions'] = quest_util.log_missions('soamissions', p['Current SOA Mission'])
				tab_logs.quests['rovmissions'] = quest_util.log_missions('rovmissions', p['Current ROV Mission'])
			else
				quests[log.type][log.area] = p['Quest Flags']
				tab_logs.quests[log.area] = quest_util.log_quests(log.area)
			end
		end
		xichecklist_updatetabs('quests')
    end
	
	-- crafting skills
	if id == 0x062 then
		local p = packets.parse('incoming', data)
		playertracker['craftingskills_completed'] = p['Fishing Level']+p['Woodworking Level']+p['Smithing Level']+p['Goldsmithing Level']+p['Clothcraft Level']
		+p['Leathercraft Level']+p['Bonecraft Level']+p['Alchemy Level']+p['Cooking Level']+p['Synergy Level']
	end
	
	if id == 0x063 then
		local parseddata = packets.parse('incoming', data)
		-- do warps
		if (parseddata.Order == 6) then 
			warps_util.warps_data = data
			tab_logs.homepoints = warps_util.log_warps('homepoints')
			tab_logs.survivalguides = warps_util.log_warps('survivalguides')
			tab_logs.waypoints = warps_util.log_warps('waypoints')
			tab_logs.telepoints = warps_util.log_warps('telepoints')
			tab_logs.cavernousmaws = warps_util.log_warps('cavernousmaws')
			tab_logs.eschanportals = warps_util.log_warps('eschanportals')
			xichecklist_updatetabs('warps')
		end
		-- do monstrosity
		if (parseddata.Order == 3) then
			mons_util.monster_levelspacket[1] = parseddata['Monster Level Char field']
			mons_util.monster_instincts = util.twobits_to_table(parseddata['Instinct Bitfield 1'])
			tab_logs.monsterlevels = mons_util.log_monsterlevels()
			tab_logs.monster_instincts = mons_util.log_monsterinstincts()
			xichecklist_updatetabs('monstrosity')
		end
		if (parseddata.Order == 4) then
			mons_util.monster_levelspacket[2] = data:sub(0x08+1, 0x87+1)
			mons_util.racejobinstincts = parseddata['Instinct Bitfield 3']
			mons_util.variants_bitfield = parseddata['Variants Bitfield']
			tab_logs.monsterlevels = mons_util.log_monsterlevels()
			tab_logs.monstervariants = mons_util.log_variants()
			tab_logs.racejobinstincts = mons_util.log_racejobinstincts()
			xichecklist_updatetabs('monstrosity')
		end
	end
	
	-- handle npc menu
	if (id == 0x033) or (id == 0x034) then
		menus_util.handle_npc_menu(data)
		xichecklist_updatemenulogs()
	elseif id == 0x061 then
		-- check player info (updated when openning menu)
		local parseddata = packets.parse('incoming', data)
		menus_util.add_title(parseddata['Title'])
		xichecklist_updatemenulogs()
	end
	
	if id == 0x05C then
		if menu_current.npcindex then menus_util.handle_npc_submenu(data) end
		xichecklist_updatemenulogs()
	end
	
	-- do RoE
	if id == 0x112 then
		if (not roe_data) then roe_data = '' end
		local parseddata = packets.parse('incoming', data)
		roe_data = roe_data .. parseddata['RoE Quest Bitfield'] -- the packet will be repeated three times, gather the data first
		if (parseddata.Order == 3) then
			roe_util.handle_roe_data(data)
			roe_data = nil -- reset
			xichecklist_updatetabs('roe')
		end
	end
	
	-- do MMM
	if id == 0x0AD then
		local parseddata = packets.parse('incoming', data)
		mmm_util.handle_mmm_data(data)
		tab_logs.mmmvouchers = mmm_util.log_vouchers()
		tab_logs.mmmrunes = mmm_util.log_runes()
		xichecklist_updatetabs('battlecontent')
	end
	
	if id == 0x052 then
		-- claer npc menu
		menus_util.reset_current_menu()
	end

	throttled_update()
end)

THROTTLED = false
function throttled_update()
	if THROTTLED then return end
	THROTTLED = true
	coroutine.sleep(0.1)
	-- Drop errors on the ground so we're never locked in THROTTLED = true
	pcall(function ()
		update_maintab()
		--xichecklist_updatetabs()
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

function xichecklist_updatemenulogs()
	tab_logs.outposts = menus_util.log_outposts()
	tab_logs.protowaypoints = menus_util.log_protowaypoints()
	tab_logs.fishes = menus_util.log_fishes()
	tab_logs.atmacite = menus_util.log_atmacitelevels()
	tab_logs.meebleburrows = menus_util.log_meeble_burrows()
	tab_logs.titles = menus_util.log_titles()
	tab_logs.titles_by_content = menus_util.list_titles_bycontent()
	tab_logs.sheola = menus_util.log_sheolabc('sheola')
	tab_logs.sheolb = menus_util.log_sheolabc('sheolb')
	tab_logs.sheolc = menus_util.log_sheolabc('sheolc')
	tab_logs.sheolgaol = menus_util.log_sheolgaol()
	tab_logs.vorseals = menus_util.log_vorseals()
end

function xichecklist_updatetabs(tab)
	if not player then return false end
	tabs[4].items = {} -- reset tab content
	tabs[5].items = {} -- reset tab content
	tabs[6].items = {} -- reset tab content
	tabs[7].items = {} -- reset tab content
	tabs[9].items = {} -- reset tab content
	
	if (tab == 'quests') then
		tabs[2].items = {} -- reset tab content
		tabs[3].items = {} -- reset tab content
		-- log quests
		append_header(2, 'San d\'Oria Missions (%d/%d)', playertracker['sandoriamissions_completed'], playertracker['sandoriamissions_total'])
		append_items(tabs[2].items, tab_logs.quests['sandoriamissions'])
		append_header(2, 'Bastok Missions (%d/%d)', playertracker['bastokmissions_completed'], playertracker['bastokmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['bastokmissions'])
		append_header(2, 'Windurst Missions (%d/%d)', playertracker['windurstmissions_completed'], playertracker['windurstmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['windurstmissions'])
		append_header(2, 'Zilart Missions (%d/%d)', playertracker['zilartmissions_completed'], playertracker['zilartmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['zilartmissions'])
		append_header(2, 'CoP Missions (%d/%d)', playertracker['copmissions_completed'], playertracker['copmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['copmissions'])
		append_header(2, 'TOAU Missions (%d/%d)', playertracker['ahturhganmissions_completed'], playertracker['ahturhganmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['ahturhganmissions'])
		append_header(2, 'WOTG Missions (%d/%d)', playertracker['wotgmissions_completed'], playertracker['wotgmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['wotgmissions'])
		append_header(2, 'ACP Missions (%d/%d)', playertracker['acpmissions_completed'], playertracker['acpmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['acpmissions'])
		append_header(2, 'MKD Missions (%d/%d)', playertracker['mkdmissions_completed'], playertracker['mkdmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['mkdmissions'])
		append_header(2, 'ASA Missions (%d/%d)', playertracker['asamissions_completed'], playertracker['asamissions_total'])
		append_items(tabs[2].items, tab_logs.quests['asamissions'])
		append_header(2, 'SoA Missions (%d/%d)', playertracker['soamissions_completed'], playertracker['soamissions_total'])
		append_items(tabs[2].items, tab_logs.quests['soamissions'])
		append_header(2, 'RoV Missions (%d/%d)', playertracker['rovmissions_completed'], playertracker['rovmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['rovmissions'])
		append_header(2, 'TVR Missions (%d/%d)', playertracker['tvrmissions_completed'], playertracker['tvrmissions_total'])
		append_items(tabs[2].items, tab_logs.quests['tvrmissions'])
		append_header(2, 'San d\'Oria Quests (%d/%d)', playertracker['sandoria_completed'], playertracker['sandoria_total'])
		append_items(tabs[2].items, tab_logs.quests['sandoria'])
		append_header(2, 'Bastok Quests (%d/%d)', playertracker['bastok_completed'], playertracker['bastok_total'])
		append_items(tabs[2].items, tab_logs.quests['bastok'])
		append_header(2, 'Windurst Quests (%d/%d)', playertracker['windurst_completed'], playertracker['windurst_total'])
		append_items(tabs[2].items, tab_logs.quests['windurst'])
		append_header(2, 'Jeuno Quests (%d/%d)', playertracker['jeuno_completed'], playertracker['jeuno_total'])
		append_items(tabs[2].items, tab_logs.quests['jeuno'])
		append_header(2, 'Aht Urhgan Quests (%d/%d)', playertracker['ahturhgan_completed'], playertracker['ahturhgan_total'])
		append_items(tabs[2].items, tab_logs.quests['ahturhgan'])
		append_header(2, 'Crystal War Quests (%d/%d)', playertracker['crystalwar_completed'], playertracker['crystalwar_total'])
		append_items(tabs[2].items, tab_logs.quests['crystalwar'])
		append_header(2, 'Outlands Quests (%d/%d)', playertracker['outlands_completed'], playertracker['outlands_total'])
		append_items(tabs[2].items, tab_logs.quests['outlands'])
		append_header(2, 'Other Quests (%d/%d)', playertracker['other_completed'], playertracker['other_total'])
		append_items(tabs[2].items, tab_logs.quests['other'])
		append_header(2, 'Abyssea Quests (%d/%d)', playertracker['abyssea_completed'], playertracker['abyssea_total'])
		append_items(tabs[2].items, tab_logs.quests['abyssea'])
		append_header(2, 'Adoulin Quests (%d/%d)', playertracker['adoulin_completed'], playertracker['adoulin_total'])
		append_items(tabs[2].items, tab_logs.quests['adoulin'])
		append_header(2, 'Coalition Assignments (%d/%d)', playertracker['coalition_completed'], playertracker['coalition_total'])
		append_items(tabs[2].items, tab_logs.quests['coalition'])
		-- log campaign ops
		append_header(3, 'Campaign Ops (%d/%d)', playertracker['campaign_completed'], playertracker['campaign_total'])
		append_items(tabs[3].items, tab_logs.quests['campaign2'])
	end
	
	-- log fishes caught
	append_header(4, 'Type of Fishes Caught (%d/%d)', playertracker['fishes_completed'], playertracker['fishes_total'])
	append_addonhelp(4, 'You must talk to \\cs(255,255,255)Katsunaga\\cr @ \\cs(50,150,255)Mhuaura (H-9)\\cr \\cs(255,255,255)(Menu: Types of fishes caught)\\cr', playertracker.talk_to_npc['katsunaga'])
	append_items(tabs[4].items, tab_logs.fishes)
	
	-- log keyitems
	append_header(5, 'Permanent Key Items (%d/%d)', playertracker['Permanent_Key_Items_completed'], playertracker['Permanent_Key_Items_total'])
	append_items(tabs[5].items, check_keyitems('Permanent Key Items'))
	append_header(5, 'Magical Maps (%d/%d)', playertracker['Magical_Maps_completed'], playertracker['Magical_Maps_total'])
	append_items(tabs[5].items, check_keyitems('Magical Maps'))
	append_header(5, 'Mounts (%d/%d)', playertracker['Mounts_completed'], playertracker['Mounts_total'])
	append_items(tabs[5].items, check_keyitems('Mounts'))
	append_header(5, 'Active Effects (%d/%d)', playertracker['Active_Effects_completed'], playertracker['Active_Effects_total'])
	append_items(tabs[5].items, check_keyitems('Active Effects'))
	append_header(5, 'Voidwatch Key Items (%d/%d)', playertracker['Voidwatch_completed'], playertracker['Voidwatch_total'])
	append_items(tabs[5].items, check_keyitems('Voidwatch'))
	append_header(5, 'Atmacite Levels (%d/%d)', playertracker['atmacite_completed'], playertracker['atmacite_total'])
	append_addonhelp(5, 'You must talk to any \\cs(255,255,255)Atmacite Refiner\\cr \\cs(50,150,255)(Menu: Enrich Atmas)\\cr', playertracker.talk_to_npc['atmacite_refiner'])
	append_items(tabs[5].items, tab_logs.atmacite)
	append_header(5, 'Claim Slips (%d/%d)', playertracker['Claim_Slips_completed'], playertracker['Claim_Slips_total'])
	append_items(tabs[5].items, check_keyitems('Claim Slips'))
	
	-- log spells and trusts
	append_header(6, 'White Magic (%d/%d)', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
	append_items(tabs[6].items, log_spells('WhiteMagic'))
	append_header(6, 'Black Magic (%d/%d)', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
	append_items(tabs[6].items, log_spells('BlackMagic'))
	append_header(6, 'Summoner Pacts (%d/%d)', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
	append_items(tabs[6].items, log_spells('SummonerPact'))
	append_header(6, 'Ninjutsu (%d/%d)', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
	append_items(tabs[6].items, log_spells('Ninjutsu'))
	append_header(6, 'Bard Songs (%d/%d)', playertracker['BardSong_completed'], playertracker['BardSong_total'])
	append_items(tabs[6].items, log_spells('BardSong'))
	append_header(6, 'Blue Magic (%d/%d)', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
	append_items(tabs[6].items, log_spells('BlueMagic'))
	append_header(6, 'Geomancy (%d/%d)', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
	append_items(tabs[6].items, log_spells('Geomancy'))
	append_header(6, 'Trust Magic (%d/%d)', playertracker['Trust_completed'], playertracker['Trust_total'])
	append_items(tabs[6].items, log_spells('Trust'))
	
	-- log warps
	append_header(7, 'Home Points (%d/%d)', playertracker['homepoints_completed'], playertracker['homepoints_total'])
	append_items(tabs[7].items, tab_logs.homepoints)
	append_header(7, 'Survival Guides (%d/%d)', playertracker['survivalguides_completed'], playertracker['survivalguides_total'])
	append_items(tabs[7].items, tab_logs.survivalguides)
	append_header(7, 'Adoulin Waypoints (%d/%d)', playertracker['waypoints_completed'], playertracker['waypoints_total'])
	append_items(tabs[7].items, tab_logs.waypoints)
	append_header(7, 'Telepoints (%d/%d)', playertracker['telepoints_completed'], playertracker['telepoints_total'])
	append_items(tabs[7].items, tab_logs.telepoints)
	append_header(7, 'WoTG Unlocks (%d/%d)', playertracker['cavernousmaws_completed'], playertracker['cavernousmaws_total'])
	append_items(tabs[7].items, tab_logs.cavernousmaws)
	append_header(7, 'Eschan Portals (%d/%d)', playertracker['eschanportals_completed'], playertracker['eschanportals_total'])
	append_items(tabs[7].items, tab_logs.eschanportals)
	append_header(7, 'Outpost Warps (%d/%d)', playertracker['outposts_completed'], playertracker['outposts_total'])
	append_addonhelp(7, 'You must talk to any \\cs(255,255,255)Outpost Teleporter NPC\\cr @ \\cs(50,150,255)three nations\\cr.', playertracker.talk_to_npc['outpostnpc'])
	append_items(tabs[7].items, tab_logs.outposts)
	append_header(7, 'Proto-Waypoints (%d/%d)', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
	append_addonhelp(7, 'You must talk to any \\cs(255,255,255)Proto-Waypoint\\cr.', playertracker.talk_to_npc['protowaypoint'])
	append_items(tabs[7].items, tab_logs.protowaypoints)
	append_header(7, 'Zones visited (%d/%d)', playertracker['zones_completed'], playertracker['zones_total'])
	append_items(tabs[7].items, tab_logs.zones)
	
	-- Log Job Points Spent
	check_exp()
	
	-- log Monstrosity levels & Race/Job Instincts
	if (tab == 'monstrosity') then
		tabs[8].items = {}
		append_header(8, 'Species Levels (%d/%d)', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
		append_items(tabs[8].items, tab_logs.monsterlevels)
		append_header(8, 'Monster Variants (%d/%d)', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
		append_items(tabs[8].items, tab_logs.monstervariants)
		append_header(8, 'Race / Job Instincts (%d/%d)', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
		append_items(tabs[8].items, tab_logs.racejobinstincts)
		append_header(8, 'Monster Instincts (%d/%d)', playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total'])
		append_items(tabs[8].items, tab_logs.monster_instincts)
	end
	
	-- log Titles
	append_header(9, 'Titles (%d/%d)', playertracker['Titles_completed'], playertracker['Titles_total'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Aligi-Kufongi\\cr @ \\cs(50,150,255)Tavnazian Safehold (H-9)\\cr', playertracker.talk_to_npc['Aligi-Kufongi'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Koyol-Futenol\\cr @ \\cs(50,150,255)Aht Urhgan Whitegate (E-9)\\cr', playertracker.talk_to_npc['Koyol-Futenol'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Tamba-Namba\\cr @ \\cs(50,150,255)Southern San d\'Oria (S) (L-8)\\cr', playertracker.talk_to_npc['Tamba-Namba'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Bhio Fehriata\\cr @ \\cs(50,150,255)Bastok Markets (S) (I-10)\\cr', playertracker.talk_to_npc['Bhio_Fehriata'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Cattah Pamjah\\cr @ \\cs(50,150,255)Windurst Waters (S) (G-10)\\cr', playertracker.talk_to_npc['Cattah_Pamjah'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Moozo-Koozo\\cr @ \\cs(50,150,255)Southern San d\'Oria (K-6)\\cr', playertracker.talk_to_npc['Moozo-Koozo'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Styi Palneh\\cr @ \\cs(50,150,255)Port Bastok (I-7)\\cr', playertracker.talk_to_npc['Styi_Palneh'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Burute-Sorute\\cr @ \\cs(50,150,255)Windurst Walls (H-10)\\cr', playertracker.talk_to_npc['Burute-Sorute'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Tuh Almobankha\\cr @ \\cs(50,150,255)Lower Jeuno (I-8)\\cr', playertracker.talk_to_npc['Tuh_Almobankha'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Zuah Lepahnyu\\cr @ \\cs(50,150,255)Port Jeuno (J-8)\\cr', playertracker.talk_to_npc['Zuah_Lepahnyu'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Shupah Mujuuk\\cr @ \\cs(50,150,255)Rabao (G-8)\\cr', playertracker.talk_to_npc['Shupah_Mujuuk'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Yulon-Polon\\cr @ \\cs(50,150,255)Selbina (I-9)\\cr', playertracker.talk_to_npc['Yulon-Polon'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Willah Maratahya\\cr @ \\cs(50,150,255)Mhaura (I-8)\\cr', playertracker.talk_to_npc['Willah_Maratahya'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Eron-Tomaron\\cr @ \\cs(50,150,255)Kazham (G-7)\\cr', playertracker.talk_to_npc['Eron-Tomaron'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Quntsu-Nointsu\\cr @ \\cs(50,150,255)Norg (G-7)\\cr', playertracker.talk_to_npc['Quntsu-Nointsu'])
	append_addonhelp(9, 'You must talk to \\cs(255,255,255)Debadle-Levadle\\cr @ \\cs(50,150,255)Western Adoulin (H-8)\\cr', playertracker.talk_to_npc['Debadle-Levadle'])
	append_items(tabs[9].items, tab_logs.titles)
	
	-- log RoE
	if (tab == 'roe') then
		tabs[10].items = {}
		append_header(10, 'RoE (%d/%d)', playertracker['RoE_completed'], playertracker['RoE_total'])
		append_items(tabs[10].items, roe_util.log_roe())
	end
	
	if (tab == 'battlecontent') then
		tabs[11].items = {}
		-- log MMM
		append_header(11, 'MMM Vouchers Unlocks (%d/%d)', playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total'])
		append_items(tabs[11].items, tab_logs.mmmvouchers)
		append_header(11, 'MMM Runes Unlocks (%d/%d)', playertracker['mmmrunes_completed'], playertracker['mmmrunes_total'])
		append_items(tabs[11].items, tab_logs.mmmrunes)
		-- log Meeble Burrows
		append_header(11, 'Meeble Burrows (%d/%d)', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp(11, 'Menu: Review expedition specifics -> \\cs(255,255,255)Sauromugue Champaign\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_batallia'])
		append_addonhelp(11, 'Menu: Review expedition specifics -> \\cs(255,255,255)Batallia Downs\\cr', playertracker.talk_to_npc['meeble_batallia'])
		append_items(tabs[11].items, tab_logs.meebleburrows)
		-- Log Sheol ABC goals & Gaol Vengeance Tiers
		append_header(11, 'Sheol A goals (%d/%d)', playertracker['sheola_completed'], playertracker['sheola_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc['sheola'])
		append_items(tabs[11].items, tab_logs.sheola)
		append_header(11, 'Sheol B goals (%d/%d)', playertracker['sheolb_completed'], playertracker['sheolb_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc['sheolb'])
		append_items(tabs[11].items, tab_logs.sheolb)
		append_header(11, 'Sheol C goals (%d/%d)', playertracker['sheolc_completed'], playertracker['sheolc_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Moogle Mastery)', playertracker.talk_to_npc['sheolc'])
		append_items(tabs[11].items, tab_logs.sheolc)
		append_header(11, 'Sheol Gaol Vengeance (%d/%d)', playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)???\\cr @ \\cs(50,150,255)Rabao (I-8)\\cr (Status Report: Sheol Gaol)', playertracker.talk_to_npc['sheolgaol'])
		append_items(tabs[11].items, tab_logs.sheolgaol)
		append_header(11, 'Eschan Vorseals (%d/%d)', playertracker['vorseals_completed'], playertracker['vorseals_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)Shiftrix\\cr @ \\cs(50,150,255)Reisenjima (F-12)\\cr', playertracker.talk_to_npc['vorseals'])
		append_items(tabs[11].items, tab_logs.vorseals)
	end
end

function check_keyitems(keyitemtype)
	local output_list = {}
	local keyitem_exclusions = require('maps/keyitems_exclusions')
	local excluded = keyitem_exclusions.excluded
	local hidden = keyitem_exclusions.hidden
	if not trackermenusettings.showexcluded then hidden = S{} end
	local playerkeyitems = windower.ffxi.get_key_items()
	local total, obtained = 0, 0
	for id, keyitem in pairs(res.key_items) do
		if (keyitem.category == keyitemtype and (not excluded:contains(id)) and (not hidden:contains(id))) then
			total = total + 1
			local completion = false
			if table.find(playerkeyitems, id) then
				-- key item obtained
				obtained = obtained + 1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, keyitem.en, completion))
		end
	end
	playertracker[util.cleanspaces(keyitemtype)..'_completed'] = obtained
	playertracker[util.cleanspaces(keyitemtype)..'_total'] = total
	return output_list
end

function log_spells(spelltype)
	local output_list = {}
	local spells_exclusions = require('maps/spells_exclusions')
	local playerspells = windower.ffxi.get_spells()
	local total, obtained = 0, 0
	for id, spell in pairs(res.spells) do
		local completion = false
		if ((spell.type == spelltype) and (not spell.unlearnable) and (not spells_exclusions[id])) then
			total = total + 1
			if (playerspells[id] == true) then
				-- spell learned
				obtained = obtained + 1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, spell.en, completion))
		end
	end
	playertracker[spelltype..'_completed'] = obtained
	playertracker[spelltype..'_total'] = total
	return output_list
end

function check_exp()
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
	playertracker['Meritpoints_completed'] = total_merit_upgrades
	-- job points
	if (type(playerinfo.job_points) == 'table') then 
		for job, value in pairs(playerinfo.job_points) do
			total_jp_spent = total_jp_spent + playerinfo.job_points[job].jp_spent
		end
	end
	playertracker['Jobpoints_completed'] = math.floor(total_jp_spent/2100)
	playertracker['Jobpoints_total'] = 22
	-- master levels
	if (type(playerinfo.master_levels) == 'table') then 
		for job, value in pairs(playerinfo.master_levels) do
			total_master_levels = total_master_levels + playerinfo.master_levels[job]
			if (playerinfo.master_levels[job] > highest_master_level) then highest_master_level = playerinfo.master_levels[job] end
		end
	end
	playertracker['Masterlevels_completed'] = total_master_levels
	playertracker['Masterlevels_highest'] = highest_master_level
end

draw()

windower.register_event('addon command', function(...)
	local quests_location = S{'sandoria', 'bastok', 'windurst', 'jeuno', 'ahturhgan', 'crystalwar', 'outlands', 'other', 'abyssea', 'adoulin', 'coalition', 'sandoriamissions', 'bastokmissions', 'windurstmissions', 'zilartmissions', 'ahturhganmissions', 'wotgmissions', 'copmissions', 'acpmissions', 'mkdmissions', 'asamissions', 'soamissions', 'rovmissions', 'tvrmissions'}
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
	elseif cmds.show:contains(arg[1]) then
		trackermenusettings.visibility = true
		trackermenusettings:save()
		draw()
		ui:show()
	elseif cmds.hide:contains(arg[1]) then
		trackermenusettings.visibility = false
		trackermenusettings:save()
		ui:hide()
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
		windower.copy_to_clipboard(util.table_to_clipboard(tabs[active_tab].items))
		windower.add_to_chat(100, 'Copy to clipboard')
	elseif cmds.scale:contains(arg[1]) then
		NEW_UISCALE 	= tonumber(arg[2]) or 1
		FONT_SIZE		= (FONT_SIZE/UI_SCALE) * NEW_UISCALE
		LINE_HEIGHT		= (LINE_HEIGHT/UI_SCALE) * NEW_UISCALE
		PADDING			= (PADDING/UI_SCALE) * NEW_UISCALE
		CHAR_WIDTH		= (FONT_SIZE/(2*NEW_UISCALE)) * NEW_UISCALE
		UI_SCALE = NEW_UISCALE
		ui:size(FONT_SIZE)
		ui:pad(PADDING)
		trackermenusettings.ui_scale = NEW_UISCALE
		trackermenusettings:save()
		util.addon_log('UI Scale: '..trackermenusettings.ui_scale)
	elseif cmds.log:contains(arg[1]) then
		if (arg[2]) then
			arg[2] = arg[2]:lower()
			if arg[2] == 'titles' then
				util.log_tablog(tab_logs.titles)
				windower.add_to_chat(160, '=== Titles (%d/%d) ===':format(playertracker['Titles_completed'], playertracker['Titles_total']))
			elseif arg[2] == 'monstrosity' then
				windower.add_to_chat(160, '=== Species Levels (%d/%d) ===':format(playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total']))
				util.log_tablog(tab_logs.monsterlevels)
				windower.add_to_chat(160, '=== Monster Variants (%d/%d) ===':format(playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total']))
				util.log_tablog(tab_logs.monstervariants)
				windower.add_to_chat(160, '=== Race / Job Instincts (%d/%d) ===':format(playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total']))
				util.log_tablog(tab_logs.racejobinstincts)
				windower.add_to_chat(160, '=== Monster Instincts (%d/%d) ===':format(playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total']))
				util.log_tablog(tab_logs.monster_instincts)
			elseif arg[2] == 'mmm' then
				windower.add_to_chat(160, '=== MMM Vouchers Unlocks (%d/%d) ===':format(playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total']))
				util.log_tablog(tab_logs.mmmvouchers)
				windower.add_to_chat(160, '=== MMM Runes Unlocks (%d/%d) ===':format(playertracker['mmmrunes_completed'], playertracker['mmmrunes_total']))
				util.log_tablog(tab_logs.mmmrunes)
			elseif arg[2] == 'meeble' then
				windower.add_to_chat(160, '=== Meeble Burrows (%d/%d) ===':format(playertracker['meebleburrows_completed'], playertracker['meebleburrows_total']))
				util.log_tablog(tab_logs.meebleburrows)
			elseif arg[2] == 'zones' then
				windower.add_to_chat(160, '=== Zones (%d/%d) ===':format(playertracker['zones_completed'], playertracker['zones_total']))
				util.log_tablog(tab_logs.zones)
			elseif arg[2] == 'warps' then
				windower.add_to_chat(160, '=== Home Points (%d/%d) ===':format(playertracker['homepoints_completed'], playertracker['homepoints_total']))
				util.log_tablog(tab_logs.homepoints)
				windower.add_to_chat(160, '=== Survival Guides (%d/%d) ===':format(playertracker['survivalguides_completed'], playertracker['survivalguides_total']))
				util.log_tablog(tab_logs.survivalguides)
				windower.add_to_chat(160, '=== Adoulin Waypoints (%d/%d) ===':format(playertracker['waypoints_completed'], playertracker['waypoints_total']))
				util.log_tablog(tab_logs.waypoints)
				windower.add_to_chat(160, '=== Outpost Warps (%d/%d) ===':format(playertracker['outposts_completed'], playertracker['outposts_total']))
				util.log_tablog(tab_logs.outposts)
				windower.add_to_chat(160, '=== Proto-Waypoints (%d/%d) ===':format(playertracker['protowaypoints_completed'], playertracker['protowaypoints_total']))
				util.log_tablog(tab_logs.protowaypoints)
				windower.add_to_chat(160, '=== WoTG Unlocks (%d/%d) ===':format(playertracker['cavernousmaws_completed'], playertracker['cavernousmaws_total']))
				util.log_tablog(tab_logs.cavernousmaws)
				windower.add_to_chat(160, '=== Eschan Portals (%d/%d) ===':format(playertracker['eschanportals_completed'], playertracker['eschanportals_total']))
				util.log_tablog(tab_logs.eschanportals)
			elseif arg[2] == 'fish' then
				windower.add_to_chat(160, '=== Type of Fish (%d/%d) ===':format(playertracker['fishes_completed'], playertracker['fishes_total']))
				util.log_tablog(tab_logs.fishes)
			elseif arg[2] == 'missions' then
				windower.add_to_chat(160, '=== San d\'Oria Missions (%d/%d) ===':format(playertracker['sandoriamissions_completed'], playertracker['sandoriamissions_total']))
				util.log_tablog(tab_logs.quests['sandoriamissions'])
				windower.add_to_chat(160, 'Bastok Missions (%d/%d) ===':format(playertracker['bastokmissions_completed'], playertracker['bastokmissions_total']))
				util.log_tablog(tab_logs.quests['bastokmissions'])
				windower.add_to_chat(160, 'Windurst Missions (%d/%d) ===':format(playertracker['windurstmissions_completed'], playertracker['windurstmissions_total']))
				util.log_tablog(tab_logs.quests['windurstmissions'])
				windower.add_to_chat(160, 'Zilart Missions (%d/%d) ===':format(playertracker['zilartmissions_completed'], playertracker['zilartmissions_total']))
				util.log_tablog(tab_logs.quests['zilartmissions'])
				windower.add_to_chat(160, 'CoP Missions (%d/%d) ===':format(playertracker['copmissions_completed'], playertracker['copmissions_total']))
				util.log_tablog(tab_logs.quests['copmissions'])
				windower.add_to_chat(160, 'TOAU Missions (%d/%d) ===':format(playertracker['ahturhganmissions_completed'], playertracker['ahturhganmissions_total']))
				util.log_tablog(tab_logs.quests['ahturhganmissions'])
				windower.add_to_chat(160, 'WOTG Missions (%d/%d) ===':format(playertracker['wotgmissions_completed'], playertracker['wotgmissions_total']))
				util.log_tablog(tab_logs.quests['wotgmissions'])
				windower.add_to_chat(160, 'ACP Missions (%d/%d) ===':format(playertracker['acpmissions_completed'], playertracker['acpmissions_total']))
				util.log_tablog(tab_logs.quests['acpmissions'])
				windower.add_to_chat(160, 'MKD Missions (%d/%d) ===':format(playertracker['mkdmissions_completed'], playertracker['mkdmissions_total']))
				util.log_tablog(tab_logs.quests['mkdmissions'])
				windower.add_to_chat(160, 'ASA Missions (%d/%d) ===':format(playertracker['asamissions_completed'], playertracker['asamissions_total']))
				util.log_tablog(tab_logs.quests['asamissions'])
				windower.add_to_chat(160, 'SoA Missions (%d/%d) ===':format(playertracker['soamissions_completed'], playertracker['soamissions_total']))
				util.log_tablog(tab_logs.quests['soamissions'])
				windower.add_to_chat(160, 'RoV Missions (%d/%d) ===':format(playertracker['rovmissions_completed'], playertracker['rovmissions_total']))
				util.log_tablog(tab_logs.quests['rovmissions'])
				windower.add_to_chat(160, 'TVR Missions (%d/%d) ===':format(playertracker['tvrmissions_completed'], playertracker['tvrmissions_total']))
				util.log_tablog(tab_logs.quests['tvrmissions'])
			elseif arg[2] == 'quests' then
				windower.add_to_chat(160, '=== San d\'Oria Quests (%d/%d) ===':format(playertracker['sandoria_completed'], playertracker['sandoria_total']))
				util.log_tablog(tab_logs.quests['sandoria'])
				windower.add_to_chat(160, '=== Bastok Quests (%d/%d) ===':format(playertracker['bastok_completed'], playertracker['bastok_total']))
				util.log_tablog(tab_logs.quests['bastok'])
				windower.add_to_chat(160, '=== Windurst Quests (%d/%d) ===':format(playertracker['windurst_completed'], playertracker['windurst_total']))
				util.log_tablog(tab_logs.quests['windurst'])
				windower.add_to_chat(160, '=== Jeuno Quests (%d/%d) ===':format(playertracker['jeuno_completed'], playertracker['jeuno_total']))
				util.log_tablog(tab_logs.quests['jeuno'])
				windower.add_to_chat(160, '=== Aht Urhgan Quests (%d/%d) ===':format(playertracker['ahturhgan_completed'], playertracker['ahturhgan_total']))
				util.log_tablog(tab_logs.quests['ahturhgan'])
				windower.add_to_chat(160, '=== Crystal War Quests (%d/%d) ===':format(playertracker['crystalwar_completed'], playertracker['crystalwar_total']))
				util.log_tablog(tab_logs.quests['crystalwar'])
				windower.add_to_chat(160, '=== Outlands Quests (%d/%d) ===':format(playertracker['outlands_completed'], playertracker['outlands_total']))
				util.log_tablog(tab_logs.quests['outlands'])
				windower.add_to_chat(160, '=== Other Quests (%d/%d) ===':format(playertracker['other_completed'], playertracker['other_total']))
				util.log_tablog(tab_logs.quests['other'])
				windower.add_to_chat(160, '=== Abyssea Quests (%d/%d) ===':format(playertracker['abyssea_completed'], playertracker['abyssea_total']))
				util.log_tablog(tab_logs.quests['abyssea'])
				windower.add_to_chat(160, '=== Adoulin Quests (%d/%d) ===':format(playertracker['adoulin_completed'], playertracker['adoulin_total']))
				util.log_tablog(tab_logs.quests['adoulin'])
				windower.add_to_chat(160, '=== Coalition Assignments (%d/%d) ===':format(playertracker['coalition_completed'], playertracker['coalition_total']))
				util.log_tablog(tab_logs.quests['coalition'])
				windower.add_to_chat(160, '=== Campaign Ops (%d/%d) ===':format(playertracker['campaign_completed'], playertracker['campaign_total']))
				util.log_tablog(tab_logs.quests['campaign2'])
			elseif arg[2] == 'campaign' then
				windower.add_to_chat(160, '=== Campaign Ops (%d/%d) ===':format(playertracker['campaign_completed'], playertracker['campaign_total']))
				util.log_tablog(tab_logs.quests['campaign2'])
			elseif quests_location:contains(arg[2]) then
				windower.add_to_chat(160, '=== '.. arg[2] ..' (%d/%d) ===':format(playertracker[arg[2]..'_completed'], playertracker[arg[2]..'_total']))
				util.log_tablog(tab_logs.quests[arg[2]])
			elseif (arg[2] == 'main') or (arg[2] == 'summary') then
				for key, text in pairs(tabs[1].items) do
					text = text:gsub('\\cs%(%d+,%d+,%d+%)', '')
					text = text:gsub('\\cr', '')
					windower.add_to_chat(160, text)
				end
			elseif (arg[2] == 'sheol') or (arg[2] == 'odyssey') then
				windower.add_to_chat(160, '=== Sheol A (%d/%d) ===':format(playertracker['sheola_completed'], playertracker['sheola_total']))
				util.log_tablog(tab_logs.sheola)
				windower.add_to_chat(160, '=== Sheol B (%d/%d) ===':format(playertracker['sheolb_completed'], playertracker['sheolb_total']))
				util.log_tablog(tab_logs.sheolb)
				windower.add_to_chat(160, '=== Sheol C (%d/%d) ===':format(playertracker['sheolc_completed'], playertracker['sheolc_total']))
				util.log_tablog(tab_logs.sheolc)
				windower.add_to_chat(160, '=== Sheol Gaol (%d/%d) ===':format(playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total']))
				util.log_tablog(tab_logs.sheolgaol)
			end
		else
			windower.add_to_chat(160, 'Must specify category')
			windower.add_to_chat(160, 'Example: //xic log '..string.color('titles', 221))
			windower.add_to_chat(160, 'Available categories: main summary titles monstrosity mmm meeble zones warps fish odyssey missions quests')
			windower.add_to_chat(160, 'sandoria bastok windurst jeuno ahturhgan crystalwar outlands other abyssea adoulin coalition campaign')
			windower.add_to_chat(160, 'sandoriamissions bastokmissions windurstmissions zilartmissions ahturhganmissions wotgmissions copmissions acpmissions mkdmissions asamissions soamissions rovmissions tvrmissions')
		end
	end
end)

-- Init & Cleanup
function addon_clear()
	playertracker = defaultplayertracker
	tab_logs = defaulttab_logs
	player = nil
	ui:hide()
end

function addon_init()
	addon_clear() -- clear on re/load
	player = windower.ffxi.get_player()
	if not player then return end
	playertracker = config.load('data/'.. windower.ffxi.get_player().name .. '.xml', playertracker)
	xichecklist_updatemenulogs()
	if (trackermenusettings.visibility and player) then
		ui:show()
	end
end

windower.register_event('load', 'login', 'logout', addon_init)
windower.register_event('logout', addon_clear)
windower.register_event('unload', function()
	ui:destroy()
end)