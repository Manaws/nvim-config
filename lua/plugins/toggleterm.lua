return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-t>]],
      direction = 'horizontal',
      shade_terminals = true,
    })

    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-n>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-r>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-t>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-d>', [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}
