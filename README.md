# MY NEOVIM CONFIG

Trying to build this up from scratch in a fairly minimal style, not a ton of dependencies or BS and to also document the few dependencies and things I do need all in one centralized spot.

## NOTE TO SELF

If you decide maintaining this is too much, check out:
- https://github.com/junegunn/vim-plug (some old school vim plug-in management)
- https://github.com/mason-org/mason.nvim (for lsp junk)
- https://github.com/nvim-lua/kickstart.nvim (the og kickstart)
- https://github.com/keifer-may/kickstart.nvim (my personal kickstart)
- https://www.lazyvim.org/
- https://www.lunarvim.org/

## GENERAL DEPENDENCIES
- Install *xclip* for X11 or *wl-clipboard* for Wayland to have access to the system clipboard between OS & Neovim
- *homebrew*
- *npm*
- *python3*
- *pip* or *pipx*
- *go*

## VIM.PACK NOTES

First we install different colorschemes for themes.
To find more visit: https://vimcolorschemes.com/

Following the colorschemes we install (in order):
- *DEPRECATED* NVIM Oil
    - For more info on Oil go to: https://github.com/stevearc/oil.nvim
    - Oil is a file explorer that lets you edit your filesystem like a nvim buffer

- NVIM Mini
    - Maybe checkout more Mini tools or info?: https://nvim-mini.org/mini.nvim/
    - We'll use this to get some file fuzzy finding, general file exploring,
    autocomplete integration, shortcuts for commenting code, some around
    and inside tooling, and general appearance improvement.

- NVIM LSP Config,
    - The github: https://github.com/neovim/nvim-lspconfig
    - Some examples and junk for lsp setups: https://neovim.io/doc/user/lsp.html#lsp-quickstart

- Typst Preview
    - Get an auto updating preview of your html site
    - https://github.com/chomosuke/typst-preview.nvim

## LSP NOTES

#### GENERAL NOTES OR TROUBLESHOOTING

If you need to refresh your file's formatting and refresh the file LSP:

```
<leader>lf 
```

You may also need to save, source the config init.lua, and then run in bash to refresh bash:

```
exec bash
```

To get a little more insight on which LSPs are working or are having issues you can run in vim:

```
:checkhealth vim.lsp
```

#### LUA-LANGUAGE-SERVER

- For lua_ls go to: https://luals.github.io/#neovim-install
- Install homebrew at: https://brew.sh/ running the command:
    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
- Then run the command:
    ```
    brew install lua-language-server
    ```

#### PYLSP

- Obviously, Python3 & pip should be installed. Run:
```
pip install python-lsp-server
```

#### GOPLS

- For gopls go to: https://go.dev/gopls/
- Ensure that go is installed and GOPATH is set up in your ENV then run:
```
go install golang.org/x/tools/gopls@latest
```

#### CCLS

- to note....

#### RUST-ANALYZER

- to note....

#### EMMET-LS

- For emmet-ls go to: https://github.com/aca/emmet-ls
- Ensure that node is installed and up-to-date and then run:
```
npm install -g emmet-ls
``` 



