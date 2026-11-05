require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

o.relativenumber = true
o.number = true

o.wrap = false

o.scrolloff = 12

o.guicursor = "n-v-c-sm:block-blinkon0,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-blinkon0"

-- ==========================================
-- CUSTOM GUTTER ARCHITECTURE (Two Columns)
-- ==========================================

-- %s : Sign column (for Git additions, LSP error red dots)
-- %= : Right-align the following text
-- %l : Absolute line number
-- %r : Relative line number
-- %C : Folding column

o.statuscolumn = "%s %=%l  %r %C"

o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- CRITICAL: Prevent files from opening completely folded up
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99

o.sidescrolloff = 10
o.sidescroll = 10

-- Optional: If you want a dedicated column on the far left to show fold arrows
-- o.foldcolumn = "1"
