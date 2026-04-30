local menus_util = {}
local menumaps = require('../maps/maps_menus')
local titlescontnt = require('../maps/titles_bycontent')
local titlesexclusions = require('../maps/titles_exclusions')
local titles_howtoobtain = require('../maps/titles_howtoobtain')
menu_current = {
	npcindex = nil,
	zoneid = nil,
	['Option Index'] = nil,
	['Secondary Option Index'] = nil,
	_unknown1 = nil,
	['Menu Parameters'] = nil,
}

function menus_util.handle_npc_menu(data)
	local parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if (menus_util.menu_npcs[npc].zoneid:contains(windower.ffxi.get_info().zone)
		and menus_util.menu_npcs[npc].menuid:contains(parseddata['Menu ID'])) then
		menus_util.menu_npcs[npc].menu_function(parseddata, data) -- second parameter is data because 0x033 menu i bugged, until kayte's PR fixes it.
	end
end

function menus_util.handle_npc_submenu(data)
	local parseddata = packets.parse('incoming', data)
	local index = (menu_current.npcindex and menu_current.zoneid==windower.ffxi.get_info().zone) and menu_current.npcindex or parseddata['NPC Index']
	if (index == nil) then return false end
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if menus_util.menu_npcs[npc].zoneid:contains(windower.ffxi.get_info().zone) then
		menus_util.menu_npcs[npc].menu_function(parseddata)
	end
end

function menus_util.reset_current_menu()
	menu_current = {
		npcindex = nil,
		zoneid = nil,
		['Option Index'] = nil,
		['Secondary Option Index'] = nil,
		_unknown1 = nil,
		['Menu Parameters'] = nil,
	}
end

function menus_util.handle_menu_options(data)
	local parseddata = packets.parse('outgoing', data)
	menu_current = {
		npcindex = parseddata['Target Index'],
		zoneid = parseddata['Zone'],
		['Option Index'] = parseddata['Option Index'],
		['Secondary Option Index'] = string.byte(data, 12),
		_unknown1 = parseddata['_unknown1'],
	}
end

function menus_util.handle_op_warps(parseddata)
	local subdata = parseddata['Menu Parameters']:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(menumaps.outposts) do
		if (not util.has_bit(subdata, key+5)) then -- +5 because mapping starts from 6th byte
			menus_util.add_outpost(key)
		end
	end
	playertracker.talk_to_npc.outpostnpc = true
	playertracker:save()
end

function menus_util.add_outpost(id)
	if (not (playertracker.outposts_unlocks[tostring(id)] == true)) then
		playertracker.outposts_unlocks[tostring(id)] = true
		playertracker:save()
		util.addon_log('Outpost added: ' .. menumaps.outposts[id])
	end
end

function menus_util.log_outposts()
	local output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.outposts) do
		total = total+1
		local completion = false
		if (playertracker.outposts_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item('outpost', name, completion))
	end
	playertracker.outposts_completed = complete
	playertracker.outposts_total = total
	return output_list
end

function menus_util.handle_chatnachoq(parseddata)
	local menu = parseddata['Menu Parameters']
	local mazes = menu:unpack('I', 13)
	playertracker.mmm_mazecount = mazes
	playertracker.talk_to_npc.chatnachoq = true
	playertracker:save()
	util.addon_log('Maze count: ' .. mazes)
end

function menus_util.handle_protowaypoint(parseddata)
	local menu = parseddata['Menu Parameters']
	for key, name in pairs(menumaps.protowaypoints) do
		if (util.has_bit(menu, key)) then
			menus_util.add_protowaypoint(key)
		end
	end
	playertracker.talk_to_npc.protowaypoint = true
	playertracker:save()
end

function menus_util.add_protowaypoint(id)
	if (not (playertracker.protowaypoints_unlocks[tostring(id)] == true)) then
		playertracker.protowaypoints_unlocks[tostring(id)] = true
		playertracker:save()
		util.addon_log('Proto-Waypoint added: ' .. menumaps.protowaypoints[id])
	end
end

function menus_util.log_protowaypoints()
	local output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.protowaypoints) do
		total = total+1
		local completion = false
		if (playertracker.protowaypoints_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item('proto-waypoint', name, completion))
	end
	playertracker.protowaypoints_completed = complete
	playertracker.protowaypoints_total = total
	return output_list
end

