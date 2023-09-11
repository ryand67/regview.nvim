local parser = require('utils.parser')
local ui = require('ui.ui')

local M = {}


M.opts = {
    cmd_key = 'rv'
}

---the main plugin runner
local function run_regview()
    ui.prompt_regs(parser.get_regs())
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
