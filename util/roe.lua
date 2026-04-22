local roe_util = {}
local roemap = require('../maps/roe_objectives')
local roe_exclusions = require('../maps/roe_objectives_extra')

function roe_util.handle_roe_data(data)
	for id, roe in pairs(roemap) do
		if (util.has_bit(roe_data, id)) then
			roe_util.add_roe(id)
		end
	end
	playertracker:save()
end

function roe_util.add_roe(id)
	if (not (playertracker.roe[tostring(id)] == true)) then
		playertracker.roe[tostring(id)] = true
		if (trackermenusettings.chat_logroe) then
			util.addon_log('RoE Completed: ' .. roemap[id].name)
		end
	end
end

function roe_util.log_roe()
	local output_list = {}
	local total, complete = 0,0
	local hiddentotal, hiddencomplete = 0,0
	local hiddenmap = roe_exclusions.hidden
	if (trackermenusettings.showexcluded) then hiddenmap = S{} end
	for key, roe in pairs(roemap) do
		total = total+1
		local completion = false
		if (roe_exclusions.excluded[key] or hiddenmap[key]) then hiddentotal = hiddentotal+1 end
		if (playertracker.roe[tostring(key)] == true) then
			complete = complete+1
			completion = true
			if (roe_exclusions.excluded[key] or hiddenmap[key]) then hiddencomplete = hiddencomplete+1 end
		end
		if (not roe_exclusions.excluded:contains(key)) and (not hiddenmap:contains(key))  then
			table.insert(output_list, util.list_item(nil, roemap[key].name, completion))
		end
	end
	playertracker['RoE_completed'] = complete - hiddencomplete
	playertracker['RoE_total'] = total - hiddentotal
	return output_list
end

return roe_util