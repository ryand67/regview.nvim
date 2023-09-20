local parser = {}

parser.get_regs = function()
    return parser.get_printable_regs(), parser.get_structured_regs()
end

---Retrieves processed register information
---@return table reg info, table of tables { type, reg, content } shape
parser.get_structured_regs = function()
    local regs = parser.get_raw_regs()
    return parser.process(regs)
end

---processes raw regs to print in buffer
parser.get_printable_regs = function()
    local regs = parser.get_raw_regs()
    return parser.split_string(regs, "\n")
end

---returns the string from the :reg command
---@return string
parser.get_raw_regs = function()
    return vim.api.nvim_exec([[ :reg ]], true)
end

---returns the amount of lines that go over the allocated buffer width
---@param regs table table of reg strings
---@param buf_width number buffer width
---@return integer number of overflowing lines
parser.get_overflow_number = function(regs, buf_width)
    local count = 0

    for _, v in pairs(regs) do
        if #v > buf_width then
            count = count + 1
        end
    end

    return count
end

---process reg into final shape
---@param unp_regs string the response from the `:reg` command
---@return table reg info, table of tables { type, reg, content } shape
parser.process = function(unp_regs)
    local regs = {}

    local split = parser.split_string(unp_regs, "\n")
    table.remove(split, 1)

    for _, v in pairs(split) do
        table.insert(regs, parser.process_reg(v))
    end

    return regs
end

---split's the strings by seperator
---@param str string string to split
---@param sep string character to split on
---@return table
parser.split_string = function(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for s in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(t, s)
    end
    return t
end

---turns registers into a table of objects with reg information
---@param reg string register information
---@return table objects of register information
parser.process_reg = function(reg)
    local r   = {}

    r.type    = string.sub(reg, 3, 3)
    r.reg     = string.sub(reg, 6, 7)
    r.content = string.sub(reg, 11)

    return r
end

return parser
