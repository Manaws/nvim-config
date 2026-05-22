return {
  'stevearc/overseer.nvim',
   cmd = {"OverseerRun", "OverseerToggle"},
  opts = {
    strategy = {
      "terminal",
      direction = "tab", 
      quit_on_exit = "never", 
    },
  },
  config = function(_, opts)
    local overseer = require('overseer')
    overseer.setup(opts)
    overseer.register_template({
      name = "go run .",
      builder = function()
        return {
          cmd = { "go" },
          args = { "run", "." },
        }
      end,
      condition = {
        filetype = { "go" },
      },
    })
    vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR> ', { desc = "Task ausführen" })
    vim.keymap.set('n', '<leader>rt', '<cmd>OverseerToggle<cr>', { desc = "Task-Liste (unten/seitlich)" })
  end
}
