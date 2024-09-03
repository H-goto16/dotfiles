local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- coc --
Plug ('neoclide/coc.nvim', {['branch'] = 'release'})
-- color scheme --
Plug ('tomasiser/vim-code-dark')
Plug ('Mofiqul/vscode.nvim')
Plug ("LunarVim/darkplus.nvim")
-- JSX Plugin --
Plug ('leafgarland/typescript-vim')
Plug ('peitalin/vim-jsx-typescript')
Plug ('pangloss/vim-javascript')
Plug ('leafgarland/typescript-vim')
Plug ('maxmellon/vim-jsx-pretty')
Plug ('jparise/vim-graphql')
Plug ('leafgarland/typescript-vim')
-- treesitter --
Plug ('nvim-treesitter/nvim-treesitter')
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
--lexima auto bracket--
Plug ('cohama/lexima.vim')
-- github copilot --
Plug ('github/copilot.vim')
vim.call('plug#end')

vim.cmd("colorscheme codedark")
-- vim settings --

vim.cmd('set number')
vim.cmd('set cursorline')
vim.cmd('set expandtab')
vim.cmd('set hlsearch')
vim.cmd('set ignorecase')
vim.cmd('set incsearch')
vim.cmd('set smartcase')
vim.cmd('set autoindent')
vim.cmd('set title')
vim.cmd('set showmatch')
vim.cmd('set clipboard+=unnamed')
vim.cmd('set tags=tags;/')
-- nvim tree
require'nvim-tree'.setup {
	view = {
		side = 'right'
	}
}
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- enable plugins
require'error-lens'.setup{}
require'ibl'.setup{}
require'lualine'.setup{}
require"scrollbar".setup{}
require('gitsigns').setup()
require("scrollbar.handlers.gitsigns").setup()
require('Comment').setup()

vim.g.coc_user_config = {
  ["coc.preferences.enableFloatHighlight"] = true,
  ["coc.preferences.jumpCommand"] = "edit",
  ["coc.preferences.jumpKey"] = "<C-LeftMouse>"
}
-- vim.cmd("autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact")
-- vim.cmd("hi tsxTagName guifg=#E06C75")
-- vim.cmd("hi tsxComponentName guifg=#E06C75")
-- vim.cmd("hi tsxCloseComponentName guifg=#E06C75")
-- vim.cmd("hi tsxTagName guifg=#E06C75")
-- vim.cmd("hi tsxComponentName guifg=#E06C75")
--vim.cmd("hi tsxCloseComponentName guifg=#E06C75")
