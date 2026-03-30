-- ============================================================
-- Bootstrap lazy.nvim
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- General Settings
-- ============================================================
vim.opt.number        = true
vim.opt.cursorline    = true
vim.opt.expandtab     = true
vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2
vim.opt.hlsearch      = true
vim.opt.ignorecase    = true
vim.opt.incsearch     = true
vim.opt.smartcase     = true
vim.opt.autoindent    = true
vim.opt.title         = true
vim.opt.showmatch     = true
vim.opt.clipboard     = "unnamedplus"
vim.opt.cmdheight     = 0
vim.opt.termguicolors = true
vim.opt.signcolumn    = "yes"
vim.opt.updatetime    = 300
vim.opt.backup        = false
vim.opt.writebackup   = false
vim.opt.list          = true
vim.opt.listchars     = { space = "·", tab = "» ", trail = "·", eol = "↲", nbsp = "␣" }

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- ============================================================
-- Keymaps (non-plugin)
-- ============================================================
local map = vim.keymap.set

map({ "n", "v" }, "<C-s>", ":w<CR>",        { noremap = true, silent = true })
map("i",          "<C-s>", "<Esc>:w<CR>a",  { noremap = true, silent = true })
map("n",          "<C-z>", "u",             { noremap = true, silent = true })
map("i",          "<C-z>", "<Esc>ui",       { noremap = true, silent = true })
map("n",          "<C-y>", "<C-r>",         { noremap = true, silent = true })
map("i",          "<C-y>", "<Esc><C-r>i",   { noremap = true, silent = true })
map("n", "<A-Up>",   ":m .-2<CR>==",            { noremap = true, silent = true })
map("n", "<A-Down>", ":m .+1<CR>==",            { noremap = true, silent = true })
map("v", "<A-Up>",   ":m '<-2<CR>gv=gv",        { noremap = true, silent = true })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv",        { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.cmd("startinsert")
  end,
})

map("t", "<C-w><C-w>", "<C-\\><C-n><C-w>w")

vim.api.nvim_create_user_command("St", function()
  local height = math.floor(vim.o.lines / 3)
  vim.cmd("botright " .. height .. "split | terminal")
end, {})

vim.api.nvim_create_user_command("Vt", function()
  local width = math.floor(vim.o.columns / 3)
  vim.cmd("topleft " .. width .. "vsplit | terminal")
end, {})

