-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
-- :lua print(vim.inspect(require("base46").get_theme_tb("base_30")))

local M = {}

local XXL_ZOOM = 116
local L_ZOOM = 150

-- separators
local separator_style = "block"
local sep_icons = {
  default = { left = "", right = "" },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}
local separators = sep_icons[separator_style]
local sep_l = separators["left"]
local sep_r = separators["right"]

local modes = {
  ["n"] = { "NORMAL", "Normal" },
  ["no"] = { "NORMAL (no)", "Normal" },
  ["nov"] = { "NORMAL (nov)", "Normal" },
  ["noV"] = { "NORMAL (noV)", "Normal" },
  ["noCTRL-V"] = { "NORMAL", "Normal" },
  ["niI"] = { "NORMAL i", "Normal" },
  ["niR"] = { "NORMAL r", "Normal" },
  ["niV"] = { "NORMAL v", "Normal" },
  ["nt"] = { "NTERMINAL", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },

  ["v"] = { "VISUAL", "Visual" },
  ["vs"] = { "V-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "V-LINE", "Visual" },
  ["Vs"] = { "V-LINE", "Visual" },
  ["\22"] = { "V-BLOCK", "Visual" },

  ["i"] = { "INSERT", "Insert" },
  ["ic"] = { "INSERT", "Insert" },
  ["ix"] = { "INSERT", "Insert" },

  ["t"] = { "TERMINAL", "Terminal" },

  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },

  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [" "] = { "S-BLOCK", "Select" },
  ["c"] = { "COMMAND", "Command" },
  ["cv"] = { "COMMAND", "Command" },
  ["ce"] = { "COMMAND", "Command" },
  ["cr"] = { "COMMAND", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}

M.base46 = {
  theme = "everforest",

  transparency = true,
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
  hl_add = {
    RainbowDelimiterRed = { fg = "red" },
    RainbowDelimiterYellow = { fg = "yellow" },
    RainbowDelimiterBlue = { fg = "blue" },
    RainbowDelimiterOrange = { fg = "orange" },
    RainbowDelimiterGreen = { fg = "green" },
    RainbowDelimiterViolet = { fg = "purple" },
    RainbowDelimiterCyan = { fg = "cyan" },

    CurSearch = {
      fg = "black",
      bg = "pink",
      bold = true,
    },

    SearchCursor = {
      fg = "black",
      bg = "red",
      bold = true,
    },
  },

  hl_override = {
    Folded = {
      fg = "#DCD7BA",
      bg = "#363646",
      italic = true,
      bold = true,
    },
    Comment = {
      fg = "#808080",
    },
    ["@comment"] = {
      fg = "#808080",
    },
    Search = {
      fg = "black",
      bg = "green",
    },
  },
}



M.nvdash = vim.o.columns > XXL_ZOOM and {
  load_on_startup = true,
  -- header = {
  --   "                                                      ",
  --   "                                                      ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "           ████████                ████████           ",
  --   "                                                      ",
  --   "        ▄▄                                  ▄▄        ",
  --   "        ██████████████████████████████████████        ",
  --   "          ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀          ",
  --   "                                                      ",
  --   "                                                      ",
  --   "       ",
  --   "                                                      ",
  -- },
  --
  -- header = {
  --   "                                                                     ",
  --   "   ██████╗ ███████╗███╗   ██╗████████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  --   "   ██╔══██╗██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  --   "   ██████╔╝█████╗  ██╔██╗ ██║   ██║   ██║   ██║██║   ██║██║██╔████╔██║ ",
  --   "   ██╔══██╗██╔══╝  ██║╚██╗██║   ██║   ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  --   "   ██████╔╝███████╗██║ ╚████║   ██║   ╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  --   "   ╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  --   "                                                                     ",
  --   "      ",
  --   "                                                                     ",
  -- },

  -- header = {
  --   "                                                                     ",
  --   "   ██████╗ ███████╗███╗   ██╗████████╗ ██████╗ ████████╗ ",
  --   "   ██╔══██╗██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗╚══██╔══╝ ",
  --   "   ██████╔╝█████╗  ██╔██╗ ██║   ██║   ██║   ██║   ██║    ",
  --   "   ██╔══██╗██╔══╝  ██║╚██╗██║   ██║   ██║   ██║   ██║    ",
  --   "   ██████╔╝███████╗██║ ╚████║   ██║   ╚██████╔╝   ██║    ",
  --   "   ╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝    ╚═╝    ",
  --   "                                                                     ",
  --   "      ",
  --   "                                                                     ",
  -- },

  header = {
    "                                                         ",
    "    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗   ",
    "    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║   ",
    "    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   ",
    "    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ",
    "    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║   ",
    "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝   ",
    "                                                         ",
    "                                                         ",
  },

  -- header = {
  --   "                                                         ",
  --   "    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗   ",
  --   "    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║   ",
  --   "    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   ",
  --   "    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ",
  --   "    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║   ",
  --   "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝   ",
  --   "                                                         ",
  --   "      ",
  --   "                                                         ",
  -- },

  -- header = {
  --   "                                                          ",
  --   "     ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓   ",
  --   "     ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒   ",
  --   "    ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░   ",
  --   "    ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██    ",
  --   "    ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒   ",
  --   "    ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░   ",
  --   "    ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░   ",
  --   "       ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░      ",
  --   "             ░    ░  ░    ░ ░        ░   ░         ░      ",
  --   "                                                          ",
  --   "      ",
  --   "                                                          ",
  -- },

  -- header = {
  --   "                                                         ",
  --   "    ███╗   ██╗███████╗ ██████╗ ██╗         ███╗   ███╗   ",
  --   "    ████╗  ██║██╔════╝██╔═══██╗╚██╗        ████╗ ████║   ",
  --   "    ██╔██╗ ██║█████╗  ██║   ██║ ╚██╗       ██╔████╔██║   ",
  --   "    ██║╚██╗██║██╔══╝  ██║   ██║ ██╔╝       ██║╚██╔╝██║   ",
  --   "    ██║ ╚████║███████╗╚██████╔╝██╔╝███████╗██║ ╚═╝ ██║   ",
  --   "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝ ╚══════╝╚═╝     ╚═╝   ",
  --   "                                                         ",
  --   "      ",
  --   "                                                         ",
  -- },
} or {
  load_on_startup = false
}

M.ui = {
  -- load tab buffer lines on start
  tabufline = {
    -- lazyload = false,
    enabled = false,
  },
  --
  telescope = {
    style = "borderless",
  },
  --
  statusline = {
    enabled = true,
    theme = "default",
    separator_style = separator_style,
    order = nil,
    modules = {
      file = function()
        local stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
        local path = vim.api.nvim_buf_get_name(stbufnr)

        -- check for an empty buffer
        if path == "" then
          return "%#St_file# 󱓞 %#St_file_sep#"
        end

        -- get path
        local rel_path = vim.fn.fnamemodify(path, ":~:.")
        local parts = vim.split(rel_path, "/")
        local processed_parts = {}

        -- shorten long paths
        local max_path_length = 35
        local max_length = 30

        -- get the number of columns
        local num_cols = vim.o.columns

        local keep_depth = 0
        if num_cols < XXL_ZOOM then
          keep_depth = 1
        elseif num_cols < L_ZOOM then
          keep_depth = 2
        else
          keep_depth = 3
        end

        -- if rel_path longer than 35, then shorten
        if #rel_path > max_path_length then
          for _, part in ipairs(parts) do
            if #part > max_length then
              local short_part = string.sub(part, 1, max_length - 1) .. "…"
              processed_parts[#processed_parts + 1] = short_part
            else
              processed_parts[#processed_parts + 1] = part
            end
          end
        else
          processed_parts = parts
        end

        local start_idx = math.max(1, #processed_parts - keep_depth + 1)
        local short_path = table.concat(processed_parts, "/", start_idx, #processed_parts)

        if start_idx > 1 then
          short_path = "…/" .. short_path
        end

        local filename = parts[#parts]
        local icon = "󰈚"

        local ok, devicons = pcall(require, "nvim-web-devicons")
        if ok then
          icon = devicons.get_icon(filename) or icon
        end

        local modified = vim.bo[stbufnr].modified and " (M)" or ""

        return string.format("%%#St_file# %s %s%s %%#St_file_sep#", icon, short_path, modified)
      end,
      git = function()
        if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
          return ""
        end

        local git_status = vim.b.gitsigns_status_dict

        local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
        local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
        local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
        local branch = git_status.head

        local max_length = 30
        if #branch > max_length then
          branch = string.sub(branch, 1, max_length - 1) .. "…"
        end

        local branch_name = " " .. branch

        local git_modules = " " .. branch_name .. added .. changed .. removed

        return "%#St_gitIcons#" .. git_modules
      end,
      mode = function ()
        local is_activewin = vim.api.nvim_get_current_win() == vim.g.statusline_winid

        if not is_activewin then
          return ""
        end

        local m = vim.api.nvim_get_mode().mode
        local num_cols = vim.o.columns

        local mode_text = ""

        if num_cols < XXL_ZOOM then
          -- shorten the mode name
          mode_text = modes[m][1]
          -- mode_text = modes[m][1]:sub(1, 1)
        else
          mode_text = modes[m][1]
        end

        local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. mode_text
        local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
        return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_l
      end,
    },
  },
}

M.buttons = {
  { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
  { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
  { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
  { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
  { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

  { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

  {
    txt = function()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime) .. " ms"
      return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
    end,
    hl = "NvDashFooter",
    no_gap = true,
    content = "fit",
  },

  { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
}

return M
