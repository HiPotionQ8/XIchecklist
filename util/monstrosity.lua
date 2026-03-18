local mons_util = {}


local map_species = require('../maps/monstrosity_species')
local map_racejobinstincts = require('../maps/monstrosity_racejobinstincts')
local monster_levels = {}
local racejobinstincts = {}

local totalspecies, obtainedspecies = 0, 0
local totalracejobinstincts, obtainedracejobinstincts = 0, 0


function mons_util.char_field_to_table(str)
    local t = {}

    for i = 1, #str do
        t[i - 1] = str:byte(i)
    end

    return t
end

function mons_util.has_bit(data, position)
    return data:unpack('q', math.floor(position/8)+1, position%8+1)
end

function mons_util.log_racejobinstincts()
	local racejobinstincts_list = {}
	local total, obtained = 0, 0
	for id, instinctname in pairs(map_racejobinstincts) do
		total = total+1
		if mons_util.has_bit(mons_util.racejobinstincts, id) then
			obtained = obtained+1
			--windower.add_to_chat(5, "[Obtained] " .. instinctname)
		else
			--windower.add_to_chat(3, instinctname)
			table.insert(racejobinstincts_list, '\\cs(255,255,0) ' .. instinctname ..'\\cr') -- add unobtained race/job instinct
		end
	end
	playertracker['Racejobinstinct_completed'] = obtained
	playertracker['Racejobinstinct_total'] = total	
	return racejobinstincts_list
end

function mons_util.log_monsterlevels()
	local species_list = {}
	local total, complete = 0, 0
	
	for id, monster in pairs(map_species) do
		total = total+99
		table.insert(species_list, '\\cs(255,255,0) Lv. ' .. mons_util.monster_levels[id] .. ' ' .. monster ..'\\cr') -- add monster
		complete = complete + mons_util.monster_levels[id]
	end
	playertracker['MonsterLevels_completed'] = complete
	playertracker['MonsterLevels_total'] = total	
	return species_list
end




return mons_util