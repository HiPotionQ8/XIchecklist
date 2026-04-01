local warps_util = {}
local warps_data = nil
local totalhomepoint, obtainedhomepoints = 0, 0
local totalsurvivalguides, obtainedsurvivalguides = 0, 0
local totalwaypoints, obtainedwaypoints = 0, 0

local warps = {
	homepoints = {data = {0x08+1, 0x17+1}, map = require('../maps/warps_homepoints')},
	survivalguides = {data = {0x18+1, 0x27+1}, map = require('../maps/warps_survivalguides')},
	waypoints = {data = {0x28+1 , 0x2E+1}, map = require('../maps/warps_waypoints')},
}

function warps_util.checkwarps(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(unpack(warps[warptype].data))
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

return warps_util