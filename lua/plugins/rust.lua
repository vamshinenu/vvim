-- Rust development: rustaceanvim
return {
  {
    "mrcjkb/rustaceanvim",
    version = '^4',
    ft = { "rust" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          cmd = { "/Users/v/.local/share/nvim/mason/packages/rust-analyzer/rust-analyzer-aarch64-apple-darwin" },
          rustaceanvim = true,
          autostart = true,
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd("RustLsp runnables")
            end, { desc = "Rust runnables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rd", function()
              vim.cmd("RustLsp debuggables")
            end, { desc = "Rust debuggables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rt", function()
              vim.cmd("RustLsp testables")
            end, { desc = "Rust testables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rc", function()
              vim.cmd("RustLsp openCargo")
            end, { desc = "Open Cargo.toml", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rp", function()
              vim.cmd("RustLsp parentModule")
            end, { desc = "Go to parent module", buffer = bufnr })
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      }
    end,
  },
}
