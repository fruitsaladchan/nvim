local M = {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				"antosha417/nvim-lsp-file-operations",
				"folke/neodev.nvim",

        -- stylua: ignore
        keys = {
          { "<leader>ll", function() vim.cmd.edit(vim.lsp.get_log_path()) end, desc = "Lsp Log" },
          { "<leader>li", "<CMD>LspInfo<CR>", desc = "Lsp Info" },
          { "<leader>lr", "<CMD>LspRestart<CR>", desc = "Lsp Restart" },
        },
			},
			{
				"stevearc/aerial.nvim",
				event = { "BufReadPre", "BufNewFile" },
				opts = {},
				keys = {
					vim.keymap.set("n", "<C-a>", "<cmd>AerialToggle left<CR>"),
				},
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
				},
			},
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				keys = {
					{ "<leader>pm", "<CMD>Mason<CR>", desc = "Mason" },
				},
				opts = {
					ui = {
						width = 0.8,
						height = 0.8,
						border = Mo.C.border,
						icons = {
							package_installed = "",
							package_pending = "",
							package_uninstalled = "",
						},
						keymaps = { apply_language_filter = "f" },
					},
				},
				config = function(_, opts)
					require("mason").setup(opts)
					local mr = require("mason-registry")
					mr:on("package:install:success", function()
						vim.defer_fn(function()
							require("lazy.core.handler.event").trigger({
								event = "FileType",
								buf = vim.api.nvim_get_current_buf(),
							})
						end, 100)
					end)
				end,
			},
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts: table):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(_, opts)
			require("nvim.plugins.lsp.diagnostic").setup()
			require("lspconfig.ui.windows").default_options.border = Mo.C.border

			Mo.U.lsp.on_attach(function(client, buffer)
				require("nvim.plugins.lsp.keymaps").on_attach(client, buffer)
				require("nvim.plugins.lsp.codelens").on_attach(client, buffer)
				require("nvim.plugins.lsp.highlight").on_attach(client, buffer)
			end)

			---@param server string server name
			local function setup_server(server)
				local config = Mo.U.lsp.resolve_config(opts.servers[server] or {})
				if opts.setup[server] then
					if opts.setup[server](server, config) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, config) then
						return
					end
				end
				require("lspconfig")[server].setup(config)
			end

			local mlsp = require("mason-lspconfig")
			local all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

			local ensure_installed = {}
			for server, server_opts in pairs(opts.servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
						setup_server(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup_server } })
		end,
	},
}

return M
