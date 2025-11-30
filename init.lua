local vim = vim

-- Begin by setting general vim options:
-- vim.cmd("set clipboard+=unnamedplus")
-- !Make sure you have xclip or something like it installed!
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.background = 'dark'
vim.o.signcolumn = 'yes'
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.scrolloff = 30
vim.o.swapfile = false
vim.o.winborder = 'rounded'

--[[

    Set the map leader key
    When in normal mode, use space to get special keymaps we'll be setting

]]--

vim.g.mapleader = ' '

-- Set some keymaps for leader keys that will source, write to the file, and quit the file
vim.keymap.set('n', '<leader>u', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

--[[

    Use pack to install the few things I do want to use as addons
    If you feel you need to give up, checkout:
        https://github.com/junegunn/vim-plug (some old school vim plug-in management)
        https://github.com/mason-org/mason.nvim (for lsp junk)
        https://github.com/nvim-lua/kickstart.nvim (the og kickstart)
        https://github.com/keifer-may/kickstart.nvim (my personal kickstart)
        https://www.lazyvim.org/
        https://www.lunarvim.org/

    First we are installing different colorschemes for themes
        To find more visit: https://vimcolorschemes.com/

    Following the colorschemes we install (in order):
        - NVIM Oil
            For more info on Oil go to: https://github.com/stevearc/oil.nvim
            Oil is a file explorer that lets you edit your filesystem like a nvim buffer

        - NVIM Mini,
            Maybe checkout more Mini tools or info?: https://nvim-mini.org/mini.nvim/

        - NVIM LSP Config,
            The github: https://github.com/neovim/nvim-lspconfig
            Some examples and junk for lsp setups: https://neovim.io/doc/user/lsp.html#lsp-quickstart

        - Typst Preview
            Get an auto updating preview of your html site
            https://github.com/chomosuke/typst-preview.nvim

]]--

vim.pack.add({
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/sainnhe/everforest' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/shaunsingh/nord.nvim' },
    { src = 'https://github.com/AlexvZyl/nordic.nvim' },
    { src = 'https://github.com/cocopon/iceberg.vim' },
    --{ src = 'https://github.com/stevearc/oil.nvim' },
    --{ src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    --{src = ''},
    --{src = ''},
})

-- Add LSP autocomplete
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotriger = true })
        end
    end,
})
vim.cmd('set completeopt+=noselect')

-- Require the NVIM Mini-Pick and NVIM Oil are setup
require 'mini.pick'.setup() -- Provides a fuzzy finder/buffer search for files
require 'mini.files'.setup() -- Provides a way to navigate filesystem and open buffers
require 'mini.icons'.setup() -- Provides fancy icons to make things pretty
require 'mini.completion'.setup() -- Provides autocomplete, working with LSPs
require 'mini.comment'.setup() -- Provides line or block comments - the hotkey is gc or gcc for toggling
require 'mini.ai'.setup() -- Provides advanced around and inside (a or i) functionality

-- Setup some leader keymaps for LSP formatting, Mini-Pick, and Oil
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>b', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':lua MiniFiles.open()<CR>')
--vim.keymap.set('n', '<leader>e', ':Oil<CR>')
--vim.keymap.set('n', '<leader>o', ':Oil ')

-- Setup the Lua Language Server (what a pain in the ass)
vim.lsp.config['lua_ls'] = {
    -- Command and arguments to start the server.
    cmd = { 'lua-language-server' },
    -- Filetypes to automatically attach to.
    filetypes = { 'lua' },
    --[[
        Sets the "workspace" to the directory where any of these files is found.
        Files that share a root directory will reuse the LSP server connection.
        Nested lists indicate equal priority, see |vim.lsp.Config|.
    ]]--
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    --[[
        Specific settings to send to the server. The schema is server-defined.
        Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    ]]--
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }

}

-- Setup the emmet_ls LSP (pain in the ass too)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config['emmet-ls'] = {
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    }
}

--[[

    Enable the different LSPs that I've installed
    Notes on installs:
    --------------------------------------------------
    --- If you have some general issues or questions:
    --- run <leader>lf to see if lsp formatting will refresh
    --- if that doesn't work, try:
    --- :checkhealth vim.lsp
    --------------------------------------------------
    For lua_ls go to: https://luals.github.io/#neovim-install
    Install homebrew at: https://brew.sh/ 
    running the command:
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    Then run the command:
        brew install lua-language-server
    --------------------------------------------------
    For emmet-ls go to: https://github.com/aca/emmet-ls
    Ensure that node is installed and up-to-date and then run:
    npm install -g emmet-ls
    --------------------------------------------------
    For gopls go to: https://go.dev/gopls/
    Ensure that go is installed and GOPATH is set up in your ENV then run:
    go install golang.org/x/tools/gopls@latest
    --------------------------------------------------


]]--

vim.lsp.enable({ 'lua_ls', 'pylsp', 'gopls', 'ccls', 'rust_analyzer', 'emmet-ls' })

-- Setting the actual colorscheme from the earlier installed colorscheme
vim.cmd('colorscheme iceberg')
--vim.cmd('colorscheme nordic')
--vim.cmd('colorscheme nord')
--vim.cmd('colorscheme tokyonight-moon')
--vim.cmd('colorscheme everforest')
--vim.cmd('colorscheme vague')

--[[
--
-- Some other things to learn about and try:
--
-- Need a good debugger if I'm learning to program in C!
--
-- For Windows, just use the raddebugger!:
-- https://github.com/EpicGamesExt/raddebugger/ && https://github.com/EpicGamesExt/raddebugger/releases
-- Failing that, RemedyBG is pretty awesome looking:
-- https://remedybg.itch.io/remedybg
-- A RemedyBG tutorial by Casey Muratori: https://www.youtube.com/watch?v=r9eQth4Q5jg
--
-- For Linux you need to install GDB:
-- docs: https://sourceware.org/gdb/current/onlinedocs/gdb
--
-- Then try Seer:
-- https://github.com/epasveer/seer
-- or try GF:
-- https://github.com/nakst/gf
-- A fun debugging the debugger video: https://www.youtube.com/watch?v=ux3s1IIvNdg
--
]]--

