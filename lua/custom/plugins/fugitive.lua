return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
      local j_fugitive = vim.api.nvim_create_augroup('j_fugitive', {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd('BufWinEnter', {
        group = j_fugitive,
        pattern = '*',
        callback = function()
          if vim.bo.ft ~= 'fugitive' then
            return
          end
          local bufnr = vim.api.nvim_get_current_buf()
          vim.keymap.set('n', '<leader>p', function()
            vim.cmd.Git 'push'
          end, { buffer = bufnr, remap = false, desc = '[p]ush' })

          -- always rebase
          vim.keymap.set('n', '<leader>P', function()
            vim.cmd.Git { 'pull', '--rebase' }
          end, { buffer = bufnr, remap = false, desc = '[P]ull' })

          -- Allows to set up branch I am pushing and any tracking
          vim.keymap.set('n', '<leader>t', ':Git push -u origin', { buffer = bufnr, remap = false, desc = '[T]rack remote branch' })
        end,
      })
      vim.keymap.set('n', 'gl', '<cmd>diffget //2<CR>', { desc = '[G]et [L]eft diff' }) -- get left
      vim.keymap.set('n', 'gr', '<cmd>diffget //3<CR>', { desc = '[G]et [R]ight diff' }) -- get right
    end,
  },
}
