local M = {
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "vue", "tsx", "jsx", "html" },
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = { map = "<M-e>" },
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      autopairs.setup(opts)
      autopairs.add_rules({
        Rule("<", ">", "rust"):with_pair(cond.before_regex("%a+:?:?$", 3)):with_move(function(args)
          return args.char == ">"
        end),
      })
    end,
  },

  {
    "kylechui/nvim-surround",
    keys = {
      { "gsa", desc = "Add surround", mode = { "n", "v" } },
      { "gsc", desc = "Change surround" },
      { "gsd", desc = "Delete surround" },
      { "<C-g>s", desc = "Add surround", mode = { "i" } },
      { "<C-g>S", desc = "Add surround", mode = { "i" } },
    },
    opts = {
      move_cursor = false,
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "gsa",
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = "gsa",
        visual_line = false,
        delete = "gsd",
        change = "gsc",
        change_line = false,
      },
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
        },
      }
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost" },
    -- stylua: ignore
    keys = {
      { "<leader>fT", function() Snacks.picker.todo_comments() end, desc = "Find TODOs" },
      { "[T", function() require("todo-comments").jump_prev() end, desc = "Prev TODO comment" },
      { "]T", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
    },
    opts = function()
      return {
        -- stylua: ignore
        keywords = {
          TODO = { icon = " ", color = Mo.C.palette.green },
          HACK = { icon = " ", color = Mo.C.palette.peach },
          NOTE = { icon = " ", color = Mo.C.palette.blue, alt = { "INFO" } },
          PERF = { icon = " ", color = Mo.C.palette.mauve, alt = { "OPTIM" } },
          TEST = { icon = " ", color = Mo.C.palette.teal, alt = { "PASSED", "FAILED" } },
          WARN = { icon = " ", color = Mo.C.palette.yellow, alt = { "WARNING", "XXX" } },
          FIX  = { icon = " ", color = Mo.C.palette.red, alt = { "FIXME", "FIXIT", "ISSUE" } },
        },
        gui_style = { fg = "BOLD" },
        highlight = {
          before = "",
          keyword = "wide_fg",
          after = "",
        },
      }
    end,
  },

  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      { "t", mode = { "n", "x", "o" } },
      { "T", mode = { "n", "x", "o" } },
      { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    opts = {
      jump = { pos = "end", offset = 0 },
      modes = {
        char = {
          -- autohide = true,
          jump_labels = function(motion)
            -- never show jump labels by default
            -- return false
            -- Always show jump labels for ftFT
            return vim.v.count == 0 and motion:find("[ftFT]")
            -- Show jump labels for ftFT in operator-pending mode
            -- return vim.v.count == 0 and motion:find("[ftFT]") and vim.fn.mode(true):find("o")
          end,
          jump = {
            autojump = true,
          },
        },
      },
      prompt = {
        enabled = true,
        prefix = { { " 󰉂 ", "FlashPromptIcon" } },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>a", group = "ai", icon = "󰭻", mode = { "n", "v" } },
        { "<leader>b", group = "buffer", icon = " " },
        { "<leader>c", group = "code", icon = " " },
        { "<leader>d", group = "debug", icon = " " },
        { "<leader>f", group = "find", icon = " " },
        { "<leader>g", group = "git", icon = " " },
        { "<leader>l", group = "lsp", icon = " " },
        { "<leader>m", group = "markdown", icon = " " },
        { "<leader>n", group = "notification", icon = "󱅫 " },
        { "<leader>t", group = "test", icon = " " },
        { "<leader>o", group = "option", icon = " " },
        { "<leader>p", group = "package", icon = " " },
        { "[", group = "prev" },
        { "]", group = "next" },
      },
      win = {
        title = false,
        no_overlap = false,
        border = Mo.C.border,
      },
      layout = {
        spacing = 5,
      },
      plugins = {
        marks = false,
        registers = false,
      },
      show_help = false,
    },
  },
}

return M
