-- ~/.config/nvim/lua/plugins/c_g_quit.lua
return {

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   opts = function(_, opts)
  --     local actions = require("telescope.actions")
  --     -- 确保 mappings 表存在
  --     opts.defaults.mappings = opts.defaults.mappings or {}
  --     opts.defaults.mappings.i = opts.defaults.mappings.i or {}
  --     opts.defaults.mappings.n = opts.defaults.mappings.n or {}
  --
  --     -- 将插入模式和普通模式下的 <C-g> 都映射为关闭 Telescope
  --     opts.defaults.mappings.i["<C-g>"] = actions.close
  --     opts.defaults.mappings.n["<C-g>"] = actions.close
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- 在补全菜单弹出时，按下 <C-g> 立即中止并关闭菜单
      opts.mapping["<C-g>"] = cmp.mapping.abort()
    end,
  },

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = function(_, opts)
  --     opts.window = opts.window or {}
  --     opts.window.mappings = opts.window.mappings or {}
  --     -- 在文件树中按 <C-g> 取消当前操作（等同于默认的 <Esc>）
  --     opts.window.mappings["<C-g>"] = "cancel"
  --   end,
  -- },

  -- LazyVim 默认用 Noice 接管了命令输入 (:) 和搜索 (/)
  -- {
  --   "folke/noice.nvim",
  --   opts = function(_, opts)
  --     -- Noice 通常会继承全局的 <C-g> -> <Esc> 映射
  --     -- 但如果你发现在某些特殊通知悬浮窗下关不掉，可以在全局 keymaps 里加入：
  --     -- vim.keymap.set("n", "<C-g>", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All Notifications" })
  --     -- 这一条视你的具体需求而定，通常第一步的全局 remap 已经够用了。
  --   end,
  -- },

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- 层层安全防护，防止报 nil 错误
      opts.picker = opts.picker or {}
      opts.picker.win = opts.picker.win or {}
      opts.picker.win.input = opts.picker.win.input or {}
      opts.picker.win.input.keys = opts.picker.win.input.keys or {}

      -- 将 <C-g> 映射为直接关闭弹窗 ("close")
      -- mode = { "n", "i" } 表示在 Normal (普通) 和 Insert (输入) 模式下都生效
      opts.picker.win.input.keys["<C-g>"] = { "close", mode = { "n", "i" } }

      -- 补充：如果你不想直接关闭，而是想让 <C-g> 像真正的 <Esc> 一样，
      -- 从“输入模式”退回到搜索框的“普通模式”（方便用 jk 上下移动选目标），
      -- 你可以把上面那行注释掉，换成下面这行：
      -- opts.picker.win.input.keys["<C-g>"] = { "stopinsert", mode = { "i" } }
    end,
  },
}
