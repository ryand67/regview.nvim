local utils = {}

utils.make_lines = function(orig, to_insert, cur_pos)
    local start = string.sub(orig, 1, cur_pos[2])
    local new_end = string.sub(orig, cur_pos[2], #orig)

    return start .. utils.trim_start(to_insert) .. new_end
end

utils.trim_start = function(s)
    local count = 0
    for i = 1, #s do
        if string.sub(s, i, i) == " " then
            count = count + 1
        else
            break
        end
    end

    return string.sub(s, count, #s)
end

utils.get_original_line = function(win, buf, cur_pos)
    return vim.api.nvim_buf_get_lines(buf, cur_pos[1] - 1, cur_pos[1], true)[1]
end

return utils
