return {
  -- disable luasnip on cursor move
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      region_check_events = "CursorMoved,CursorMovedI",
      delete_check_events = "TextChanged,InsertLeave",
    },
  },

  -- indent blankline remove function scope
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = function(_, opts)
      opts.scope = { enabled = true }
      return opts
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      require("ibl").setup(opts)
    end,
  },

  -- NVIM SURROUND (ysiw)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- We leave this empty to inherit the mathematically perfect default mappings
      }
    end,
  },

  -- RAINBOW DELIMITERS
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "User FilePost",
  },
}
