return {
  "leoluz/nvim-dap-go",
  ft = "go", -- Plugin wird nur geladen, wenn eine .go Datei geöffnet wird
  config = function()
    require("dap-go").setup()
  end,
}
