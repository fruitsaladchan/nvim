local keymap = vim.keymap.set

--custom
keymap("n", ";", ":", { noremap = true })
keymap("n", "<S-w>", "b", { noremap = true, silent = true })
keymap("n", "zz", "<Cmd>q!<CR>", { desc = "Quit" })
keymap({ "n", "x" }, "<A-h>", "^", { desc = "To the first non-blank char of the line" })
keymap({ "n", "x" }, "<A-l>", "$", { desc = "To the end of the line" })

-- Editing: write
keymap("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>W", "<Cmd>wa<CR>", { desc = "Save files" })

-- Editing: quit
keymap("n", "<leader>q", "<Cmd>q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", "<Cmd>q!<CR>", { desc = "Force quit" })

-- Motion
keymap("n", "<M-k>", "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move up" })
keymap("n", "<M-j>", "<Cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move down" })
keymap("i", "<M-k>", "<Esc><Cmd>move .-2<CR>==gi", { desc = "Move up" })
keymap("i", "<M-j>", "<Esc><Cmd>move .+1<CR>==gi", { desc = "Move down" })
-- stylua: ignore 
keymap("v", "<M-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move up" })
keymap("v", "<M-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move down" })

-- Split window
keymap("n", "<leader>_", "<C-w>s", { desc = "Split below" })
keymap("n", "<leader>|", "<C-w>v", { desc = "Split right" })

-- Move to window
keymap("n", "<C-h>", "<C-w>h", { remap = true, desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { remap = true, desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { remap = true, desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { remap = true, desc = "Go to right window" })

-- Resize window
keymap("n", "<A-Down>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<A-Up>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<A-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Increase window width" })
keymap("n", "<A-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Decrease window width" })

-- Saner behavior of n and N
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

keymap("v", ">", ">gv", { desc = "Visual shifting" })
keymap("v", "<", "<gv", { desc = "Visual shifting" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Escape and clear hlsearch" })

-- Better up/down
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move cursor up" })
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move cursor down" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
keymap("n", "<leader>cd", function()
  vim.diagnostic.open_float({ scope = "cursor", force = false })
end, { desc = "Line Diagnostic" })
keymap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
keymap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keymap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keymap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keymap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

keymap("n", "<leader>pl", "<CMD>Lazy<CR>", { desc = "Lazy" })

-- stylua: ignore start
Mo.U.format.snacks_toggle():map("<leader>of")
Mo.U.format.snacks_toggle(true):map("<leader>oF")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>os")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>oL")
Snacks.toggle.line_number():map("<leader>ol")
Snacks.toggle.treesitter():map("<leader>ot")
Snacks.toggle.diagnostics():map("<leader>od")
Snacks.toggle.inlay_hints():map("<leader>oh")
Snacks.toggle.zen():map("<leader>oz")

-- Code format
keymap({ "n", "v" }, "<leader>cf", function() Mo.U.format.format({ force = true }) end, { desc = "Code format" })
