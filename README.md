# teastylua.nvim

teastylua.nvim is wrapper for [StyLua](https://github.com/JohnnyMorganz/StyLua).

## Requirements

- Neovim nightly (v0.5)
- StyLua

## Usage

For init.vim

```vim
nmap <Space>f <Plug>teastyluaFormat

"optional
let g:teastylua_options = '--search-parent-directories --config-path="path/to/config"'
```

For init.lua

```lua
vim.api.nvim_set_keymap("n", "<Space>f", "<Plug>teastyluaFormat")

-- optional
vim.g.teastylua_options = "--search-parent-directories --config-path="path/to/config""
```

Formats the current buffer when executed.
