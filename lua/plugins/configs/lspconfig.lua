-- Autocommand for LSP key mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts) -- Correct mapping for line diagnostics
    --list of all diagnostics
    -- Key mapping to show all diagnostics in the project using Telescope
    vim.keymap.set('n', '<leader>ld', function()
      require('telescope.builtin').diagnostics { bufnr = 0 } -- For current buffer
    end, opts)

    vim.keymap.set('n', '<leader>lw', function()
      require('telescope.builtin').diagnostics {} -- For workspace/project
    end, opts)
    -- Key mapping to show code actions (fixes) for diagnostics using Telescope
    vim.keymap.set('n', '<leader>cf', function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set('v', '<leader>cf', function()
      vim.lsp.buf.range_code_action()
    end, opts)
  end,
})

-- Capabilities configuration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}

-- Adding semantic tokens capability
capabilities.textDocument.semanticTokens = {
  dynamicRegistration = false,
  tokenTypes = {
    'namespace',
    'type',
    'class',
    'enum',
    'interface',
    'struct',
    'typeParameter',
    'parameter',
    'variable',
    'property',
    'enumMember',
    'event',
    'function',
    'method',
    'macro',
    'keyword',
    'modifier',
    'comment',
    'string',
    'number',
    'regexp',
    'operator',
  },
  tokenModifiers = {
    'declaration',
    'definition',
    'readonly',
    'static',
    'deprecated',
    'abstract',
    'async',
    'modification',
    'documentation',
    'defaultLibrary',
  },
  formats = { 'relative' },
  requests = {
    range = true,
    full = {
      delta = true,
    },
  },
}

-- Setup language servers
local lspconfig = require 'lspconfig'

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
}

local servers = { 'tsserver', 'html', 'cssls', 'gopls', 'jsonls', 'intelephense', 'tailwindcss' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

-- Specific configuration for gopls
lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Enable semantic tokens for gopls
    if client.server_capabilities.semanticTokensProvider then
      local augroup = vim.api.nvim_create_augroup('GoplsSemanticTokens', { clear = true })
      vim.api.nvim_create_autocmd('TextChanged', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.semantic_tokens_full()
        end,
      })
      vim.lsp.buf.semantic_tokens_full()
    end
  end,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      diagnosticsDelay = '300ms',
      matcher = 'Fuzzy',
      semanticTokens = true,
    },
  },
}
