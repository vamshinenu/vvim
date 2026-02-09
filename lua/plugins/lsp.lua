-- LSP configuration: mason + native vim.lsp.config (Neovim 0.11+)
return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- Mason LSP config (for auto-installation only)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "saghen/blink.cmp" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "svelte",
          "ts_ls",
          "html",
          "cssls",
          "lua_ls",
          "jsonls",
          "yamlls",
          "eslint",
          "tailwindcss",
          "prismals",
          "pyright",
          "bashls",
          "dockerls",
          "graphql",
          "vimls",
        },
        automatic_installation = false,
      })

      -- Get blink.cmp capabilities
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Common root markers for most projects
      local common_root_markers = { '.git', 'package.json', 'tsconfig.json', 'jsconfig.json' }

      -- Server configurations with native vim.lsp.config API
      -- Each server needs: cmd, filetypes, root_markers, and optionally settings

      -- TypeScript/JavaScript
      vim.lsp.config['ts_ls'] = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
        capabilities = capabilities,
      }

      -- Svelte
      vim.lsp.config['svelte'] = {
        cmd = { 'svelteserver', '--stdio' },
        filetypes = { 'svelte' },
        root_markers = { 'svelte.config.js', 'svelte.config.ts', 'package.json', '.git' },
        capabilities = capabilities,
        settings = {
          svelte = {
            compiler = { enable = true },
            emmet = { enable = true },
          },
        },
      }

      -- HTML
      vim.lsp.config['html'] = {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html', 'templ' },
        root_markers = common_root_markers,
        capabilities = capabilities,
        init_options = {
          provideFormatter = true,
          embeddedLanguages = { javascript = true, css = true },
          configurationSection = { 'html', 'css', 'javascript' },
        },
        settings = {
          html = {
            format = { enable = true },
            suggest = { enable = true },
            completion = { enable = true },
          },
        },
      }

      -- CSS
      vim.lsp.config['cssls'] = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = common_root_markers,
        capabilities = capabilities,
      }

      -- JSON
      vim.lsp.config['jsonls'] = {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_markers = common_root_markers,
        capabilities = capabilities,
      }

      -- YAML
      vim.lsp.config['yamlls'] = {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
        root_markers = common_root_markers,
        capabilities = capabilities,
      }

      -- ESLint
      vim.lsp.config['eslint'] = {
        cmd = { 'vscode-eslint-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue', 'svelte', 'astro' },
        root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', 'eslint.config.js', 'eslint.config.mjs', 'package.json', '.git' },
        capabilities = capabilities,
        on_init = function(client)
          -- Disable pull diagnostics — ESLint's implementation is buggy.
          -- This makes it use push-based publishDiagnostics instead, which works correctly.
          client.server_capabilities.diagnosticProvider = nil
        end,
        settings = {
          eslint = {
            validate = "on",
            useESLintClass = false,
            experimental = { useFlatConfig = nil },
            format = true,
            quiet = false,
            onIgnoredFiles = "off",
            run = "onType",
            codeAction = {
              disableRuleComment = { enable = true, location = "separateLine" },
              showDocumentation = { enable = true },
            },
            workingDirectory = { mode = "auto" },
          },
        },
      }

      -- Tailwind CSS
      vim.lsp.config['tailwindcss'] = {
        cmd = { 'tailwindcss-language-server', '--stdio' },
        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
        root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'package.json', '.git' },
        capabilities = capabilities,
      }

      -- Prisma
      vim.lsp.config['prismals'] = {
        cmd = { 'prisma-language-server', '--stdio' },
        filetypes = { 'prisma' },
        root_markers = { 'prisma', 'package.json', '.git' },
        capabilities = capabilities,
      }

      -- Python
      vim.lsp.config['pyright'] = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
        capabilities = capabilities,
      }

      -- Bash
      vim.lsp.config['bashls'] = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash', 'zsh' },
        root_markers = { '.git' },
        capabilities = capabilities,
      }

      -- Docker
      vim.lsp.config['dockerls'] = {
        cmd = { 'docker-langserver', '--stdio' },
        filetypes = { 'dockerfile' },
        root_markers = { 'Dockerfile', '.git' },
        capabilities = capabilities,
      }

      -- GraphQL
      vim.lsp.config['graphql'] = {
        cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
        filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
        root_markers = { '.graphqlrc', '.graphqlrc.js', '.graphqlrc.json', '.graphqlrc.yaml', '.graphqlrc.yml', 'graphql.config.js', 'graphql.config.json', 'graphql.config.yaml', 'graphql.config.yml', '.git' },
        capabilities = capabilities,
      }

      -- Vim
      vim.lsp.config['vimls'] = {
        cmd = { 'vim-language-server', '--stdio' },
        filetypes = { 'vim' },
        root_markers = { '.git' },
        capabilities = capabilities,
      }

      -- Lua (Neovim-specific settings)
      vim.lsp.config['lua_ls'] = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Enable all servers
      vim.lsp.enable({
        'ts_ls',
        'svelte',
        'html',
        'cssls',
        'jsonls',
        'yamlls',
        'eslint',
        'tailwindcss',
        'prismals',
        'pyright',
        'bashls',
        'dockerls',
        'graphql',
        'vimls',
        'lua_ls',
      })

      -- Stop rogue rust-analyzer instances
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and (client.name == "rust-analyzer" or client.name == "rust_analyzer") and not client.config.rustaceanvim then
            vim.lsp.stop_client(args.data.client_id)
            vim.notify("Stopped rogue rust-analyzer instance: " .. client.name, vim.log.levels.WARN)
          end
        end,
      })

      -- Keymaps for LSP
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>ar", vim.lsp.buf.rename, { desc = "Rename symbol" })

      -- LSP refresh/restart keymaps
      vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP info" })
      vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients()[1].id)<cr>", { desc = "Stop LSP" })
      vim.keymap.set("n", "<leader>lR", function()
        for _, client in ipairs(vim.lsp.get_clients()) do
          vim.lsp.stop_client(client.id)
        end
        vim.defer_fn(function()
          vim.cmd("edit")
        end, 100)
        print("All LSP clients restarted")
      end, { desc = "Force restart all LSP" })

      -- Diagnostic keymaps
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Show diagnostic list" })

      -- Configure diagnostic signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "⚠",
            [vim.diagnostic.severity.HINT] = "💡",
            [vim.diagnostic.severity.INFO] = "ℹ",
          },
        },
        virtual_text = {
          prefix = "●",
          spacing = 4,
          severity = { min = vim.diagnostic.severity.HINT },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- LSP handlers for better UI
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      -- Prevent general LSP from attaching to Rust files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          for _, client in ipairs(clients) do
            if (client.name == "rust-analyzer" or client.name == "rust_analyzer") and not client.config.rustaceanvim then
              vim.lsp.stop_client(client.id)
              vim.notify("Stopped non-rustaceanvim LSP client: " .. client.name, vim.log.levels.WARN)
            end
          end
        end,
      })
    end,
  },
}