function menus_util.handle_burrowsnpc(parseddata)
	local map_name = nil
	if ((menu_current.zoneid == 244 and menu_current['_unknown1'] == 1) -- Upper Jeuno / Sauromugue Menu
		or (menu_current['zoneid'] == 120 and menu_current['Option Index'] == 14)) then
		map_name = 'Sauromugue_Champaign'
		menus_util.handle_sauromugueburrowsmenu(map_name, parseddata['Menu Parameters'])
		playertracker.talk_to_npc.meeble_sauromugue = true
		playertracker:save()
	elseif ((menu_current.zoneid == 244 and menu_current['_unknown1'] == 2) -- Upper Jeuno / Batallia Menu
			or (menu_current.zoneid == 105 and menu_current['Option Index'] == 14)) then
		map_name = 'Batallia_Downs'
		menus_util.handle_batalliaburrowsmenu(map_name, parseddata['Menu Parameters'])
		playertracker.talk_to_npc.meeble_batallia = true
		playertracker:save()
	end
end

function menus_util.handle_sauromugueburrowsmenu(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	for id, name in pairs(burrowmap) do
		if util.has_bit(menu_parameters, id) then
			menus_util.add_meeble_burrows(id,map_name)
		end
	end
end

function menus_util.handle_batalliaburrowsmenu(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	local batallia_unlocks = util.twobits_to_table(menu_parameters)
	for id, name in pairs(burrowmap) do
		if batallia_unlocks[id] == 3 then
			menus_util.add_meeble_burrows(id,map_name)
		end
	end
end

function menus_util.add_meeble_burrows(id,map_name)
	if (not (playertracker.meeble_completed[map_name][tostring(id)] == true)) then
		playertracker.meeble_completed[map_name][tostring(id)] = true
		playertracker:save()
		util.addon_log('Meeble Burrow added: ' .. menumaps.meeble_burrows[map_name][id])
	end
end

function menus_util.log_meeble_burrows()
	local output_list = {}
	local total, complete = 0,0
	for zone, burrows in pairs(menumaps.meeble_burrows) do
		for id, name in pairs(burrows) do
			total = total+1
			local completion = false
			if (playertracker.meeble_completed[zone][tostring(id)] == true) then
				complete = complete+1
				completion = true
			end
			table.insert(output_list, util.list_item(zone, name, completion))
		end
	end
	playertracker.meebleburrows_completed = complete
	playertracker.meebleburrows_total = total
	return output_list
end

function menus_util.handle_katsunaga(parseddata)
	if menu_current['_unknown1'] == 0 then
		for flag, id in ipairs(menumaps.fishes_menu) do
			if (id ~= false) then
				if util.has_bit(parseddata['Menu Parameters'], flag) then
					menus_util.add_fish_caught(id)
				end
			end
		end
		playertracker.talk_to_npc.katsunaga = true
		playertracker:save()
	end
end

function menus_util.add_fish_caught(id)
	if (not (playertracker.fishes_caught[tostring(id)] == true)) then
		playertracker.fishes_caught[tostring(id)] = true
		playertracker:save()
		util.addon_log('Fish added: ' .. res.items[id].en)
	end
end

function menus_util.log_fishes()
	local output_list = {}
	local total, complete = 0,0
	for key, id in pairs(menumaps.fishes_menu) do
		total = total+1
		local completion = false
		if (playertracker.fishes_caught[tostring(id)] == true) then
			complete = complete+1
			completion = true
		end
		if (id) then
			table.insert(output_list, util.list_item('fish', res.items[id].en, completion))
		end
	end
	playertracker.fishes_completed = complete
	return output_list
end

function menus_util.handle_atmacitenpc(parseddata)
	local atmacite_levels = util.fourbits_to_table(parseddata['Menu Parameters'])
	local playerkeyitems = windower.ffxi.get_key_items()
	if (menu_current['_unknown1'] == 0 and menu_current['Option Index'] == 2) then
		for key, atmacite in pairs(menumaps.atmacite) do
			if (table.find(playerkeyitems, atmacite.id)) then
				if (playertracker.atmacite_levels[tostring(key)] == nil) then
					util.addon_log('Atmacite added: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				elseif (atmacite_levels[key] > playertracker.atmacite_levels[tostring(key)]) then
					util.addon_log('Atmacite Updated: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				end
				playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
			end
		end
		playertracker.talk_to_npc.atmacite_refiner = true
		playertracker:save()
	end
end

function menus_util.log_atmacitelevels()
	local output_list = {}
	local total, complete = 0,0
	for key, atmacite in pairs(menumaps.atmacite) do
		total = total+15
		local completion = false
		if (playertracker.atmacite_levels[tostring(key)] == 15) then
			completion = true
		end
		local level = playertracker.atmacite_levels[tostring(key)] or 0
		complete = complete+level
		table.insert(output_list, util.list_item('atmacite', 'Lv. ('..level..'/15) ' .. atmacite.en, completion))
	end
	playertracker.atmacite_completed = complete
	return output_list
end

function menus_util.handle_chocobostablenpc(parseddata)
	if (parseddata['Menu Parameters'] ~= nil) then
		local winglevel = string.byte(parseddata['Menu Parameters'], 5)
		if (winglevel > playertracker['wingskill_completed']) then
			playertracker.wingskill_completed = winglevel
			playertracker.talk_to_npc.chocobokid = true
			playertracker:save()
			util.addon_log('Wing Skill updated: '..winglevel)
		end
	end
end

function menus_util.handle_titles_npc(parseddata, data)
	--local flags = parseddata['Menu Parameters']:sub(1, 24) -- commented until kayte PR 
	local flags = data:sub(81, 104)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	for cat, ids in ipairs(menumaps.titlesnpc_menu[npc]) do
		local category = flags:unpack('I', 1 + (cat - 1) * 4)
		for flag, id in ipairs(ids) do
			if bit.band(category, bit.lshift(1, flag)) == 0 then
				menus_util.add_title(id)
			end
		end
	end
	playertracker.talk_to_npc[util.cleanspaces(npc)] = true
	playertracker:save()
end

function menus_util.add_title(id)
	if (not (playertracker.titles[tostring(id)] == true)) then
		playertracker.titles[tostring(id)] = true
		util.addon_log('Title added: ' .. res.titles[id].en)
	end
	playertracker:save()
end

function menus_util.log_titles()
	local output_list = {}
	local total, complete = 0,0
	local exclusions = titlesexclusions
	if (trackermenusettings.showexcluded) then exclusions = S{} end
	local ids = L(res.titles:keyset()):sort()
	for id in ids:it() do
		total = total+1
		local completion = false
		local obtainmethod = ''
		if (titles_howtoobtain[res.titles[id].en]) then
			obtainmethod = titles_howtoobtain[res.titles[id].en]
		end
		if (playertracker.titles[tostring(id)] == true) then
			complete = complete+1
			completion = true
		else
			if (exclusions:contains(id)) then
				total = total - 1
			end
		end
		if (not exclusions:contains(id)) then  
			table.insert(output_list, util.list_item('Titles', res.titles[id].en, completion, obtainmethod))
		end
	end
	playertracker.Titles_completed = complete
	playertracker.Titles_total = total
	return output_list
end

function menus_util.list_titles_bycontent()
	local output_list = {}
	for content, titles in pairs(titlescontnt) do
		local total, complete = 0,0
		local completion = false
		for key, titleid in pairs(titles) do
			total = total+1
			if (titlesexclusions:contains(titleid)) then total = total-1 end
			if (playertracker.titles[tostring(titleid)] == true) then
				complete = complete+1
				if (titlesexclusions:contains(titleid)) then total = total+1 end
			end
		end
		if (complete == total) then completion = true end
		table.insert(output_list, util.list_item(nil, '--' .. content ..' titles %d/%d':format(complete, total), completion))
	end
	return output_list
end

function menus_util.handle_odyssey_questionmark(parseddata)
	if (menu_current['Option Index'] == 2 or menu_current['Option Index'] == 4 or menu_current['Option Index'] == 5 or menu_current['Option Index'] == 7) then 
		-- SheolABC
		local nostos = 0
		for byteidx, entry in pairs(menumaps.odyssey.sheolabc[menu_current['Option Index']]) do
			byteidx = tonumber(byteidx)
			if (byteidx) then -- if its a number, aka not nostos or talk_to_npc
				playertracker.sheolabc[tostring(menu_current['Option Index'])][tostring(byteidx)] = string.byte(parseddata['Menu Parameters'], byteidx)
			end
		end
		if menumaps.odyssey.sheolabc[menu_current['Option Index']].nostos then
			nostos = parseddata['Menu Parameters']:unpack('I2', menumaps.odyssey.sheolabc[menu_current['Option Index']].nostos.data)
			playertracker.sheolabc[tostring(menu_current['Option Index'])].nostos = nostos
		end
		if menumaps.odyssey.sheolabc[menu_current['Option Index']].talk_to_npc then
			playertracker.talk_to_npc[menumaps.odyssey.sheolabc[menu_current['Option Index']].talk_to_npc] = true
		end
	elseif (menu_current['Option Index'] == 8 or menu_current['Option Index'] == 9 or menu_current['Option Index'] == 10) then -- Choose Sheo Gaol status report
		-- Sheol Gaol
		for byteidx, name in pairs (menumaps.odyssey.gaol[menu_current['Option Index']]) do
			local venglevel = bit.band(string.byte(parseddata['Menu Parameters'], byteidx), 0x1F) -- 5 bits are the veng level
			if (not playertracker.sheolgaol[tostring(menu_current['Option Index'])][tostring(byteidx)]) then
				util.addon_log(name..' V'..venglevel..' Added')
			elseif (venglevel > playertracker.sheolgaol[tostring(menu_current['Option Index'])][tostring(byteidx)]) then
				util.addon_log(name..' V'..venglevel..' Updated')
			end 
			playertracker.sheolgaol[tostring(menu_current['Option Index'])][tostring(byteidx)] = venglevel
		end
		playertracker.talk_to_npc.sheolgaol = true
	end
	playertracker:save()
end

function menus_util.log_sheolgaol()
	local output_list = {}
	local total, complete = 0,0
	for optionidx, optiontbl in pairs(menumaps.odyssey.gaol) do
		for byteidx, name in pairs(optiontbl) do
			local venglevel = playertracker.sheolgaol[tostring(optionidx)][tostring(byteidx)] or 0
			local completion = false
			if venglevel == 25 then completion = true end
			table.insert(output_list, util.list_item(nil, 'V'..venglevel..' '..name, completion))
			complete = complete+venglevel
		end
	end
	playertracker.sheolgaoltiers_completed = complete
	return output_list
end

function menus_util.log_sheolabc(sheol)
	local output_list = {}
	local total, complete = 0,0
	local map_optionindex = 0
	if sheol == 'sheola' then map_optionindex = {2}
	elseif sheol == 'sheolb' then map_optionindex = {4,5}
	elseif sheol == 'sheolc' then map_optionindex = {7}
	end
	for _, optionindex in pairs(map_optionindex) do
		for byteidx, entry in pairs(menumaps.odyssey.sheolabc[optionindex]) do
			local completion = false
			if byteidx ~= 'talk_to_npc' then
				total = total+1
				if (playertracker.sheolabc[tostring(optionindex)][tostring(byteidx)]) then
					if playertracker.sheolabc[tostring(optionindex)][tostring(byteidx)] >= entry.goal then
						completion = true
						complete = complete+1
					end
				end
				table.insert(output_list, util.list_item(nil, (playertracker.sheolabc[tostring(optionindex)][tostring(byteidx)] or 0)..'/'..entry.goal..' '..entry.name, completion))
			end
		end
	end
	playertracker[sheol..'_completed'] = complete
	playertracker[sheol..'_total'] = total
	return output_list
end

function menus_util.handle_vorseals_npc(parseddata)
	local nibble_table = util.fourbits_to_table(parseddata['Menu Parameters'])
	if (parseddata['Menu ID'] == 9701) then -- initial interaction with NPC, no Option Index
		for nibble, vorseal in pairs(menumaps.vorseals) do
			if (playertracker.vorseals[tostring(nibble)] == nil) then
				util.addon_log('Vorseal added: ['..nibble_table[nibble]..'/'..vorseal.goal..'] '..vorseal.name)
			elseif (nibble_table[nibble] > playertracker.vorseals[tostring(nibble)]) then
				util.addon_log('Vorseal updated: ['..nibble_table[nibble]..'/'..vorseal.goal..'] '..vorseal.name)
			end
			playertracker.vorseals[tostring(nibble)] = nibble_table[nibble]
		end
	end
	playertracker.talk_to_npc.vorseals = true
	playertracker:save()
end

function menus_util.log_vorseals()
	local output_list = {}
	local total, complete = 0,0
	for nibble, vorseal in pairs(menumaps.vorseals) do
		local completion = false
		total = total+vorseal.goal
		if (playertracker.vorseals[tostring(nibble)]) then
			complete = complete+playertracker.vorseals[tostring(nibble)]
			if playertracker.vorseals[tostring(nibble)] == vorseal.goal then
				completion = true
			end
		end
		table.insert(output_list, util.list_item(nil, (playertracker.vorseals[tostring(nibble)] or 0)..'/'..vorseal.goal..' '..vorseal.name, completion))
	end
	playertracker.vorseals_completed = complete
	playertracker.vorseals_total = total
	return output_list
end

menus_util.menu_npcs = {
	-- Outpost Warp NPCs
	['Conrad'] = {zoneid=S{234}, menuid=S{584,581}, menu_function=menus_util.handle_op_warps},
	['Jeanvirgaud'] = {zoneid=S{231}, menuid=S{716,864}, menu_function=menus_util.handle_op_warps},
	['Rottata'] = {zoneid=S{240}, menuid=S{653,552}, menu_function=menus_util.handle_op_warps},
	-- MMM NPC
	['Chatnachoq'] = {zoneid=S{245}, menuid=S{10095}, menu_function=menus_util.handle_chatnachoq},
	-- Proto-Waypoint NPCs
	['Proto-Waypoint'] = {zoneid=S{243,248,249,247,252}, menuid=S{10209,10012,345,141,266}, menu_function=menus_util.handle_protowaypoint},
	
	-- Meenle Burrow
	['Burrow Investigator'] = {zoneid=S{244}, menuid=S{5500}, menu_function=menus_util.handle_burrowsnpc},
	['Burrow Researcher'] = {zoneid=S{120,105}, menuid=S{5500}, menu_function=menus_util.handle_burrowsnpc},
	
	-- Fishing NPC
	['Katsunaga'] = {zoneid=S{249}, menuid=S{197}, menu_function=menus_util.handle_katsunaga},
	
	-- Atmacite Refiner
	['Atmacite Refiner'] = {
	zoneid=S{26,51,80,84,87,91,94,98,105,110,120,126,230,235,238,247,250,252}, 
	menuid=S{6,7,8,15,16,24,25,46,49,79,264,627,657,962,1023}, 
	menu_function=menus_util.handle_atmacitenpc},
	
	-- Chocobo NPC
	['Arvilauge'] = {zoneid=S{230}, menuid=S{846}, menu_function=menus_util.handle_chocobostablenpc},
	['Gonija'] = {zoneid=S{234}, menuid=S{534}, menu_function=menus_util.handle_chocobostablenpc},
	['Kiria-Romaria'] = {zoneid=S{241}, menuid=S{761}, menu_function=menus_util.handle_chocobostablenpc},
	
	-- Title Changer NPCs
	["Aligi-Kufongi"] = {zoneid=S{26}, menuid=S{342}, menu_function=menus_util.handle_titles_npc},
	["Koyol-Futenol"] = {zoneid=S{50}, menuid=S{644}, menu_function=menus_util.handle_titles_npc},
	["Tamba-Namba"] = {zoneid=S{80}, menuid=S{306}, menu_function=menus_util.handle_titles_npc},
	["Bhio Fehriata"] = {zoneid=S{87}, menuid=S{167}, menu_function=menus_util.handle_titles_npc},
	["Cattah Pamjah"] = {zoneid=S{94}, menuid=S{138}, menu_function=menus_util.handle_titles_npc},
	["Moozo-Koozo"] = {zoneid=S{230}, menuid=S{675}, menu_function=menus_util.handle_titles_npc},
	["Styi Palneh"] = {zoneid=S{236}, menuid=S{200}, menu_function=menus_util.handle_titles_npc},
	["Burute-Sorute"] = {zoneid=S{239}, menuid=S{10004}, menu_function=menus_util.handle_titles_npc},
	["Tuh Almobankha"] = {zoneid=S{245}, menuid=S{10014}, menu_function=menus_util.handle_titles_npc},
	["Zuah Lepahnyu"] = {zoneid=S{246}, menuid=S{330}, menu_function=menus_util.handle_titles_npc},
	["Shupah Mujuuk"] = {zoneid=S{247}, menuid=S{1011}, menu_function=menus_util.handle_titles_npc},
	["Yulon-Polon"] = {zoneid=S{248}, menuid=S{10001}, menu_function=menus_util.handle_titles_npc},
	["Willah Maratahya"] = {zoneid=S{249}, menuid=S{10001}, menu_function=menus_util.handle_titles_npc},
	["Eron-Tomaron"] = {zoneid=S{250}, menuid=S{10013}, menu_function=menus_util.handle_titles_npc},
	["Quntsu-Nointsu"] = {zoneid=S{252}, menuid=S{1011}, menu_function=menus_util.handle_titles_npc},
	["Debadle-Levadle"] = {zoneid=S{256}, menuid=S{15}, menu_function=menus_util.handle_titles_npc},
	
	-- ??? Odyssey
	["???"] = {zoneid=S{247}, menuid=S{2001}, menu_function=menus_util.handle_odyssey_questionmark},
	
	-- Vorseals
	["Shiftrix"] = {zoneid=S{291}, menuid=S{9701}, menu_function=menus_util.handle_vorseals_npc},
}

return menus_util