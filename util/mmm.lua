local mmm_util = {}

mmm_util.log_vouchers = function(bitfield)
	if bitfield==nil then return end
	local output_list = {}
	local total, complete = 0, 0
	for id in mmmvouchersids:it() do
		total = total+1
		local completion = false
		if util.has_bit(bitfield, id-28736)  then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, res.items[id].en, completion))
	end
	playertracker.mmmvouchers_completed = complete
	playertracker.mmmvouchers_total = total
	tab_logs.mmmvouchers = {
		name = tab_logs.mmmvouchers.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

mmm_util.log_runes = function(bitfield)
	if bitfield==nil then return end
	local output_list = {}
	local total, complete = 0, 0
	for id in mmmrunesids:it() do
		total = total+1
		local completion = false
		if util.has_bit(bitfield, id-28800)  then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, res.items[id].en, completion))
	end
	playertracker.mmmrunes_completed = complete
	playertracker.mmmrunes_total = total
	tab_logs.mmmrunes = {
		name = tab_logs.mmmrunes.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

return mmm_util