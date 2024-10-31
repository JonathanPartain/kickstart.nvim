return { -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'debugloop/telescope-undo.nvim' },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          path_display = {
            'truncate',
          },
          mappings = {
            i = {
              ['<C-enter>'] = 'to_fuzzy_refine',
              ['<C-h>'] = 'which_key',
            },
          },
        },
        pickers = {
          find_files = {
            theme = 'dropdown',
            layout_strategy = 'cursor',
            hidden = true,
            layout_config = {
              height = 0.95,
              width = 0.95,
              preview_width = 0.65,
            },
          },
          help_tags = {
            theme = 'dropdown',
          },
          keymaps = {
            theme = 'dropdown',
          },
          buffers = {
            theme = 'dropdown',
          },
          quickfix = {
            theme = 'dropdown',
          },
          jumplist = {
            theme = 'dropdown',
          },
          grep_string = {
            theme = 'dropdown',
            additional_args = { '--hidden' },
          },
          live_grep = {
            theme = 'dropdown',
            additional_args = { '--hidden' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
            require('telescope.themes').get_cursor(),
            require('telescope.themes').get_ivy(),
          },
          undo = {
            side_by_side = true,
            layout_strategy = 'horizontal',
            layout_config = {
              preview_height = 0.8,
            },
            -- telescope-undo.nvim config, see below
            mappings = {
              -- insert mode
              i = {
                ['<cr>'] = require('telescope-undo.actions').restore,
                ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
                ['<C-cr>'] = require('telescope-undo.actions').yank_additions,
              },
              -- normal mode
              n = {
                ['y'] = function(bufnr)
                  return require('telescope-undo.actions').yank_larger(bufnr)
                end,
                ['Y'] = require('telescope-undo.actions').yank_additions,
                ['u'] = require('telescope-undo.actions').restore,
              },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension 'undo')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = '[F]ind items in [Q]uickfix list' })
      vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = '[F]ind items in [J]umplist' })
      vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = '[F]ind [C]olorschemes' })
      --vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind in current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      --vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      --vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      --vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
      vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = '[U]ndo tree' })
    end,
  },
}
