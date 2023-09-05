local M = {}

M.opts = {
    cmd_key = "*"
}

---sets up regview
---@param opts any
M.setup = function(opts)
    M.opts = vim.tbl_extend("force", M.opts, opts)
end

return M
