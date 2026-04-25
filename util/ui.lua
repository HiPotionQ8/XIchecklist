texts = require('texts')
-- UI CONSTANTS
FONT_SIZE    = 12
LINE_HEIGHT  = 16
PADDING      = 8
CHAR_WIDTH   = 8
VISIBLE_ROWS = 15
-- UI WINDOW STATE
active_tab = 1
scroll     = 0
selected   = 1
-- UI DATA
tabs = {
    {
        name = 'Main',
        items = {}
    },
    {
        name = 'Story',
        items = {}
    },
    {
        name = 'Campaign',
        items = {}
    },
	{
        name = 'Fish',
        items = {}
    },
	{
        name = 'Key Items',
        items = {}
    },
	{
        name = 'Magic',
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
	{
        name = 'RoE',
        items = {}
    },
	{
        name = 'Battle Content',
        items = {}
    },
}

-- UI TEXT OBJECT
ui = texts.new('', {
    pos = { x = trackermenusettings.pos.x, y = trackermenusettings.pos.y },
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

function append_items(dst, src)
    if type(dst) ~= 'table' or type(src) ~= 'table' then
        return
    end
    for _, item in ipairs(src) do
		local text = item.text
		local display = true
		local menucolor = '(255,255,0)'
		if (item.completed == true and trackermenusettings.showcompleted == false) then
			display = false
		end
		if item.completed == true then
			menucolor = '(0,255,0)'
		end
		if item.obtainmethod ~= nil then
			local obtainmethod = '\\cs(255,255,255)[' .. item.obtainmethod .. ']\\cr\\cs'..menucolor
			if item.category == 'Titles' then
				text = obtainmethod..' '..text
			else
				text = text..' '..obtainmethod
			end
		end
		if item.category ~= nil then 
			text = '['..item.category..'] '..text
		end
		local text = '\\cs'..menucolor..text..'\\cr'
		if (display == true) then
			table.insert(dst, text)
		end
    end
end

function append_maintab(text, ...)
	local args = {...}
	local menulinecolor = '(255,255,0)'
	if (args[1]==args[2]) then menulinecolor = '(0,255,0)' end
	table.insert(tabs[1].items, '\\cs'..menulinecolor..'-'..text:format(...)..'\\cr')
end

function append_header(tab, text, ...)
	args = {...}
	local menulinecolor = '(255,255,255)'
	if (args[1]==args[2]) then menulinecolor = '(0,255,0)' end
	text = '==== '..text..' ===='
	table.insert(tabs[tab].items, '\\cs'..menulinecolor..text:format(...)..'\\cr')
	if args[2] == 0 then
		table.insert(tabs[tab].items, '\\cs(235,0,0)You must zone to update.\\cr')
	end
end

function append_addonhelp(tab, text, condition)
	if not (condition and trackermenusettings.showcompleted) then
		append_items(tabs[tab].items, {util.list_item('Addon Help', '\\cs(235,0,0)'..text..'\\cr', condition)})
	end
end

-- UI HELPERS
function inside(mx, my, x, y, width, h)
	return mx >= x and mx <= x + width
		and my >= y and my <= y + h
end

function clamp_scroll(count)
	if selected < scroll + 1 then
		scroll = selected - 1
	elseif selected > scroll + VISIBLE_ROWS then
		scroll = selected - VISIBLE_ROWS
	end
	scroll = math.max(0, math.min(scroll, count - VISIBLE_ROWS))
end

function draw()
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
		-- add active_tab helper text here
		items = {'\\cs(128,128,128)Change zones to update Quests / Campaigns / Warps / Monstrosity \\cr', '\\cs(128,128,128)Check the README or "//xic help" to register NPC-related data \\cr'}
		count = 1
	end
	clamp_scroll(count)
	for i = 1, VISIBLE_ROWS do
		local idx = i + scroll
		if items[idx] then
			text = text .. (idx == selected and '\\cs(255,0,0)> ' or '  ') .. items[idx] .. '\\cr\n'
		end
	end
	ui:text(text)
	ui:pos(trackermenusettings.pos.x, trackermenusettings.pos.y)
end