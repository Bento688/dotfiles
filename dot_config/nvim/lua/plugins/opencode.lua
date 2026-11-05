return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      { "folke/snacks.nvim", optional = true },
    },
    keys = {
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        desc = "Ask OpenCode",
        mode = { "n", "x" },
      },
      {
        "<leader>ox",
        function()
          require("opencode").select()
        end,
        desc = "OpenCode Actions",
        mode = { "n", "x" },
      },

      {
        "go",
        function()
          return require("opencode").operator "@this "
        end,
        desc = "Add range to OpenCode",
        mode = { "n", "x" },
        expr = true,
      },
      {
        "goo",
        function()
          return require("opencode").operator "@this " .. "_"
        end,
        desc = "Add line to OpenCode",
        mode = "n",
        expr = true,
      },
    },
    config = function()
      vim.g.opencode_opts = {}

      vim.o.autoread = true
    end,
  },
}
