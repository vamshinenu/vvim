-- Autocompletion: blink.cmp with Supermaven integration
return {
  -- Blink.cmp - blazing fast completion
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Huijiro/blink-cmp-supermaven",
    },
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Use super-tab for Tab to accept (like VS Code)
      keymap = {
        preset = "super-tab",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            -- Check for Supermaven suggestion first
            local supermaven_ok, supermaven = pcall(require, "supermaven-nvim.completion_preview")
            if supermaven_ok and supermaven.has_suggestion() then
              -- Use vim.schedule to defer execution outside of keymap context
              -- This prevents "E565: Not allowed to change text or change window" error
              vim.schedule(function()
                supermaven.on_accept_suggestion()
              end)
              return true
            end
            return false
          end,
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down" },
        ["<C-u>"] = { "scroll_documentation_up" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        -- Auto-show documentation after a short delay
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        -- Show ghost text preview
        ghost_text = {
          enabled = true,
        },
        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
      },

      -- Configure sources with Supermaven
      sources = {
        default = { "supermaven", "lsp", "path", "snippets", "buffer" },
        providers = {
          supermaven = {
            name = "supermaven",
            module = "blink-cmp-supermaven",
            score_offset = 100, -- Prioritize AI suggestions
            async = true,
          },
        },
      },

      -- Use Rust fuzzy matcher for best performance
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },

      -- Enable signature help
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
    },

    opts_extend = { "sources.default" },
  },

  -- Emmet for HTML/CSS completion
  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-e>"
      vim.g.user_emmet_settings = {
        javascript = {
          extends = "jsx",
        },
        typescript = {
          extends = "jsx",
        },
        svelte = {
          extends = "html",
        },
      }
    end,
  },
}
