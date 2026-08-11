texts = require('util/texts')
-- UI CONSTANTS
UI_SCALE				= tonumber(trackermenusettings.ui_scale) or 1
FONT_SIZE				= function() return 12 * UI_SCALE end
SUBTAB_FONT_SIZE 		= function() return 0.8 * FONT_SIZE() end
LINE_HEIGHT				= function() return 16 * UI_SCALE end
PADDING					= function() return 8 * UI_SCALE end
SUBTAB_PADDING			= function() return 0.8 * PADDING() end
CHAR_WIDTH				= function() return (FONT_SIZE()/(2*UI_SCALE)) * UI_SCALE end
VISIBLE_ROWS			= 15
-- UI COLORS
UI_BG					= {red = 12, green = 12,  blue = 32,  alpha = 210}
UI_TABBG				= {red = 30, green = 60,  blue = 120,  alpha = 240}
UI_TABBG_SELECTED		= {red = 70, green = 130, blue = 200, alpha = 220}
UI_SUBTABBG				= {red = 75, green = 75,  blue = 100,  alpha = 200}
UI_SUBTABBG_SELECTED	= {red = 70, green = 130, blue = 200, alpha = 220}
UI_SUBTABBG_COMPLETED	= {red = 35, green = 110,  blue = 35,  alpha = 220}
-- UI WINDOW STATE
active_tab				= 1
active_subtab			= 0
scroll					= 0
selected				= 1
maintabs_height			= 0
subtabs_height			= 0
subtabs_initiated 		= false
subtabs_drawn 			= false
-- UI DATA
tabs = {
    {
        name = 'Main',
        items = L{},
		button = {},
    },
    {
        name = 'Story',
        items = L{},
		button = {},
		tabs = {'sandoriamissions', 'bastokmissions', 'windurstmissions', 'zilartmissions', 'copmissions', 'assaults', 'ahturhganmissions', 'campaign', 'wotgmissions', 'acpmissions', 'mkdmissions', 'asamissions', 'soamissions', 'rovmissions', 'tvrmissions', 'sandoria', 'bastok', 'windurst', 'jeuno', 'ahturhgan', 'crystalwar', 'outlands', 'other', 'abyssea', 'adoulin', 'coalition'},
    },
	{
        name = 'Other Content',
        items = L{},
		button = {},
		tabs = {'fishes', 'ergonlocus', 'jobpoints', 'masterlevels'},
    },
	{
        name = 'Key Items',
        items = L{},
		button = {},
		tabs = {'Permanent_Key_Items', 'Magical_Maps', 'Mounts', 'Active_Effects', 'Abyssea', 'Voidwatch', 'Mog_Garden', 'Claim_Slips', 'atmacite'},
    },
	{
        name = 'Magic',
        items = L{},
		button = {},
		tabs = {'WhiteMagic', 'BlackMagic', 'SummonerPact', 'Ninjutsu', 'BardSong', 'BlueMagic', 'Geomancy', 'Trust', 'CorsairRoll', 'pupattachments'}
    },
	{
        name = 'Warps',
        items = L{},
		button = {},
		tabs = {'homepoints', 'survivalguides', 'waypoints', 'telepoints', 'cavernousmaws', 'lycopodium', 'eschanportals', 'outposts', 'protowaypoints', 'zones', 'abysseaconflux',
		'unknownwarps',
		},
    },
	{
        name = 'Monstrosity',
        items = L{},
		button = {},
		tabs = {'monsterlevels', 'monstervariants', 'racejobinstincts', 'monsterinstincts'},
    },
	{
        name = 'Titles',
        items = L{},
		button = {},
		tabs = {'titles', 'titles_by_content', 'titles_by_content_detailed'},
    },
	{
        name = 'RoE',
        items = L{},
		button = {},
		tabs = {'roe'},
    },
	{
        name = 'Battle Content',
        items = L{},
		button = {},
		tabs = {'mmm_mazecount', 'mmmvouchers','mmmrunes','meebleburrows','sheola','sheolb','sheolc','sheolgaol','vorseals', 'emporox'},
    },
}

subtabs = T{}

-- UI TEXT OBJECT
ui = {}
ui.menu = texts.new('', {
    pos = { x = trackermenusettings.pos.x, y = trackermenusettings.pos.y },
    text = {
        font = 'Arial',
        size = FONT_SIZE(),
        red = 255, green = 255, blue = 255,
    },
    bg = {
        red = UI_BG.red, green = UI_BG.green, blue = UI_BG.blue,
        alpha = UI_BG.alpha,
    },
    padding = PADDING(),
})

