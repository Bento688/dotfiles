local options = {
  formatters_by_ft = {

    -- web
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },

    -- scripting
    python = { "isort", "black" },
    lua = { "stylua" },

    -- systems & compiled
    go = { "goimports", "gofmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },

    java = { "google-java-format" },
  },

  format_on_save = nil,
  format_after_save = nil,

  -- {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 3000,
  --   lsp_fallback = true,
  -- },
}

return options
