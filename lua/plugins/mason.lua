return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
      })

      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      end

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "gopls", "jdtls" },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({ on_attach = on_attach })
          end,
          lua_ls = function()
            lspconfig.lua_ls.setup({
              on_attach = on_attach,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } }
                }
              }
            })
          end,
          gopls = function()
            lspconfig.gopls.setup({
              on_attach = on_attach,
              settings = {
                gopls = {
                  completeUnimported = true,
                  usePlaceholders = true,
                  analyses = {
                    unusedparams = true
                  }
                }
              }
            })
          end,
          jdtls = function() end, -- managed by nvim-jdtls, skip here
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.zig",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },

  { "neovim/nvim-lspconfig" },
}
