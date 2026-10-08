-- ~/.config/nvim/lua/plugins/im-select.lua
return {
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup({
      default_im_select = "com.apple.keylayout.ABC",
      default_command = "/opt/homebrew/bin/im-select"
    })
  end,
}
