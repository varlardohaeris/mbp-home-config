return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        -- 注意：LazyVim 默认使用 nvim-jdtls，所以我们要针对 jdtls 进行特殊设置
        jdtls = function(_, opts)
          -- 这一步是为了防止 lspconfig 自动启动 jdtls，交给 nvim-jdtls 处理
          return true
        end,
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- opts.cmd 是一个包含了启动命令及其参数的 table
      -- Mason 安装的 jdtls 包装脚本支持通过 --jvm-arg 来传递参数

      table.insert(opts.cmd, "--jvm-arg=-Xmx12G")

      table.insert(opts.cmd, "--jvm-arg=-Xms12G")

      -- 如果你觉得还是慢，可以开启并行 GC（现代 JDK 默认通常是 G1，但显式指定也没坏处）
      table.insert(opts.cmd, "--jvm-arg=-XX:+UseG1GC")

      -- 还可以添加其他 JVM 调优参数
      -- table.insert(opts.cmd, "--jvm-arg=-XX:+UseStringDeduplication")
    end,
  },
}
