require "nvchad.autocmds"

-- Highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove "o"
    vim.opt_local.formatoptions:append "r"
  end,
  desc = "Decouple Insert/Normal auto-commenting",
})

-- wrap text on markdown files.
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.linebreak = true
--   end,
-- })

-- Dynamic tab titles for Ghostty (un-used since I use tmux now)
-- Create a group to prevent duplicate autocmds when re-sourcing
local title_group = vim.api.nvim_create_augroup("dynamic_title", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
  group = title_group,
  callback = function()
    -- Ensure the title feature is actually turned ON
    vim.opt.title = true

    local fname = vim.fn.expand "%:t"
    if fname == "" then
      fname = "[No Name]"
    end

    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    -- Using pcall or simple string formatting to ensure it doesn't error
    local success, _ = pcall(function()
      vim.opt.titlestring = fname .. " (" .. cwd .. ") - nvim"
    end)

    if not success then
      vim.opt.titlestring = "nvim"
    end
  end,
  desc = "Dynamic window title for Ghostty/AltTab",
})

-- vim.api.nvim_create_autocmd("VimLeave", {
--   group = vim.api.nvim_create_augroup("title_cleanup", { clear = true }),
--   callback = function()
--     vim.opt.title = false
--     vim.opt.titlestring = ""
--   end,
--   desc = "Reset window title when leaving Neovim",
-- })

-- vim.api.nvim_create_autocmd("BufDelete", {
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
--       vim.cmd "Nvdash"
--     end
--   end,
-- })

-- custom cursor start
-- local original_guicursor = vim.o.guicursor
--
-- local function with_cursor_highlight(guicursor, hl)
--   local parts = vim.split(guicursor, ",", { plain = true })
--
--   for i, part in ipairs(parts) do
--     local modes, style = part:match "^([^:]+):(.+)$"
--
--     if modes and style then
--       -- Preserve cursor shape/blinking configuration.
--       -- Remove an existing highlight group, if present.
--       --
--       -- Examples:
--       --   block-Cursor
--       --   ver25-Cursor
--       --   block-blinkwait700-blinkoff400-blinkon250-Cursor
--       style = style:gsub("%-[%a_@][%w_@%.]*$", "")
--
--       parts[i] = modes .. ":" .. style .. "-" .. hl
--     end
--   end
--
--   return table.concat(parts, ",")
-- end
--
-- local search_guicursor = with_cursor_highlight(original_guicursor, "SearchCursor")
--
-- local function cursor_inside_search_match()
--   if vim.v.hlsearch == 0 then
--     return false
--   end
--
--   local pattern = vim.fn.getreg "/"
--
--   if pattern == "" then
--     return false
--   end
--
--   -- Make vim.regex behave like normal / and ? searches
--   if not pattern:find("\\[cC]") then
--     if vim.o.ignorecase then
--       if vim.o.smartcase and pattern:match("%u") then
--         pattern = "\\C" .. pattern
--       else
--         pattern = "\\c" .. pattern
--       end
--     else
--       pattern = "\\C" .. pattern
--     end
--   end
--
--   local line = vim.api.nvim_get_current_line()
--   local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
--
--   local regex = vim.regex(pattern)
--   local offset = 0
--
--   while offset <= #line do
--     local start_col, end_col = regex:match_str(line:sub(offset + 1))
--
--     if start_col == nil then
--       break
--     end
--
--     start_col = start_col + offset
--     end_col = end_col + offset
--
--     if cursor_col >= start_col and cursor_col < end_col then
--       return true
--     end
--
--     offset = math.max(end_col, start_col + 1)
--   end
--
--   return false
-- end
--
-- local function update_search_cursor()
--   if cursor_inside_search_match() then
--     vim.o.guicursor = search_guicursor
--   else
--     vim.o.guicursor = original_guicursor
--   end
-- end
--
-- vim.api.nvim_create_autocmd({
--   "CursorMoved",
--   "CursorMovedI",
--   "CmdlineLeave",
-- }, {
--   callback = update_search_cursor,
-- })
-- custom cursor end
