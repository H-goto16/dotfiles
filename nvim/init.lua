local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- coc --
Plug ('neoclide/coc.nvim', {['branch'] = 'release'})
-- nvim treesitter --
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
-- color scheme --
Plug ('tomasiser/vim-code-dark')
Plug ('Mofiqul/vscode.nvim')
Plug ("LunarVim/darkplus.nvim")
-- JSX Plugin --
Plug ('peitalin/vim-jsx-typescript')
Plug ('pangloss/vim-javascript')
Plug ('maxmellon/vim-jsx-pretty')
Plug ('jparise/vim-graphql')
Plug ('leafgarland/typescript-vim')
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
-- smooth scroll --
Plug ('karb94/neoscroll.nvim')
vim.call('plug#end')

vim.cmd("colorscheme vscode")
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
vim.cmd(":command Sd CocCommand tsserver.goToSourceDefinition")
vim.cmd('nnoremap <C-LeftMouse> :Sd<CR> ')
-- nvim tree
require'nvim-tree'.setup {
	view = {
		side = 'right'
	}
}
-- enable plugins
require('error-lens').setup{}
require('ibl').setup{}
require('lualine').setup{}
require("scrollbar").setup{}
require('gitsigns').setup()
require("scrollbar.handlers.gitsigns").setup()
require('Comment').setup()
require('neoscroll').setup({
  mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
    '<C-u>', '<C-d>',
    '<C-b>', '<C-f>',
    '<C-y>', '<C-e>',
    'zt', 'zz', 'zb',
  },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing = 'linear',           -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
  ignored_events = {           -- Events ignored while scrolling
      'WinScrolled', 'CursorMoved'
  },
})
neoscroll = require('neoscroll')
vim.g.coc_user_config = {
  ["coc.preferences.enableFloatHighlight"] = true,
  ["coc.preferences.jumpCommand"] = "edit",
  ["coc.preferences.jumpKey"] = "<C-LeftMouse>"
}

vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })


require('nvim-treesitter.configs').setup {
  ensure_installed = {"typescript", "javascript", "tsx", "json", "markdown"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true
  }
}