-- ============================================================
-- Plugins
-- ============================================================
require("lazy").setup({

  -- ----------------------------------------------------------
  -- Theme: VSCode Dark
  -- ----------------------------------------------------------
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      require("vscode").setup({
        style = "dark",
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
      })
      vim.cmd.colorscheme("vscode")
    end,
  },

  -- ----------------------------------------------------------
  -- Treesitter (v1.0+ 新API)
  -- ----------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- パーサーのインストール（非同期）
      require("nvim-treesitter").install({
        "typescript", "tsx", "javascript", "json", "markdown",
        "python", "c", "rust", "lua", "html", "css", "graphql",
      })
      -- ファイルタイプごとにtreesitterハイライト・インデントを有効化
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- JSX/HTML タグの自動閉じ
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Bracket pair coloring (TSX対応)
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local rainbow = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""]  = rainbow.strategy["global"],
          tsx   = rainbow.strategy["local"],
          html  = rainbow.strategy["local"],
        },
        query = {
          [""]        = "rainbow-delimiters",
          lua         = "rainbow-blocks",
          tsx         = "rainbow-parens",
          typescript  = "rainbow-parens",
          javascript  = "rainbow-parens",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- ----------------------------------------------------------
  -- LSP: mason + lspconfig (Neovim 0.11+ 新API)
  -- ----------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", "eslint", "pyright", "clangd", "rust_analyzer", "lua_ls",
        },
        -- automatic_enable = true (default): インストール済みサーバーを自動起動
      })

      -- LSPアタッチ時のキーマップ (LspAttach autocmd = 0.11+ 推奨)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local opts  = { buffer = bufnr, silent = true }
          map("n",          "gd",          vim.lsp.buf.definition,     opts)
          map("n",          "gy",          vim.lsp.buf.type_definition, opts)
          map("n",          "gi",          vim.lsp.buf.implementation,  opts)
          map("n",          "gr",          vim.lsp.buf.references,      opts)
          map("n",          "K",           vim.lsp.buf.hover,           opts)
          map("n",          "gh",          vim.lsp.buf.hover,           opts)
          map("n",          "<F2>",        vim.lsp.buf.rename,          opts)
          map({ "n", "v" }, "<leader>rn",  vim.lsp.buf.rename,          opts)
          map({ "n", "v" }, "<leader>a",   vim.lsp.buf.code_action,     opts)
          map("n",          "<leader>ac",  vim.lsp.buf.code_action,     opts)
          map("n",          "<leader>qf",  vim.lsp.buf.code_action,     opts)
          map("n",          "[g",          vim.diagnostic.goto_prev,    opts)
          map("n",          "]g",          vim.diagnostic.goto_next,    opts)
        end,
      })

      -- ESLint: 保存時に自動fix
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern  = { "*.ts", "*.tsx", "*.js", "*.jsx" },
        callback = function()
          local clients = vim.lsp.get_clients({ bufnr = 0, name = "eslint" })
          if #clients > 0 then
            vim.cmd("EslintFixAll")
          end
        end,
      })

      -- 全サーバー共通: capabilities (blink.cmp連携)
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- TypeScript / TSX: inlay hints
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints           = "all",
              includeInlayFunctionParameterTypeHints   = true,
              includeInlayVariableTypeHints            = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints  = true,
              includeInlayEnumMemberValueHints         = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints         = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints          = true,
            },
          },
        },
      })

      -- Rust: clippy
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      })

      -- Lua: vim グローバルを認識
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = { prefix = "●", source = "if_many" },
        float        = { border = "rounded", source = true },
        signs        = true,
        underline    = true,
        update_in_insert = false,
      })
    end,
  },

  -- ----------------------------------------------------------
  -- Completion: blink.cmp
  -- ----------------------------------------------------------
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("blink.cmp").setup({
        keymap = {
          preset    = "default",
          ["<Tab>"]     = { "select_next", "snippet_forward", "fallback" },
          ["<S-Tab>"]   = { "select_prev", "snippet_backward", "fallback" },
          ["<CR>"]      = { "accept", "fallback" },
          ["<C-Space>"] = { "show", "fallback" },
          ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
          ["<C-b>"]     = { "scroll_documentation_up", "fallback" },
        },
        snippets  = { preset = "luasnip" },
        sources   = { default = { "lsp", "path", "snippets", "buffer" } },
        completion = {
          documentation = { auto_show = true },
          accept        = { auto_brackets = { enabled = true } },
          menu          = { border = "rounded" },
        },
        signature = { enabled = true, window = { border = "rounded" } },
      })
    end,
  },

  -- ----------------------------------------------------------
  -- Formatting: conform.nvim
  -- ----------------------------------------------------------
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          typescript      = { "biome", stop_after_first = true },
          typescriptreact = { "biome", stop_after_first = true },
          javascript      = { "biome", stop_after_first = true },
          javascriptreact = { "biome", stop_after_first = true },
          json            = { "biome", stop_after_first = true },
          markdown        = { "prettier" },
          python          = { "black" },
          c               = { "clang_format" },
          rust            = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms   = 1000,
          lsp_fallback = true,
        },
      })
      map({ "n", "v" }, "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { silent = true })
    end,
  },

  -- ----------------------------------------------------------
  -- UI: ファイルツリー / ステータスバー / タブバー
  -- ----------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { side = "right" },
        renderer = { indent_width = 1 },
      })
      map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "vscode" } })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers        = "ordinal",
          tab_size       = 10,
          indicator      = { icon = "▎", style = "underline" },
          separator_style = "slope",
          color_icons    = true,
          show_buffer_icons = true,
          show_close_icon   = false,
          show_tab_indicators = true,
          diagnostics    = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
        highlights = {},
      })
    end,
  },

  -- Diagnostics リスト (CocList diagnostics の代替)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      map("n", "<space>a", "<cmd>Trouble diagnostics toggle<cr>",     { silent = true })
      map("n", "<space>o", "<cmd>Trouble symbols toggle<cr>",         { silent = true })
      map("n", "<space>s", "<cmd>Trouble lsp toggle focus=false<cr>", { silent = true })
    end,
  },

  -- キーマップヒント
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  -- 通知 / コマンドライン UI
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"]                = true,
          },
        },
        presets = {
          bottom_search        = true,
          command_palette      = true,
          long_message_to_split = true,
          lsp_doc_border       = true,
        },
      })
    end,
  },

  -- スクロールバー
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- インデントガイド
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        scope = {
          enabled   = true,
          highlight = {
            "RainbowDelimiterRed", "RainbowDelimiterYellow",
            "RainbowDelimiterBlue", "RainbowDelimiterOrange",
            "RainbowDelimiterGreen", "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        },
      })
    end,
  },

  -- ----------------------------------------------------------
  -- Git
  -- ----------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs   = require("gitsigns")
          local opts = { buffer = bufnr, silent = true }
          map("n", "]c",          gs.next_hunk,                         opts)
          map("n", "[c",          gs.prev_hunk,                         opts)
          map("n", "<leader>hp",  gs.preview_hunk,                      opts)
          map("n", "<leader>hr",  gs.reset_hunk,                        opts)
          map("n", "<leader>hb",  gs.blame_line,                        opts)
        end,
      })
    end,
  },
  { "kdheepak/lazygit.nvim" },

  -- ----------------------------------------------------------
  -- ナビゲーション / 検索
  -- ----------------------------------------------------------
  {
    "folke/flash.nvim",
    config = function()
      require("flash").setup()
      map({ "n", "x", "o" }, "s", function() require("flash").jump() end,       { silent = true })
      map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { silent = true })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      local builtin = require("telescope.builtin")
      map("n", "<leader>ff", builtin.find_files,  {})
      map("n", "<leader>fg", builtin.live_grep,   {})
      map("n", "<leader>fb", builtin.buffers,     {})
      map("n", "<leader>fh", builtin.help_tags,   {})
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("spectre").setup() end,
  },

  -- ----------------------------------------------------------
  -- 編集補助
  -- ----------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },

  -- 自動括弧 (lexima.vim の代替)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
    end,
  },

  -- 複数カーソル (vim-multiple-cursors の代替)
  { "mg979/vim-visual-multi" },

  -- スムーズスクロール
  {
    "karb94/neoscroll.nvim",
    config = function() require("neoscroll").setup() end,
  },

  -- ----------------------------------------------------------
  -- AI
  -- ----------------------------------------------------------
  { "github/copilot.vim" },

  -- ----------------------------------------------------------
  -- 言語個別
  -- ----------------------------------------------------------
  { "jparise/vim-graphql" },

}, {
  ui = { border = "rounded" },
})

