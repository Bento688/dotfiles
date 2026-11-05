return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview", mode = "n" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop", mode = "n" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle", mode = "n" },
    },
    build = function(plugin)
      if vim.fn.executable "npx" == 1 then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        -- Force lazy to load the plugin path so the vim function becomes available
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    config = function()
      -- General settings
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_echo_preview_url = 0

      -- Render options
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }

      vim.g.mkdp_page_title = "「${name}」"
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark"

      -- Expand home directory for the image path
      vim.g.mkdp_images_path = vim.fn.expand "~/.markdown_images"
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",

    event = "VeryLazy",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },

    init = function()
      local function set_markdown_heading_colors()
        local colors = require("base46").get_theme_tb "base_30"

        local heading_colors = {
          colors.baby_pink,
          colors.teal,
          colors.green,
          colors.sun,
          colors.cyan,
          colors.purple,
        }

        for i, color in ipairs(heading_colors) do
          -- Raw markdown / cursor-line state
          vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", {
            fg = color,
            bold = true,
          })

          -- Rendered heading icon / foreground
          vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, {
            fg = color,
            bold = true,
          })

          -- Rendered heading body/background
          local bg_group = "RenderMarkdownH" .. i .. "Bg"
          local existing = vim.api.nvim_get_hl(0, {
            name = bg_group,
            link = false,
          })

          vim.api.nvim_set_hl(0, bg_group, {
            fg = color,
            bg = existing.bg,
            bold = true,
          })
        end

        vim.api.nvim_set_hl(0, "@markup.quote.markdown", {
          bg = "NONE",
        })
      end

      set_markdown_heading_colors()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_markdown_heading_colors,
      })
    end,

    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },

      quote = {
        repeat_linebreak = true,
      },

      win_options = {
        showbreak = {
          default = "",
          rendered = " ",
        },
        breakindent = {
          default = false,
          rendered = true,
        },
        breakindentopt = {
          default = "",
          rendered = "",
        },
      },

      overrides = {
        buflisted = {
          [false] = {
            code = {
              language_icon = false,
              left_pad = 0,
              right_pad = 0,
            },
            sign = {
              enabled = false,
            },
          },
        },
      },
    },
  },
}
