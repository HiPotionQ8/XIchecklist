local mons_util = {}
local maps = require('../maps/monstrosity')
mons_util.monster_levelspacket = {
	[1] = nil,
	[2] = nil,
}
local monsterlevels = nil
local racejobinstincts = nil
local variants_bitfield = nil
local monsterinstincts = nil

function mons_util.log_racejobinstincts()
	if mons_util.racejobinstincts==nil then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, name in pairs(maps.racejobinstincts) do
		total = total+1
		local completion = false
		if util.has_bit(mons_util.racejobinstincts, id) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	playertracker.racejobinstinct_completed = obtained
	playertracker.racejobinstinct_total = total	
	return output_list
end

function mons_util.log_monsterlevels()
	if (mons_util.monster_levelspacket[1] == nil or mons_util.monster_levelspacket[2] == nil) then 
		return
	else 
		mons_util.monsterlevels = util.bytes_to_table(mons_util.monster_levelspacket[1] .. mons_util.monster_levelspacket[2])
	end
	if mons_util.monsterlevels==nil then return end
	local output_list = {}
	local total, complete = 0, 0
	for id, monster in pairs(maps.species) do
		total = total+1
		local completion = false
		complete = complete + mons_util.monsterlevels[id]
		if (mons_util.monsterlevels[id] == 99) then completion = true end
		table.insert(output_list, util.list_item(nil, 'Lv. ' .. mons_util.monsterlevels[id] .. ' ' .. monster, completion)) -- add monster
	end
	playertracker.monsterlevels_completed = math.floor(complete/99)
	playertracker.monsterlevels_total = total	
	return output_list
end

function mons_util.log_variants()
	if mons_util.variants_bitfield==nil then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, name in pairs(maps.species_variants) do
		total = total+1
		local completion = false
		if util.has_bit(mons_util.variants_bitfield, (id-256)) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	playertracker.monstervariants_completed = obtained
	playertracker.monstervariants_total = total	
	return output_list
end

function mons_util.log_monsterinstincts()
	if mons_util.monsterinstincts==nil then return end
	local output_list = {}
	--local instincts_unlocks = util.twobits_to_table(mons_util.monsterinstincts)
	local total, obtained = 0, 0
	for table_id, unlocked_level in pairs(mons_util.monsterinstincts) do
		--total = total+3
		local instinct_index_base = 3 * (table_id - 1)
		for instinct_index=1, 3 do
			local completion = false
			if (maps.monsterinstincts[instinct_index_base+instinct_index]) then
				total = total+1
				if (unlocked_level >= instinct_index) then
					obtained = obtained+1
					completion = true
				end
				table.insert(output_list, util.list_item(nil, maps.monsterinstincts[instinct_index_base+instinct_index], completion))
			end
		end
	end
	playertracker.monsterinsincts_completed = obtained
	playertracker.monsterinsincts_total = total	
	return output_list
end

return mons_util