
-- NOTE: Notification
return {
  "rcarriga/nvim-notify",
  -- lazy = false,
  config = function()
    require("notify").setup {
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade",
      timeout = 3000,
      top_down = true,
      time_formats = {
        notification = "%I:%M",
    },
  }
    vim.notify = require "notify"
  end,
}
