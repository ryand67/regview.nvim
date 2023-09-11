local parser = require("utils.parser")

local ui = {}

---open ui window
---@param regs table register information
ui.open_window = function(regs)
    local buffer = vim.api.nvim_create_buf(true, false)
    local window = vim.api.nvim_open_win(buffer, true, ui.win_config(regs))

    for regNum = 1, #regs do
        vim.api.nvim_buf_set_lines(buffer, regNum - 1, regNum - 1, false, { regs[regNum] })
    end

    vim.api.nvim_set_option_value("readonly", true, { buf = buffer })
    vim.api.nvim_win_set_cursor(window, { 1, 1 })
end

ui.win_config = function(regs)
    local width = math.floor(vim.api.nvim_win_get_width(0) * .75)
    return {
        relative  = "editor",
        focusable = true,
        style     = "minimal",
        border    = "rounded",
        width     = width,
        height    = #regs + parser.get_overflow_number(regs, width),
        title     = "Regview:",
        row       = #regs,
        col       = 10
    }
end

return ui
