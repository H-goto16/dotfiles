local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- coc --
Plug ('neoclide/coc.nvim', {['branch'] = 'release'})
-- color scheme --
Plug ('tomasiser/vim-code-dark')
-- material icon theme --
Plug ('Allianaab2m/nvim-material-icon-v3')
-- status bar --
Plug ('nvim-lualine/lualine.nvim')
-- tab bar --
Plug ('nvim-tree/nvim-web-devicons')
Plug ('lewis6991/gitsigns.nvim')
Plug ('romgrk/barbar.nvim')
-- sidebar --
Plug ('nvim-tree/nvim-tree.lua')
Plug ('nvim-tree/nvim-web-devicons')
Plug ('kdheepak/lazygit.nvim')
-- eslint --
Plug ('neovim/nvim-lspconfig')
Plug ('jose-elias-alvarez/null-ls.nvim')
Plug ('MunifTanjim/eslint.nvim')

-- error lens --
Plug ('chikko80/error-lens.nvim')
Plug ('nvim-telescope/telescope.nvim')
-- scroll bar --
Plug ('petertriho/nvim-scrollbar')
-- indent rainbow --
Plug ('lukas-reineke/indent-blankline.nvim')
Plug ('TheGLander/indent-rainbowline.nvim')
-- comment --
Plug ('numToStr/Comment.nvim')
vim.call('plug#end')

vim.cmd('colorscheme codedark')
vim.cmd('set number')
require'nvim-tree'.setup {
	view = {
		side = 'right'
	}
}
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

require'error-lens'.setup{}
require'ibl'.setup{}
require'lualine'.setup{}
require"scrollbar".setup{}
require('gitsigns').setup()
require("scrollbar.handlers.gitsigns").setup()
require('Comment').setup()
