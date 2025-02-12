local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Grep (root dir)" },
		{ "<leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "Find word" },
		{ "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
		{ "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search" },
		{ "<leader>fb", "<Cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "List buffers" },
		{ "<leader>fd", "<Cmd>Telescope diagnostics<CR>", desc = "List diagnostics" },
		{ "<leader>fs", Mo.U.finder.lsp_symbols("document"), desc = "Goto symbol" },
		{ "<leader>fS", Mo.U.finder.lsp_symbols("workspace"), desc = "Goto symbol (Workspace)" },
		{ "<leader>fn", Mo.U.finder.config_files(), desc = "Neovim config files" },
		{ "<leader>fR", "<Cmd>Telescope resume<CR>", desc = "Resume" },
	},
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				Mo.U.on_load("telescope.nvim", function()
					require("telescope").load_extension("fzf")
				end)
			end,
		},
	},
	opts = function()
		local actions = require("telescope.actions")
		local layout_actions = require("telescope.actions.layout")

		return {
			defaults = {
				prompt_prefix = " ",
				selection_caret = "󰈺 ",
				layout_config = {
					height = 0.9,
					width = 0.9,
					preview_cutoff = 120,
					horizontal = {
						preview_width = 0.6,
					},
					vertical = {
						preview_height = 0.7,
					},
				},
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-n>"] = actions.cycle_history_next,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<Esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-e>"] = layout_actions.toggle_preview,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "file" },
					hidden = true,
					previewer = true,
					theme = "dropdown",
					layout_config = {
						height = 0.4,
						width = 0.8,
						prompt_position = "top",
					},
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
					sort_mru = true,
					sort_lastused = true,
					ignore_current_buffer = false,
					prompt_position = "top",
					mappings = {
						i = { ["<C-x>"] = actions.delete_buffer },
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			winblend = 0,
		}
	end,
}

return M
