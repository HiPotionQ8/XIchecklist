local menus_util = {}
local menumaps = require('../maps/maps_menus')
menu_current = {
	npcindex = nil,
	zoneid = nil,
	['Option Index'] = nil,
	['Secondary Option Index'] = nil,
	_unknown1 = nil,
	['Menu Parameters'] = nil,
}

function menus_util.handle_npc_menu(data)
	parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if (
		(
			(menus_util.menu_npcs[npc].zoneid == windower.ffxi.get_info().zone) or
			(menus_util.menu_npcs[npc].zoneid:contains(windower.ffxi.get_info().zone))
		)
		and (
			(menus_util.menu_npcs[npc].menuid == parseddata['Menu ID']) or
			(menus_util.menu_npcs[npc].menuid:contains(parseddata['Menu ID']))
		)
	) then
		menus_util.menu_npcs[npc]['menu_function'](data)
	end
end

function menus_util.handle_npc_submenu(data)
	parseddata = packets.parse('incoming', data)
	local index = menu_current.npcindex
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if (((menus_util.menu_npcs[npc].zoneid == windower.ffxi.get_info().zone) or (menus_util.menu_npcs[npc].zoneid:contains(windower.ffxi.get_info().zone)))) then
		menus_util.menu_npcs[npc]['menu_function'](data)
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

function menus_util.handle_op_warps(data)
	parseddata = packets.parse('incoming', data)
	menu = parseddata['Menu Parameters']
	subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(menumaps.outposts) do
		if (not util.has_bit(subdata, key+5)) then -- used+5 because mapping starts from 6th byte
			menus_util.add_outpost(key)
		end
	end
end

function menus_util.add_outpost(id)
	if (not (playertracker.outposts_unlocks[tostring(id)] == true)) then
		playertracker.outposts_unlocks[tostring(id)] = true
		playertracker:save()
		util.addon_log('Outpost added: ' .. menumaps.outposts[id])
	end
end

function menus_util.log_outposts()
	output_list = {}
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
	playertracker['outposts_completed'] = complete
	playertracker['outposts_total'] = total
	return output_list
end

function menus_util.handle_chatnachoq(data)
	parseddata = packets.parse('incoming', data)
	menu = parseddata['Menu Parameters']
	local marbles = menu:unpack('I', 5)
	local mazes = menu:unpack('I', 13)
	playertracker['mmm_mazecount'] = mazes
	playertracker:save()
	--util.addon_log('Maze count: ' .. mazes)
end

function menus_util.handle_protowaypoint(data)
	parseddata = packets.parse('incoming', data)
	menu = parseddata['Menu Parameters']
	--subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(menumaps.protowaypoints) do
		if (util.has_bit(menu, key)) then
			menus_util.add_protowaypoint(key)
		end
	end
end

function menus_util.add_protowaypoint(id)
	if (not (playertracker.protowaypoints_unlocks[tostring(id)] == true)) then
		playertracker.protowaypoints_unlocks[tostring(id)] = true
		playertracker:save()
		util.addon_log('Proto-Waypoint added: ' .. menumaps.protowaypoints[id])
	end
end

function menus_util.log_protowaypoints()
	output_list = {}
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
	playertracker['protowaypoints_completed'] = complete
	playertracker['protowaypoints_total'] = total
	return output_list
end

function menus_util.handle_burrowsnpc(data)
	local parseddata = packets.parse('incoming', data)
	local map_name = nil
	if ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 1) -- Upper Jeuno / Sauromugue Menu
		or (menu_current['zoneid'] == 120 and menu_current['Option Index'] == 14)) then
		map_name = 'Sauromugue_Champaign'
		menus_util.handle_sauromugueburrowsmenu(map_name, parseddata['Menu Parameters'])
	elseif ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 2) -- Upper Jeuno / Batallia Menu
			or (menu_current['zoneid'] == 105 and menu_current['Option Index'] == 14)) then
		map_name = 'Batallia_Downs'
		menus_util.handle_batalliaburrowsmenu(map_name, parseddata['Menu Parameters'])
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
	output_list = {}
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
	playertracker['meebleburrows_completed'] = complete
	playertracker['meebleburrows_total'] = total
	return output_list
end

function menus_util.handle_katsunaga(data)
	if menu_current['_unknown1'] == 0 then
		local parseddata = packets.parse('incoming', data)
		menu = parseddata['Menu Parameters']
		for flag, id in ipairs(menumaps.fishes_menu) do
			if (id ~= false) then
				if util.has_bit(menu, flag) then
					menus_util.add_fish_caught(id)
				end
			end
		end
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
	output_list = {}
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
	playertracker['fishes_completed'] = complete
	return output_list
end

function menus_util.handle_atmacitenpc(data)
	local parseddata = packets.parse('incoming', data)
	local atmacite_levels = util.fourbits_to_table(parseddata['Menu Parameters'])
	local playerkeyitems = windower.ffxi.get_key_items()
	if (menu_current['_unknown1'] == 0 and menu_current['Option Index'] == 2) then
		for key, atmacite in pairs(menumaps.atmacite) do
			if (table.find(playerkeyitems, atmacite.id)) then
				if (playertracker.atmacite_levels[tostring(key)] == nil) then
					playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
					playertracker:save()
					util.addon_log('Atmacite added: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				elseif (atmacite_levels[key] > playertracker.atmacite_levels[tostring(key)]) then
					playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
					playertracker:save()
					util.addon_log('Atmacite Updated: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				end
			end
		end
	end
end

function menus_util.log_atmacitelevels()
	output_list = {}
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
	playertracker['atmacitelevels_completed'] = complete
	--playertracker['atmacitelevels_total'] = total
	return output_list
end

function menus_util.handle_chocobostablenpc(data)
	local parseddata = packets.parse('incoming', data)
	if (parseddata['Menu Parameters'] ~= nil) then
		local winglevel = string.byte(parseddata['Menu Parameters'], 5)
		if (winglevel > playertracker['wingskill_completed']) then
			playertracker['wingskill_completed'] = winglevel
			playertracker:save()
			util.addon_log('Wing Skill updated: '..winglevel)
		end
	end
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
	
}

return menus_util