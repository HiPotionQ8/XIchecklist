_addon.name     = 'xichecklist'
_addon.author   = 'Anokata'
_addon.version  = '0.2.1'
_addon.commands = {'xichecklist', 'xic'}


require('sets')
packets = require('packets')
local texts = require('texts')
local config = require('config')
res = require('resources')

-------------------------------------------------
-- Defaults
-------------------------------------------------

trackermenusettings = {}
trackermenusettings.pos = {}
trackermenusettings.pos.x = 120
trackermenusettings.pos.y = 120

trackermenusettings = config.load(trackermenusettings)

playertracker = {
	['bastokquests_completed'] = 0,
	['bastokquests_total'] = 0,
	['sandoriaquests_completed'] = 0,
	['sandoriaquests_total'] = 0,
	['windurstquests_completed'] = 0,
	['windurstquests_total'] = 0,
	['jeunoquests_completed'] = 0,
	['jeunoquests_total'] = 0,
	['ahturhganquests_completed'] = 0,
	['ahturhganquests_total'] = 0,
	['crystalwarquests_completed'] = 0,
	['crystalwarquests_total'] = 0,
	['outlandsquests_completed'] = 0,
	['outlandsquests_total'] = 0,
	['otherquests_completed'] = 0,
	['otherquests_total'] = 0,
	['abysseaquests_completed'] = 0,
	['abysseaquests_total'] = 0,
	['adoulinquests_completed'] = 0,
	['adoulinquests_total'] = 0,
	
	['coalitionquests_completed'] = 0,
	['coalitionquests_total'] = 0,
	
	['campaign_completed'] = 0,
	['campaign_total'] = 0,
	
	['Permanent Key Items_completed'] = 0,
	['Permanent Key Items_total'] = 0,
	['Magical Maps_completed'] = 0,
	['Magical Maps_total'] = 0,
	['Mounts_completed'] = 0,
	['Mounts_total'] = 0,
	['Claim Slips_completed'] = 0,
	['Claim Slips_total'] = 0,
	
	['WhiteMagic_completed'] = 0,
	['WhiteMagic_total'] = 0,
	['BlackMagic_completed'] = 0,
	['BlackMagic_total'] = 0,
	['SummonerPact_completed'] = 0,
	['SummonerPact_total'] = 0,
	['Ninjutsu_completed'] = 0,
	['Ninjutsu_total'] = 0,
	['BardSong_completed'] = 0,
	['BardSong_total'] = 0,
	['BlueMagic_completed'] = 0,
	['BlueMagic_total'] = 0,
	['Geomancy_completed'] = 0,
	['Geomancy_total'] = 0,
	['Trust_completed'] = 0,
	['Trust_total'] = 0,
	
	['Jobpoints_completed'] = 0,
	['Jobpoints_total'] = 46200,
	['Masterlevels_completed'] = 0,
	['Masterlevels_total'] = 1100,
	['Masterlevels_highest'] = 0,
	
	['Homepoints_completed'] = 0,
	['Homepoints_total'] = 0,
	['Survivalguides_completed'] = 0,
	['Survivalguides_total'] = 0,
	['Waypoints_completed'] = 0,
	['Waypoints_total'] = 0,
	
	['Racejobinstinct_completed'] = 0,
	['Racejobinstinct_total'] = 0,
	['MonsterLevels_completed'] = 0,
	['MonsterLevels_total'] = 0,
	['MonsterVariants_completed'] = 0,
	['MonsterVariants_total'] = 0,
	
	['Titles_completed'] = 0,
	['Titles_total'] = 0,
}

--playertracker = config.load('data/'.. windower.ffxi.get_player().name .. '.xml', playertracker)

playertitles = {}
playertitles = config.load('data/titles.xml', playertitles)


-------------------------------------------------
-- CONSTANTS
-------------------------------------------------
local FONT_SIZE    = 12
local LINE_HEIGHT  = 16
local PADDING      = 8
local CHAR_WIDTH   = 8
local VISIBLE_ROWS = 15