ui.showcompleted = texts.new('', {
			pos = { x = 0, y = 0},
			text = {
				font = 'Arial',
				size = FONT_SIZE(),
				red = 255, green = 255, blue = 255,
			},
			bg = {
				red = UI_SUBTABBG.red, green = UI_SUBTABBG.green, blue = UI_SUBTABBG.blue,
				alpha = UI_SUBTABBG.alpha,
			},
			padding = PADDING(),
			flags = {
				--right = true,
				--bottom = true,
				draggable = false,
			},
		})
ui.showcompleted:text('Show Completed')
ui.showcompleted:register_event('left_click', function()
	trackermenusettings.showcompleted = not trackermenusettings.showcompleted
	util.addon_log('showcompleted: '..tostring(trackermenusettings.showcompleted))
	trackermenusettings:save()
	xichecklist_updatemenulogs()
	if trackermenusettings.showcompleted then
		ui.showcompleted:bg_color(UI_SUBTABBG_SELECTED.red, UI_SUBTABBG_SELECTED.green, UI_SUBTABBG_SELECTED.blue)
		ui.showcompleted:bg_alpha(UI_SUBTABBG_SELECTED.alpha)
	else
		ui.showcompleted:bg_color(UI_SUBTABBG.red, UI_SUBTABBG.green, UI_SUBTABBG.blue)
		ui.showcompleted:bg_alpha(UI_SUBTABBG.alpha)
	end
end)
ui.showcompleted:hide()

initiate_tabs = function()
	for i, tab in ipairs(tabs) do
		tabs[i].button = texts.new('', {
			pos = { x = ui.menu:pos_x(), y = ui.menu:pos_y()},
			text = {
				font = 'Arial',
				size = FONT_SIZE(),
				red = 255, green = 255, blue = 255,
			},
			bg = {
				red = UI_TABBG.red, green = UI_TABBG.green, blue = UI_TABBG.blue,
				alpha = UI_TABBG.alpha,
			},
			padding = PADDING(),
			flags = {
				draggable = false,
			},
		})
		tabs[i].button:text(tab.name)
		tabs[i].button:register_event('left_click', function()
			if tabs[i].tabs then
				tabs[i].items = L{}
				for idx, tab in ipairs(tabs[i].tabs) do
					append_header(i, tab_logs[tab].name..' (%d/%d)', tab_logs[tab].completed, tab_logs[tab].total)
					if (addonhelptext[tab]) then
						for hi, helptext in pairs(addonhelptext[tab]) do
							append_addonhelp(i, addonhelptext[tab][hi][1], playertracker.talk_to_npc[addonhelptext[tab][hi][2]])
						end
					end
					append_items(tabs[i].items, tab_logs[tab].items)
				end
			end
			active_tab = i
			active_subtab = 0
			selected = 1
			scroll = 0
			subtabs_drawn = false
			draw()
		end)
		if tabs[i].tabs then
			initiate_subtabs(i, tabs[i].tabs)
		end
	end
	subtabs_initiated = true
end

initiate_subtabs = function(activetab, subtabslist)
	tabs[activetab].subtabs = {}
	for i, tab in ipairs(subtabslist) do
		tabs[activetab].subtabs[i] = {}
		tabs[activetab].subtabs[i].active_tab = activetab
		tabs[activetab].subtabs[i].button = texts.new('', {
			pos = {x = 0, y = 0},
			text = {
				font = 'Arial',
				size = FONT_SIZE(),
				red = 255, green = 255, blue = 255,
			},
			bg = {
				red = UI_SUBTABBG.red, green = UI_SUBTABBG.green, blue = UI_SUBTABBG.blue,
				alpha = UI_SUBTABBG.alpha,
			},
			padding = PADDING(),
			flags = {
				draggable = false,
			},
		})
		tabs[activetab].subtabs[i].button:text(defaulttab_logs[tab].name)
		tabs[activetab].subtabs[i].tab = tab
		tabs[activetab].subtabs[i].button:register_event('left_click', function()
			tabs[activetab].items = L{}
			append_header(activetab, tab_logs[tab].name..' (%d/%d)', tab_logs[tab].completed, tab_logs[tab].total)
			if (addonhelptext[tab]) then
				for i, helptext in pairs(addonhelptext[tab]) do
					append_addonhelp(activetab, addonhelptext[tab][i][1], playertracker.talk_to_npc[addonhelptext[tab][i][2]])
				end
			end
			append_items(tabs[activetab].items, tab_logs[tab].items)
			active_subtab = i
			selected = 1
			scroll = 0
			subtabs_drawn = false
			draw()
		end)
	end
end

