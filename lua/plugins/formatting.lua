-- Code formatting: conform.nvim
return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          rust = { "rustfmt" },
        },
        format_on_save = function(bufnr)
          -- Disable auto-format for Svelte files with Svelte 5 syntax
          if vim.bo[bufnr].filetype == "svelte" then
            local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
            if content:match("{@render") or content:match("{#snippet") or content:match("$props") or content:match("$bindable") or content:match("$state") then
              return false
            end
          end
          return { timeout_ms = 5000, lsp_fallback = true }
        end,
        formatters = {
          prettier = {
            command = "/Users/v/.local/share/nvim/mason/bin/prettier",
            args = { "--stdin-filepath", "$FILENAME" },
          },
          prettier_svelte = {
            command = "/Users/v/.local/share/nvim/mason/bin/prettier",
            args = { 
              "--parser", "svelte", 
              "--stdin-filepath", "$FILENAME",
            },
          },
          stylua = {
            command = "/Users/v/.local/share/nvim/mason/bin/stylua",
            args = { "--stdin-filename", "$FILENAME", "-" },
          },
          rustfmt = {
            command = "/Users/v/.local/share/nvim/mason/bin/rustfmt",
            args = { "--edition", "2021" },
          },
        },
      })
      
      -- Smart format function that handles Svelte 5 files
      local function format_file()
        if vim.bo.filetype == "svelte" then
          local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
          if content:match("{@render") or content:match("{#snippet") or content:match("$props") or content:match("$bindable") or content:match("$state") then
            vim.lsp.buf.format({ async = true })
            vim.notify("Using LSP formatting for Svelte 5 syntax", vim.log.levels.INFO)
          else
            require("conform").format({ async = true, lsp_fallback = true })
          end
        else
          require("conform").format({ async = true, lsp_fallback = true })
        end
      end

      vim.keymap.set("n", "<leader>af", format_file, { desc = "Format file" })
    end,
  },
}
