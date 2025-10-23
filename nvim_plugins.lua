return {
  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
  },
  {
    "xero/miasma.nvim",
    lazy = false,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
  },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
  },
  {
    "Shatur/neovim-ayu",
    lazy = false,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
  },
  {
    "sainnhe/everforest",
    lazy = false,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
  },
  {
    "sainnhe/sonokai",
    lazy = false,
  },
  {
    "sainnhe/edge",
    lazy = false,
  },
  

  

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
        -- Close the buffer silently without any messages or confirmations
        vim.cmd('silent! bdelete')
      end, { desc = "Close current buffer" })

      -- Force close buffer keymap - silent
      vim.keymap.set("n", "<leader>bd", function()
        -- Force close silently without any messages or confirmations
        vim.cmd('silent! bdelete!')
      end, { desc = "Force close buffer" })
      
      -- Buffer navigation keymaps
      vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", { desc = "Back (previous buffer)" })
      vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
      
      -- Circular buffer navigation (wraps around)
      vim.keymap.set("n", "<leader>b]", function()
        local buffers = vim.api.nvim_list_bufs()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_index = -1
        
        -- Find current buffer index
        for i, buf in ipairs(buffers) do
          if buf == current_buf then
            current_index = i
            break
          end
        end
        
        -- Get next buffer (wrap around if needed)
        local next_index = current_index + 1
        if next_index > #buffers then
          next_index = 1
        end
        
        -- Switch to next buffer
        vim.api.nvim_set_current_buf(buffers[next_index])
        print("Switched to next buffer (circular)")
      end, { desc = "Next buffer (circular)" })
      
      vim.keymap.set("n", "<leader>b[", function()
        local buffers = vim.api.nvim_list_bufs()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_index = -1
        
        -- Find current buffer index
        for i, buf in ipairs(buffers) do
          if buf == current_buf then
            current_index = i
            break
          end
        end
        
        -- Get previous buffer (wrap around if needed)
        local prev_index = current_index - 1
        if prev_index < 1 then
          prev_index = #buffers
        end
        
        -- Switch to previous buffer
        vim.api.nvim_set_current_buf(buffers[prev_index])
        print("Switched to previous buffer (circular)")
      end, { desc = "Previous buffer (circular)" })
      
      -- API file finder - uses Telescope to find matching files
      vim.keymap.set("n", "<leader>fa", function()
        -- Get the current line and try to extract API endpoint
        local current_line = vim.api.nvim_get_current_line()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local cursor_col = cursor_pos[2]
        
        -- Try to find API endpoint pattern in current line
        local api_pattern = "/api/[%w%-%_/%.]+"
        local api_endpoint = current_line:match(api_pattern)
        
        -- If not found in current line, try to find it around cursor
        if not api_endpoint then
          -- Look for API pattern around cursor position
          local line_before = current_line:sub(1, cursor_col + 1)
          local line_after = current_line:sub(cursor_col + 1)
          
          -- Try to match API endpoint that includes cursor position
          local extended_line = line_before .. line_after
          api_endpoint = extended_line:match(api_pattern)
        end
        
        -- If still not found, prompt user for API endpoint
        if not api_endpoint then
          api_endpoint = vim.fn.input("Enter API endpoint (e.g., /api/activity/test/update-answers): ", "/api/")
          if api_endpoint == "" then
            return
          end
        end
        
        -- Convert API endpoint to search pattern for Telescope
        local function api_to_search_pattern(api_path)
          -- Remove /api/ prefix but keep the rest of the path structure
          local search_pattern = api_path:gsub("^/api/", "")
          
          -- Keep slashes for exact path matching, just clean up special chars
          search_pattern = search_pattern:gsub("[-_]", " ") -- Only replace hyphens and underscores
          
          -- Clean up multiple spaces
          search_pattern = search_pattern:gsub("%s+", " ")
          
          -- Trim leading/trailing spaces
          search_pattern = search_pattern:match("^%s*(.-)%s*$")
          
          return search_pattern
        end
        
        local search_pattern = api_to_search_pattern(api_endpoint)
        
        -- Open Telescope file search with the pattern pre-filled
        local telescope_ok, telescope = pcall(require, "telescope.builtin")
        if not telescope_ok then
          return
        end
        
        telescope.find_files({
          prompt_title = "Find API file: " .. api_endpoint,
          default_text = search_pattern,
        })
      end, { desc = "Find API file from endpoint" })
      
      -- Visual mode API finder - extract API from selection
      vim.keymap.set("v", "<leader>fa", function()
        -- Get selected text
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local start_line = start_pos[2]
        local start_col = start_pos[3]
        local end_line = end_pos[2]
        local end_col = end_pos[3]
        
        local selected_text = ""
        if start_line == end_line then
          -- Single line selection
          local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
          selected_text = line:sub(start_col, end_col)
        else
          -- Multi-line selection (take first line for simplicity)
          local first_line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
          selected_text = first_line:sub(start_col)
        end
        
        -- Clean up the selected text and extract API endpoint
        selected_text = selected_text:match("^%s*(.-)%s*$") -- trim whitespace
        local api_endpoint = selected_text:match("/api/[%w%-%_/%.]+")
        
        if not api_endpoint then
          return
        end
        
        -- Convert API endpoint to search pattern for Telescope
        local function api_to_search_pattern(api_path)
          -- Remove /api/ prefix but keep the rest of the path structure
          local search_pattern = api_path:gsub("^/api/", "")
          
          -- Keep slashes for exact path matching, just clean up special chars
          search_pattern = search_pattern:gsub("[-_]", " ") -- Only replace hyphens and underscores
          
          -- Clean up multiple spaces
          search_pattern = search_pattern:gsub("%s+", " ")
          
          -- Trim leading/trailing spaces
          search_pattern = search_pattern:match("^%s*(.-)%s*$")
          
          return search_pattern
        end
        
        local search_pattern = api_to_search_pattern(api_endpoint)
        
        -- Open Telescope file search with the pattern pre-filled
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
        { "<leader>b", group = "Buffer" },
        { "<leader>bf", desc = "Buffer explorer" },
        { "<leader>bb", desc = "Back (previous buffer)" },
        { "<leader>bn", desc = "Next buffer" },
        { "<leader>bp", desc = "Previous buffer" },
        { "<leader>b]", desc = "Next buffer (circular)" },
        { "<leader>b[", desc = "Previous buffer (circular)" },
        { "<leader>w", desc = "Save" },
        { "<leader>q", desc = "Quit" },
        { "<leader>wq", desc = "Save and quit" },
        { "<leader>h", desc = "Clear search highlights" },
        -- Buffer delete keymap is now defined above with smart handling
-- { "<leader>bd", desc = "Delete buffer" },
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
        
        -- Split keymaps
        { "<leader>s", group = "Split" },
        { "<leader>sh", desc = "Split horizontal" },
        { "<leader>sl", desc = "Split vertical" },
        { "<leader>sj", desc = "Split horizontal and go down" },
        { "<leader>sk", desc = "Split horizontal and go up" },
        { "<leader>si", desc = "Split vertical and go right" },
        { "<leader>sd", desc = "Split vertical and go left" },
        
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
        { "<leader>h", group = "Git Hunk" },
        { "<leader>hs", desc = "Stage hunk" },
        { "<leader>hr", desc = "Reset hunk" },
        { "<leader>hS", desc = "Stage buffer" },
        { "<leader>hu", desc = "Undo stage hunk" },
        { "<leader>hR", desc = "Reset buffer" },
        { "<leader>hp", desc = "Preview hunk" },
        { "<leader>hb", desc = "Blame line" },
        { "<leader>hB", desc = "Toggle line blame" },
        { "<leader>hd", desc = "Diff this" },
        { "<leader>hD", desc = "Diff this ~" },
        { "<leader>ht", desc = "Toggle deleted" },
        
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
      
      -- Debug keybinding to check Supermaven suggestions
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
        
        -- Copy to system clipboard
        vim.fn.setreg("+", relative_path)
        vim.fn.setreg("", relative_path) -- Also copy to unnamed register
        
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
              modified  = "",
              renamed   = "󰁕",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            },
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          use_libuv_file_watcher = false, -- Disable for better performance
          hijack_netrw_behavior = "open_current",
          scan_mode = "shallow", -- Faster scanning
          filtered_items = {
            visible = true, -- Show hidden files by default
            hide_dotfiles = false, -- Show dot files by default
            hide_gitignored = false, -- Disable git status checking for better performance
            hide_hidden = false, -- Show hidden files by default
            never_show = {
              ".git",
              "node_modules",
              ".DS_Store",
              "target",
              "dist",
              "build",
            },
          },
          async_directory_scan = "auto", -- Optimize scanning
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
        -- Fix for state management issues
        close_if_last_window = false,
        enable_git_status = false, -- Disable for better performance
        enable_diagnostics = false, -- Disable for better performance
        open_files_do_not_replace_types = { "terminal", "trouble", "qf", "neo-tree" },
        sort_case_insensitive = false,
        sort_function = nil,
        default_source = "filesystem",
        -- Event handlers to prevent state issues
        event_handlers = {
          {
            event = "file_opened",
            handler = function(file_path)
              -- auto close
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
        -- Performance optimizations
        popup_border_style = "single",
        enable_normal_mode_for_inputs = false,
        open_files_in_last_window = true,
        sort_case_insensitive = false,
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Buffer explorer" })
      vim.keymap.set("n", "<leader>ft", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })
      vim.keymap.set("n", "<leader>.", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
    end,
  },

  -- Theme switcher
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      -- Custom buffer deletion function
        local function delete_buffer_in_telescope(prompt_bufnr)
          local action_state = require("telescope.actions.state")
          local actions = require("telescope.actions")
          
          -- Get current selection
          local entry = action_state.get_selected_entry()
          if not entry or not entry.bufnr then
            vim.notify("No buffer selected", vim.log.levels.WARN)
            return
          end
          
          -- Check if buffer has unsaved changes
          local modified = vim.api.nvim_buf_get_option(entry.bufnr, "modified")
          if modified then
            local choice = vim.fn.confirm("Buffer has unsaved changes. Save first?", "&Yes\n&No\n&Cancel", 1)
            if choice == 1 then -- Yes
              vim.api.nvim_buf_call(entry.bufnr, function()
                vim.cmd("write")
              end)
            elseif choice == 3 then -- Cancel
              vim.notify("Buffer deletion cancelled", vim.log.levels.INFO)
              return
            end
          end
          
          -- Get buffer name for feedback BEFORE deleting
          local buf_name = vim.api.nvim_buf_get_name(entry.bufnr)
          local buf_display = buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":t") or "[No Name]"
          
          -- Try to delete the buffer
          local success, err = pcall(function()
            vim.api.nvim_buf_delete(entry.bufnr, { force = false })
          end)
          
          if not success then
            vim.notify("Failed to close buffer '" .. buf_display .. "': " .. err, vim.log.levels.ERROR)
            return
          end
          
          -- Show success message
          vim.notify("Closed buffer: " .. buf_display, vim.log.levels.INFO)
          
          -- Use Telescope's built-in refresh mechanism
          local picker = action_state.get_current_picker(prompt_bufnr)
          if picker then
            picker:refresh_finder()
          end
        end
        
        telescope.setup({
          defaults = {
            mappings = {
              i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
              },
            },
            -- Make mappings more responsive
            prompt_prefix = "🔍 ",
            selection_caret = "❯ ",
            path_display = { "truncate" },
            -- Reduce timeout for faster response
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
            },
          },
          pickers = {
            buffers = {
              mappings = {
                n = {
                  ["c"] = "delete_buffer",
                  ["d"] = "delete_buffer",
                  ["dd"] = "delete_buffer",
                },
                i = {
                  ["<C-d>"] = "delete_buffer",
                },
              },
            },
          },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fu", function()
        local current_file = vim.fn.expand("%:t")
        local filetype = vim.bo.filetype
        
        -- Define search patterns based on file type
        local search_pattern = ""
        if filetype == "svelte" then
          search_pattern = "**/*.svelte"
        elseif filetype == "typescript" or filetype == "javascript" then
          search_pattern = "**/*.{ts,js,svelte}"
        elseif filetype == "rust" then
          search_pattern = "**/*.rs"
        else
          -- For all other file types, search all files
          search_pattern = "**/*"
        end
        
        -- Use ripgrep to find matches with line numbers
        local cmd = "rg -n " .. vim.fn.shellescape(current_file) .. " -g " .. vim.fn.shellescape(search_pattern)
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()
        
        -- Parse results to extract file and line info
        local matches = {}
        for line in result:gmatch("[^\r\n]+") do
          if line ~= "" then
            -- Parse ripgrep output: "filename:line:content"
            local filename, line_num = line:match("^(.+):(%d+):")
            if filename and line_num then
              table.insert(matches, {
                file = filename,
                line = tonumber(line_num)
              })
            end
          end
        end
        
        -- If only one match found, open file and jump to line
        if #matches == 1 then
          local match = matches[1]
          vim.cmd("edit +" .. match.line .. " " .. match.file)
          print("Opened: " .. match.file .. " at line " .. match.line)
        else
          -- Multiple matches or no matches, show Telescope picker
          require("telescope.builtin").live_grep({
            default_text = current_file,
            additional_args = function()
              return search_pattern ~= "**/*" and { "--glob=" .. search_pattern } or {}
            end,
          })
        end
      end, { desc = "Find file usages" })
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
          left_trunc_marker = "",
          right_trunc_marker = "",
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

  -- Mason for managing LSP servers, DAP servers, linters, and formatters
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

  -- Mason LSP config to easily configure LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
      
      -- Prevent Biome from being auto-started by mason-lspconfig
      local original_setup = require("mason-lspconfig").setup
      require("mason-lspconfig").setup = function(opts)
        opts = opts or {}
        opts.ensure_installed = opts.ensure_installed or {}
        -- Remove biome from ensure_installed if present
        local new_ensure_installed = {}
        for _, server in ipairs(opts.ensure_installed) do
          if server ~= "biome" and server ~= "biome_lsp" then
            table.insert(new_ensure_installed, server)
          end
        end
        opts.ensure_installed = new_ensure_installed
        return original_setup(opts)
      end
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      -- Set up Mason LSP config
      mason_lspconfig.setup({
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
        -- Disable automatic handlers to prevent auto-starting servers
        automatic_installation = false,
      })

      -- Explicitly block Biome LSP from starting
      vim.lsp.config["biome"] = {
        enabled = false,  -- This prevents the Biome LSP server from starting
        autostart = false,
      }
      
      -- Also block any biome-related servers
      vim.lsp.config["biome_lsp"] = {
        enabled = false,
        autostart = false,
      }

      -- Explicitly block rust-analyzer from being started by general LSP config
      -- since it's handled by rustaceanvim
      vim.lsp.config["rust-analyzer"] = {
        enabled = false,  -- This prevents the server from starting
      }
      vim.lsp.config["rust_analyzer"] = {
        enabled = false,  -- Block underscore variant too
      }

      -- Set up LSP servers (rust-analyzer handled by rustaceanvim)
      local servers = {
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
      }

      -- Global prevention: Block Biome from starting
      local original_lsp_enable = vim.lsp.enable
      vim.lsp.enable = function(server_name, ...)
        if server_name == "biome" then
          vim.notify("Biome LSP disabled - using Prettier instead", vim.log.levels.INFO)
          return false
        end
        return original_lsp_enable(server_name, ...)
      end

      -- Ensure rust-analyzer is never started by the general LSP config
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and (client.name == "rust-analyzer" or client.name == "rust_analyzer") and not client.config.rustaceanvim then
            -- This is a rogue rust-analyzer instance, stop it immediately
            vim.lsp.stop_client(args.data.client_id)
            vim.notify("Stopped rogue rust-analyzer instance: " .. client.name, vim.log.levels.WARN)
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
              commitCharactersSupport = true,
              documentationFormat = { "markdown", "plaintext" },
              deprecatedSupport = true,
              preselectSupport = true,
              tagSupport = {
                valueSet = { 1 },
              },
              insertReplaceSupport = true,
              resolveSupport = {
                properties = {
                  "documentation",
                  "detail",
                  "additionalTextEdits",
                },
              },
            },
          },
        },
      })

      -- Set up each server using new vim.lsp.config API
      for _, server in ipairs(servers) do
        vim.lsp.config[server] = {
          capabilities = capabilities,
        }
        vim.lsp.enable(server)
      end

      -- Global prevention: Block any rust-analyzer that's not from rustaceanvim
      local original_lsp_enable = vim.lsp.enable
      vim.lsp.enable = function(server_name, ...)
        if server_name == "rust-analyzer" or server_name == "rust_analyzer" then
          vim.notify("rust-analyzer should only be started by rustaceanvim", vim.log.levels.ERROR)
          return false
        end
        return original_lsp_enable(server_name, ...)
      end

      -- Manual setup for servers with special configurations
      vim.lsp.config.svelte = {
        settings = {
          svelte = {
            compiler = {
              enable = true,
            },
            emmet = {
              enable = true,
            },
          },
        },
        capabilities = capabilities,
      }
      vim.lsp.enable("svelte")

      

      vim.lsp.config.html = {
        init_options = {
          provideFormatter = true,
          embeddedLanguages = {
            javascript = true,
            css = true,
          },
          configurationSection = {
            "html",
            "css",
            "javascript",
          },
        },
        settings = {
          html = {
            format = {
              enable = true,
            },
            suggest = {
              enable = true,
            },
            completion = {
              enable = true,
            },
          },
        },
      }
      vim.lsp.enable("html")

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
      vim.lsp.enable("lua_ls")

      -- Keymaps for LSP
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      
      -- LSP refresh/restart keymaps
      vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP info" })
      vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients()[1].id)<cr>", { desc = "Stop LSP" })
      vim.keymap.set("n", "<leader>lR", function()
        -- Force restart all LSP clients
        for _, client in ipairs(vim.lsp.get_active_clients()) do
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

      -- Configure diagnostic signs (modern way)
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "⚠",
            [vim.diagnostic.severity.HINT] = "💡",
            [vim.diagnostic.severity.INFO] = "ℹ",
          },
        },
      })

      -- Configure diagnostic display
      vim.diagnostic.config({
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

      -- Prevent general LSP from attaching to Rust files (handled by rustaceanvim)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          -- Stop any non-rustaceanvim LSP clients for Rust files
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          for _, client in ipairs(clients) do
            if (client.name == "rust-analyzer" or client.name == "rust_analyzer") and not client.config.rustaceanvim then
              vim.lsp.stop_client(client.id)
              vim.notify("Stopped non-rustaceanvim LSP client: " .. client.name, vim.log.levels.WARN)
            end
          end
        end,
      })

      -- Auto-restart LSP if it becomes unresponsive
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 and vim.bo.filetype ~= "" then
            -- Try to restart LSP for this buffer if no clients are attached
            local ft = vim.bo.filetype
            local server_map = {
              javascript = "ts_ls",
              typescript = "ts_ls",
              svelte = "svelte",
              lua = "lua_ls",
              html = "html",
              css = "cssls",
              json = "jsonls",
              yaml = "yamlls",
            }
            if server_map[ft] then
              vim.defer_fn(function()
                vim.lsp.enable(server_map[ft])
                vim.notify("Auto-restarted LSP for " .. ft, vim.log.levels.INFO)
              end, 1000)
            end
          end
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<M-Space>"] = cmp.mapping.complete(), -- Alt+Space as alternative
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- Priority: 1. Supermaven, 2. cmp completion, 3. luasnip, 4. normal tab
            local supermaven_ok, supermaven = pcall(require, "supermaven-nvim.completion_preview")
            if supermaven_ok and supermaven.has_suggestion() then
              supermaven.on_accept_suggestion()
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "supermaven", priority = 900 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Add icons to completion items
            local kind_icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰊄",
            Supermaven = "",
            }
            
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            
            -- Set source name
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              supermaven = "[Supermaven]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            
            return vim_item
          end,
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
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

  -- Conform.nvim for modern formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" }, -- Use basic prettier for Svelte, rely on LSP for complex formatting
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
              return false -- Skip auto-format for Svelte 5 files
            end
          end
          -- Use conform for all other cases
          return { timeout_ms = 5000, lsp_fallback = true }
        end,
        -- Configure formatters with explicit paths
        formatters = {
          prettier = {
            command = "/Users/v/.local/share/nvim/mason/bin/prettier",
            args = { "--stdin-filepath", "$FILENAME" },
          },
          -- Basic prettier for Svelte (limited Svelte 5 support)
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
          -- Check if file contains Svelte 5 syntax
          local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
          if content:match("{@render") or content:match("{#snippet") or content:match("$props") or content:match("$bindable") or content:match("$state") then
            -- Use LSP formatting for Svelte 5 syntax
            vim.lsp.buf.format({ async = true })
            vim.notify("Using LSP formatting for Svelte 5 syntax", vim.log.levels.INFO)
          else
            -- Use conform for regular Svelte files
            require("conform").format({ async = true, lsp_fallback = true })
          end
        else
          -- Use conform for all other file types
          require("conform").format({ async = true, lsp_fallback = true })
        end
      end

      -- Format keymap
      vim.keymap.set("n", "<leader>af", format_file, { desc = "Format file" })
    end,
  },

  -- Enhanced Rust tools and diagnostics
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
        -- Configure rust-analyzer to use Mason's instance (standard)
        server = {
          cmd = { "/Users/v/.local/share/nvim/mason/packages/rust-analyzer/rust-analyzer-aarch64-apple-darwin" },
          rustaceanvim = true,  -- Mark this as the rustaceanvim instance
          -- Ensure this is the only rust-analyzer that can attach to Rust files
          autostart = true,
          on_attach = function(client, bufnr)
            -- Keymaps for Rust
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
        -- Configure DAP (Debug Adapter Protocol)
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

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "rust",
          "javascript",
          "typescript",
          "svelte",
          "html",
          "css",
          "json",
          "yaml",
          "toml",
          "xml",
          "markdown",
          "markdown_inline",
          "bash",
          "python",
          "go",
          "java",
          "cpp",
          "c",
          "php",
          "ruby",
          "sql",
          "dockerfile",
          "graphql",
          "vim",
          "vimdoc",
          "regex",
          "comment",
          "diff",
          "gitcommit",
          "gitignore",
          "git_rebase",
          "gitattributes",
          "git_config",
          "query",
          "http",
          "jsonc",
          "scss",
          "vue",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        fold = {
          enable = true,
        },
        auto_install = true,
      })
    end,
},

  -- Supermaven AI assistant
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>", -- Keep for reference but disabled below
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "neo-tree", "TelescopePrompt" },
        color = {
          suggestion_color = "#888888",
          cterm = 244,
        },
        disable_inline_completion = false, -- Enable inline completion
        disable_keymaps = true, -- Disable built-in keymaps, let cmp handle Tab
        log_level = "info", -- Enable logging to debug issues
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
              -- Show in status line that Supermaven has a suggestion
              vim.opt.statusline = vim.opt.statusline:get() .. " [AI:Tab]"
            end
          end, 100)
        end,
      })
    end,
  },

  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        -- Add any custom configuration here
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

  -- Additional useful plugins
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next hunk" })

          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous hunk" })

          -- Actions
          vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
          vim.keymap.set("n", "<leader>hb", function() gs.blame_line { full = true } end, { buffer = bufnr, desc = "Blame line" })
          vim.keymap.set("n", "<leader>hB", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })
          vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
          vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, { buffer = bufnr, desc = "Diff this ~" })
          vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })

          -- Text object
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select hunk" })
        end,
      })
    end,
  },

  -- Git UI tools
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GRename", "GDelete", "GBrowse", "GRemove", "GUnlink", "Gclog", "Gllog" },
    config = function()
      -- Fugitive keymaps
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
      vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
      vim.keymap.set("n", "<leader>ga", "<cmd>Git add %<cr>", { desc = "Git add current file" })
      vim.keymap.set("n", "<leader>gA", "<cmd>Git add .<cr>", { desc = "Git add all" })
      vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
      vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git pull" })
      vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff split" })
      vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
      vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<cr>", { desc = "Git write (stage)" })
      vim.keymap.set("n", "<leader>gr", "<cmd>Gread<cr>", { desc = "Git read (checkout)" })
    end,
  },

  -- GitHub integration
  {
    "pwntester/octo.nvim",
    cmd = { "Octo" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        use_local_fs = true,
        enable_builtin = true,
        mappings = {
          issue = {
            close_issue = { lhs = "<space>ic", desc = "close issue" },
            reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            add_label = { lhs = "<space>la", desc = "add label" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            goto_issue = { lhs = "<space>gi", desc = "goto issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add ❤️ reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add 🚀 reaction" },
            react_eyes = { lhs = "<space>re", desc = "add 👀 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
            merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
            list_commits = { lhs = "<space>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add ❤️ reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add 🚀 reaction" },
            react_eyes = { lhs = "<space>re", desc = "add 👀 reaction" },
          },
          review_thread = {
            goto_issue = { lhs = "<space>gi", desc = "goto issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
          },
        },
      })
    end,
  },

  

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Session management to restore previous files and cursor positions
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
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty for defaults
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
        surrounds = {
          -- HTML tags
          ["t"] = {
            add = function()
              local result = require("nvim-surround.config").get_input("Enter tag name: ")
              if result then
                return { { "<" .. result .. ">" }, { "</" .. result .. ">" } }
              end
            end,
            find = "<[^>]*>.-</[^>]*>",
            delete = "^(<[^>]*)%s*(.-)%s*(</[^>]*)$",
            change = {
              target = "^<([^>]*)%s*(.-)%s*(</[^>]*)$",
              replacement = function()
                local result = require("nvim-surround.config").get_input("Enter new tag name: ")
                if result then
                  return { { "<" .. result .. ">" }, { "</" .. result .. ">" } }
                end
              end,
            },
          },
        },
      })
    end,
  },

  
}