-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- tabs stuff
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = '/home/jonathan/.config/nvim/.undo//'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

vim.opt.colorcolumn = '80'

vim.opt.isfname:append '@-@'
-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 20

-- auto save *.tf files
vim.api.nvim_create_augroup('tf_autosave', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'format all .tf files recursively when saving a .tf file',
  group = 'tf_autosave',
  pattern = '*.tf',
  command = '!tofu fmt -recursive',
})
--
-- disable lsp log
vim.lsp.set_log_level 'off'
vim.opt.laststatus = 3
-- python indenting

vim.g.python_indent = {}
vim.g.python_indent.open_paren = 'shiftwidth() * 2'
vim.g.python_indent.nested_paren = 'shiftwidth()'
vim.g.python_indent.continue = 'shiftwidth() * 2'
vim.g.python_indent.searchpair_timeout = 150

-- vim: ts=2 sts=2 sw=2 et