-------------------------------------------------
-- WINDOW STATE
-------------------------------------------------
local win_x = trackermenusettings.pos.x
local win_y = trackermenusettings.pos.y
local win_w = 280

local dragging = false
local drag_dx  = 0
local drag_dy  = 0

-------------------------------------------------
-- UI STATE
-------------------------------------------------
local active_tab = 1
local scroll     = 0
local selected   = 1

-------------------------------------------------
-- DATA
-------------------------------------------------
tabs = {
    {
        name = 'Main',
        items = {}
    },
    {
        name = 'Quests',
        items = {}
    },
    {
        name = 'Campaign',
        items = {}
    },
	{
        name = 'Coalitions',
        items = {}
    },
	{
        name = 'Key Items',
        items = {}
    },
	{
        name = 'Spells',
        items = {}
    },
	{
        name = 'Warps',
        items = {}
    },
	{
        name = 'Monstrosity',
        items = {}
    },
	{
        name = 'Titles',
        items = {}
    },
}

-------------------------------------------------
-- QUESTS STUFF HERE
-------------------------------------------------

util = require('util/util')
quest_util = require('util/quests')
warps_util = require('util/warps')
mons_util = require('util/monstrosity')
titles_util = require('util/titles')

local cmds = {
    help = S{'help','h'},
	hide = S{'hide'},
	show = S{'show'},
	test = S{'test'},

}

local function append_items(dst, src)
    if type(dst) ~= 'table' or type(src) ~= 'table' then
        return
    end
    for _, item in ipairs(src) do
        table.insert(dst, item)
    end
end

function append_maintab(text, ...)
	local args = {...}
	local menulinecolor = '(255,255,0)'
	if (args[1]==args[2]) then menulinecolor = '(0,255,0)' end
	table.insert(tabs[1].items, '\\cs' .. menulinecolor .. '--' .. text:format(...) .. '\\cr')
	
end

