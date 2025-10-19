-- Set leader key BEFORE loading anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "nightfox" } },
  checker = { enabled = true },
  change_detection = { notify = false },
})

-- Initialize theme system
require("themes").set_theme("nightfox")

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- Swap file management to prevent conflicts
vim.opt.swapfile = false
vim.opt.updatecount = 0
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Enable icons
vim.g.have_nerd_font = true

-- Enable transparency (no blur)
vim.opt.termguicolors = true

-- Disable netrw and use neo-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Clear any existing netrw autocommands
vim.api.nvim_create_augroup("netrw", { clear = true })

-- Start with empty buffer instead of netrw directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("enew")
    end
  end,
  once = true,
})

-- Handle swap files automatically
vim.cmd([[
  augroup SwapFileHandling
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echo "Opening file read-only due to existing swap file"
  augroup END
]])

-- Command to clean up swap files
vim.api.nvim_create_user_command('CleanSwapFiles', function()
  local swap_dir = vim.fn.stdpath("data") .. "/swap"
  local handle = io.popen("find " .. swap_dir .. " -name '*.swp' -type f")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result and result ~= "" then
      vim.fn.system("rm " .. swap_dir .. "/*.swp")
      print("Cleaned up swap files")
    else
      print("No swap files found")
    end
  end
end, { desc = "Clean up all swap files" })

-- Set transparent background but ensure line numbers are visible
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight LineNrAbove guibg=NONE ctermbg=NONE
  highlight LineNrBelow guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
  highlight Folded guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  
  " Ensure line numbers are visible
  highlight LineNr guifg=#5eacd3
  highlight LineNrAbove guifg=#5eacd3
  highlight LineNrBelow guifg=#5eacd3
  highlight CursorLineNr guifg=#ffffff
]])






-- Additional useful settings
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Incremental search
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Smart case search
vim.opt.cursorline = true -- Highlight current line
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.splitbelow = true -- Horizontal splits to bottom
vim.opt.splitright = true -- Vertical splits to right

-- Folding configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext = ""
vim.opt.fillchars = { fold = " " }

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })

-- Buffer closing with smart handling (moved to plugins.lua to avoid conflicts)
-- vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
-- vim.keymap.set("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Leader key buffer navigation (j for previous, k for next - like vim motion)
vim.keymap.set("n", "<leader>j", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>k", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

