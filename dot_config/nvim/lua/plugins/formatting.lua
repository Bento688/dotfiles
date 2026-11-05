return {

  -- ==========================
  -- FORMATTING ENGINE (Conform)
  -- ==========================

  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
}
