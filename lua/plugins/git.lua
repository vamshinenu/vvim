-- Git integration: gitsigns, fugitive, octo
return {
  -- Gitsigns
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

          -- Actions (git hunk)
          vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("v", "<leader>ghs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("v", "<leader>ghr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
          vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
          vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
          vim.keymap.set("n", "<leader>ghb", function() gs.blame_line { full = true } end, { buffer = bufnr, desc = "Blame line" })
          vim.keymap.set("n", "<leader>ghB", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })
          vim.keymap.set("n", "<leader>ghd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
          vim.keymap.set("n", "<leader>ghD", function() gs.diffthis("~") end, { buffer = bufnr, desc = "Diff this ~" })
          vim.keymap.set("n", "<leader>ght", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })

          -- Text object
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select hunk" })
        end,
      })
    end,
  },

  -- Git UI tools (vim-fugitive)
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GRename", "GDelete", "GBrowse", "GRemove", "GUnlink", "Gclog", "Gllog" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>ga", "<cmd>Git add %<cr>", desc = "Git add current file" },
      { "<leader>gA", "<cmd>Git add .<cr>", desc = "Git add all" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git write (stage)" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git read (checkout)" },
    },
  },

  -- GitHub integration (octo.nvim)
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
}
