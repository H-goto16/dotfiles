-- Vim API Shortcuts
local Plug = vim.fn['plug#']

-- Plugin Installation
vim.call('plug#begin')

-- Plugin Declarations
local plugins = {
  -- coc.nvim
  { 'neoclide/coc.nvim', { branch = 'release' } },
  -- nvim-treesitter
  { 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } },
  -- Color schemes
  'tomasiser/vim-code-dark',
  'Mofiqul/vscode.nvim',
  'LunarVim/darkplus.nvim',
  -- JSX/TSX
  'peitalin/vim-jsx-typescript',
  'pangloss/vim-javascript',
  'maxmellon/vim-jsx-pretty',
  'jparise/vim-graphql',
  'leafgarland/typescript-vim',
  -- Material icons
  'Allianaab2m/nvim-material-icon-v3',
  -- Status/tab bars
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',
  'lewis6991/gitsigns.nvim',
  'romgrk/barbar.nvim',
  -- Sidebar plugins
  'nvim-tree/nvim-tree.lua',
  'kdheepak/lazygit.nvim',
  -- LSP/Eslint
  'neovim/nvim-lspconfig',
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/eslint.nvim',
  -- Error Lens
  'chikko80/error-lens.nvim',
  'nvim-telescope/telescope.nvim',
  -- Scrollbar
  'petertriho/nvim-scrollbar',
  -- Indentation/Rainbow
  'lukas-reineke/indent-blankline.nvim',
  'TheGLander/indent-rainbowline.nvim',
  -- Commenting/Auto-brackets
  'numToStr/Comment.nvim',
  'cohama/lexima.vim',
  -- GitHub Copilot
  'github/copilot.vim',
  -- Smooth scrolling
  'karb94/neoscroll.nvim',
  -- Bracket colorization
  'HiPhish/rainbow-delimiters.nvim',
  'HiPhish/nvim-ts-rainbow2',
  -- Notifications
  'rcarriga/nvim-notify',
}

-- Register plugins
for _, plug in ipairs(plugins) do
  if type(plug) == "table" then
    Plug(plug[1], plug[2])
  else
    Plug(plug)
  end
end

vim.call('plug#end')

-- Colorscheme
vim.cmd('colorscheme vscode')

-- General Vim Settings
local settings = {
  'set number', 'set cursorline', 'set expandtab',
  'set hlsearch', 'set ignorecase', 'set incsearch',
  'set smartcase', 'set autoindent', 'set title',
  'set showmatch', 'set clipboard+=unnamed',
  'set tags=tags;/', 'set cmdheight=0',
  'set list', 'set lcs+=space:·', 'set listchars+=tab:»\\ ', 'set listchars+=trail:·', 'set listchars+=eol:↲', 'set listchars+=nbsp:␣',
}

for _, setting in ipairs(settings) do
  vim.cmd(setting)
end

-- Commands & Key Mappings
vim.cmd(":command Sd CocCommand tsserver.goToSourceDefinition")
vim.cmd("autocmd TermOpen * setlocal nonumber")
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx" },
  command = "CocCommand tsserver.executeAutofix"
})
vim.opt.termguicolors = true

-- Key Mappings
local keymaps = {
  { mode = 'n', key = '<C-s>', action = ':w<CR>', opts = { noremap = true, silent = true } },
  { mode = 'i', key = '<C-s>', action = '<Esc>:w<CR>a', opts = { noremap = true, silent = true } },
  { mode = 'v', key = '<C-s>', action = '<Esc>:w<CR>', opts = { noremap = true, silent = true } },
  -- Move lines with Alt+Up/Down
  { mode = 'n', key = '<A-Up>', action = ':m .-2<CR>==', opts = { noremap = true, silent = true } },
  { mode = 'n', key = '<A-Down>', action = ':m .+1<CR>==', opts = { noremap = true, silent = true } },
  { mode = 'v', key = '<A-Up>', action = ":m '<-2<CR>gv=gv", opts = { noremap = true, silent = true } },
  { mode = 'v', key = '<A-Down>', action = ":m '>+1<CR>gv=gv", opts = { noremap = true, silent = true } },
}

for _, map in ipairs(keymaps) do
  vim.api.nvim_set_keymap(map.mode, map.key, map.action, map.opts)
end

-- Plugin Setup
require('nvim-tree').setup { view = { side = 'right' } }
require('error-lens').setup{}
require('lualine').setup{}
require('gitsigns').setup{}
require('scrollbar').setup{}
require('scrollbar.handlers.gitsigns').setup()
require('nvim-web-devicons').get_icons()
require('Comment').setup()
require("ibl").setup(require("indent-rainbowline").make_opts({}))
require('neoscroll').setup {
  mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
  hide_cursor = false,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  easing = 'linear',
  performance_mode = false,
  ignored_events = { 'WinScrolled', 'CursorMoved' }
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "javascript", "json", "markdown" },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
}

vim.g.coc_user_config = {
  ["coc.preferences.enableFloatHighlight"] = true,
  ["coc.preferences.jumpCommand"] = "edit",
  ["coc.preferences.jumpKey"] = "<C-LeftMouse>"
}
