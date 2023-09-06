local utils = require('utils')

local M = {}

M.opts = {
    cmd_key = "\""
}

local function run_regview()
    local reg = utils.get_processed_reg()
    P(reg)
end

---sets up regview
---@param opts any
M.setup = function(opts)
    if type(opts) == "table" then
        M.opts = vim.tbl_extend("force", M.opts, opts)
    end

    vim.keymap.set('n', M.opts.cmd_key, run_regview, {})
end

return M
