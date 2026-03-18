# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Doom Emacs personal configuration for Vasiliy Yorkin. Located at `~/.config/doom/` (the `$DOOMDIR`).

## Key Commands

- `doom sync` — must be run after modifying `init.el` or `packages.el` (not needed for `config.el` changes)
- `doom/reload` (`M-x doom/reload`) — reload config from within Emacs
- `doom doctor` — diagnose common issues
- `doom upgrade` — update Doom Emacs

## Architecture

The config is split across files loaded by `config.el` via Doom's `load!` macro:

| File | Purpose |
|------|---------|
| `init.el` | Doom module declarations (`doom!` block) — controls which modules are enabled |
| `packages.el` | Third-party package declarations — no `require`/`use-package!` here, just `package!` |
| `config.el` | Entry point that loads all `+*.el` files |
| `+base.el` | Fonts (JuliaMono 18), frame settings, scrolling, fringes, margins, tab-bar-notch for macOS notch |
| `+themes.el` | Theme config (base16-black-metal), italics disabled globally, custom face hooks |
| `+keys.el` | Evil keybindings — C-hjkl for window navigation, `;`/`:` swapped, leader bindings |
| `+ui.el` | UI packages: rainbow-delimiters, idle-highlight, hl-line, evil-mc, evil-matchit, zoom-window, expand-region |
| `+projectile.el` | Projectile search paths and settings |
| `+org.el` | Org-mode configuration |
| `+git.el` | Git-related config (magit, git-messenger) |
| `+other.el` | Treemacs and consult settings |
| `+coq.el` | Coq theorem prover config |
| `+lean.el` | Lean 4 theorem prover config (uses nael-mode from Codeberg) |
| `custom.el` | Emacs custom-set-variables (auto-generated) |

## Conventions

- All `.el` files use `lexical-binding: t`
- Package configuration uses `use-package!` wrapped in `after!` blocks when needed
- Keybindings use Doom's `map!` macro with Evil states (`:n` normal, `:v` visual, `:nv` both)
- Leader-prefixed bindings go in `map!` with `:leader`
- Custom functions use `my/` prefix (e.g., `my/disable-all-italics`)

## Enabled Language Modules

Go, Haskell, JavaScript, Python, Rust, OCaml, Zig, Coq, Solidity, Emacs Lisp, web (HTML/CSS), shell, JSON, YAML, Markdown, Org — most with `+lsp` and `+tree-sitter` flags. LSP backend is Eglot (`+eglot` flag).
