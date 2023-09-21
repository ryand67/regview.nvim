local parser = require('utils.parser')
local ui = require('ui.ui')

local M = {}

---the main plugin runner
M.run_regview = function()
    ui.prompt_regs(parser.get_regs())
end

return M
