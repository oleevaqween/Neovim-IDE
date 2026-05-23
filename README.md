# Neovim WSL2 IDE

A full Neovim IDE for WSL2, installed in one command.

> **Screenshot coming soon**

---

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/neovim-wsl2-ide.git
cd neovim-wsl2-ide
bash install.sh
```

That's it. The script handles everything: Neovim, Node.js, LSP servers, formatters, linters, and debug adapters.

---

## What Gets Installed

### System tools
| Tool | Purpose |
|------|---------|
| Neovim v0.11.0 | Editor (prebuilt tarball, no FUSE needed) |
| Node.js v20 LTS | Required for npm-based LSP tools |
| ripgrep | Fast grep, used by fzf-lua and Neovim search |
| fd-find | Fast file finder |
| win32yank | Windows ↔ WSL2 clipboard bridge |

### Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| nvim-lspconfig | LSP client configuration |
| mason.nvim | LSP/tool installer |
| mason-tool-installer.nvim | Headless auto-install of all tools |
| nvim-cmp | Autocompletion engine |
| LuaSnip + friendly-snippets | Snippet engine + snippet collection |
| lspkind.nvim | VS Code-style icons in completion menu |
| Codeium (Windsurf fork) | AI code completion |
| nvim-treesitter | Syntax highlighting and code parsing |
| fzf-lua | Fuzzy finder for files, LSP, git, and more |
| nvim-tree.lua | File explorer |
| lualine.nvim | Status line |
| which-key.nvim | Keybinding popup on `<leader>?` |
| trouble.nvim | Diagnostics and LSP reference panel |
| gitsigns.nvim | Git diff signs in the gutter |
| vim-fugitive | Git blame, log, diff from inside Neovim |
| nvim-dap + nvim-dap-ui | Debugger with visual UI |
| nvim-dap-python | Python debug adapter |
| nvim-dap-go | Go debug adapter |
| efmls-configs-nvim | EFM language server formatter/linter configs |
| tailwind-tools.nvim | Tailwind CSS class sorting and previews |
| obsidian.nvim | Obsidian vault integration |
| render-markdown.nvim | Render markdown in buffer |
| melange | Color theme |
| nvim-web-devicons | File type icons |
| mini.ai | Better `a`/`i` text objects |
| mini.comment | Line and block commenting |
| mini.move | Move lines and selections with `Alt+hjkl` |
| mini.surround | Add/change/delete surrounding brackets/quotes |
| mini.cursorword | Highlight word under cursor |
| mini.indentscope | Animated indent scope indicator |
| mini.pairs | Auto-close brackets and quotes |
| mini.trailspace | Highlight and remove trailing whitespace |
| mini.bufremove | Close buffers without closing splits |
| mini.notify | Notification popup system |

### LSP Servers

| Server | Language(s) |
|--------|-------------|
| lua-language-server | Lua |
| typescript-language-server | TypeScript, JavaScript |
| pyright | Python |
| gopls | Go |
| bash-language-server | Bash / Shell |
| dockerfile-language-server | Dockerfile |
| emmet-language-server | HTML, CSS, JSX, TSX |
| json-lsp | JSON, JSONC |
| tailwindcss-language-server | Tailwind CSS |
| yaml-language-server | YAML |
| efm-langserver | Multi-language formatter/linter bridge |

### Formatters & Linters (via EFM)

| Tool | Language |
|------|----------|
| stylua | Lua |
| luacheck | Lua |
| black | Python |
| flake8 | Python |
| prettier | JS, TS, HTML, CSS, JSON, Markdown |
| eslint_d | JS, TS |
| gofumpt | Go |
| revive | Go |
| shellcheck | Bash |
| shfmt | Bash |
| hadolint | Dockerfile |
| fixjson | JSON |

### Debug Adapters

| Adapter | Language |
|---------|----------|
| debugpy | Python |
| delve | Go |

---

## Key Bindings

> Leader key is `<Space>`

### Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<C-d>` / `<C-u>` | Half-page down/up (cursor centered) |
| `n` / `N` | Next/previous search result (centered) |

### File Explorer
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree |
| `<leader>m` | Focus file tree |

### Fuzzy Finder (fzf-lua)
| Key | Action |
|-----|--------|
| `<leader>gd` | LSP: go to definition |
| `<leader>gr` | LSP: references |
| `<leader>gt` | LSP: type definitions |
| `<leader>ds` | LSP: document symbols |
| `<leader>ws` | LSP: workspace symbols |
| `<leader>gi` | LSP: implementations |

### LSP
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<leader>gD` | Go to definition |
| `<leader>gS` | Go to definition (vertical split) |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Open diagnostics float |
| `<leader>D` | Open line diagnostics float |
| `<leader>pd` / `<leader>nd` | Previous / next diagnostic |

### Buffers
| Key | Action |
|-----|--------|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |

### Debugger (DAP)
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |

### Completion
| Key | Action |
|-----|--------|
| `<CR>` | Confirm completion |
| `<Tab>` / `<S-Tab>` | Next / previous completion item |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort completion |
| `<C-b>` / `<C-f>` | Scroll docs up/down |

### Misc
| Key | Action |
|-----|--------|
| `<leader>?` | Show buffer-local keymaps (which-key) |
| `J` | Join lines (cursor stays put) |
| `<` / `>` in visual | Indent left/right and reselect |

---

## How to Customize

All config lives in `config/lua/`:

- **Options** → `config/options.lua`
- **Keymaps** → `config/keymaps.lua`
- **Plugins** → `plugins/` — one file per plugin
- **LSP servers** → `servers/` — one file per server
- **Formatters/linters** → `servers/efm-langserver.lua`

To add a new plugin, create a new file in `plugins/` returning a lazy.nvim spec — it's picked up automatically.

To add a new LSP server:
1. Add the Mason package name to `plugins/mason.lua` under `ensure_installed`
2. Create a new file in `servers/` with `vim.lsp.config(...)` and `vim.lsp.enable(...)`
3. Add `require("servers.your-server")` to `servers/init.lua`

---

## Credits

Built on top of the [Zero to Neovim](https://github.com/YOUR_COURSE_LINK) course setup.
