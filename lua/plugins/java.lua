return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local jdtls = require("jdtls")
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
    local jdtls_path = mason_path .. "/jdtls"

    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local os_config = vim.fn.has("mac") == 1 and "mac" or (vim.fn.has("win32") == 1 and "win" or "linux")

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

    local bundles = {}
    local debug_jar = vim.fn.glob(
      mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
    )
    if debug_jar ~= "" then
      table.insert(bundles, debug_jar)
    end

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher,
        "-configuration", jdtls_path .. "/config_" .. os_config,
        "-data", workspace_dir,
      },
      root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
      settings = {
        java = {
          eclipse = { downloadSources = true },
          maven = { downloadSources = true },
          configuration = { updateBuildConfiguration = "interactive" },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          inlayHints = { parameterNames = { enabled = "all" } },
          format = { enabled = true },
        },
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {
            "org.assertj.core.api.Assertions.assertThat",
            "org.junit.jupiter.api.Assertions.*",
            "org.mockito.Mockito.*",
          },
        },
      },
      init_options = { bundles = bundles },
      on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, opts)
        vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, opts)
        vim.keymap.set("v", "<leader>em", function() jdtls.extract_method(true) end, opts)
      end,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        jdtls.start_or_attach(config)
      end,
    })
  end,
}
