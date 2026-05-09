-- NOTE: keymaps related to a plugin are found in that plugin's lua file

vim.keymap.set("n", "gl", vim.diagnostic.setloclist)
vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[b", vim.cmd.bprevious)
vim.keymap.set("n", "]b", vim.cmd.bnext)
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end , {desc = "Clear floating windows with esc in normal mode"})
