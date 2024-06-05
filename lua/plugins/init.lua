local plugins = {
  { lazy = true, 'nvim-lua/plenary.nvim' },

  {
    'AstroNvim/astrotheme',
    priority = 1000,
    config = true,
  },

  -- File tree setup
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      { 'MunifTanjim/nui.nvim', lazy = true },
    },
    config = function()
      require 'plugins.configs.neotree'
    end,
  },
  -- icons, for UI related plugins
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },

  -- syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  },

  -- buffer + tab line
  {
    'akinsho/bufferline.nvim',
    event = 'BufReadPre',
    config = function()
      require 'plugins.configs.bufferline'
    end,
  },

  -- statusline

  {
    'echasnovski/mini.statusline',
    config = function()
      require('mini.statusline').setup { set_vim_settings = false }
    end,
  },

  -- we use cmp plugin only when in insert mode
  -- so lets lazyload it at InsertEnter event, to know all the events check h-events
  -- completion , now all of these plugins are dependent on cmp, we load them after cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- cmp sources
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',

      -- snippets
      --list of default snippets
      'rafamadriz/friendly-snippets',

      -- snippets engine
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },

      -- autopairs , autocompletes ()[] etc
      {
        'windwp/nvim-autopairs',
        config = function()
          require('nvim-autopairs').setup()

          --  cmp integration
          local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
          local cmp = require 'cmp'
          cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },
    },
    config = function()
      require 'plugins.configs.cmp'
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall' },
    config = function()
      require('mason').setup()
    end,
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins.configs.lspconfig'
    end,
  },

  -- formatting , linting
  {
    'stevearc/conform.nvim',
    lazy = true,
    config = function()
      require 'plugins.configs.conform'
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  -- indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('ibl').setup {
        indent = { char = '│' },
        scope = { char = '│', highlight = 'Comment' },
      }
    end,
  },

  -- files finder etc
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = function()
      require 'plugins.configs.telescope'
    end,
  },

  -- -- lazygit
  -- {
  --   'jesseduffield/lazygit',
  --   event = 'VeryLazy',
  -- },
  -- git status on signcolumn etc
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    'github/copilot.vim',
    event = 'VeryLazy',
    autoStart = true,
    keys = { { '<leader>A', '<cmd>Copilot panel<cr>' } },
  },
  {
    'fatih/vim-go',
    event = 'VeryLazy',
    autoStart = true,
  },
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    -- autoStart = true,
    -- keys = { { "<leader>A", "<cmd>Copilot panel<cr>" } },
  },
  -- Add toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require 'plugins.configs.toggleterm'
    end,
  },
  -- session management
  {
    'rmagatti/auto-session',
    config = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
      vim.keymap.set('n', '<leader>p', require('auto-session.session-lens').search_session)
      require('auto-session').setup {
        pre_save_cmds = { 'Neotree close' },
        post_restore_cmds = { 'Neotree filesystem show' },
      }
    end,
  },
}

require('lazy').setup(plugins, require 'lazy_config')
