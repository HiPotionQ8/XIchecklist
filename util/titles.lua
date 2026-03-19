local titles_util = {}
local npcmaps = require('../maps/titles_npcs')

local totaltitles, obtainedtitles = 0, 0

function titles_util.handle_npc_menu(npc, flags)
	local new = 0
	local lost = 0
	
	for cat, ids in ipairs(npcmaps[npc].menu) do
		local category = flags:unpack('I', 1 + (cat - 1) * 4)
		for flag, id in ipairs(ids) do
			if bit.band(category, bit.lshift(1, flag)) == 0 then
				--windower.add_to_chat(100, 'title added: ' .. res.titles[id].en)
				titles_util.add_title(id)
			end
		end
	end
end


function titles_util.check_titles_npc(data)
	parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not npcmaps[npc] then
		return
	end
	titles_util.handle_npc_menu(npc, data:sub(81, 104))
end

function titles_util.add_title(id)
	playertitles[tostring(id)] = true
	playertitles:save(windower.ffxi.get_player().name)
end

function titles_util.log_titles()
	titles_list = {}
	local total, complete = 0,0
	for key, title in pairs(res.titles) do
		total = total+1
		if (playertitles[tostring(key)] == true) then
			complete = complete+1
			--table.insert(titles_list, '\\cs(0,255,0) ' .. res.titles[key].en ..'\\cr') -- add obtained title
		else
			table.insert(titles_list, '\\cs(255,255,0) ' .. res.titles[key].en ..'\\cr') -- add missing title
		end
	end
	playertracker['Titles_completed'] = complete
	playertracker['Titles_total'] = total
	return titles_list
end

return titles_util