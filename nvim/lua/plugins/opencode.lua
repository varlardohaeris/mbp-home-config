return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  -- 使用 LazyVim 推荐的 opts 表配置核心逻辑
  opts = {
    -- 核心修复 2：针对 v0.5.0+ 开启 server 自动启动
    server = {
      auto_start = true,
    },
  },
  config = function(_, opts)
    -- 核心修复 1：在插件加载前，强行将真实的 opencode 路径塞入 Neovim 的 PATH 环境变量最前面！
    -- 这样可以 100% 保证插件底层调用的是你刚才 which 出来的那个真实的 CLI 工具
    local opencode_bin_path = vim.fn.expand("~/.opencode/bin")
    if not string.find(vim.env.PATH, opencode_bin_path, 1, true) then
      vim.env.PATH = opencode_bin_path .. ":" .. vim.env.PATH
    end

    -- 将 LazyVim 组合好的 opts 注入给全局变量（该插件要求的强制机制）
    vim.g.opencode_opts = opts

    vim.o.autoread = true -- Required for `opts.events.reload`

    local opencode = require("opencode")

    -- 下面是你原有的快捷键映射
    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      opencode.ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      opencode.select()
    end, { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      opencode.toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function()
      return opencode.operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return opencode.operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function()
      opencode.command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      opencode.command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
