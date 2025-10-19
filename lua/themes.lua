-- Theme switcher functionality
local M = {}

-- Available themes
M.themes = {
  { name = "tokyonight", display = "Tokyo Night" },
  { name = "catppuccin", display = "Catppuccin" },
  { name = "gruvbox", display = "Gruvbox" },
  { name = "rose-pine", display = "Rose Pine" },
  { name = "dracula", display = "Dracula" },
  { name = "onedark", display = "One Dark" },
  { name = "nord", display = "Nord" },
  { name = "kanagawa", display = "Kanagawa" },
  { name = "nightfox", display = "Nightfox" },
  { name = "miasma", display = "Miasma" },
  { name = "cyberdream", display = "Cyberdream" },
  { name = "solarized", display = "Solarized" },
  { name = "ayu", display = "Ayu" },
  { name = "monokai-pro", display = "Monokai Pro" },
  { name = "oxocarbon", display = "Oxocarbon" },
  { name = "github", display = "GitHub" },
  { name = "everforest", display = "Everforest" },
  { name = "gruvbox-material", display = "Gruvbox Material" },
  { name = "sonokai", display = "Sonokai" },
  { name = "edge", display = "Edge" },
}

-- Current theme
M.current_theme = "nightfox"

-- Function to set theme
M.set_theme = function(theme_name)
  if theme_name == "tokyonight" then
    local ok, tokyonight = pcall(require, "tokyonight")
    if ok then
      tokyonight.setup({
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(colors)
        colors.bg = "#1a1b26"
        colors.bg_dark = "#16161e"
        colors.bg_float = "#1a1b26"
        colors.bg_highlight = "#292e42"
        colors.bg_popup = "#1a1b26"
        colors.bg_search = "#292e42"
        colors.bg_sidebar = "#1a1b26"
        colors.bg_statusline = "#1a1b26"
        colors.bg_visual = "#292e42"
      end,
    })
      vim.cmd([[colorscheme tokyonight]])
    else
      print("Tokyonight theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "catppuccin" then
    local ok, catppuccin = pcall(require, "catppuccin")
    if ok then
      catppuccin.setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { light = "latte", dark = "mocha" },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = false,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
    })
      vim.cmd([[colorscheme catppuccin]])
    else
      print("Catppuccin theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "gruvbox" then
    local ok, gruvbox = pcall(require, "gruvbox")
    if ok then
      gruvbox.setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    })
      vim.cmd([[colorscheme gruvbox]])
    else
      print("Gruvbox theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "rose-pine" then
    local ok, rose_pine = pcall(require, "rose-pine")
    if ok then
      rose_pine.setup({
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    })
      vim.cmd([[colorscheme rose-pine]])
    else
      print("Rose Pine theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "dracula" then
    local ok, dracula = pcall(require, "dracula")
    if ok then
      dracula.setup({
      transparent_bg = true,
      italic_comment = true,
    })
      vim.cmd([[colorscheme dracula]])
    else
      print("Dracula theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "onedark" then
    local ok, onedark = pcall(require, "onedark")
    if ok then
      onedark.setup({
      style = "dark", -- dark, darker, cool, deep, warm, warmer, light
      transparent = true,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      toggle_style_key = "<leader>ts",
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },
      lualine = {
        transparent = false,
      },
      colors = {},
      highlights = {},
      diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
      },
    })
      vim.cmd([[colorscheme onedark]])
    else
      print("One Dark theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "nord" then
    local ok, nord = pcall(require, "nord")
    if ok then
      nord.setup({
      diff = { mode = "bg" },
      error = "#bf616a",
      warn = "#d08770",
      warning = "#d08770",
      info = "#81a1c1",
      hint = "#88c0d0",
      todo = "#81a1c1",
    })
      vim.cmd([[colorscheme nord]])
    else
      print("Nord theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "kanagawa" then
    local ok, kanagawa = pcall(require, "kanagawa")
    if ok then
      kanagawa.setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
        background = {
          dark = "wave",
          light = "lotus"
        },
      })
      vim.cmd([[colorscheme kanagawa]])
    else
      print("Kanagawa theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "nightfox" then
    local ok, nightfox = pcall(require, "nightfox")
    if ok then
      nightfox.setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        },
        groups = {
          all = {
            Normal = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
          }
        }
      })
      vim.cmd([[colorscheme nightfox]])
    else
      print("Nightfox theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "miasma" then
    local ok, miasma = pcall(require, "miasma")
    if ok then
      vim.opt.background = "dark"
      vim.cmd([[colorscheme miasma]])
    else
      print("Miasma theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "cyberdream" then
    local ok, cyberdream = pcall(require, "cyberdream")
    if ok then
      cyberdream.setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
      vim.cmd([[colorscheme cyberdream]])
    else
      print("Cyberdream theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "solarized" then
    local ok, solarized = pcall(require, "solarized")
    if ok then
      solarized.setup({
        transparent = true,
        styles = {
          comments = "italic",
          functions = "bold",
          keywords = "italic",
          operators = "bold",
          strings = "italic",
          variables = "NONE",
        },
        palette = "solarized", -- solarized, solarized-high-contrast, solarized-8
        mode = "dark", -- dark, light
      })
      vim.cmd([[colorscheme solarized]])
    else
      print("Solarized theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "ayu" then
    local ok, ayu = pcall(require, "ayu")
    if ok then
      ayu.setup({
        mirage = false,
        overrides = {
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
        }
      })
      vim.cmd([[colorscheme ayu-mirage]])
    else
      print("Ayu theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "monokai-pro" then
    local ok, monokai = pcall(require, "monokai-pro")
    if ok then
      monokai.setup({
        transparent = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true },
          type = { italic = true },
          storageclass = { italic = true },
          structure = { italic = true },
          parameter = { italic = true },
          annotation = { italic = true },
          tag_attribute = { italic = true },
        },
        filter = "pro", -- classic, octagon, pro, machine, ristretto, spectrum
      })
      vim.cmd([[colorscheme monokai-pro]])
    else
      print("Monokai Pro theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "oxocarbon" then
    local ok, oxocarbon = pcall(require, "oxocarbon")
    if ok then
      vim.opt.background = "dark"
      vim.cmd([[colorscheme oxocarbon]])
    else
      print("Oxocarbon theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "github" then
    local ok, github = pcall(require, "github-theme")
    if ok then
      github.setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        }
      })
      vim.cmd([[colorscheme github_dark]])
    else
      print("GitHub theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "everforest" then
    local ok, everforest = pcall(require, "everforest")
    if ok then
      everforest.setup({
        background = "hard",
        transparent_background_level = 1,
        italics = true,
        disable_italic_comments = false,
      })
      vim.cmd([[colorscheme everforest]])
    else
      print("Everforest theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "gruvbox-material" then
    local ok, gruvbox_material = pcall(require, "gruvbox-material")
    if ok then
      gruvbox_material.setup({
        background = "hard",
        transparent_background = true,
        italics = true,
        disable_italic_comments = false,
      })
      vim.cmd([[colorscheme gruvbox-material]])
    else
      print("Gruvbox Material theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "sonokai" then
    local ok, sonokai = pcall(require, "sonokai")
    if ok then
      sonokai.setup({
        style = "andromeda",
        transparent = true,
        italics = {
          comments = true,
          keywords = true,
          functions = true,
          strings = true,
          variables = true,
        },
      })
      vim.cmd([[colorscheme sonokai]])
    else
      print("Sonokai theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  elseif theme_name == "edge" then
    local ok, edge = pcall(require, "edge")
    if ok then
      edge.setup({
        style = "neon",
        transparent = true,
        italics = {
          comments = true,
          keywords = true,
          functions = true,
          strings = true,
          variables = true,
        },
      })
      vim.cmd([[colorscheme edge]])
    else
      print("Edge theme not available, falling back to default")
      vim.cmd([[colorscheme default]])
    end
  else
    print("Unknown theme: " .. theme_name .. ", falling back to default")
    vim.cmd([[colorscheme default]])
  end
  
  M.current_theme = theme_name
  print("Theme changed to: " .. theme_name)
end

-- Function to cycle through themes
M.cycle_theme = function()
  local current_index = 1
  for i, theme in ipairs(M.themes) do
    if theme.name == M.current_theme then
      current_index = i
      break
    end
  end
  
  local next_index = current_index % #M.themes + 1
  M.set_theme(M.themes[next_index].name)
end

-- Function to show theme picker
M.show_theme_picker = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Select a theme",
    finder = finders.new_table({
      results = M.themes,
      entry_maker = function(theme)
        return {
          value = theme.name,
          display = theme.display,
          ordinal = theme.display,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        M.set_theme(selection.value)
      end)
      return true
    end,
  }):find()
end

-- Set up keymaps
vim.keymap.set("n", "<leader>tc", M.cycle_theme, { desc = "Cycle theme" })
vim.keymap.set("n", "<leader>tt", M.show_theme_picker, { desc = "Theme picker" })

return M