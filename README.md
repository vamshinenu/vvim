# vvim

A comprehensive development environment setup featuring Neovim configuration with modern features, extensive theme support, LSP integration, AI-powered development tools, and a beautifully configured Ghostty terminal.

## 🚀 Features

### 🎨 **20+ Beautiful Themes**
- Tokyo Night, Catppuccin, Gruvbox, Rose Pine
- Dracula, One Dark, Nord, Kanagawa, Nightfox
- Miasma, Cyberdream, Solarized, Ayu
- Monokai Pro, Oxocarbon, GitHub, Everforest
- Gruvbox Material, Sonokai, Edge

**Theme Controls:**
- `<leader>tc` - Cycle through themes
- `<leader>tt` - Open theme picker

### 🤖 **AI Integration**
- **Supermaven** - AI-powered code completion
- Tab key accepts AI suggestions first
- `<leader>aa` - Toggle Supermaven
- `<leader>ad` - Debug AI suggestions

### 🔧 **LSP & Development**
- **Language Support:** TypeScript, JavaScript, Svelte, Rust, Lua, HTML, CSS, JSON, YAML, Python, Go, Java, C/C++, PHP, Ruby, SQL, Docker, GraphQL
- **Smart Formatting:** Prettier, Stylua, rustfmt with Svelte 5 support
- **Diagnostics:** Modern error highlighting and navigation
- **Code Actions:** LSP-powered refactoring

### 📁 **File Management**
- **Neo-tree** - Modern file explorer with git integration
- **Telescope** - Fuzzy finder for files, buffers, grep
- **API File Finder** - Smart file discovery from endpoints (`<leader>fa`)

### 🔄 **Buffer Management**
- **Bufferline** - Visual buffer tabs
- Smart buffer closing with unsaved changes detection
- Circular buffer navigation
- `<leader>c` - Close buffer, `<leader>bd` - Force close

### 🌳 **Git Integration**
- **Gitsigns** - Git signs in gutter
- **Fugitive** - Git commands inside Neovim
- **Octo** - GitHub PR/issue management
- Git hunk operations and blame

### 🖥️ **Ghostty Terminal**
- **Modern Terminal** - Fast, GPU-accelerated terminal emulator
- **Beautiful Transparency** - 80% background opacity with blur effects
- **Clean Interface** - No window decorations for minimal distraction
- **Comfortable Padding** - 10px padding for better visual appeal
- **Frosted Glass Effect** - Background blur for modern aesthetics

### ⚡ **Productivity Features**
- **Auto-session** - Restore previous sessions
- **Which-key** - Keybinding hints
- **Comment.nvim** - Smart commenting
- **NVIM-surround** - Surround text objects
- **Text objects** - Enhanced vim text objects
- **Autopairs** - Auto bracket pairing

## 📁 Structure

```
vvim/
├── init.lua           # Main configuration file
├── lua/
│   ├── plugins.lua    # Plugin configurations
│   └── themes.lua     # Theme management system
├── lazy-lock.json     # Plugin version lock file
└── ghostty/
    └── config         # Ghostty terminal configuration
```

## 🛠️ Installation

### Neovim Configuration

1. **Backup your current config:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/vamshinenu/vvim.git ~/.config/nvim
   ```

3. **Launch Neovim:**
   ```bash
   nvim
   ```

4. **Lazy.nvim will automatically install all plugins.**

### Ghostty Terminal Configuration

1. **Install Ghostty** (macOS):
   ```bash
   brew install --cask ghostty
   ```
   Or download from [ghostty.org](https://ghostty.org)

2. **Backup existing Ghostty config:**
   ```bash
   mv "$HOME/Library/Application Support/com.mitchellh.ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.backup"
   ```

3. **Copy Ghostty configuration:**
   ```bash
   cp ~/.config/nvim/ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
   ```

4. **Restart Ghostty** or press `Cmd+Shift+,` to reload configuration.

## ⌨️ Key Mappings

### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fa` - Find API file from endpoint
- `<leader>e` - Toggle file explorer

### Buffer Navigation
- `<Tab>` / `<S-Tab>` - Next/Previous buffer
- `<leader>j` / `<leader>k` - Previous/Next buffer (vim-style)
- `<leader>c` - Close buffer
- `<leader>bd` - Force close buffer

### LSP & Code
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>af` - Format file
- `<leader>al` - LSP code actions

### Git
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gd` - Git diff

### AI Assistant
- `<leader>aa` - Toggle Supermaven
- `<Tab>` - Accept AI suggestion (priority over completion)
- `<leader>ad` - Debug AI suggestions

### Window Navigation
- `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` - Navigate windows

## 🎯 Highlights

### Smart Completion Priority
1. **Supermaven AI suggestions** (highest priority)
2. **LSP completion**
3. **Snippets**
4. **Buffer/Path completion**

### Svelte 5 Support
- Automatic detection of Svelte 5 syntax
- Smart formatting (LSP for Svelte 5, Prettier for regular Svelte)
- Full language server support

### Rust Development
- **rustaceanvim** integration
- Cargo.toml management
- Runnables, testables, debuggables
- Clippy integration

### Transparent Themes
All themes configured with transparent backgrounds for a clean look that pairs perfectly with the Ghostty terminal's transparency.

### Ghostty Terminal Features
- **Background Opacity**: 80% transparency for subtle background visibility
- **Background Blur**: 15px blur for beautiful frosted glass effect
- **Window Decorations**: Disabled for clean, minimal interface
- **Custom Padding**: 10px horizontal and vertical padding
- **Dark Background**: #1a1a1a for comfortable viewing

## 🔧 Customization

### Adding New Themes
1. Add theme to `lua/themes.lua` in the themes table
2. Configure theme in the `set_theme` function
3. Theme will be available in the theme picker

### Modifying Plugins
Edit `lua/plugins.lua` to add, remove, or configure plugins.

### LSP Configuration
LSP servers are configured in the plugins.lua file under the nvim-lspconfig section.

## 📦 Plugin Management

This configuration uses **lazy.nvim** for plugin management with locked versions in `lazy-lock.json` for reproducibility.

To update plugins:
```vim
:Lazy update
```

To restore exact versions:
```bash
nvim --headless "+Lazy restore" +qa
```

## 🤝 Contributing

Feel free to submit issues, fork, and create pull requests to improve this configuration!

## 📄 License

MIT License - feel free to use this configuration as a base for your own setup.

---

**Happy coding! 🎉**