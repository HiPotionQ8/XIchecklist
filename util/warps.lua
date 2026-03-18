local warps_util = {}
local hpmaps = require('../maps/warps_homepoints')
local sgmaps = require('../maps/warps_survivalguides')
local wpmaps = require('../maps/warps_waypoints')
local totalhomepoint, obtainedhomepoints = 0, 0
local totalsurvivalguides, obtainedsurvivalguides = 0, 0
local totalwaypoints, obtainedwaypoints = 0, 0

function warps_util.checkhomepoints(data)
	local subdata = data:sub(0x08+1, 0x17+1) -- home points address in packet [0x063]
	local subdata = util.bin_dump(subdata) -- convert shit to zeroes and ones
	local hpunlocks = util.to_bools(subdata) -- convert zeros and ones to true/false
	local totalhomepoint, obtainedhomepoints = 0, 0
	homepoints_list = {}
	-- check for unobtained home points
	for hpindex, hpname in pairs (hpmaps) do
		totalhomepoint = totalhomepoint+1
		if (not hpunlocks[hpindex+1]) then
			table.insert(homepoints_list, '\\cs(255,255,0)' .. hpname ..'\\cr') -- add non completed home point
		else
			obtainedhomepoints = obtainedhomepoints+1
		end
	end
	playertracker['Homepoints_completed'] = obtainedhomepoints
	playertracker['Homepoints_total'] = totalhomepoint		
	return homepoints_list
end

function warps_util.checksurvivalguides(data)
	local subdata = data:sub(0x18+1, 0x27+1) -- survival guides address in packet [0x063]
	local subdata = util.bin_dump(subdata) -- onvert shit to zeroes and ones
	local svunlocks = util.to_bools(subdata) -- convert zeros and ones to true/false
	local totalsurvivalguides, obtainedsurvivalguides = 0, 0
	survivalguides_list = {}
	-- check for unobtained home points
	for svindex=0, #sgmaps do
		totalsurvivalguides = totalsurvivalguides+1
		if (not svunlocks[svindex+1]) then
			table.insert(survivalguides_list, '\\cs(255,255,0)[SurvivalGuide]' .. sgmaps[svindex] ..'\\cr') -- add non completed survival guide
		else
			obtainedsurvivalguides = obtainedsurvivalguides+1
		end
	end
	playertracker['Survivalguides_completed'] = obtainedsurvivalguides
	playertracker['Survivalguides_total'] = totalsurvivalguides		
	return survivalguides_list
end

function warps_util.checkwaypoints(data)
	local subdata = data:sub(0x28+1 , 0x2E+1) -- waypoint address in packet [0x063]
	local subdata = util.bin_dump(subdata) -- convert shit to zeroes and ones
	local wpunlocks = util.to_bools(subdata) -- convert zeros and ones to true/false
	local totalwaypoint, obtainedwaypoints = 0, 0
	waypoints_list = {}
	-- check for unobtained home points
	for wpindex, wpname in pairs(wpmaps) do
		local bitindex = ((math.floor(wpindex/8)+1)*8) - ((wpindex%8) +1)
		totalwaypoint = totalwaypoint+1
		
		if (not wpunlocks[bitindex+1]) then
			--windower.add_to_chat(207, '[' .. wpindex .. ']' .. wpname) -- print non completed way point
			table.insert(waypoints_list, '\\cs(255,255,0)[Waypoints] [index '.. wpindex .. ']' .. wpname ..'\\cr') -- add non completed way point
		else
			obtainedwaypoints = obtainedwaypoints+1
		end
	end
	playertracker['Waypoints_completed'] = obtainedwaypoints
	playertracker['Waypoints_total'] = totalwaypoint		
	return waypoints_list
end

return warps_util