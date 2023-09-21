# regview.nvim

<!--toc:start-->
- [regview.nvim](#regviewnvim)
  - [About](#about)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Todo](#todo)
<!--toc:end-->

## About
A Neovim plugin that makes the register process more seamless.
![regview screenshot](./screenshots/regview.png)

## Installation
Install it just like any other Neovim plugin

```lua
use 'ryand67/regview.nvim'
```

## Usage
```lua
vim.keymap.set("n", "rv", ":Regview<CR>")
```

## Todo
* UI launch on cursor maybe
* Rearrange register content would be cool
* Highlight register content in window
