local warps_util = {}
local opmaps = require('../maps/maps_outposts')
local totalhomepoint, obtainedhomepoints = 0, 0
local totalsurvivalguides, obtainedsurvivalguides = 0, 0
local totalwaypoints, obtainedwaypoints = 0, 0

local warps = {
	homepoints = {data = {0x08+1, 0x17+1}, map = require('../maps/warps_homepoints')},
	survivalguides = {data = {0x18+1, 0x27+1}, map = require('../maps/warps_survivalguides')},
	waypoints = {data = {0x28+1 , 0x2E+1}, map = require('../maps/warps_waypoints')},
}

function warps_util.checkwarps(warptype, data)
	local subdata = data:sub(unpack(warps[warptype].data))
	local total, obtained = 0, 0
	warps_list = {}
	-- check for unobtained warp
	for index, name in pairs(warps[warptype].map) do
		total = total+1
		if (not util.has_bit(subdata, index)) then
			table.insert(warps_list, '\\cs(255,255,0)['.. warptype ..'] ' .. name ..'\\cr') -- add non obtained warp
		else
			obtained = obtained+1
		end
	end
	playertracker[warptype..'_completed'] = obtained
	playertracker[warptype..'_total'] = total		
	return warps_list
end

function warps_util.handle_op_warps(data)
	parseddata = packets.parse('incoming', data)
	menu = parseddata['Menu Parameters']
	subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(opmaps) do
		if (not util.has_bit(subdata, key+5)) then -- used+5 because mapping starts from 6th byte
			warps_util.add_outpost(key)
		end
	end
end

function warps_util.add_outpost(id)
	if (not (playertracker.outposts_unlocks[tostring(id)] == true)) then
		playertracker.outposts_unlocks[tostring(id)] = true
		playertracker:save()
		util.addon_log('Outpost added: ' .. opmaps[id])
	end
end

function warps_util.log_outposts()
	outposts_list = {}
	local total, complete = 0,0
	for key, name in pairs(opmaps) do
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

return warps_util