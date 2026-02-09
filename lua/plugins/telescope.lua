-- Telescope fuzzy finder
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      
      -- Custom buffer deletion function
      local function delete_buffer_in_telescope(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")
        
        local entry = action_state.get_selected_entry()
        if not entry or not entry.bufnr then
          vim.notify("No buffer selected", vim.log.levels.WARN)
          return
        end
        
        local modified = vim.api.nvim_buf_get_option(entry.bufnr, "modified")
        if modified then
          local choice = vim.fn.confirm("Buffer has unsaved changes. Save first?", "&Yes\n&No\n&Cancel", 1)
          if choice == 1 then
            vim.api.nvim_buf_call(entry.bufnr, function()
              vim.cmd("write")
            end)
          elseif choice == 3 then
            vim.notify("Buffer deletion cancelled", vim.log.levels.INFO)
            return
          end
        end
        
        local buf_name = vim.api.nvim_buf_get_name(entry.bufnr)
        local buf_display = buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":t") or "[No Name]"
        
        local success, err = pcall(function()
          vim.api.nvim_buf_delete(entry.bufnr, { force = false })
        end)
        
        if not success then
          vim.notify("Failed to close buffer '" .. buf_display .. "': " .. err, vim.log.levels.ERROR)
          return
        end
        
        vim.notify("Closed buffer: " .. buf_display, vim.log.levels.INFO)
        
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
          prompt_prefix = "🔍 ",
          selection_caret = "❯ ",
          path_display = { "truncate" },
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
        
        local search_pattern = ""
        if filetype == "svelte" then
          search_pattern = "**/*.svelte"
        elseif filetype == "typescript" or filetype == "javascript" then
          search_pattern = "**/*.{ts,js,svelte}"
        elseif filetype == "rust" then
          search_pattern = "**/*.rs"
        else
          search_pattern = "**/*"
        end
        
        local cmd = "rg -n " .. vim.fn.shellescape(current_file) .. " -g " .. vim.fn.shellescape(search_pattern)
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()
        
        local matches = {}
        for line in result:gmatch("[^\r\n]+") do
          if line ~= "" then
            local filename, line_num = line:match("^(.+):(%d+):")
            if filename and line_num then
              table.insert(matches, {
                file = filename,
                line = tonumber(line_num)
              })
            end
          end
        end
        
        if #matches == 1 then
          local match = matches[1]
          vim.cmd("edit +" .. match.line .. " " .. match.file)
          print("Opened: " .. match.file .. " at line " .. match.line)
        else
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
}
