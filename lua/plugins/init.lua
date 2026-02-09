-- Plugin configuration entry point
-- This file combines all plugin modules and returns them to lazy.nvim

-- Helper function to safely require a module and return its contents
local function require_module(name)
  local ok, module = pcall(require, "plugins." .. name)
  if ok then
    return module
  else
    vim.notify("Failed to load plugin module: " .. name .. " - " .. tostring(module), vim.log.levels.ERROR)
    return {}
  end
end

-- Combine all plugin modules
local plugins = {}

-- Load each module and merge into the plugins table
local modules = {
  "colorschemes",  -- Theme plugins
  "editor",        -- Core editor: indent, autopairs, surround, comments, text objects, session
  "ui",            -- UI: neo-tree, bufferline, lualine, which-key
  "telescope",     -- Fuzzy finder
  "lsp",           -- LSP: mason, lspconfig
  "completion",    -- Autocompletion: nvim-cmp, snippets, emmet
  "formatting",    -- Code formatting: conform.nvim
  "treesitter",    -- Syntax highlighting
  "git",           -- Git integration: gitsigns, fugitive, octo
  "rust",          -- Rust development: rustaceanvim
  "ai",            -- AI assistance: supermaven
}

for _, module_name in ipairs(modules) do
  local module_plugins = require_module(module_name)
  for _, plugin in ipairs(module_plugins) do
    table.insert(plugins, plugin)
  end
end

return plugins
