return {
  {
    "alexmozaidze/palenight.nvim",
    opts = {
      on_highlights = function(hl, c)
        -- 修改常规的光标所在行
        hl.CursorLine = { bg = "#5D3F7A" }

        -- 修改 Telescope 列表选中的背景
        hl.TelescopeSelection = { bg = "#5D3F7A" }

        -- 修改补全菜单选中的背景
        hl.PmenuSel = { bg = "#5D3F7A" }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "palenight",
    },
  },
}
