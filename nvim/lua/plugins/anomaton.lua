return {
  {
    "eandrju/cellular-automaton.nvim",
    -- 这个插件不需要在启动时加载，按键触发时再加载即可（Lazy Loading），不拖慢启动速度
    keys = {
      -- 经典用法：当你遇到修不好的 Bug，心态崩溃时，按下 <leader>fml (F**k My Life)
      {
        "<leader>fml",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Make it rain (代码瀑布)",
      },
      -- 另一种效果：康威生命游戏，代码会像细胞一样繁衍和死亡
      {
        "<leader>gol",
        "<cmd>CellularAutomaton game_of_life<CR>",
        desc = "Game of Life (代码生命游戏)",
      },
      -- 第三种效果：乱码打乱，代码瞬间变成一团乱麻
      {
        "<leader>scr",
        "<cmd>CellularAutomaton scramble<CR>",
        desc = "Scramble (代码搅碎机)",
      },
    },
  },
}
