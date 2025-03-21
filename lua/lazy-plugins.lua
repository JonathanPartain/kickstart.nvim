require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  require 'kickstart.plugins.gitsigns',

  require 'kickstart.plugins.which-key',

  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.lspconfig',
  --
  require 'kickstart.plugins.autoformat',
  --
  require 'kickstart.plugins.cmp',
  --
  require 'kickstart.plugins.colorscheme',
  --
  require 'kickstart.plugins.todo-comments',
  --
  require 'kickstart.plugins.mini',
  --
  require 'kickstart.plugins.treesitter',
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',

  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
