

local quest_util = {}

quests = {completed={},current={}}
campaings_completed_log = {
	['Completed Campaign Missions'] = '',
	['Completed Campaign Missions (2)'] = '',
}
campaigns_completed = nil

_G.quest_logs = {
    [0x0070] = {type='current', area='otherquests'},
    [0x00B0] = {type='completed', area='otherquests'},
    [0x00E0] = {type='current', area='abysseaquests'},
    [0x00E8] = {type='completed', area='abysseaquests'},
    [0x00F0] = {type='current', area='adoulinquests'},
    [0x00F8] = {type='completed', area='adoulinquests'},
    [0x0100] = {type='current', area='coalitionquests'},
    [0x0108] = {type='completed', area='coalitionquests'},
	[0x0090] = {type='completed', area='sandoriaquests'},
	[0x0050] = {type='current', area='sandoriaquests'},
	[0x0098] = {type='completed', area='bastokquests'},
	[0x0058] = {type='current', area='bastokquests'},
	[0x00A0] = {type='completed', area='windurstquests'},
	[0x0060] = {type='current', area='windurstquests'},
	[0x00A8] = {type='completed', area='jeunoquests'},
	[0x0068] = {type='current', area='jeunoquests'},
	[0x00C0] = {type='completed', area='ahturhganquests'},
	[0x0080] = {type='current', area='ahturhganquests'},
	[0x00C8] = {type='completed', area='crystalwarquests'},
	[0x0088] = {type='current', area='crystalwarquests'},
	[0x00B8] = {type='completed', area='outlandsquests'},
	[0x0078] = {type='current', area='outlandsquests'},
}

local maps = {
    abysseaquests = require('../maps/quests_abyssea'),
    adoulinquests = require('../maps/quests_adoulin'),
    coalitionquests = require('../maps/quests_coalitions'),
    otherquests = require('../maps/quests_other'),
	sandoriaquests = require('../maps/quests_sandoria'),
	bastokquests = require('../maps/quests_bastok'),
	windurstquests = require('../maps/quests_windurst'),
	jeunoquests = require('../maps/quests_jeuno'),
	ahturhganquests = require('../maps/quests_ahturhgan'),
	crystalwarquests = require('../maps/quests_crystalwar'),
	outlandsquests = require('../maps/quests_outlands'),
	campaign = require('../maps/campaign'),
}

function quest_util.to_set(data)
    return {data:unpack('q64':rep(#data/4))}
end

function quest_util.addon_error(str)
    --windower.add_to_chat(167, 'You must change areas or complete %s quests before using this command.':format(str))
end

function quest_util.log_quests(quest_type)
    if not quests.completed[quest_type] then
        quest_util.addon_error(quest_type)
        return true
    end
    local completed = quest_util.to_set(quests.completed[quest_type])
    local current = quest_util.to_set(quests.current[quest_type])
    local complete,total = 0, 0
	local quest_list = {}
	for key, questname in pairs(maps[quest_type]) do -- test print all
		if maps[quest_type][key] then
			total = total + 1
            if completed[key+1] then
                complete = complete + 1
				--table.insert(quest_list, '\\cs(0,255,0)' .. maps[quest_type][key] ..'\\cr') -- add completed quest name
            else
				table.insert(quest_list, '\\cs(255,255,0) ['.. quest_type .. '] ' .. maps[quest_type][key] ..'\\cr') -- add non completed quest name
            end
        end
	end
	playertracker[quest_type..'_completed'] = complete
	playertracker[quest_type..'_total'] = total
	return quest_list
end

function quest_util.log_campaign(data)
	local campaign_unlocks = util.bin_dump(data) -- convert shit to zeroes and ones
	local campaign_unlocks = util.to_bools(campaign_unlocks) -- convert zeros and ones to true/false
	local complete,total = 0, 0
	local quest_list = {}
	for key,campaignname in pairs(maps.campaign) do
		local bitindex = ((math.floor(key/8)+1)*8) - ((key%8) +1)
		if maps.campaign[key] then
			total = total + 1
			if campaign_unlocks[bitindex+1] then
				complete = complete + 1
				--table.insert(quest_list, '\\cs(0,255,0) ' .. campaignname ..'\\cr') -- add completed campaign name
			else
				table.insert(quest_list, '\\cs(255,255,0) ' .. campaignname ..'\\cr') -- add non completed campaign name
			end
		end
	end
	playertracker['campaign_completed'] = complete
	playertracker['campaign_total'] = total
	return quest_list
end


return quest_util