function update_maintab()
	
	tabs[1].items = {}
	
	table.insert(tabs[1].items, '- Missions')
	append_maintab('Campaign Ops %d/%d', playertracker['campaign_completed'], playertracker['campaign_total'])
	
	table.insert(tabs[1].items, '- Quests')
	append_maintab('Bastok Quests %d/%d', playertracker['bastokquests_completed'], playertracker['bastokquests_total'])
	append_maintab('San d\'Oria Quests %d/%d', playertracker['sandoriaquests_completed'], playertracker['sandoriaquests_total'])
	append_maintab('Windurst Quests %d/%d', playertracker['windurstquests_completed'], playertracker['windurstquests_total'])
	append_maintab('Jeuno Quests %d/%d', playertracker['jeunoquests_completed'], playertracker['jeunoquests_total'])
	append_maintab('Aht Urhgan Quests %d/%d', playertracker['ahturhganquests_completed'], playertracker['ahturhganquests_total'])
	append_maintab('Crystal War Quests %d/%d', playertracker['crystalwarquests_completed'], playertracker['crystalwarquests_total'])
	append_maintab('Outlands Quests %d/%d', playertracker['outlandsquests_completed'], playertracker['outlandsquests_total'])
	append_maintab('Other Quests %d/%d', playertracker['otherquests_completed'], playertracker['otherquests_total'])
	append_maintab('Abyssea Quests %d/%d', playertracker['abysseaquests_completed'], playertracker['abysseaquests_total'])
	append_maintab('Adoulin Quests %d/%d', playertracker['adoulinquests_completed'], playertracker['adoulinquests_total'])
	append_maintab('Coalition Assignments %d/%d', playertracker['coalitionquests_completed'], playertracker['coalitionquests_total'])

	table.insert(tabs[1].items, '- Key Items')
	append_maintab('Permanent Key Items %d/%d', playertracker['Permanent Key Items_completed'], playertracker['Permanent Key Items_total'])
	append_maintab('Magical Maps %d/%d', playertracker['Magical Maps_completed'], playertracker['Magical Maps_total'])
	append_maintab('Mounts %d/%d', playertracker['Mounts_completed'], playertracker['Mounts_total'])
	append_maintab('Claim Slips %d/%d', playertracker['Claim Slips_completed'], playertracker['Claim Slips_total'])

	table.insert(tabs[1].items, '- Magic')
	append_maintab('White Magic %d/%d', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
	append_maintab('Black Magic %d/%d', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
	append_maintab('Summoner Pacts %d/%d', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
	append_maintab('Ninjutsu %d/%d', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
	append_maintab('Bard Songs %d/%d', playertracker['BardSong_completed'], playertracker['BardSong_total'])
	append_maintab('Blue Magic %d/%d', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
	append_maintab('Geomancy %d/%d', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
	append_maintab('Trusts %d/%d', playertracker['Trust_completed'], playertracker['Trust_total'])

	table.insert(tabs[1].items, '- EXP')
	append_maintab('Job Points %d/%d', playertracker['Jobpoints_completed'], playertracker['Jobpoints_total'])
	append_maintab('Master Levels %d/%d (Highest: %d)', playertracker['Masterlevels_completed'], playertracker['Masterlevels_total'], playertracker['Masterlevels_highest'])
	
	table.insert(tabs[1].items, '- Warps')
	append_maintab('Home Points %d/%d', playertracker['Homepoints_completed'], playertracker['Homepoints_total'])
	append_maintab('Survival Guides %d/%d', playertracker['Survivalguides_completed'], playertracker['Survivalguides_total'])
	append_maintab('Waypoints %d/%d (untested)', playertracker['Waypoints_completed'], playertracker['Waypoints_total'])
	
	table.insert(tabs[1].items, '- Monstrosity (WIP)')
	append_maintab('Monster Levels %d/%d', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
	append_maintab('Race/Job Instincts %d/%d', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
	append_maintab('Monster Variants %d/%d', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
	
	table.insert(tabs[1].items, '----------------------')
	table.insert(tabs[1].items, '- Titles')
	append_maintab('Titles %d/%d', playertracker['Titles_completed'], playertracker['Titles_total'])
	append_items(tabs[1].items, titles_util.list_titles_bycontent())
	
	
	
end



windower.register_event('incoming chunk', function(id, data, modified, injected, blocked)
	if id == 0x056 then
		local p = packets.parse('incoming', data)
		local log = quest_logs[p.Type]
		-- do quests
		if log then
			if ((p.Type == 128)) then -- if Aht Urhgan Current Quests
				quests[log.type][log.area] = p["Current TOAU Quests"]
			elseif ((p.Type == 192)) then -- if Aht Urhgan Completed Quests
				quests[log.type][log.area] = p["Completed TOAU Quests"]
			else
				quests[log.type][log.area] = p['Quest Flags']
			end
		end
		
		-- do campaigns
		if (p.Type == 48) then
			campaings_completed_log['Completed Campaign Missions'] = p['Quest Flags']
		elseif (p.Type == 56) then
			campaings_completed_log['Completed Campaign Missions (2)'] = p['Quest Flags']
		end
		campaigns_completed = campaings_completed_log['Completed Campaign Missions'] .. campaings_completed_log['Completed Campaign Missions (2)']
		quests['completed']['campaign'] = campaigns_completed
		
		xichecklist_init()
    end
	
	
	if id == 0x063 then
		local parseddata = packets.parse('incoming', data)
		-- do warps
		if (parseddata.Order == 6) then 
			tabs[7].items = {}
			append_items(tabs[7].items, warps_util.checkhomepoints(data))
			append_items(tabs[7].items, warps_util.checksurvivalguides(data))
			append_items(tabs[7].items, warps_util.checkwaypoints(data))
			
		end
		-- do monstrosity
		if (parseddata.Order == 3) then
			mons_util.monster_levels = mons_util.char_field_to_table(parseddata['Monster Level Char field'])
			--monster_instincts = bytes_to_table(parseddata['Instinct Bitfield 1'])
			xichecklist_init()
		end
		if (parseddata.Order == 4) then
			mons_util.racejobinstincts = parseddata['Instinct Bitfield 3']
			mons_util.variants_bitfield = parseddata['Variants Bitfield']
			
			xichecklist_init()
		end
	end
	
	-- do titles
	if id == 0x033 then
		-- check title npc menu
		titles_util.check_titles_npc(data)
	elseif id == 0x061 then
		-- check player info (updated when openning menu)
		local parseddata = packets.parse('incoming', data)
		titles_util.add_title(parseddata['Title'])
	end
	
	--xichecklist_init()
	update_maintab()
	
end)



function xichecklist_init()
	
	--tabs[1].items = {} -- reset main menu content
	tabs[2].items = {} -- reset main menu content
	tabs[3].items = {} -- reset main menu content
	tabs[4].items = {} -- reset main menu content
	tabs[5].items = {} -- reset main menu content
	tabs[6].items = {} -- reset main menu content
	
	tabs[8].items = {} -- reset main menu content
	tabs[9].items = {} -- reset main menu content
	
	-- log quests
	tabs[2].items = quest_util.log_quests('sandoriaquests')
	append_items(tabs[2].items, quest_util.log_quests('bastokquests'))
	append_items(tabs[2].items, quest_util.log_quests('windurstquests'))
	append_items(tabs[2].items, quest_util.log_quests('jeunoquests'))
	append_items(tabs[2].items, quest_util.log_quests('ahturhganquests'))
	append_items(tabs[2].items, quest_util.log_quests('crystalwarquests'))
	append_items(tabs[2].items, quest_util.log_quests('outlandsquests'))
	append_items(tabs[2].items, quest_util.log_quests('otherquests'))
	append_items(tabs[2].items, quest_util.log_quests('abysseaquests'))
	append_items(tabs[2].items, quest_util.log_quests('adoulinquests'))
	
	-- log campaign ops
	tabs[3].items = quest_util.log_campaign(campaigns_completed)
	
	-- log coalitions
	tabs[4].items = quest_util.log_quests('coalitionquests')
	
	-- log keyitems
	tabs[5].items = check_keyitems('Permanent Key Items')
	append_items(tabs[6].items, check_keyitems('Magical Maps'))
	append_items(tabs[6].items, check_keyitems('Mounts'))
	append_items(tabs[6].items, check_keyitems('Claim Slips'))
	
	-- log spells and trusts
	tabs[6].items = check_playerspells('WhiteMagic')
	append_items(tabs[7].items, check_playerspells('BlackMagic'))
	append_items(tabs[7].items, check_playerspells('SummonerPact'))
	append_items(tabs[7].items, check_playerspells('Ninjutsu'))
	append_items(tabs[7].items, check_playerspells('BardSong'))
	append_items(tabs[7].items, check_playerspells('BlueMagic'))
	append_items(tabs[7].items, check_playerspells('Geomancy'))
	append_items(tabs[7].items, check_playerspells('Trust'))
		
	-- Log Job Points Spent
	check_jobpoints()
	
	-- log Monstrosity levels & Race/Job Instincts
	table.insert(tabs[8].items, '- Species Levels')
	append_items(tabs[8].items, mons_util.log_monsterlevels())
	table.insert(tabs[8].items, '- Monster Variants')
	append_items(tabs[8].items, mons_util.log_variants())
	table.insert(tabs[8].items, '- Race / Job Instincts')
	append_items(tabs[8].items, mons_util.log_racejobinstincts())
	
	-- log Monstrosity levels & Race/Job Instincts
	append_items(tabs[9].items, titles_util.log_titles())
	
end


-------------------------------------------------
-- STUFF HERE
-------------------------------------------------

local playerkeyitems = windower.ffxi.get_key_items()

function check_keyitems(keyitemtype)
	local keyitem_list = {}
	totalkeyitems = 0
	obtainedkeyitems = 0
	for id, value in pairs(res.key_items) do
		if (value.category == keyitemtype) then
			if table.find(playerkeyitems, id) then
				-- key item obtained
				obtainedkeyitems = obtainedkeyitems + 1
				totalkeyitems = totalkeyitems + 1
			else
				-- key item unobtained
				table.insert (keyitem_list, '\\cs(255,255,0)' .. value.en ..'\\cr') -- add unobtained keyitem
				totalkeyitems = totalkeyitems + 1
			end
		end
	end
	playertracker[keyitemtype..'_completed'] = obtainedkeyitems
	playertracker[keyitemtype..'_total'] = totalkeyitems
	return keyitem_list
end

local playerspells = windower.ffxi.get_spells()

function check_playerspells(spelltype)
	local spells_list = {}
	totalplayerspells = 0
	learnedspells = 0
	for id, value in pairs(res.spells) do
		if (value.type == spelltype) then
			if (playerspells[id] == true) then
				-- spell learned
				learnedspells = learnedspells + 1
				totalplayerspells = totalplayerspells + 1
			else
				-- spell unlearned
				table.insert (spells_list, '\\cs(255,255,0)' .. value.en ..'\\cr') -- add unlearned spell
				totalplayerspells = totalplayerspells + 1
			end
		end
	end
	playertracker[spelltype..'_completed'] = learnedspells
	playertracker[spelltype..'_total'] = totalplayerspells
	return spells_list
end

function check_jobpoints()
	local total_jp_spent = 0
	local total_master_levels = 0
	local highest_master_level = 0
	local playerinfo = windower.ffxi.get_player()
	-- job points
	if (type(playerinfo.job_points) == 'table') then 
		for job, value in pairs(playerinfo.job_points) do
			total_jp_spent = total_jp_spent + playerinfo.job_points[job].jp_spent
		end
	end
	playertracker['Jobpoints_completed'] = total_jp_spent
	local menulinecolor = '(255,255,0)'
	if (total_jp_spent==46200) then menulinecolor = '(0,255,0)' end
	table.insert(tabs[1].items, '\\cs' .. menulinecolor .. '-- Job Points '.. total_jp_spent .. '/46200\\cr')
	-- master levels
	if (type(playerinfo.master_levels) == 'table') then 
		for job, value in pairs(playerinfo.master_levels) do
			total_master_levels = total_master_levels + playerinfo.master_levels[job]
			if (playerinfo.master_levels[job] > highest_master_level) then highest_master_level = playerinfo.master_levels[job] end
		end
	end
	playertracker['Masterlevels_completed'] = total_master_levels
	playertracker['Masterlevels_highest'] = highest_master_level
end

-------------------------------------------------
-- TEXT OBJECT
-------------------------------------------------
local ui = texts.new('', {
    pos = { x = win_x, y = win_y },
    text = {
        font = 'Consolas',
        size = FONT_SIZE,
        red = 255, green = 255, blue = 255,
    },
    bg = {
        red = 25, green = 25, blue = 25,
        alpha = 200,
    },
    padding = PADDING,
})

ui:show()

-------------------------------------------------
-- HELPERS
-------------------------------------------------
local function inside(mx, my, x, y, w, h)
    return mx >= x and mx <= x + w
       and my >= y and my <= y + h
end

local function clamp_scroll(count)
    if selected < scroll + 1 then
        scroll = selected - 1
    elseif selected > scroll + VISIBLE_ROWS then
        scroll = selected - VISIBLE_ROWS
    end
    scroll = math.max(0, math.min(scroll, count - VISIBLE_ROWS))
end

-------------------------------------------------
-- LAYOUT CALC
-------------------------------------------------


-------------------------------------------------
-- DRAW
-------------------------------------------------
local function draw()
    local text = ''

    -- Tabs
    for i, tab in ipairs(tabs) do
        text = text .. (i == active_tab and '['..tab.name..'] ' or ' '..tab.name..'  ')
    end

    text = text .. '\n────────────\n'

    -- List
    local items = tabs[active_tab].items
	local count = #items
	if count == 0 then
        items = {'\\cs(128,128,128)No data\\cr'}
        count = 1
    end
	clamp_scroll(count)
    for i = 1, VISIBLE_ROWS do
        local idx = i + scroll
        if items[idx] then
            text = text .. (idx == selected and '\\cs(255,0,0)> ' or '  ') .. items[idx] .. '\\cr\n'
			--text = text .. 'test\n'
        end
    end

    ui:text(text)
    ui:pos(win_x, win_y)
	
	
end

draw()

-------------------------------------------------
-- MOUSE HANDLER
-------------------------------------------------
windower.register_event('mouse', function(type, x, y, delta, blocked)
    local px, py = ui:pos()
    local items = tabs[active_tab].items
    local count = #items

    -------------------------------------------------
    -- TAB CLICK
    -------------------------------------------------
    if type == 1 then
        local tx = px + PADDING
        local ty = py + PADDING
		
        for i, tab in ipairs(tabs) do
            local label =
                (i == active_tab and '['..tab.name..'] ' or ' '..tab.name..'  ')
            local w = #label * CHAR_WIDTH + i*2

            if inside(x, y, tx, ty, w, LINE_HEIGHT) then
                active_tab = i
                selected = 1
                scroll = 0
                draw()
                return true
            end
			
            tx = tx + w
        end
    end

    -------------------------------------------------
    -- DRAG WINDOW
    -------------------------------------------------
    if type == 1 and inside(x, y, px, py, win_w, LINE_HEIGHT + PADDING) then
        dragging = true
        drag_dx = x - px
        drag_dy = y - py
        return true
    end

    if type == 0 then dragging = false end

    if dragging and type == 1 then
        win_x = x - drag_dx
        win_y = y - drag_dy
		windower.add_to_chat(167, 'type 3 drag')
		trackermenusettings.pos.x = win_x
		trackermenusettings.pos.y = win_y
        draw()
        return true
    end

    -------------------------------------------------
    --[[ LIST CLICK
    -------------------------------------------------
    if type == 1 then
        local list_y = py + PADDING + LINE_HEIGHT * 2

        for i = 1, VISIBLE_ROWS do
            local idx = i + scroll
            local row_y = list_y + (i - 1) * LINE_HEIGHT

            if inside(x, y, px, row_y, win_w, LINE_HEIGHT) then
                if items[idx] then
                    selected = idx
                    clamp_scroll(count)
                    draw()
                    return true
                end
            end
        end
    end]]


	
	
	--------------------
	--- mouse scroll up down
	--------------------
	
	if delta and delta ~= 0 then
       --if inside(x, y, px, py, hit_w or win_w, hit_h or (hit_line_height * (VISIBLE_ROWS + 4))) then
            if delta > 0 then
                selected = math.max(1, selected - 1)
				clamp_scroll(count)
            else
                selected = math.min(count, selected + 1)
				clamp_scroll(count)
            end
            draw()
            return true
        --end
    end
	
	
	
end)


windower.register_event('addon command', function(...)
    if arg[1] == 'eval' then
        assert(loadstring(table.concat(arg, ' ',2)))()
    elseif cmds.help:contains(arg[1]) then
		
	elseif cmds.show:contains(arg[1]) then
		ui:show()
	elseif cmds.hide:contains(arg[1]) then
		ui:hide()
	elseif cmds.test:contains(arg[1]) then
		
		--update_maintab()
		windower.add_to_chat(100, "test")
		
		
    end
end)


-------------------------------------------------
-- CLEANUP
-------------------------------------------------
windower.register_event('unload', function()
    ui:destroy()
end)