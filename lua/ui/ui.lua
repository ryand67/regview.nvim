local parser = require("utils.parser")
local utils = require("utils.utils")

local ui = {}

---open ui window
---@param printable_regs table register information
ui.prompt_regs = function(regs)
    local printable_regs = regs.printable
    local structured_regs = regs.structured

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()
    local original_curpos = vim.api.nvim_win_get_cursor(original_win)

    local original_line = utils.get_original_line(original_win, original_buf, original_curpos)

    local buffer = vim.api.nvim_create_buf(true, false)
    local window = vim.api.nvim_open_win(buffer, true, ui.win_config(printable_regs))

    for regNum = 1, #printable_regs do
        vim.api.nvim_buf_set_lines(buffer, regNum - 1, regNum - 1, false, { printable_regs[regNum] })
    end

    vim.api.nvim_buf_set_option(buffer, 'readonly', true)
    vim.api.nvim_buf_set_option(buffer, 'modified', false)
    vim.api.nvim_win_set_cursor(window, { 1, 1 })

    vim.keymap.set({ 'n', 'i', 'v' }, '<Esc>', function()
        vim.api.nvim_win_close(window, true)
    end, { buffer = buffer })

    vim.keymap.set({ 'n', 'i', 'v' }, 'q', function()
        vim.api.nvim_win_close(window, true)
    end, { buffer = buffer })

    local cur_pos
    vim.keymap.set({ 'n', 'i', 'v' }, '<cr>', function()
        -- -1 because we need to offset for the type name content header
        cur_pos = vim.api.nvim_win_get_cursor(window)[1] - 1
        if cur_pos < 1 or cur_pos > #printable_regs - 1 then
            return
        end

        local s = utils.make_lines(original_line, structured_regs[cur_pos].content, original_curpos)

        vim.api.nvim_buf_set_lines(original_buf, original_curpos[1] - 1, original_curpos[1], true, { s })
    end, { buffer = buffer })
end

ui.win_config = function(regs)
    local width = math.floor(vim.api.nvim_win_get_width(0) * .75)

    return {
        relative  = "mouse",
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
