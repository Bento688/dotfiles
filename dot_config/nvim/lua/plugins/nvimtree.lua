return {
  {
    "nvim-tree/nvim-tree.lua",

    opts = function(_, opts)
      opts.sync_root_with_cwd = true
      opts.respect_buf_cwd = true

      opts.update_focused_file = {
        enable = true,
        update_root = false,
      }

      opts.filters = {
        dotfiles = false,
        git_ignored = true,
        exclude = { ".env" },
      }

      opts.view = {
        signcolumn = "no",
      }

      -- Preserve NvChad/nvim-tree's existing mappings
      local old_on_attach = opts.on_attach

      opts.on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        if old_on_attach then
          old_on_attach(bufnr)
        else
          api.map.on_attach.default(bufnr)
        end

        -- Override `s`: reveal selected file in Finder
        vim.keymap.set("n", "s", function()
          local node = api.tree.get_node_under_cursor()

          if node and node.absolute_path then
            vim.system({
              "open",
              "-R",
              node.absolute_path,
            })
          end
        end, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          desc = "Reveal in Finder",
        })
      end
    end,
  },
}
