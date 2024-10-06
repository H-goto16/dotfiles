local Plug = vim.fn['plug#']

-- Plugin Installation
vim.call('plug#begin')

-- Plugin Declarations
local plugins = {
        -- coc.nvim
        { 'neoclide/coc.nvim',               { branch = 'release' } },
        -- nvim-treesitter
        { 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } },
        -- Color schemes
        'tomasiser/vim-code-dark',
        'Mofiqul/vscode.nvim',
        'LunarVim/darkplus.nvim',
        -- JSX/TSX support
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
        'akinsho/bufferline.nvim',
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
        -- Search and replace
        'nvim-lua/plenary.nvim',
        'nvim-pack/nvim-spectre'
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

-- Helper functions for settings and mappings
local function set_vim_options(options)
        for _, opt in ipairs(options) do
                vim.cmd(opt)
        end
end

local function set_keymaps(mappings)
        for _, map in ipairs(mappings) do
                vim.api.nvim_set_keymap(map.mode, map.key, map.action, map.opts)
        end
end

-- General Vim Settings
local general_settings = {
        'set number', 'set cursorline', 'set expandtab',
        'set hlsearch', 'set ignorecase', 'set incsearch',
        'set smartcase', 'set autoindent', 'set title',
        'set showmatch', 'set clipboard+=unnamed',
        'set tags=tags;/', 'set cmdheight=0',
        'set list', 'set lcs+=space:·', 'set listchars+=tab:»\\ ',
        'set listchars+=trail:·', 'set listchars+=eol:↲',
        'set listchars+=nbsp:␣',
}
set_vim_options(general_settings)

vim.opt.termguicolors = true

-- Key Mappings
local keymaps = {
        { mode = 'n', key = '<C-s>', action = ':w<CR>',       opts = { noremap = true, silent = true } },
        { mode = 'i', key = '<C-s>', action = '<Esc>:w<CR>a', opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<C-s>', action = '<Esc>:w<CR>',  opts = { noremap = true, silent = true } },
}
set_keymaps(keymaps)

-- Alt arrow key mappings for moving lines
set_keymaps({
        { mode = 'n', key = '<A-Up>',   action = ':m .-2<CR>==',     opts = { noremap = true, silent = true } },
        { mode = 'n', key = '<A-Down>', action = ':m .+1<CR>==',     opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<A-Up>',   action = ":m '<-2<CR>gv=gv", opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<A-Down>', action = ":m '>+1<CR>gv=gv", opts = { noremap = true, silent = true } },
})

-- Plugin Setup
local plugin_setup = {
        ['nvim-tree'] = function() require('nvim-tree').setup { view = { side = 'right' } } end,
        ['error-lens'] = function() require('error-lens').setup {} end,
        ['lualine'] = function() require('lualine').setup {} end,
        ['gitsigns'] = function() require('gitsigns').setup {} end,
        ['scrollbar'] = function()
                require('scrollbar').setup {}
                require('scrollbar.handlers.gitsigns').setup()
        end,
        ['nvim-web-devicons'] = function() require('nvim-web-devicons').get_icons() end,
        ['Comment'] = function() require('Comment').setup() end,
        ['bufferline'] = function()
                require('bufferline').setup {
                        options = {
                                numbers = 'ordinal',
                                diagnostics = 'coc',
                                diagonostic_indicator = function(count)
                                        return '(' .. count .. ')'
                                end
                        }
                }
        end,
        ['nvim-treesitter'] = function()
                require('nvim-treesitter.configs').setup {
                        ensure_installed = { "typescript", "javascript", "json", "markdown" },
                        highlight = { enable = true },
                        rainbow = {
                                enable = true,
                                extended_mode = true,
                        },
                }
        end,
        ['spectre'] = function() require('spectre').setup() end,
        ['ibl'] = function()
                require("ibl").setup(require("indent-rainbowline").make_opts({}))
        end
}
for _, setup in pairs(plugin_setup) do
        setup()
end

-- Commands & Autocommands
vim.cmd("autocmd TermOpen * setlocal nonumber")
vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.tsx", "*.ts", "*.js", "*.jsx" },
        command = "CocCommand tsserver.executeAutofix"
})

vim.cmd('colorscheme vscode')

-- Key mappings for CoCList and other coc.nvim features
local coc_keymaps = {
        { mode = "n", key = "<space>a", action = ":<C-u>CocList diagnostics<cr>", opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>e", action = ":<C-u>CocList extensions<cr>",  opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>c", action = ":<C-u>CocList commands<cr>",    opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>o", action = ":<C-u>CocList outline<cr>",     opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>s", action = ":<C-u>CocList -I symbols<cr>",  opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>j", action = ":<C-u>CocNext<cr>",             opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>k", action = ":<C-u>CocPrev<cr>",             opts = { silent = true, nowait = true } },
        { mode = "n", key = "<space>p", action = ":<C-u>CocListResume<cr>",       opts = { silent = true, nowait = true } },
}
set_keymaps(coc_keymaps)
