local warps_util = {}
local warps_data = nil

local warps = {
	homepoints = {data = {0x08+1, 0x17+1}, map = require('../maps/warps_homepoints')},
	survivalguides = {data = {0x18+1, 0x27+1}, map = require('../maps/warps_survivalguides')},
	waypoints = {data = {0x28+1 , 0x37+1}, map = require('../maps/warps_waypoints')},
	telepoints = {data = {0x38+1, 0x3B+1}, map = require('../maps/warps_telepoints')},
	cavernousmaws = {data = {0x3C+1, 0x3F+1}, map = require('../maps/warps_cavernousmaws')},
	eschanportals = {data = {0x40+1, 0x44+1}, map = require('../maps/warps_eschanportals')},
}

function warps_util.checkwarps(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(unpack(warps[warptype].data))
	local total, complete = 0, 0
	local output_list = {}
	-- check for obtained warp
	for index, name in pairs(warps[warptype].map) do
		total = total+1
		local completion = false
		if (util.has_bit(subdata, index)) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(warptype, name, completion))
	end
	playertracker[warptype..'_completed'] = complete
	playertracker[warptype..'_total'] = total		
	return output_list
end

function warps_util.countwarps(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(unpack(warps[warptype].data))
	local complete = 0
	for i = 1, #subdata do
		local byte = string.byte(subdata, i)
		while byte ~= 0 do
			byte = bit.band(byte, byte - 1)
			complete = complete + 1
		end
	end
	if complete > 0 then complete = complete-1 end
	playertracker[warptype..'_completed'] = complete
	return complete
end

return warps_util