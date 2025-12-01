local vim = vim

-- Begin by setting general vim options:
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

-- Set the map leader key; use space to get special keymaps we'll be setting.
vim.g.mapleader = ' '

-- Set some keymaps for leader keys that will source, write to the file, and quit the file
vim.keymap.set('n', '<leader>u', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

-- Use vim.pack to install the few things I do want to use as addons. To see more, check the README.
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

--Add LSP autocomplete
--vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(ev)
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         if client:supports_method('textDocument/completion') then
--             vim.lsp.completion.enable(true, client.id, ev.buf, { autotriger = true })
--         end
--     end,
-- })
-- vim.cmd('set completeopt+=noselect')

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
        -- Sets the "workspace" to the directory where any of these files is found.
        -- Files that share a root directory will reuse the LSP server connection.
        -- Nested lists indicate equal priority, see |vim.lsp.Config|.
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
        -- Specific settings to send to the server. The schema is server-defined.
        -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
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

-- Enable the different LSPs that I've installed. For install info, see the README.
vim.lsp.enable({ 'lua_ls', 'pylsp', 'gopls', 'ccls', 'rust_analyzer', 'emmet-ls' })

-- Setting the actual colorscheme from the earlier installed colorscheme
vim.cmd('colorscheme iceberg')
--vim.cmd('colorscheme nordic')
--vim.cmd('colorscheme nord')
--vim.cmd('colorscheme tokyonight-moon')
--vim.cmd('colorscheme everforest')
--vim.cmd('colorscheme vague')


