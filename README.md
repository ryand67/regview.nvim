# regview.nvim

## About
A neovim plugin that makes the register process more seamless.

## Usage
Simply call the `setup` function in your neovim config and pass in your desired keyboard command (default is `rv`).

```lua
require('regview').setup({
           cmd_key = 'xy' 
        })
```

## Todo
* UI launch on cursor maybe
* Rearrange register content would be cool
