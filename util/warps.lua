local warps_util = {}
local hpmaps = require('../maps/warps_homepoints')
local sgmaps = require('../maps/warps_survivalguides')
local wpmaps = require('../maps/warps_waypoints')
local totalhomepoint, obtainedhomepoints = 0, 0
local totalsurvivalguides, obtainedsurvivalguides = 0, 0
local totalwaypoints, obtainedwaypoints = 0, 0

function warps_util.checkhomepoints(data)
	local subdata = data:sub(0x08+1, 0x17+1) -- home points address in packet [0x063]
	local totalhomepoint, obtainedhomepoints = 0, 0
	homepoints_list = {}
	-- check for unobtained home points
	for hpindex, hpname in pairs(hpmaps) do
		totalhomepoint = totalhomepoint+1
		if (not util.has_bit(subdata, hpindex)) then
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
	local totalsurvivalguides, obtainedsurvivalguides = 0, 0
	survivalguides_list = {}
	-- check for unobtained home survival guide
	for svindex=0, #sgmaps do
		totalsurvivalguides = totalsurvivalguides+1
		if (not util.has_bit(subdata, svindex)) then
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
	local totalwaypoint, obtainedwaypoints = 0, 0
	waypoints_list = {}
	-- check for unobtained home points
	for wpindex, wpname in pairs(wpmaps) do
		totalwaypoint = totalwaypoint+1
		if (not util.has_bit(subdata, wpindex)) then
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