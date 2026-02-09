-- AI assistance: supermaven
return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "neo-tree", "TelescopePrompt" },
        color = {
          suggestion_color = "#888888",
          cterm = 244,
        },
        disable_inline_completion = false,
        disable_keymaps = true,
        log_level = "info",
      })
      
      -- Auto-start Supermaven and show status
      vim.defer_fn(function()
        local api = require("supermaven-nvim.api")
        if not api.is_running() then
          api.start()
          print("Supermaven started - Use :SupermavenUseFree or :SupermavenUsePro to activate")
        else
          print("Supermaven is running - Tab will now accept AI suggestions first")
        end
      end, 1000)
      
      -- Add visual indicator for Supermaven suggestions
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          vim.defer_fn(function()
            local supermaven_ok, supermaven = pcall(require, "supermaven-nvim.completion_preview")
            if supermaven_ok and supermaven.has_suggestion() then
              vim.opt.statusline = vim.o.statusline .. " [AI:Tab]"
            end
          end, 100)
        end,
      })
    end,
  },
}
