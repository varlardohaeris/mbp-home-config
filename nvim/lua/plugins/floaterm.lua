return {
  "voldikss/vim-floaterm",
  lazy = false,
  cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
  -- 确保按键在 "n"(普通) 和 "t"(终端) 模式下都生效
  keys = {
    -- 1. 设置 Toggle 快捷键 (比如 F12 或 Ctrl+t)
    -- 这里的 <cmd>...<cr> 写法在终端模式下也能直接触发命令，无需先退回普通模式
    { "<F12>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Floaterm" },

    -- 如果你想用 Ctrl + / (在某些终端下是 <C-/> 或 <C-_>)
    { "<C-/>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Floaterm" },

    -- wsl2
    { "<C-_>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Floaterm" },
    -- 2. 创建新终端 (多个 Terminal)
    { "<leader>fn", "<cmd>FloatermNew<cr>", mode = { "n", "t" }, desc = "New Floaterm" },

    -- 3. 切换下一个/上一个终端 (循环切换 session)
    { "<F10>", "<cmd>FloatermPrev<cr>", mode = { "n", "t" }, desc = "Prev Floaterm" },
    { "<F11>", "<cmd>FloatermNext<cr>", mode = { "n", "t" }, desc = "Next Floaterm" },
  },
  config = function()
    -- vim-floaterm 是 VimL 插件，通过 vim.g 全局变量配置
    vim.g.floaterm_width = 0.8 -- 宽度 (0-1 为百分比，>1 为像素)
    vim.g.floaterm_height = 0.8 -- 高度
    vim.g.floaterm_border = "rounded" -- 边框样式：single, double, rounded, solid, shadow, none
    vim.g.floaterm_title = "Terminal ($1)" -- 标题
    vim.g.floaterm_keymap_new = "<Nop>" -- 禁用插件默认键位，避免冲突
    vim.g.floaterm_keymap_prev = "<Nop>"
    vim.g.floaterm_keymap_next = "<Nop>"
    vim.g.floaterm_keymap_toggle = "<Nop>"

    -- 让终端窗口在打开时自动进入插入模式 (可选)
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "floaterm://*",
      callback = function()
        vim.cmd("startinsert")
      end,
    })
  end,
}
