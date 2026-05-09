require("telescope").setup({
  defaults = {initial_mode = "normal"},

  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
      file_ignore_patterns = {
        ".next/",
        "node_modules/",
        ".git/",
        ".venv/",
        "__pycache__/",
        ".DS_Store"
      }
    },

    live_grep = {
      initial_mode = "insert",
      additional_args = {
        "--hidden",
        "--glob", "!.next/",
        "--glob", "!node_modules/",
        "--glob", "!.git/",
        "--glob", "!.venv/",
        "--glob", "!__pycache__/",
        "--glob", "!.DS_Store"
      }
    }
  }
})

local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep)
vim.keymap.set("n", "<leader>b", telescope_builtin.buffers)
