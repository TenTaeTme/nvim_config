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

  {
    'goolord/alpha-nvim',
    opts = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- Set the header
      dashboard.section.header.val = {
        '███████╗██████╗ ██╗██╗  ██╗ ██╗██████╗        ██╗ ',
        '██╔════╝██╔══██╗██║██║ ██╔╝███║╚════██╗    ██╗╚██',
        '███████╗██████╔╝██║█████╔╝ ╚██║ █████╔╝    ╚═╝ ██║',
        '╚════██║██╔═══╝ ██║██╔═██╗  ██║ ╚═══██╗    ██╗ ██║',
        '███████║██║     ██║██║  ██╗ ██║██████╔╝    ╚═╝██╔╝',
        '╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝        ╚═╝ ',
      }

      -- Set the buttons
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('p', '  Find project', ':Telescope projects <CR>'),
        dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
        dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
      }

      -- Set the footer
      dashboard.section.footer.val = {
        'Neovim loaded in ' .. vim.fn.strftime '%Y-%m-%d %H:%M:%S',
      }

      -- Set the layout
      dashboard.config.layout = {
        { type = 'padding', val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
        dashboard.section.header,
        { type = 'padding', val = 5 },
        dashboard.section.buttons,
        { type = 'padding', val = 3 },
        dashboard.section.footer,
      }

      return dashboard
    end,
    config = function(_, opts)
      local alpha = require 'alpha'
      alpha.setup(opts.config)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        desc = 'Add Alpha dashboard footer',
        once = true,
        callback = function()
          local stats = require('lazy').stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          opts.section.footer.val = { 'Nvim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins  in ' .. ms .. 'ms' }
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function(plugin, opts)
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require 'luasnip'
      luasnip.filetype_extend('javascript', { 'javascriptreact' })
      luasnip.filetype_extend('typescript', { 'typescriptreact' })
      -- load snippets paths
      require('luasnip.loaders.from_vscode').lazy_load {
        paths = { vim.fn.stdpath 'config' .. '/snippets' },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function(plugin, opts)
      opts = vim.tbl_extend('force', {
        check_ts = true,
        ts_config = { java = false },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub('%s+', ''),
          offset = 0,
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'PmenuSel',
          highlight_grey = 'LineNr',
        },
      }, opts or {})

      -- Load and setup nvim-autopairs with the given options
      local npairs = require 'nvim-autopairs'
      npairs.setup(opts)

      -- Define custom rules and conditions
      local Rule = require 'nvim-autopairs.rule'
      local cond = require 'nvim-autopairs.conds'

      npairs.add_rules {
        Rule('$', '$', { 'tex', 'latex' })
          :with_pair(cond.not_after_regex '%%')
          :with_pair(cond.not_before_regex('xxx', 3))
          :with_move(cond.none())
          :with_del(cond.not_after_regex 'xx')
          :with_cr(cond.none()),
      }

      -- Disable autopairs for .vim files
      npairs.add_rules {
        Rule('a', 'a', '-vim'),
      }
    end,
  },
}

require('lazy').setup(plugins, require 'lazy_config')
