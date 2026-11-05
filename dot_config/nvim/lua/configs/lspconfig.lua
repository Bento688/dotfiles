local nvlsp = require "nvchad.configs.lspconfig"

local default_on_attach = nvlsp.on_attach

nvlsp.on_attach = function (client, bufnr)
  default_on_attach(client, bufnr)

  vim.keymap.set("n", "gd", function()
    require("telescope.builtin").lsp_definitions()
  end, {
    buffer = bufnr,
    desc = "[G]o to [D]efinition",
  })
end

nvlsp.defaults()

-- Lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Python
vim.lsp.config("pyright", {
  root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "uv.lock",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

-- PHP
vim.lsp.config("intelephense", {
  settings = {
    intelephense = {
      telemetry = {
        enabled = false,
      },
      files = {
        maxSize = 5000000,
      },
    },
  },
})

-- Enable servers
vim.lsp.enable {
  "lua_ls",
  "pyright",
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "gopls",
  "clangd",
  "rust_analyzer",
  "intelephense",
  "marksman",
  "yamlls",
  "gitlab_ci_ls",
  "csharp_ls"
}

vim.diagnostic.config { severity_sort = true }

-- Hover borders
local _hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function(opts)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return _hover(opts)
end

local _signature_help = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function(opts)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return _signature_help(opts)
end
