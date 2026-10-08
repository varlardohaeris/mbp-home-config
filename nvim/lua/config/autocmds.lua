-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

-- 监听 ColorScheme 事件，确保在任何主题加载后强行覆盖选中行颜色
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- 既然你觉得之前有点暗，这里换了一个【更亮、更饱满的紫色】
    -- 如果觉得太亮，可以换回 #5D3F7A 或者试试 #6A4B8D
    local highlight_bg = "#7B3B99"

    -- 定义所有需要变成紫色的高亮组
    local target_groups = {
      "CursorLine", -- 1. 通用光标行 (完美覆盖代码区、Neo-tree 侧边栏、Trouble 列表)
      "Visual", -- 2. Visual 模式 (鼠标拖拽或按 v 选中的区域)
      "PmenuSel", -- 3. LSP 自动补全下拉菜单的选中行
      "TelescopeSelection", -- 4. Telescope 搜索列表的选中行
      "SnacksPickerListCursorLine", -- 5. Snacks 选择器的选中行 (LazyVim 常用)
      "QuickFixLine", -- 6. Quickfix (快速修复) 列表的选中行
      "LspReferenceRead", -- 7. LSP 光标停留在变量上时，同名变量的高亮
      "LspReferenceText", -- 8. LSP 同名变量文本高亮
      "LspReferenceWrite", -- 9. LSP 同名变量写入高亮
    }

    -- 批量应用背景颜色
    for _, group in ipairs(target_groups) do
      vim.api.nvim_set_hl(0, group, { bg = highlight_bg, default = false })
    end

    -- (可选) 强烈建议把当前行号的背景也改掉，配上白色的字，这样你在左侧也能一眼看到光标在哪
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFFF", bg = highlight_bg, bold = true, default = false })
  end,
})

-- 帮助函数：模拟按键输入（带映射解析）
-- 为什么不用 normal! ？因为我们要触发 Treesitter 的插件快捷键，而不是 Vim 原生快捷键
local function goto_node(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "m", true)
end

-- ==========================================
-- 1. 方法 (Method / Function) 跳转命令
-- ==========================================
vim.api.nvim_create_user_command("GotoMethodBegin", function()
  goto_node("[f") -- LazyVim 默认：跳转到上一个/当前函数的开头
end, { desc = "Go to the beginning of the current method/function" })

vim.api.nvim_create_user_command("GotoMethodEnd", function()
  goto_node("]F") -- LazyVim 默认：跳转到下一个/当前函数的结尾
end, { desc = "Go to the end of the current method/function" })

-- ==========================================
-- 2. 类 (Class) 跳转命令
-- ==========================================
vim.api.nvim_create_user_command("GotoClassBegin", function()
  goto_node("[c") -- LazyVim 默认：跳转到上一个/当前类的开头
end, { desc = "Go to the beginning of the current class" })

vim.api.nvim_create_user_command("GotoClassEnd", function()
  goto_node("]C") -- LazyVim 默认：跳转到下一个/当前类的结尾
end, { desc = "Go to the end of the current class" })

-- ==========================================
-- 3. 代码块 (Block `{ }`) 跳转命令
-- ==========================================
-- 对于大括号代码块，Vim 原生的机制已经极其完美，直接调用原生跳转
vim.api.nvim_create_user_command("GotoBlockBegin", function()
  vim.cmd("normal![{")
end, { desc = "Go to the beginning of the current block '{'" })

vim.api.nvim_create_user_command("GotoBlockEnd", function()
  vim.cmd("normal! ]}")
end, { desc = "Go to the end of the current block '}'" })
