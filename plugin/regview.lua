local rv = require('rv')

vim.api.nvim_create_user_command("Regview", function(opts)
    rv.run_regview()
end, {
    nargs = 0
})
