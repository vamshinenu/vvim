-- Core editor enhancements: indentation, autopairs, surround, comments, text objects, session
return {
  -- Mini icons for which-key
  {
    "echasnovski/mini.icons",
    lazy = true,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
          char = "│",
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  },

  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "<leader>/",
          block = "<leader>?",
        },
        opleader = {
          line = "<leader>/",
          block = "<leader>?",
        },
        mappings = {
          basic = true,
          extra = true,
        },
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Session management
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        session_lens = {
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
        -- Close neo-tree before saving session to avoid it showing in buffer area
        pre_save_cmds = {
          "Neotree close",
        },
        -- Don't save these buffer types in the session
        bypass_save_filetypes = { "neo-tree", "alpha", "dashboard", "lazy" },
      })
    end,
  },

  -- Text objects for enhanced functionality
  {
    "kana/vim-textobj-user",
    dependencies = {
      "kana/vim-textobj-indent",
      "kana/vim-textobj-line",
      "kana/vim-textobj-entire",
    },
    config = function()
      -- Text objects are automatically loaded
      -- ai/ii - indent object
      -- al/il - line object
      -- ae/ie - entire buffer object
    end,
  },

  -- Additional text objects (must load after vim-textobj-user)
  {
    "sgur/vim-textobj-parameter",
    dependencies = {
      "kana/vim-textobj-user",
    },
    config = function()
      -- a,/i, - parameter object
    end,
  },

  -- Surround functionality for tags, quotes, brackets, etc.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
}
