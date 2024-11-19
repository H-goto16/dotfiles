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
        'nvim-pack/nvim-spectre',
        -- Multiple cursors
        'terryma/vim-multiple-cursors',
        -- Rename variable
        'nvim-lua/plenary.nvim',
        { 'filipdutescu/renamer.nvim', { branch = 'master' } },
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
        { mode = 'n', key = '<C-s>',      action = ':w<CR>',                                   opts = { noremap = true, silent = true } },
        { mode = 'i', key = '<C-s>',      action = '<Esc>:w<CR>a',                             opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<C-s>',      action = '<Esc>:w<CR>',                              opts = { noremap = true, silent = true } },
        { mode = 'n', key = '<A-Up>',     action = ':m .-2<CR>==',                             opts = { noremap = true, silent = true } },
        { mode = 'n', key = '<A-Down>',   action = ':m .+1<CR>==',                             opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<A-Up>',     action = ":m '<-2<CR>gv=gv",                         opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<A-Down>',   action = ":m '>+1<CR>gv=gv",                         opts = { noremap = true, silent = true } },
        { mode = 'i', key = '<F2>',       action = '<cmd>lua require("renamer").rename()<cr>', opts = { noremap = true, silent = true } },
        { mode = 'n', key = '<leader>rn', action = '<cmd>lua require("renamer").rename()<cr>', opts = { noremap = true, silent = true } },
        { mode = 'v', key = '<leader>rn', action = '<cmd>lua require("renamer").rename()<cr>', opts = { noremap = true, silent = true } }
}
set_keymaps(keymaps)

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
                                tab_size = 10,
                                indicator = {
                                        icon = '▎',
                                        style = 'underline',
                                },
                                separator_style = 'slope',
                                color_icons = true,
                                show_buffer_icons = true,
                                show_close_icon = false,
                                show_tab_indicators = true,

                                diagnostics = 'coc',
                                diagonostic_indicator = function(count, level)
                                        local icon = level:match("error") and " " or " "
                                        return " " .. icon .. count
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
        --         ['ibl'] = function()
        --                 opts = {}
        --                 require("ibl").setup(require("indent-rainbowline").make_opts(opts))
        --         end
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

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
local keyset = vim.keymap.set
function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
                vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
                vim.fn.CocActionAsync('doHover')
        else
                vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
})

keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
vim.api.nvim_create_autocmd("FileType", {
        group = "CocGroup",
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = "Setup formatexpr specified filetype(s)."
})
vim.api.nvim_create_autocmd("User", {
        group = "CocGroup",
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder"
})

local opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
local opts = { silent = true, nowait = true }
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
