local warps_util = {}
local warps_data = nil
local maps = require('../maps/warps')

local warps_bytes = {
	homepoints = {0x08+1, 0x17+1},
	survivalguides = {0x18+1, 0x27+1},
	waypoints = {0x28+1 , 0x37+1},
	telepoints = {0x38+1, 0x3B+1},
	cavernousmaws = {0x3C+1, 0x3F+1},
	eschanportals = {0x40+1, 0x44+1},
}

function warps_util.log_warps(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(unpack(warps_bytes[warptype]))
	local total, complete = 0, 0
	local output_list = {}
	-- check for obtained warp
	for index, name in pairs(maps[warptype]) do
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
	local subdata = warps_util.warps_data:sub(unpack(warps_bytes[warptype]))
	local complete = 0
	for i = 1, #subdata do
		local byte = string.byte(subdata, i)
		while byte ~= 0 do
			byte = bit.band(byte, byte - 1)
			complete = complete + 1
		end
	end
	playertracker[warptype..'_completed'] = complete
	return complete
end

return warps_util