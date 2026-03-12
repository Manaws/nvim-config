return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        }
      })
      vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
    end
  }
}
