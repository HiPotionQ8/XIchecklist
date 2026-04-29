local roe_util = {}
local roemap = require('../maps/roe_objectives')
local roe_exclusions = require('../maps/roe_objectives_extra')
local roe_data = ''

function roe_util.log_roe(roe_data)
	local output_list = {}
	local total, complete = 0,0
	local hiddentotal, hiddencomplete = 0,0
	local hiddenmap = roe_exclusions.hidden
	if trackermenusettings.showexcluded then hiddenmap = S{} end
	local keys = L(roemap:keyset()):sort()
	for key in keys:it() do
		total = total+1
		local completion = false
		if (roe_exclusions.excluded[key] or hiddenmap[key]) then hiddentotal = hiddentotal+1 end
		if util.has_bit(roe_data, key) then
			complete = complete+1
			completion = true
			if (roe_exclusions.excluded[key] or hiddenmap[key]) then hiddencomplete = hiddencomplete+1 end
		end
		if (not roe_exclusions.excluded:contains(key)) and (not hiddenmap:contains(key))  then
			table.insert(output_list, util.list_item(nil, roemap[key].name, completion))
		end
	end
	playertracker.RoE_completed = complete - hiddencomplete
	playertracker.RoE_total = total - hiddentotal
	return output_list
end

return roe_util