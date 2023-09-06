local utils = {}

utils.get_processed_reg = function()
    local regs = vim.api.nvim_exec([[ :reg ]], true)
    return utils.process(regs)
end

utils.split_string = function(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

utils.process = function(unp_regs)
    local regs = {}

    local split = utils.split_string(unp_regs, "\n")
    table.remove(split, 1)

    for k, v in pairs(split) do
        table.insert(regs, utils.process_reg(v))
    end

    return regs
end

utils.process_reg = function(reg)
    local r   = {}

    r.type    = string.sub(reg, 3, 3)
    r.reg     = string.sub(reg, 6, 7)
    r.content = string.sub(reg, 11)

    return r
end

return utils
