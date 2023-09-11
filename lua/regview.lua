local parser = require('utils.parser')
local ui = require('ui.ui')

local M = {}


M.opts = {
    cmd_key = "\""
}

---the main plugin runner
local function run_regview()
    -- local regs = parser.get_structured_regs()
    ui.open_window(parser.get_printable_regs())
end

---sets up regview
---@param opts table
M.setup = function(opts)
    if type(opts) == "table" then
        M.opts = vim.tbl_extend("force", M.opts, opts)
    end

    vim.keymap.set('n', M.opts.cmd_key, run_regview, {})
end

return M
