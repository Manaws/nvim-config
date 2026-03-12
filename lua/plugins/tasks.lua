return {
  'stevearc/overseer.nvim',
  opts = {
    strategy = {
      "terminal",
      direction = "tab", 
      quit_on_exit = "never", 
    },
  },
  config = function(_, opts)
    require('overseer').setup(opts)
    vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR> ', { desc = "Task ausführen" })
    vim.keymap.set('n', '<leader>rt', '<cmd>OverseerToggle<cr>', { desc = "Task-Liste (unten/seitlich)" })
  end
}
