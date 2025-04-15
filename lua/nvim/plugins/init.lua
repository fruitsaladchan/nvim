Mo.C.init()

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>tt",
        function()
          Snacks.terminal.open()
        end,
        desc = "Open terminal",
      },
      {
        "<C-n>",
        function()
          Snacks.explorer()
        end,
        desc = "explorer",
      },
      {
        "<leader>bD",
        function()
          Snacks.bufdelete.other()
        end,
        desc = "Delete Other",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>nd",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>nh",
        function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History",
      },
    },
    opts = {
      zen = {
        show = {
          statusline = false,
          tabline = false,
        },
        toggles = {
          dim = false,
        },
      },
      indent = {
        indent = { char = "┊" },
        scope = { enabled = false },
        notifier = { enabled = true },
        chunk = { enabled = true },
        scroll = { enabled = true },
        filter = function(buf)
          return vim.g.snacks_indent ~= false
            and vim.b[buf].snacks_indent ~= false
            and vim.bo[buf].buftype == ""
            and vim.bo[buf].filetype ~= "markdown"
        end,
      },
      scope = { enabled = true },
      notifier = {
        icons = {
          error = "",
          warn = "",
          info = "",
          debug = "",
          trace = "",
        },
      },
      lazygit = {
        configure = false,
        win = { border = Mo.C.border },
      },
      terminal = {
        interactive = true,
      },
      input = { enabled = true },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            auto_close = true,
            layout = {
              preset = "sidebar",
              preview = false,
              layout = {
                position = "right",
              },
            },
            win = {
              list = {
                keys = {
                  ["<c-n>"] = "exit",
                },
              },
            },
          },
        },
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { folds = { open = true, git_hl = true } },
      words = { enabled = true },
      styles = {
        terminal = {
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd("stopinsert")
            else
              self.esc_timer:start(200, 0, function() end)
              return "<esc>"
            end
          end,
          mode = "t",
          expr = true,
          desc = "Double escape to normal mode",
          -- position = "float",
          height = 0.5,
          -- width = 0.9,
          -- zindex = 50,
          border = "rounded",
          keys = {
            q = "hide",
          },
        },
        notification = {
          wo = { wrap = true },
        },
        help = {
          position = "float",
          height = 0.9,
          width = 0.9,
          zindex = 50,
          border = "rounded",
        },
        input = {
          row = -3,
          col = -5,
          width = 32,
          relative = "cursor",
          title_pos = "left",
          keys = {
            i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
          },
        },
      },
      dashboard = {
        preset = {
          header = [[
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⠒⠒⠒⠒⠒⠲⠤⣄⡀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⣠⠴⠒⠋⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⢦⡀⠀⠀⠀⠀⠀⠙⠦⣀⣼⣿⠿⠛⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⠋⠉⠓⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢢⡀⢀⡠⣤⠖⠒⠛⢿⡁⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠹⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠒⠊⠉⢩⠏⠀⠃⠀⠀⠀⠀⠘⣆⢀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣤⣀⢳⠈⠙⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⠔⠋⠀⠀⠀⠀⠀⡞⠀⠀⠀⠀⢀⣠⣴⣶⣿⣿⣿⡿⠿⠿⠛⠛⠉⠉⠉⠀⡆⠀⠀⠀⠀⡀⠀⠀⠉⠹⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⣀⣳⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⠞⠁⢀⣀⣀⣀⠀⠀⠀⠸⣀⣠⣴⣾⣿⣿⣿⣿⢿⠟⠉⠀⠀⢠⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⢸⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠋⠉⠉⠁⠀⠀⠈⠉⠉⣳⣶⣿⣿⣿⣿⣿⡟⠋⣰⠋⠀⠀⡆⠀⡞⠀⠒⢤⣀⡴⢻⢱⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⡿⠀⢰⠃⠀⢀⣴⠃⢸⣃⣀⡤⠞⠉⠳⣼⠀⣇⠀⠀⠀⢸⡆⠀⠀⠀⠀⠰⡌⢿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⣸⠀⢠⡞⡿⠐⢺⣿⣹⣿⣿⣶⣄⠈⡗⡿⡄⠀⠀⢸⢹⡀⠀⠀⠀⠀⢳⣌⠻⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⣸⢰⡏⡇⡇⠀⢸⡃⡏⠹⠛⡇⠈⠃⠹⣇⠙⣄⠀⢺⣉⣯⢩⠐⠀⠀⢸⣿⣷⣿⣿⣟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⣿⡿⠁⠀⠀⠀⡏⡏⣧⡇⡇⢄⠀⢏⠙⠒⠊⠀⠀⠀⠀⠙⣆⠈⣲⣟⣿⠻⣿⡀⠀⠀⡜⠛⠉⠁⠀⠉⠑⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⡟⠀⠀⠀⠀⢰⡇⠃⣿⣷⢳⠈⡗⠮⢦⠀⠀⢀⠀⠀⠀⠀⢈⠀⠟⢻⠟⣴⣿⢻⠀⣸⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡖⡆⢠⠞⠀⢠⠟⡇⠀⢸⡇⣸⣿⣿⡎⢧⣷⠀⠀⠀⠀⡟⠚⠉⠒⢦⣈⠀⠙⠒⣽⢟⡇⠀⡴⢹⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⢱⠋⠀⠀⣼⠀⡇⠀⣸⢧⣿⣿⣿⣷⠀⠛⢧⠀⠀⠀⡇⠀⠀⠀⡴⠃⠀⢀⣼⣿⡼⣡⠞⡅⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⢧⠀⠀⡇⠀⡇⠀⣿⠟⠛⠿⣿⣿⡆⠀⠈⣆⠐⢤⣀⠀⠀⠋⣀⣠⣴⣿⣿⣿⣟⠁⠀⣳⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠹⡄⠸⣆⡴⡇⠀⣗⠚⠓⠂⠀⠀⠈⣿⣽⡀⠀⠘⡦⣬⡿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⡤⠞⠁⠳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠘⢿⡒⠢⢤⣀⠀⢀⡼⠁⠀⢧⠀⢻⠀⡇⠀⢹⠀⠀⠀⠀⠀⠀⠸⣷⣳⡀⠀⢸⣶⣿⣦⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⢱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⠢⢄⣀⠉⠛⠦⣄⣀⡸⡄⠀⢧⡇⠀⢸⣺⡉⡧⠤⡀⠀⠀⠳⡳⣷⡀⠀⠘⣿⣿⣧⣾⣾⣿⣿⣿⣿⣷⢻⣿⣿⣄⠀⠀⢻⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢨⠟⠲⢤⣀⠀⠉⠁⠀⠀⠁⠀⠘⣿⢿⣷⡓⣧⡀⠀⢳⠹⣝⢷⣄⠀⠘⣯⣽⣟⣿⡛⠻⠿⣟⣿⠘⣏⠻⠛⢦⡀⠀⢻⡳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⠋⣀⣤⠴⠚⠁⠀⠀⠀⠀⠀⠀⠀⠈⢧⣻⣷⢸⡇⠀⢸⠀⢸⣷⣝⠷⠀⠘⣿⣷⣿⣿⣷⣆⣿⣿⠀⢿⡄⠀⠀⠙⢦⡈⢷⠙⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠠⠶⣖⣋⣉⣁⡤⠤⢶⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⠃⠀⢸⠀⠀⠀⠈⣽⣶⣦⡟⣿⣿⣿⣿⡿⣇⢻⡀⢸⣿⡀⠀⠀⠈⢻⡾⣧⠈⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⡼⠁⠀⠀⠀⠀⠀⠀⢈⡷⢦⡤⠤⠤⠠⣄⣀⣀⣀⠀⠈⠓⢶⣋⠀⠀⠀⠸⣧⣬⣿⡇⠸⣿⣽⡇⠀⣘⣞⣿⠀⡟⣧⠀⠀⠀⠀⠱⡜⡄⠀⡷⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⠞⠀⠀⠀⠀⠀⠀⡀⠴⣿⠃⠀⠙⠦⣄⣀⣀⡴⠚⣟⠙⠒⠦⠤⠽⠇⠀⠀⠀⠀⠀⡏⡇⠀⢹⣿⣿⣩⣽⡛⣿⠀⢿⢻⣄⢀⠀⠀⠀⠈⢇⠀⢸⢿⡄⠀⠀⠀⠀⠀⠀⠀
⠀⣠⠋⠀⣰⠂⠀⣠⠔⠋⠀⢠⠇⠀⠀⠀⠀⠀⠀⣾⢀⣾⠸⡄⢠⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠇⠀⠀⣿⣿⠁⠀⢹⣿⠀⢸⠘⣿⡌⠳⣄⠀⠀⢸⠀⣧⡈⢷⠀⠀⠀⠀⠀⠀⠀
⡴⠃⠀⢠⡏⡠⠞⠁⠀⠀⢀⡏⠀⠀⠀⠀⠀⠀⢸⣏⡞⡏⠀⢳⡏⠀⠀⠀⠀⢠⠇⠀⠀⢠⢟⣠⠞⣠⣷⣿⠶⠯⣿⢸⣆⢸⡄⢿⣷⠀⠈⠙⢦⡸⣸⠁⠉⠺⣇⠀⠀⠀⠀⠀⠀
⠀⠀⢀⡿⠋⠀⠀⠀⠀⠀⡞⠀⠀⣀⣀⣀⣀⣀⣿⡿⠀⡇⠀⡼⠀⠀⠀⠀⠀⡜⠀⠐⠚⠉⣹⡭⠟⣿⣿⣿⡇⠀⢸⠸⡘⣦⡇⢸⢯⣇⠀⠀⢠⡷⡗⠢⣄⣀⡏⢽⡦⣀⠀⠀⠀
⠀⠀⢸⠁⠀⠀⠀⠀⠀⡼⠁⠀⠰⡇⠀⠀⠀⠀⠈⠉⠙⠓⢶⠃⠀⠀⠀⠀⢸⠃⠀⢀⡴⠃⢧⠖⣒⣿⡿⣿⣗⣤⡏⠀⠇⠹⣳⡄⡏⢿⡄⠴⠋⠀⠹⣄⡠⠞⠑⠢⢝⣎⠑⠦⣀
⠀⠀⡆⠀⠀⠀⠀⠀⡼⠁⠀⣰⠀⡇⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⢀⡏⢀⡴⠋⠀⠀⡞⠛⠋⣿⣷⣿⡇⠀⡸⠀⠀⠀⢷⠙⣇⠈⢧⠀⠀⠀⠀⢱⠀⠀⠀⠀⠀⠉⢧⠀⠀
⠀⢸⠀⠀⠀⠀⢀⡜⠁⠀⢠⡇⠀⠹⡀⠀⡀⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⣼⣴⠋⠀⢀⡴⠚⢳⣠⠔⠛⠛⠛⢇⣸⢥⡀⠀⢀⡼⠀⠈⢧⡘⡆⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠈⡆⠀
⠀⡜⠀⠀⠀⢠⠞⠀⠀⢀⣾⡇⠀⠀⢹⡞⠁⠀⠀⠀⠀⠘⢦⣀⠀⠀⡼⠋⠈⠉⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⡟⣦⡀⠀⠀⠹⣼⡀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⡇⠀
⠀⠇⠀⠀⡴⠋⠀⠀⢀⠼⢻⠇⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢺⣡⣤⡴⠒⠒⠒⠒⠒⠒⠒⠒⠲⠤⠤⢤⣀⣀⠀⢸⠱⡇⠙⢳⣄⠀⠘⠓⠦⢤⣀⠘⡇⠀⠀⠀⠀⠀⡇⠀
⠀⡇⣠⠞⠁⢀⣠⠔⠋⠀⢸⡀⠀⡞⣀⡤⠤⠤⠴⠒⠒⠒⢛⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠧⣽⡄⢸⠈⠱⣄⠀⠀⠀⠈⢿⡳⢤⠀⠀⠀⠀⡇⣀
⠀⡿⠵⠒⠚⠉⠀⠀⠀⠀⠈⡇⢰⢷⠃⠀⠀⢀⣀⣠⣼⠋⠉⠉⠉⠁⢠⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢾⡀⠀⠈⠻⣗⡲⠤⣀⠙⣎⢧⠀⠀⠸⠚⠁
⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠘⠗⣲⠞⠉⠉⢀⣾⠇⠀⠀⠀⠀⠀⣸⣿⡏⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⡀⠀⣷⢣⢿⢸⣧⣘⡎⡇⠀⠀⠀⠀
⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣄⡼⠁⠀⢀⣴⣿⣿⠀⠀⠀⠀⠀⠀⣿⣿⣇⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⣿⢯⢏⡞⡏⡼⡇⡇⠀⠀⠀⠀
⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀⣠⠴⠋⠀⣀⣤⣿⣿⣿⡇⠀⠀⠀⠀⠀⢰⣿⣿⣿⣴⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣟⢯⣴⣧⠃⠹⣽⠀⠀⠀⠀
⠓⢤⡈⢦⠀⠀⠀⣀⡤⠚⠁⢀⣤⣾⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⠃⠀⣰⡿⣛⠻⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡈⠛⢦⣀⠀⠀⠀⠀⠀
⠀⠀⠉⣚⣷⣴⡚⠁⠀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⡇⢀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣧⠀⠿⠸⠿⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣤⣤⣬⠷⡄⠀⠀⠀
⠀⠀⠛⠥⢄⣀⠉⣩⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⣠⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣏⠀⠀⠘⢦⠀⠀
  ]],
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
