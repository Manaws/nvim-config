-- keymaps
--
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>q', '<cmd>bn | bd #<CR>', { desc = 'Aktuellen Buffer schließen' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Fehlermeldung anzeigen" })
vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR> ', { desc = "Task ausführen" })
vim.keymap.set('n', '<leader>rt', '<cmd>OverseerToggle<cr>', { desc = "Task-Liste (unten/seitlich)" })
  