draw_tabs = function()
	local total_xextent, total_yextent = 0, 0
	local xextent, yextent = 0, 0
	for i, tab in ipairs(tabs) do
		tabs[i].button:pos(ui.menu:pos_x()+total_xextent, ui.menu:pos_y())
		tabs[i].button:visible(ui.menu:visible())
		tabs[i].button:size(FONT_SIZE())
		tabs[i].button:pad(PADDING())
		if active_tab == i then
			tabs[i].button:bg_color(UI_TABBG_SELECTED.red, UI_TABBG_SELECTED.green, UI_TABBG_SELECTED.blue)
			tabs[i].button:bg_alpha(UI_TABBG_SELECTED.alpha)
		else
			tabs[i].button:bg_color(UI_TABBG.red, UI_TABBG.green, UI_TABBG.blue)
			tabs[i].button:bg_alpha(UI_TABBG.alpha)
		end
		xextent, yextent = tabs[i].button:extents()
		total_xextent = total_xextent + xextent
	end
	ui.width = total_xextent
	maintabs_height = yextent
end

draw_subtabs = function()
	if subtabs_initiated and subtabs_drawn then return end
	local total_xextent, total_yextent = 0, maintabs_height+PADDING()
	local xextent, yextent = 0, 0
	local lines = 0
	hide_subtabs()
	if tabs[active_tab].subtabs then
		lines = 1
		for i, tab in pairs(tabs[active_tab].subtabs) do
			tabs[active_tab].subtabs[i].button:pos(ui.menu:pos_x()+total_xextent, ui.menu:pos_y()+total_yextent)
			local tabname = tabs[active_tab].subtabs[i].tab
			tabs[active_tab].subtabs[i].button:text(defaulttab_logs[tabname].name .. ' (%d/%d)':format(tab_logs[tabname].completed, tab_logs[tabname].total))
			tabs[active_tab].subtabs[i].button:visible(ui.menu:visible())
			tabs[active_tab].subtabs[i].button:size(SUBTAB_FONT_SIZE())
			tabs[active_tab].subtabs[i].button:pad(SUBTAB_PADDING())
			xextent, yextent = tabs[active_tab].subtabs[i].button:extents()
			total_xextent = total_xextent + xextent + 7
			if active_subtab == i then
				tabs[active_tab].subtabs[i].button:bg_color(UI_SUBTABBG_SELECTED.red, UI_SUBTABBG_SELECTED.green, UI_SUBTABBG_SELECTED.blue)
				tabs[active_tab].subtabs[i].button:bg_alpha(UI_SUBTABBG_SELECTED.alpha)
			else
				if (tab_logs[tabname].completed >= tab_logs[tabname].total) and (tab_logs[tabname].total > 0) then
					tabs[active_tab].subtabs[i].button:bg_color(UI_SUBTABBG_COMPLETED.red, UI_SUBTABBG_COMPLETED.green, UI_SUBTABBG_COMPLETED.blue)
					tabs[active_tab].subtabs[i].button:bg_alpha(UI_SUBTABBG_COMPLETED.alpha)
				else
					tabs[active_tab].subtabs[i].button:bg_color(UI_SUBTABBG.red, UI_SUBTABBG.green, UI_SUBTABBG.blue)
					tabs[active_tab].subtabs[i].button:bg_alpha(UI_SUBTABBG.alpha)
				end
			end
			if total_xextent > ui.width then
				total_xextent = xextent + 7
				lines = lines + 1
				total_yextent = total_yextent + yextent + 3
				tabs[active_tab].subtabs[i].button:pos(ui.menu:pos_x(), ui.menu:pos_y()+total_yextent)
			end
		end
	end
	subtabs_height = (lines > 0 ) and total_yextent or 0
	local menuexextent, menuyextent = ui.menu:extents()
	local showcompletedxextent, showcompletedextent = ui.showcompleted:extents()
	ui.showcompleted:pos(trackermenusettings.pos.x+menuexextent-showcompletedxextent, trackermenusettings.pos.y+menuyextent-showcompletedextent)
	ui.showcompleted:visible(ui.menu:visible())
end

hide_subtabs = function()
	for i, tab in ipairs(tabs) do
		if tabs[i].subtabs then
			for ti, tab in pairs(tabs[i].subtabs) do
				tabs[i].subtabs[ti].button:hide()
			end
		end
	end
	ui.showcompleted:hide()
	subtabs_height = 0
end

append_items = function(dst, src)
    if type(dst) ~= 'table' or type(src) ~= 'table' then
        return
    end
    for _, item in ipairs(src) do
		dst:append(item)
    end
end

format_item = function(item)
	local text = item.text
	local menucolor = item.completed and '(0,255,0)' or '(255,255,0)'
	if item.obtainmethod ~= nil then
		local obtainmethod = '\\cs(255,255,255)[' .. item.obtainmethod .. ']\\cr\\cs'..menucolor
		if item.category == 'Titles' then
			text = obtainmethod..' '..text
		else
			text = text..' '..obtainmethod
		end
	end
	text = '\\cs'..menucolor..text..'\\cr'
	
	return text
