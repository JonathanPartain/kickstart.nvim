return {
  {
    'siawkz/nvim-cheatsh',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      cheatsh_url = 'https://cht.sh/', -- URL of the cheat.sh instance to use, support self-hosted instances
      position = 'top', -- position of the window can be: bottom, top, left, right
      height = 20, -- height of the cheat when position is top or bottom
      width = 100, -- width of the cheat when position is left or right
    },
    --config = function()
    -- vim.keymap.set('n', '<leader>ft', '<cmd>CheatList<cr>', { desc = '[F]ind [T]ldr/cheat' })
    -- end,
  },
}
