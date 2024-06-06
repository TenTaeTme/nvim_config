require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua',
    'vim',
    'vimdoc',
    'html',
    'css',
    'typescript',
    'javascript',
    'go',
    'php',
    'json',
    'jsonc',
    'yaml',
    'toml',
    'python',
    'bash',
    'cmake',
    'dockerfile',
    'lua',
    'python',
    'scss',
    'tsx',
    'yaml',
  },

  highlight = {
    enable = true,

    -- use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  -- indent = { enable = true },
}
