require "nvchad.mappings"

local map = vim.keymap.set

vim.api.nvim_create_user_command("Rfinder", function()
  local path = vim.api.nvim_buf_get_name(0)
  os.execute("open -R " .. path)
end, {})

-- =========================================================
-- INSERT MODE KEYBINDINGS
-- =========================================================
-- Map (j + j) to Esc
map("i", "jj", "<ESC>", { desc = "Escape insert mode" })
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- =========================================================
-- NORMAL MODE KEYBINDINGS
-- =========================================================

-- Git bindings
map("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "Git diff this" })

map("n", "<leader>gD", function()
  require("gitsigns").diffthis "~"
end, { desc = "Git diff this against the last commit" })

map("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { desc = "Git diff this" })

-- === Navigation (Buffers) ===
-- map("n", "<S-h>", "<cmd> bprevious <CR>", { desc = "Previous buffer" })
-- map("n", "<S-l>", "<cmd> bnext <CR>", { desc = "Next buffer" })

-- === Splits (Creating them) ===
map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>s", "<C-w>s", { desc = "Split window horizontally" })

map("n", "<Up>", ":resize +4<CR>", { desc = "Upsize Horizontal Split +" })
map("n", "<Down>", ":resize -4<CR>", { desc = "Downsize Horizontal Split -" })
map("n", "<Left>", ":vertical resize -4<CR>", { desc = "Downsize Vertical Split -" })
map("n", "<RIght>", ":vertical resize +4<CR>", { desc = "Upsize Vertical Split +" })

-- === Pane Navigation (Moving between splits) ===
map("n", "<leader>h", "<C-w>h", { desc = "Focus left split" })
map("n", "<leader>j", "<C-w>j", { desc = "Focus below split" })
map("n", "<leader>k", "<C-w>k", { desc = "Focus above split" })
map("n", "<leader>l", "<C-w>l", { desc = "Focus right split" })

-- copy file/line/column info
map("n", "<leader>cp", function()
  local file = vim.fn.expand "%"
  local line = vim.fn.line "."
  local col = vim.fn.col "."
  local location = string.format("%s:%d:%d", file, line, col)

  vim.fn.setreg("+", location)
  print("Copied: " .. location)
end, { desc = "Copy file path with line and column" })

-- === Scroll ===
map("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
map("n", "<C-d>", "<C-d>zz", { desc = "Page down" })

map("n", "<C-o>", "<C-o>zz", { desc = "Go back to previous location" })
map("n", "<C-i>", "<C-i>zz", { desc = "Step into a newer location" })

map("n", "zl", "15zl", { desc = "Scroll Right 15 Characters" })
map("n", "zh", "15zh", { desc = "Scroll Left 15 Characters" })

-- === Code Actions & LSP =========================================

-- map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action (Quick Fix)" })
-- map("n", "gr", "<cmd>Telescope lsp_references<cr>zz", { desc = "Telescope to reference" })

map("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]o to [D]efinition" })

map("n", "<leader>p", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format Document" })

-- LSPsaga
-- hover
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", {
  silent = true,
  desc = "LSP Hover",
})

-- Peek definition
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", {
  silent = true,
  desc = "Peek definition",
})

-- Finder: definition + references etc.
map("n", "gr", "<cmd>Lspsaga finder<CR>", {
  silent = true,
  desc = "LSP Finder",
})

-- Code actions
map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", {
  silent = true,
  desc = "Code action",
})

-- Rename
map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", {
  silent = true,
  desc = "Rename symbol",
})

-- Diagnostics
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {
  silent = true,
  desc = "Previous diagnostic",
})

map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", {
  silent = true,
  desc = "Next diagnostic",
})

-- Outline
map("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", {
  silent = true,
  desc = "Symbols outline",
})

-- Show diagnostic error in a floating window
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostic error" })

-- Jump to type def
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Jumps to the type definition of the symbol under the cursor" })

-- Efficiently jump between errors in the file
-- map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
-- map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })

-- ===========================================================

-- just for learning reference
-- === TELESCOPE CHANGE CWD ===
-- map("n", "<leader>fc", function()
--   local builtin = require "telescope.builtin"
--   local actions = require "telescope.actions"
--   local action_state = require "telescope.actions.state"
--
--   builtin.find_files {
--     prompt_title = "Open Workspace (Change CWD)",
--
--     -- 1. Force the engine to only return directories (ignores files)
--     find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
--
--     -- 2. Define where the search starts
--     cwd = "~/Documents/Codes/",
--
--     attach_mappings = function(prompt_bufnr, map)
--       actions.select_default:replace(function()
--         actions.close(prompt_bufnr)
--
--         local selection = action_state.get_selected_entry()
--
--         vim.cmd("cd " .. selection.path)
--
--         print("Workspace anchored to: " .. selection.path)
--       end)
--
--       return true
--     end,
--   }
-- end, { desc = "Find and Open Folder" })

-- ==================================================================================================================
-- VISUAL MODE KEYBINDINGS
-- ==================================================================================================================

-- === Stay in visual mode while indenting ===
-- (The 'gv' command re-selects the previous visual block)
map("v", "<", "<gv", { desc = "Outdent and keep selection" })
map("v", ">", ">gv", { desc = "Indent and keep selection" })

-- === Move selected lines while staying in visual mode ===
-- (This uses a command-line trick to move the text, then reselect and re-indent)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- === Toggle Comment ===
-- (NvChad maps 'gc' to comment. This hits 'gc' while maintaining visual mode)
map("v", "<leader>c", "gc", { desc = "Toggle comment selection" })

map("x", "<leader>cp", function()
  local file = vim.fn.expand "%"

  -- In active Visual mode:
  -- "v" = one end of the selection
  -- "." = the cursor / other end
  local start_pos = vim.fn.getpos "v"
  local end_pos = vim.fn.getpos "."

  local s_line, s_col = start_pos[2], start_pos[3]
  local e_line, e_col = end_pos[2], end_pos[3]

  -- Normalize in case you selected backwards
  if s_line > e_line or (s_line == e_line and s_col > e_col) then
    s_line, e_line = e_line, s_line
    s_col, e_col = e_col, s_col
  end

  local location = string.format("%s:%d:%d-%d:%d", file, s_line, s_col, e_line, e_col)

  vim.fn.setreg("+", location)
  print("Copied: " .. location)
end, { desc = "Copy visual selection file range" })

map({ "n", "v" }, "<leader>fm", function()
  require("conform").format {
    lsp_fallback = true,
    async = false, -- Synchronous formatting is safer for visual ranges
    timeout_ms = 3000,
  }
  -- Optional: Drop back to normal mode after formatting
  local mode = vim.api.nvim_get_mode().mode
  if mode:match "v" or mode:match "V" or mode:match "\22" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  end
end, { desc = "Format File or Highlighted Range" })

-- ==========================================
-- THE VOID PASTE (ThePrimeagen Special)
-- ==========================================
-- Highlight text, then <leader>p to paste over it
-- without losing the original word in your buffer.
map("x", "<leader>p", [["_dP]])

-- ==================================================================================================================
