local conform = require 'conform'

conform.setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    -- Add other specific formatters here
  },
  format_on_save = {
    enabled = true,
    timeout_ms = 1000,
  },
  -- Optionally set a default formatter
  default_formatters = {
    'prettier', -- or any other formatter you want as a default
  },
}
