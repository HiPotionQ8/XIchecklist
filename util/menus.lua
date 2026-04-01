local menus_util = {}
local menumaps = require('../maps/maps_menus')

function menus_util.handle_npc_menu(data)
	parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	local zone_id = windower.ffxi.get_info().zone
	if (
	(
		(menus_util.menu_npcs[npc].zoneid == windower.ffxi.get_info().zone)
		or (menus_util.menu_npcs[npc].zoneid:contains(windower.ffxi.get_info().zone))
	)
	and (
	(menus_util.menu_npcs[npc].menuid == parseddata['Menu ID'])
	or (menus_util.menu_npcs[npc].menuid:contains(parseddata['Menu ID']))
	)
	) then
		menus_util.menu_npcs[npc]['menu_function'](data)
	end
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
	outposts_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.outposts) do
		total = total+1
		if (playertracker.outposts_unlocks[tostring(key)] == true) then
			complete = complete+1
			--table.insert(outposts_list, '\\cs(0,255,0)[outpost] ' .. name ..'\\cr') -- add obtained outpost
		else
			table.insert(outposts_list, '\\cs(255,255,0)[outpost] ' .. name ..'\\cr') -- add missing outpost
		end
	end
	playertracker['outposts_completed'] = complete
	playertracker['outposts_total'] = total
	return outposts_list
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
	protowaypoints_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.protowaypoints) do
		total = total+1
		if (playertracker.protowaypoints_unlocks[tostring(key)] == true) then
			complete = complete+1
			--table.insert(protowaypoints_list, '\\cs(0,255,0)[proto-waypoint] ' .. name ..'\\cr') -- add obtained proto-waypoint
		else
			table.insert(protowaypoints_list, '\\cs(255,255,0)[proto-waypoint] ' .. name ..'\\cr') -- add missing proto-waypoint
		end
	end
	playertracker['protowaypoints_completed'] = complete
	playertracker['protowaypoints_total'] = total
	return protowaypoints_list
end

menus_util.menu_npcs = {
	-- Outpost Warp NPCs
	['Conrad'] = {entityid=17735859, zoneid=234, menuid=584, menu_function=menus_util.handle_op_warps}, -- Bastok Mines
	['Jeanvirgaud'] = {entityid=17723597, zoneid=231, menuid=864, menu_function=menus_util.handle_op_warps}, -- Northern San d'Oria
	['Rottata'] = {entityid=17760439, zoneid=240, menuid=653, menu_function=menus_util.handle_op_warps}, -- Port Windurst
	-- MMM NPC
	['Chatnachoq'] = {entityid=17780943, zoneid=245, menuid=10095, menu_function=menus_util.handle_chatnachoq}, -- Lower Jeuno
	-- Proto-Waypoint NPCs
	['Proto-Waypoint'] = {entityid=S{17772844,17793139,17797259,17789018,17809536}, zoneid=S{243,248,249,247,252}, menuid=S{10209,10012,345,141,266}, menu_function=menus_util.handle_protowaypoint}, -- Ru'Lude Gardens / Selbine / Mhaura / Rabao / Norg
	
}

return menus_util