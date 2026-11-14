local util = {}
local bit = require('bit')

util.addon_log = function(str)
    windower.add_to_chat(161, '[Checklist] ' .. str)
end

util.has_bit = function(data, position)
    return data:unpack('q', math.floor(position/8)+1, position%8+1)
end

util.bytes_to_table = function(str)
    local t = {}
    for i = 1, #str do
        t[i - 1] = str:byte(i)
    end
    return t
end

util.twobits_to_table = function(data)
-- Extract 2-bit values into a table
	local result = {}
	for i = 1, #data do
		local byte = data:byte(i)
		-- Each byte contains 4 values (2 bits each)
		for j = 0, 3 do
			local shift = j * 2
			local value = bit.band(bit.rshift(byte, shift), 0x03)
			result[#result + 1] = value
		end
	end
	return result
end

util.fourbits_to_table = function(data)
    local result = {}
    for i = 1, #data do
        local byte = data:byte(i)
        -- lower 4 bits (bits 0–3)
        local low  = bit.band(byte, 0x0F)
        -- upper 4 bits (bits 4–7)
        local high = bit.band(bit.rshift(byte, 4), 0x0F)
        -- (LSB first)
        result[#result + 1] = low
        result[#result + 1] = high
    end
    return result
end

util.cleanspaces = function(str)
    return (str:gsub(" ", "_"))
end

util.list_item = function(category, text, completed, obtainmethod)
	if (completed ~= true) then completed = false end
	if (text == nil) then return end
	local item = {
		category = category,
		text = text,
		completed = completed,
		obtainmethod = obtainmethod,
	}
	return item
end

util.totalpoints = function()
	local completed, total = 0,0
	for key, value in pairs(playertracker) do
		if (key:sub(-10) == "_completed" and type(value) == "number") then
			completed = completed + value
		elseif (key:sub(-6) == "_total" and type(value) == "number") then
			total = total + value
		end
	end
	return completed, total
end

util.table_to_clipboard = function(tbl, showcompleted)
	local result = ""
    for i = 1, #tbl do
		local text = tostring(tbl[i].text)
		text = text:gsub("\\cs%(%d+,%d+,%d+%)", "")
		text = text:gsub("\\cr", "")
		if (tbl[i].completed and showcompleted) or (not tbl[i].completed) then
			result = result .. text .. "\n"
		end
    end
    return result
end

util.log_tablog = function(tbl, striplastbracket)
	for key, item in pairs(tbl) do
		local text = item.text
		text = text:gsub("\\cs%(%d+,%d+,%d+%)", "")
		text = text:gsub("\\cr", "")
		if (item.completed == false) then
			windower.add_to_chat(160, text)
		end
	end
end

return util