return {
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			Mo.U.on_very_lazy(function()
				Mo.U.format.formatter = {
					name = "conform.nvim",
					format = function(buf)
						local ft = vim.bo[buf].filetype
						local opts = Mo.U.opts("conform.nvim")
						local extra_args = opts.extra_lang_opts[ft] or {}
						require("conform").format(vim.tbl_deep_extend("force", { bufnr = buf }, extra_args))
					end,
				}
			end)
		end,
		opts = {
			-- Adding your config snippet here
			config = function()
				require("conform").setup({
					format_on_save = {
						timeout_ms = 500,
						lsp_format = "fallback",
					},
				})
			end,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			extra_lang_opts = {
				go = {
					lsp_format = "last",
				},
				rust = {
					lsp_format = "last",
				},
			},
			formatters_by_ft = {
				sh = { "shfmt" },
				lua = { "stylua" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				python = { "black", "ruff" },
				yaml = { "prettier" },
			},
			formatters = {
				shfmt = { prepend_args = { "-i", "2", "-ci" } },
				eslint_d = {
					condition = function(self, ctx)
						return vim.fs.find(
							{ "eslint.config.js", ".eslintrc.cjs" },
							{ path = ctx.filename, upward = true }
						)[1]
					end,
				},
				stylelint = {
					condition = function(self, ctx)
						return vim.fs.find(
							{ ".stylelintrc", "stylelint.config.js", "stylelint.config.cjs" },
							{ path = ctx.filename, upward = true }
						)[1]
					end,
				},
			},
		},
	},
}
