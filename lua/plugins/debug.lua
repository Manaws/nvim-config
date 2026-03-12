return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "delve", "codelldb" }, 
    })

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Debug: Start/Continue" })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Debug: Step Over" })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Debug: Step Into" })
    vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
  end,
}
