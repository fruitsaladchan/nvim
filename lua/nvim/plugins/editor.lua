local M = {

	{
		"windwp/nvim-ts-autotag",
		ft = { "tsx", "jsx", "html" },
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
				Rule("<", ">", "rust"):with_pair(cond.before_regex("%a+")):with_move(function(args)
					return args.char == ">"
				end),
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		keys = {
			{ "ys", desc = "Add surround" },
			{ "ds", desc = "Delete surround" },
			{ "cs", desc = "Replace surround" },
		},
		opts = { move_cursor = false },
	},

	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
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
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost" },
		keys = {
			{ "<leader>fT", "<Cmd>TodoTelescope<CR>", desc = "Find TODOs" },
			{
				"[T",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Prev TODO comment",
			},
			{
				"]T",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next TODO comment",
			},
		},
		opts = function()
			return {
				keywords = {
					TODO = { icon = " ", color = Mo.C.palette.green },
					HACK = { icon = " ", color = Mo.C.palette.peach },
					NOTE = { icon = " ", color = Mo.C.palette.blue, alt = { "INFO" } },
					PERF = { icon = " ", color = Mo.C.palette.mauve, alt = { "OPTIM" } },
					TEST = { icon = " ", color = Mo.C.palette.teal, alt = { "PASSED", "FAILED" } },
					WARN = { icon = " ", color = Mo.C.palette.yellow, alt = { "WARNING", "XXX" } },
					FIX = { icon = " ", color = Mo.C.palette.red, alt = { "FIXME", "FIXIT", "ISSUE" } },
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
		keys = {
			-- { "f", mode = { "n", "x", "o" } },
			-- { "F", mode = { "n", "x", "o" } },
			{
				"f",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"F",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
		opts = {
			jump = {
				pos = "end",
			},
			modes = {
				char = {
					-- autohide = true,
					jump_labels = function(motion)
						return vim.v.count == 0 and motion:find("[ftFT]")
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
				{ "<leader>a", group = "Ai", icon = " ", mode = { "n", "v" } },
				{ "<leader>b", group = "buffer", icon = " " },
				{ "<leader>c", group = "code", icon = " " },
				{ "<leader>d", group = "debug", icon = " " },
				{ "<leader>f", group = "find", icon = " " },
				{ "<leader>g", group = "git", icon = " " },
				{ "<leader>l", group = "lsp", icon = " " },
				{ "<leader>m", group = "markdown", icon = " " },
				{ "<leader>n", group = "notification", icon = "󱅫 " },
				{ "<leader>t", group = "test", icon = " " },
				{ "<leader>o", group = "option", icon = "󰘵 " },
				{ "<leader>p", group = "package", icon = " " },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "g", group = "goto" },
			},
			win = {
				title = false,
				no_overlap = false,
				border = Mo.C.border,
			},
			layout = {
				spacing = 5,
				align = "center",
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
