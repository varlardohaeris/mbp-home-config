-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua
--

local map = vim.keymap.set
map({ "i", "n", "v", "c", "s", "t" }, "<C-g>", "<Esc>", { remap = true, desc = "Equivalent to Escape" })

vim.keymap.set("n", "f.", function()
  Snacks.picker.files({
    cwd = vim.fn.expand("%:p:h"), -- 获取当前文件的完整目录路径
    title = "Files (Current Dir)", -- 自定义标题（可选）
  })
end, { desc = "Find Files (Current Directory)" })
