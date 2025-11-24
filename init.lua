vim.o.clipboard= 'unnamedplus'
vim.o.background = 'dark'
vim.o.signcolumn = 'yes'
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.softtabstop = 4
vim.o.scrolloff = 30
vim.o.swapfile = false
vim.o.winborder = 'rounded'
vim.g.mapleader = ' '


vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.pack.add({
		{src = 'https://github.com/vague-theme/vague.nvim'},
		{src = 'https://github.com/sainnhe/everforest'},
		{src = 'https://github.com/folke/tokyonight.nvim'},
		{src = 'https://github.com/shaunsingh/nord.nvim'},
		{src = 'https://github.com/AlexvZyl/nordic.nvim'},
		{src = 'https://github.com/stevearc/oil.nvim'},
		{src = 'https://github.com/echasnovski/mini.pick'},
		{src = 'https://github.com/neovim/nvim-lspconfig'},
		{src = 'https://github.com/chomosuke/typst-preview.nvim'},
		--{src = ''},
		--{src = ''},
})

vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client:supports_method('textDocument/completion') then
						vim.lsp.completion.enable(true, client.id, ev.buf,{autotriger = true})
				end
		end,
})
vim.cmd('set completeopt+=noselect')

require 'mini.pick'.setup()
require 'oil'.setup()

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')


vim.lsp.enable({'lua_ls', 'pyright', 'gopls', 'clangd', 'rust_analyzer', 'emmet-ls'})

vim.cmd('colorscheme nordic')
--vim.cmd('colorscheme nord')
--vim.cmd('colorscheme tokyonight-moon')
--vim.cmd('colorscheme everforest')
--vim.cmd('colorscheme vague')



