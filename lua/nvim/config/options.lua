vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable auto format
vim.g.autoformat = true

local opt = vim.opt

opt.confirm = true
opt.autowrite = true

opt.pumheight = 12
opt.winminwidth = 5
opt.wildoptions = "pum"
opt.wildmode = "longest:full,full"
opt.completeopt = "menu,menuone,noselect"

opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.formatoptions = "jcrqlnt"

opt.scrolloff = 7
opt.sidescrolloff = 5

-- split
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- display
opt.wrap = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.ignorecase = true
opt.virtualedit = "block"
opt.shortmess:append({ W = true, I = true, c = true, C = true })

opt.fillchars = {
	eob = " ",
	fold = " ",
	foldsep = " ",
	foldopen = "",
	foldclose = "",
}

-- fold
opt.foldlevel = 99
opt.foldcolumn = "auto"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.laststatus = 0
opt.showcmd = false
opt.showmode = false

opt.clipboard = "unnamedplus"

opt.cursorline = true
opt.cursorlineopt = Mo.C.transparent and "number" or "number,line"

-- indent
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2

-- number
opt.number = true
opt.relativenumber = true

-- time
opt.timeoutlen = 500
opt.updatetime = 300

-- undo
opt.undofile = true

--neovide
vim.g.neovide_transparency = 0.7
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.o.guifont = "FiraCode Nerd Font:h10"
-- vim.g.neovide_background_color = "#0f1117"