end

append_maintab = function(text, ...)
	local args = {...}
	local menulinecolor = (args[1]==args[2]) and '(0,255,0)' or '(255,255,0)'
	tabs[1].items:append(util.list_item(nil, '\\cs'..menulinecolor..'-'..text:format(...)..'\\cr'))
end

append_header = function(tab, text, ...)
	args = {...}
	local menulinecolor = (args[1]==args[2]) and '(0,255,0)' or '(255,255,255)'
	text = '==== '..text..' ===='
	tabs[tab].items:append(util.list_item(nil, '\\cs'..menulinecolor..text:format(...)..'\\cr'))
	if args[2] == 0 then
		tabs[tab].items:append(util.list_item(nil, '\\cs(235,0,0)You must zone to update.\\cr'))
	end
end

append_addonhelp = function(tab, text, condition)
	if not (condition and trackermenusettings.showcompleted) then
		append_items(tabs[tab].items, {util.list_item('Addon Help', '\\cs(235,0,0)'..text..'\\cr', condition)})
	end
end

-- UI HELPERS
inside = function(mx, my, x, y, width, h)
	return mx >= x and mx <= x + width
		and my >= y and my <= y + h
end

clamp_scroll = function(count)
	if selected < scroll + 1 then
		scroll = selected - 1
	elseif selected > scroll + VISIBLE_ROWS then
		scroll = selected - VISIBLE_ROWS
	end
	scroll = math.max(0, math.min(scroll, count - VISIBLE_ROWS))
end

draw = function()
	local text = ''
	if ui.width then
		text = text .. '\n'.. '─':rep((PADDING()/CHAR_WIDTH())+(ui.width/(2*CHAR_WIDTH()))) .. '\n'
	else
		text = text .. '\n────────────────────────────────────────────────────────────────\n'
	end
	if subtabs_height > 0 then
		text = text .. ('\n'):rep(subtabs_height/LINE_HEIGHT()-1)
	end
	-- List
	local items = tabs[active_tab].items
	if (trackermenusettings.showcompleted == false) then
		items = items:filter(function(item)
			return item.completed == false
		end)
	end
	local count = items:length()
	if count == 0 then
		-- add active_tab helper text here
		--items = {'\\cs(128,128,128)Change zones to update Quests / Campaigns / Warps / Monstrosity \\cr', '\\cs(128,128,128)Check the README or "//xic help" to register NPC-related data \\cr'}
		items = {util.list_item(nil, '\\cs(128,128,128)Change zones to update Quests / Campaigns / Warps / Monstrosity \\cr \n \\cs(128,128,128)Check the README or "//xic help" to register NPC-related data \\cr')}
		count = 1
	end
	clamp_scroll(count)
	for i = 1, VISIBLE_ROWS do
		local idx = i + scroll
		if items[idx] then
			text = text .. (idx == selected and '\\cs(255,0,0)> ' or '  ') .. format_item(items[idx]) .. '\\cr\n'
		end
	end
	ui.menu:text(text)
	ui.menu:pos(trackermenusettings.pos.x, trackermenusettings.pos.y)
	local menuexextent, menuyextent = ui.menu:extents()
	local showcompletedxextent, showcompletedextent = ui.showcompleted:extents()
	ui.showcompleted:pos(trackermenusettings.pos.x+menuexextent-showcompletedxextent, trackermenusettings.pos.y+menuyextent-showcompletedextent)
	--ui.showcompleted:show()
end

initiate_tabs()

-------------------------------------------------
windower.register_event('prerender', function()
	draw_tabs()
	draw_subtabs()
	draw()
	if not subtabs_drawn then
		coroutine.sleep(0.1)
		subtabs_drawn = true
	end
end)

ui.menu:register_event('drag', function()
	subtabs_drawn = false
	draw_tabs()
	draw_subtabs()
end)

windower.register_event('mouse', function(type, x, y, delta, blocked)
	if (ui.menu:visible() == false) then return end
    local px, py = ui.menu:pos()
    local items = tabs[active_tab].items
    local count = #items
	-- save new UI pos if changed
	if (px ~= trackermenusettings.pos.x) and (py ~= trackermenusettings.pos.y) then
		trackermenusettings.pos.x = px
		trackermenusettings.pos.y = py
		trackermenusettings:save()
	end
	-- mouse scroll up down
	if delta and delta ~= 0 then
		if ui.menu:hover(x, y) then
			if delta > 0 then
				selected = math.max(1, selected - 1)
				clamp_scroll(count)
			else
				selected = math.min(count, selected - delta)
				clamp_scroll(count)
			end
			draw()
			return true
		end
	end
end)