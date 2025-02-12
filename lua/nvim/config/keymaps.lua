local keymap = vim.keymap.set

--custom
keymap("n", ";", ":", { noremap = true })
keymap("n", "<S-w>", "b", { noremap = true, silent = true })

keymap("n", "<leader>w", "<Cmd>wa<CR>", { desc = "Save files" })
keymap("n", "zz", "<Cmd>q!<CR>", { desc = "Quit" })

--disable copy on delete (personal pref)
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "dw", '"_dw', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "cw", '"_cw', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "C", '"_C', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "D", '"_D', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "s", '"_s', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "p", ":set paste<CR>p:set nopaste<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "P", ":set paste<CR>P:set nopaste<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "yy", "^vg_y", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "p", ":set paste<CR>p:set nopaste<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-v>", '<Esc>:set paste<CR>"+gP:set nopaste<CR>', { noremap = true, silent = true })

-- Motion
keymap({ "n", "x" }, "<A-h>", "^", { desc = "To the first non-blank char of the line" })
keymap({ "n", "x" }, "<A-l>", "$", { desc = "To the end of the line" })
-- Move line
keymap("n", "<M-k>", "<Cmd>move .-2<CR>==", { desc = "Move up" })
keymap("n", "<M-j>", "<Cmd>move .+1<CR>==", { desc = "Move down" })
keymap("i", "<M-k>", "<Esc><Cmd>move .-2<CR>==gi", { desc = "Move up" })
keymap("i", "<M-j>", "<Esc><Cmd>move .+1<CR>==gi", { desc = "Move down" })
keymap("v", "<M-k>", ":move '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move up" })
keymap("v", "<M-j>", ":move '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move down" })

-- Split window
keymap("n", "<leader>-", "<C-w>s", { desc = "Split below" })
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

-- next results
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
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

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

-- terminal with bash
keymap("n", "<leader>tt", function()
	Mo.U.terminal({ "bash" })
end, { desc = "terminal" })

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

--terminal with lzygit
keymap("n", "<leader>gg", function()
	Mo.U.terminal({ "lazygit" })
end, { desc = "lazygit" })

-- Code format
keymap("n", "<leader>of", function()
	Mo.U.format.toggle()
end, { desc = "Toggle auto format(global)" })
keymap({ "n", "v" }, "<leader>cf", function()
	Mo.U.format.format({ force = true })
end, { desc = "Code format" })

--options
keymap("n", "<leader>oh", function()
	Mo.U.toggle.inlay_hints()
end, { desc = "Toggle Inlay Hints" })
keymap("n", "<leader>os", function()
	Mo.U.toggle("spell")
end, { desc = "Toggle spelling" })
vim.keymap.set("n", "<leader>on", function()
	local current = vim.wo.number
	vim.wo.number = not current
	vim.wo.relativenumber = not current
end, { desc = "Toggle line numbers" })

keymap("n", "<leader>ow", function()
	Mo.U.toggle("wrap")
end, { desc = "Toggle word wrap" })
