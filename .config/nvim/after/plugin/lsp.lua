local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.ensure_installed({
  'tsserver',
  'pyright',
  'clangd',
  'eslint',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'cmdline' },
    { name = 'cmp_git' },
  }
})

local signs = { error = " ", warn = " ", hint = " ", info = " " }
lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  sign_icons = signs
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local telescope = require('telescope.builtin')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<space>gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', '<space>gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', '<space>K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<space>gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', '<space>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<space>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<space>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<space>gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<space>bf', function() vim.lsp.buf.format({ async = true }) end, opts)

  vim.keymap.set('n', '<space>ds', function() telescope.lsp_document_symbols() end, opts)
  vim.keymap.set('n', '<space>ws', function() telescope.lsp_dynamic_workspace_symbols() end, opts)

end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
