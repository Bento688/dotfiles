return {
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "vhyrro/luarocks.nvim", -- Recommended to manage the magick rock automatically
    },
    opts = {
      backend = "kitty", -- Ghostty uses kitty protocol
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
      },

      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,

      window_overlap_clear_enabled = false,
      pipe_path = "/tmp/nvim-image-" .. vim.fn.getpid(), -- Better performance on Unix

      editor_only_render_when_focused = true,

      tmux_show_only_in_active_window = true,
    },
  },
}
