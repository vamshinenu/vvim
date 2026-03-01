# dotfiles

Personal Neovim, Zellij, and Ghostty configuration. This repo lives at
`~/.config/nvim` and contains configs for other tools via symlinks.

## Setup on a new machine

### 1. Clone

```bash
git clone https://github.com/vamshinenu/vvim.git ~/.config/nvim
```

### 2. Neovim

Just open nvim. Lazy.nvim bootstraps itself and installs all plugins
automatically on first launch.

```bash
nvim
```

Requires a Nerd Font for icons.

### 3. Zellij

The zellij config lives in this repo at `zellij/`. Zellij expects its config
at `~/.config/zellij/`, so create a symlink:

```bash
ln -s ~/.config/nvim/zellij ~/.config/zellij
```

If `~/.config/zellij` already exists, back it up or remove it first.

### 4. Ghostty

The ghostty config lives at `ghostty/config` in this repo. Copy or symlink it:

```bash
# macOS
ln -s ~/.config/nvim/ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
```

## Repo structure

```
.
├── init.lua                  # Entry point: leader key, lazy.nvim bootstrap, base settings, keymaps
├── lua/plugins/
│   ├── init.lua              # Plugin list aggregator
│   ├── ai.lua                # Supermaven (AI completion)
│   ├── colorschemes.lua      # OneDark theme
│   ├── completion.lua        # nvim-cmp, snippets
│   ├── editor.lua            # Autopairs, surround, comment, which-key, auto-session
│   ├── formatting.lua        # Conform (prettier, stylua, rustfmt)
│   ├── git.lua               # Gitsigns, fugitive, octo
│   ├── lsp.lua               # LSP servers via mason + lspconfig
│   ├── rust.lua              # rustaceanvim, crates.nvim
│   ├── telescope.lua         # Telescope fuzzy finder
│   ├── treesitter.lua        # Treesitter, textobjects
│   └── ui.lua                # Neo-tree, bufferline, lualine, noice, indent guides
├── lazy-lock.json            # Pinned plugin versions
├── ghostty/config            # Ghostty terminal config
├── zellij/
│   ├── config.kdl            # Zellij config
│   ├── config.kdl.bak        # Backup
│   └── themes/               # Zellij themes (tokyo-night)
├── nvim_init.lua             # Legacy (unused)
└── nvim_plugins.lua          # Legacy (unused)
```

## Symlinks summary

After cloning, these symlinks should exist:

| Symlink path | Target |
|---|---|
| `~/.config/zellij` | `~/.config/nvim/zellij` |
| Ghostty config (platform-dependent) | `~/.config/nvim/ghostty/config` |

Everything is tracked in one repo at `~/.config/nvim`.

## Notes

- Leader key is Space
- Plugin manager: lazy.nvim (auto-bootstraps, no manual install needed)
- LSP servers are installed automatically via Mason on first open
- Transparent backgrounds are set globally so the terminal's opacity shows through
