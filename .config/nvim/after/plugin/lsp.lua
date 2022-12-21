local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.ensure_installed({
	'tsserver',
	'pyright',
	'clangd',
	'eslint',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = signs})

lsp.on_attach(function(client, bufnr)
    local opts = { noremap=true, silent=true }
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
     vim.keymap.set('n', '<space>gD', 'vim.lsp.buf.declaration()<CR>', opts)
     vim.keymap.set('n', '<space>gd', 'vim.lsp.buf.definition()<CR>', opts)
     vim.keymap.set('n', '<space>K', 'vim.lsp.buf.hover()<CR>', opts)
     vim.keymap.set('n', '<space>gi', 'vim.lsp.buf.implementation()<CR>', opts)
     vim.keymap.set('n', '<space>wa', 'vim.lsp.buf.add_workspace_folder()<CR>', opts)
     vim.keymap.set('n', '<space>wr', 'vim.lsp.buf.remove_workspace_folder()<CR>', opts)
     vim.keymap.set('n', '<space>wl', 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
     vim.keymap.set('n', '<space>D', 'vim.lsp.buf.type_definition()<CR>', opts)
     vim.keymap.set('n', '<space>rn', 'vim.lsp.buf.rename()<CR>', opts)
     vim.keymap.set('n', '<space>ca', 'vim.lsp.buf.code_action()<CR>', opts)
     vim.keymap.set('n', '<space>gr', 'vim.lsp.buf.references()<CR>', opts)
     vim.keymap.set('n', '<space>bf', 'vim.lsp.buf.formatting()<CR>', opts)

    -- Auto format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
