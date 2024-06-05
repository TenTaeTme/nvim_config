-- Key mappings
local map = vim.keymap.set

-- General mappings
map('n', '<C-s>', '<cmd>w<CR>')
map('i', 'jk', '<ESC>')
map('n', '<C-c>', '<cmd>%y+<CR>') -- copy whole file content

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>')
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>gt', '<cmd>Telescope git_status<CR>')

-- Bufferline, cycle buffers

-- Comment.nvim
map('n', '<leader>/', 'gcc', { remap = true })
map('v', '<leader>/', 'gc', { remap = true })

-- Format
map('n', '<leader>fm', function()
  require('conform').format()
end)

map('n', '<C-.>', '<Cmd>ToggleTerm size=60 direction=vertical<CR>', { desc = 'Open vertical Terminal' })
map('n', '<C-,>', '<Cmd>2ToggleTerm size=60 direction=vertical<CR>', { desc = 'Open second vertical Terminal' })
map('n', '<C-/>', '<Cmd>ToggleTerm size=150 direction=vertical<CR>', { desc = 'Increase size of vertical Terminal' })
map('t', '<C-.>', '<Cmd>ToggleTerm size=60 direction=vertical<CR>', { desc = 'Open vertical Terminal' })
map('t', '<C-,>', '<Cmd>2ToggleTerm size=60 direction=vertical<CR>', { desc = 'Open second vertical Terminal' })
map('t', '<C-/>', '<Cmd>ToggleTerm size=150 direction=vertical<CR>', { desc = 'Increase size of vertical Terminal' })
map('n', 'gi', function()
  vim.lsp.buf.implementation()
end, { desc = 'Go to implementation', noremap = true })
map('n', '<Leader>ns', function()
  require('package-info').show()
end, { desc = 'Show info package' })
map('n', '<Leader>np', function()
  require('package-info').change_version()
end, { desc = 'Change version package.json' })
map('n', '<Leader>nd', function()
  require('package-info').delete()
end, { desc = 'Delete version package.json' })
map('n', '<Leader>ni', function()
  require('package-info').install()
end, { desc = 'Install version package.json' })
map('n', '<Leader>fd', function()
  require('telescope.builtin').lsp_definitions { jump_type = 'never' }
end, { desc = 'LSP definitions' })
map('n', '<Leader>aa', 'ggyG', { desc = 'Copy whole buffer' })
map('n', '<Leader>ac', 'ggdG', { desc = 'Cut whole buffer' })
map('n', '<Leader>pp', '"0p', { desc = 'Put from 0 register' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Up and center' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Down and center' })
map('n', '<Leader>w', ':w!<CR>', { desc = 'Save File' })
map('n', '<Leader>q', '::wall|qa!<CR>', { desc = 'Save all and quit' })
-- map('n', '<Leader>Q', ':wall<bar>SessionPurgeOrphaned<bar>qa!<CR>', { noremap = true, silent = true, desc = 'Save all, destroy session, and quit' })
map('n', '<Leader>Q', function()
  vim.cmd 'noa'
  vim.cmd 'wall'
  vim.cmd 'SessionPurgeOrphaned'
  vim.cmd 'SessionDelete'
  vim.cmd 'qa!'
end, { desc = 'Save all, destroy session, and quit' })

-- Bufferline
function close_all_buffers()
  for _, e in ipairs(require('bufferline').get_elements().elements) do
    vim.schedule(function()
      vim.cmd('bd ' .. e.id)
    end)
  end
end

map('n', 'L', function()
  require('bufferline').cycle(1)
end, { desc = 'Next buffer' })

map('n', 'H', function()
  require('bufferline').cycle(-1)
end, { desc = 'Previous buffer' })

map('n', '<Leader>bp', function()
  require('bufferline').pick_buffer()
end, { desc = 'Pick buffer' })

map('n', '<Leader>bc', function()
  require('bufferline').close_with_pick()
end, { desc = 'Pick buffer to close' })

map('n', '<Leader>bx', function()
  vim.cmd 'bd'
end, { desc = 'Close buffer' })

map('n', '<Leader>bc', function()
  require('bufferline').close_others()
end, { desc = 'Close other buffers' })

map('n', '<Leader>bC', function()
  close_all_buffers()
end, { desc = 'Close all buffers' })
-- Set Vim options
vim.opt.relativenumber = true -- sets vim.opt.relativenumber vim.opt.number = true                 -- sets vim.opt.number
vim.opt.spell = false -- sets vim.opt.spell
vim.opt.signcolumn = 'auto' -- sets vim.opt.signcolumn to auto
vim.opt.wrap = false -- sets vim.opt.wrap

vim.g.matchup_matchparen_nomode = 'i' -- set mode to not match parenthesis in matchup

-- Diagnostic signs
vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

-- Window navigation
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })

-- Close window
map('n', '<C-q>', '<cmd>q<CR>', { desc = 'Close window' })
