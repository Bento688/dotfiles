return {

  -- ==========================
  -- SYNTAX ENGINE (Treesitter)
  -- ==========================
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    opts = {
      ensure_installed = {
        -- Neovim core (Never remove these)
        "vim",
        "lua",
        "vimdoc",

        -- Web & Fullstack
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",

        -- Backend & Systems
        "python",
        "go",
        "rust",
        "cpp",
        "c",

        -- Ops & Tooling
        "dockerfile",
        "yaml",
        "bash",
        "markdown",
      },

      indent = {
        enable = true,
        disable = {
          "javascript",
          "typescript",
          "tsx",
          "html",
        },
      },
    },
  },
}
