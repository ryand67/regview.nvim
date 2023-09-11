local utils = {}

utils.make_lines = function(orig, to_insert, cur_pos)
    return orig
end

utils.get_original_line = function(win, buf, cur_pos)
    return vim.api.nvim_buf_get_lines(buf, cur_pos[1] - 1, cur_pos[1], true)
end

return utils
