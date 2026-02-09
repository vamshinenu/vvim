-- UI plugins: neo-tree, bufferline, lualine, which-key
return {
  -- Which-key for key mapping hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      win = {
        border = "none",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 1, 2, 1, 2 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      show_help = true,
      show_keys = true,
      triggers = {
        { "<leader>", mode = "nxso" },
      },
      timeout = 100,
    },
    config = function()
      -- Set up buffer closing keymaps - simple and silent
      vim.keymap.set("n", "<leader>c", function()
        vim.cmd('silent! bdelete')
      end, { desc = "Close current buffer" })


      
      -- API file finder - uses Telescope to find matching files
      vim.keymap.set("n", "<leader>fa", function()
        local current_line = vim.api.nvim_get_current_line()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local cursor_col = cursor_pos[2]
        
        local api_pattern = "/api/[%w%-%_/%.%+]+"
        local api_endpoint = current_line:match(api_pattern)
        
        if not api_endpoint then
          local line_before = current_line:sub(1, cursor_col + 1)
          local line_after = current_line:sub(cursor_col + 1)
          local extended_line = line_before .. line_after
          api_endpoint = extended_line:match(api_pattern)
        end
        
        if not api_endpoint then
          api_endpoint = vim.fn.input("Enter API endpoint (e.g., /api/activity/test/update-answers): ", "/api/")
          if api_endpoint == "" then
            return
          end
        end
        
        local function api_to_search_pattern(api_path)
          local search_pattern = api_path:gsub("^/api/", "")
          search_pattern = search_pattern:gsub("[-_]", " ")
          search_pattern = search_pattern:gsub("%s+", " ")
          search_pattern = search_pattern:match("^%s*(.-)%s*$")
          return search_pattern
        end
        
        local search_pattern = api_to_search_pattern(api_endpoint)
        
        local telescope_ok, telescope = pcall(require, "telescope.builtin")
        if not telescope_ok then
          return
        end
        
        telescope.find_files({
          prompt_title = "Find API file: " .. api_endpoint,
          default_text = search_pattern,
        })
      end, { desc = "Find API file from endpoint" })
      
      -- Visual mode API finder
      vim.keymap.set("v", "<leader>fa", function()
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local start_line = start_pos[2]
        local start_col = start_pos[3]
        local end_line = end_pos[2]
        local end_col = end_pos[3]
        
        local selected_text = ""
        if start_line == end_line then
          local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
          selected_text = line:sub(start_col, end_col)
        else
          local first_line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
          selected_text = first_line:sub(start_col)
        end
        
        selected_text = selected_text:match("^%s*(.-)%s*$")
        local api_endpoint = selected_text:match("/api/[%w%-%_/%.]+")
        
        if not api_endpoint then
          return
        end
        
        local function api_to_search_pattern(api_path)
          local search_pattern = api_path:gsub("^/api/", "")
          search_pattern = search_pattern:gsub("[-_]", " ")
          search_pattern = search_pattern:gsub("%s+", " ")
          search_pattern = search_pattern:match("^%s*(.-)%s*$")
          return search_pattern
        end
        
        local search_pattern = api_to_search_pattern(api_endpoint)
        
        local telescope_ok, telescope = pcall(require, "telescope.builtin")
        if not telescope_ok then
          return
        end
        
        telescope.find_files({
          prompt_title = "Find API file: " .. api_endpoint,
          default_text = search_pattern,
        })
      end, { desc = "Find API file from selected endpoint" })
      
      -- Register leader key mappings
      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "File" },
        { "<leader>ff", desc = "Find files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Find buffers" },
        { "<leader>fa", desc = "Find API file" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>fu", desc = "Find file usages" },
        { "<leader>e", desc = "Toggle file explorer" },
        { "<leader>ft", desc = "Focus file explorer" },

        { "<leader>w", desc = "Save" },
        { "<leader>q", desc = "Quit" },
        { "<leader>wq", desc = "Save and quit" },
        { "<leader>h", desc = "Clear search highlights" },
        { "<leader>t", group = "Theme" },
        { "<leader>tc", desc = "Cycle theme" },
        { "<leader>tt", desc = "Theme picker" },
        { "<leader>a", group = "Actions" },
        { "<leader>aa", desc = "Toggle Supermaven" },
        { "<leader>ac", desc = "Copy relative path" },
        { "<leader>ad", desc = "Debug Supermaven" },
        { "<leader>af", desc = "Format file" },
        { "<leader>al", desc = "LSP code actions" },
        { "<leader>as", desc = "Suggestions menu" },
        { "<leader>an", desc = "Rename" },
        { "<leader>am", desc = "Supermaven status" },
        { "<leader>au", desc = "Supermaven use free" },
        { "<leader>ap", desc = "Supermaven use pro" },
        
        -- Git keymaps
        { "<leader>g", group = "Git" },
        { "<leader>gs", desc = "Git status" },
        { "<leader>gc", desc = "Git commit" },
        { "<leader>ga", desc = "Git add current file" },
        { "<leader>gA", desc = "Git add all" },
        { "<leader>gp", desc = "Git push" },
        { "<leader>gl", desc = "Git pull" },
        { "<leader>gd", desc = "Git diff split" },
        { "<leader>gb", desc = "Git blame" },
        { "<leader>gw", desc = "Git write (stage)" },
        { "<leader>gr", desc = "Git read (checkout)" },
        
        -- Git hunk keymaps
        { "<leader>gh", group = "Git Hunk" },
        { "<leader>ghs", desc = "Stage hunk" },
        { "<leader>ghr", desc = "Reset hunk" },
        { "<leader>ghS", desc = "Stage buffer" },
        { "<leader>ghu", desc = "Undo stage hunk" },
        { "<leader>ghR", desc = "Reset buffer" },
        { "<leader>ghp", desc = "Preview hunk" },
        { "<leader>ghb", desc = "Blame line" },
        { "<leader>ghB", desc = "Toggle line blame" },
        { "<leader>ghd", desc = "Diff this" },
        { "<leader>ghD", desc = "Diff this ~" },
        { "<leader>ght", desc = "Toggle deleted" },
        
        -- Folding keymaps
        { "<leader>z", group = "Folding" },
        { "<leader>zc", desc = "Close fold" },
        { "<leader>zo", desc = "Open fold" },
        { "<leader>za", desc = "Toggle fold" },
        { "<leader>zR", desc = "Open all folds" },
        { "<leader>zM", desc = "Close all folds" },
        
        -- Surround keymaps
        { "ds", desc = "Delete surround" },
        { "cs", desc = "Change surround" },
        { "ys", desc = "Yank surround" },
        { "yss", desc = "Yank surround line" },
        { "yS", desc = "Yank surround line" },
        { "ySS", desc = "Yank surround line" },
        { "S", desc = "Surround visual", mode = "v" },
        { "gS", desc = "Surround visual line", mode = "v" },
        
        -- Text objects
        { "ai", desc = "Around indent", mode = "o" },
        { "ii", desc = "Inside indent", mode = "o" },
        { "al", desc = "Around line", mode = "o" },
        { "il", desc = "Inside line", mode = "o" },
        { "ae", desc = "Around entire", mode = "o" },
        { "ie", desc = "Inside entire", mode = "o" },
        { "a,", desc = "Around parameter", mode = "o" },
        { "i,", desc = "Inside parameter", mode = "o" },
        
        -- Change and yank variants
        { "cai", desc = "Change around indent", mode = "o" },
        { "cii", desc = "Change inside indent", mode = "o" },
        { "cal", desc = "Change around line", mode = "o" },
        { "cil", desc = "Change inside line", mode = "o" },
        { "cae", desc = "Change around entire", mode = "o" },
        { "cie", desc = "Change inside entire", mode = "o" },
        { "ca,", desc = "Change around parameter", mode = "o" },
        { "ci,", desc = "Change inside parameter", mode = "o" },
        
        { "dai", desc = "Delete around indent", mode = "o" },
        { "dii", desc = "Delete inside indent", mode = "o" },
        { "dal", desc = "Delete around line", mode = "o" },
        { "dil", desc = "Delete inside line", mode = "o" },
        { "dae", desc = "Delete around entire", mode = "o" },
        { "die", desc = "Delete inside entire", mode = "o" },
        { "da,", desc = "Delete around parameter", mode = "o" },
        { "di,", desc = "Delete inside parameter", mode = "o" },
        
        { "yai", desc = "Yank around indent", mode = "o" },
        { "yii", desc = "Yank inside indent", mode = "o" },
        { "yal", desc = "Yank around line", mode = "o" },
        { "yil", desc = "Yank inside line", mode = "o" },
        { "yae", desc = "Yank around entire", mode = "o" },
        { "yie", desc = "Yank inside entire", mode = "o" },
        { "ya,", desc = "Yank around parameter", mode = "o" },
        { "yi,", desc = "Yank inside parameter", mode = "o" },
      })
      
      -- Save with <leader>w
      vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
      
      -- AI commands
      vim.keymap.set("n", "<leader>aa", function()
        local api = require("supermaven-nvim.api")
        api.toggle()
        print("Supermaven toggled - Status: " .. (api.is_running() and "running" or "stopped"))
      end, { desc = "Toggle Supermaven" })
      
      vim.keymap.set("n", "<leader>am", "<cmd>SupermavenStatus<cr>", { desc = "Supermaven status" })
      vim.keymap.set("n", "<leader>au", "<cmd>SupermavenUseFree<cr>", { desc = "Supermaven use free" })
      vim.keymap.set("n", "<leader>ap", "<cmd>SupermavenUsePro<cr>", { desc = "Supermaven use pro" })
      
      vim.keymap.set("n", "<leader>ad", function()
        local supermaven_ok, supermaven = pcall(require, "supermaven-nvim.completion_preview")
        if supermaven_ok then
          if supermaven.has_suggestion() then
            print("✅ Supermaven has suggestion available - Tab will accept it")
          else
            print("❌ No Supermaven suggestion available")
          end
        else
          print("❌ Supermaven not loaded: " .. tostring(supermaven))
        end
      end, { desc = "Debug Supermaven suggestions" })
      
      -- Copy relative path of current file
      vim.keymap.set("n", "<leader>ac", function()
        local relative_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
        if relative_path == "" then
          print("No file path to copy")
          return
        end
        
        vim.fn.setreg("+", relative_path)
        vim.fn.setreg("", relative_path)
        
        print("Copied: " .. relative_path)
      end, { desc = "Copy relative path" })
      
      -- LSP code actions
      vim.keymap.set("n", "<leader>al", vim.lsp.buf.code_action, { desc = "LSP code actions" })
      
      -- Suggestions menu (trigger completion)
      vim.keymap.set("n", "<leader>as", function()
        vim.cmd("startinsert")
        vim.schedule(function()
          vim.fn.feedkeys("<C-Space>", "i")
        end)
      end, { desc = "Trigger code suggestions" })
      
      -- Double leader trigger for completion in normal mode
      vim.keymap.set("n", "<leader><leader>", function()
        vim.cmd("startinsert")
        vim.schedule(function()
          vim.fn.feedkeys("<C-Space>", "i")
        end)
      end, { desc = "Trigger completion" })
      
      -- Normal mode completion trigger (Ctrl+Space in normal mode)
      vim.keymap.set("n", "<C-Space>", function()
        vim.cmd("startinsert")
        vim.schedule(function()
          vim.fn.feedkeys("<C-Space>", "i")
        end)
      end, { desc = "Trigger completion from normal mode" })
      
      -- Insert mode manual completion trigger (Alt+c)
      vim.keymap.set("i", "<M-c>", function()
        require("cmp").complete()
      end, { desc = "Manual completion trigger" })
      
      -- Folding keymaps
      vim.keymap.set("n", "<leader>zc", "zc", { desc = "Close fold" })
      vim.keymap.set("n", "<leader>zo", "zo", { desc = "Open fold" })
      vim.keymap.set("n", "<leader>za", "za", { desc = "Toggle fold" })
      vim.keymap.set("n", "<leader>zR", "zR", { desc = "Open all folds" })
      vim.keymap.set("n", "<leader>zM", "zM", { desc = "Close all folds" })
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        default_component_configs = {
          icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
          },
          git_status = {
            symbols = {
              added     = "✚",
              deleted   = "✖",
              modified  = "",
              renamed   = "󰁕",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            },
          },
        },
        filesystem = {
          follow_current_file = true,
          use_libuv_file_watcher = true,
          hijack_netrw_behavior = "open_default",
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false,
          },
        },
        window = {
          position = "left",
          width = 40,
          mappings = {
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["l"] = "open",
            ["h"] = "close_node",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["C"] = "close_node",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["I"] = "toggle_gitignore",
            ["R"] = "refresh",
          },
        },
        close_if_last_window = false,
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf", "neo-tree" },
        sort_case_insensitive = false,
        sort_function = nil,
        default_source = "filesystem",
        event_handlers = {
          {
            event = "file_opened",
            handler = function(file_path)
              require("neo-tree.command").execute({ action = "close" })
            end
          },
          {
            event = "neo_tree_buffer_enter",
            handler = function()
              vim.cmd("highlight! Cursor blend=100")
            end
          },
          {
            event = "neo_tree_buffer_leave",
            handler = function()
              vim.cmd("highlight! Cursor blend=0")
            end
          },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

      vim.keymap.set("n", "<leader>ft", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })
      vim.keymap.set("n", "<leader>.", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
    end,
  },

  -- Bufferline (tabs for open buffers)
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "none",
          close_command = "bdelete %d",
          right_mouse_command = "bdelete %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = { style = "icon", icon = "▎" },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "nightfox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "neo-tree", "alpha" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { 
            { 
              "filename", 
              path = 1,
              file_status = true,
              symbols = {
                modified = '[+]',
                readonly = '[RO]',
                unnamed = '[No Name]',
              }
            } 
          },
          lualine_x = { 
            { 
              "filetype", 
              icon_only = true,
              separator = "",
              padding = { left = 1, right = 0 }
            } 
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}
