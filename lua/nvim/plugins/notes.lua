local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  keys = {
    { "<leader>mr", "<Cmd>RenderMarkdown toggle<CR>", desc = "Toggle render markdown" },
  },
  opts = {
    heading = { enabled = false },
    code = {
      sign = false,
      width = "block",
      position = "right",
      min_width = 60,
      left_pad = 2,
      right_pad = 2,
      inline_pad = 1,
      language_pad = 1,
    },
    pipe_table = {
      preset = "round",
    },
  },
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
