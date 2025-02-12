local M = {
	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install && git restore .",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		keys = {
			{ "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Markdown Preview" },
		},
	},
}

return M
