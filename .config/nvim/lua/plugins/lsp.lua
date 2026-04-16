return {

  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'l3mon4d3/luasnip' },
      { 'rafamadriz/friendly-snippets' },
    },

    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig.util')

      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls',    -- JavaScript / JSX / TypeScript
          'pyright',  -- Python
          'clangd',   -- C / C++
          'eslint',   -- ESLint diagnostics + code actions
          'yamlls',   -- YAML
          'jsonls',   -- JSON
          'html',     -- HTML
          'cssls',    -- CSS
          'texlab',   -- LaTeX
        },
        handlers = {
          -- default handler
          function(server_name)
            lspconfig[server_name].setup({})
          end,

          -- JavaScript/TypeScript: require a project root so ts_ls indexes
          -- the full workspace (enables cross-file find-references)
          ['ts_ls'] = function()
            lspconfig.ts_ls.setup({
              root_dir = util.root_pattern(
                'tsconfig.json', 'jsconfig.json', 'package.json', '.git'
              ),
              single_file_support = false,
            })
          end,

          ['jsonls'] = function()
            lspconfig.jsonls.setup({
              settings = {
                json = { validate = { enable = true } },
              },
            })
          end,

          ['yamlls'] = function()
            lspconfig.yamlls.setup({
              settings = {
                yaml = { validate = true, hover = true, completion = true },
              },
            })
          end,
        },
      })

      -- Completion
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      cmp.setup({
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>']     = cmp.mapping.abort(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

      -- Keymaps
      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', '<space>gD', function() vim.lsp.buf.declaration() end, opts)
      vim.keymap.set('n', '<space>gd', function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set('n', '<space>K',  function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set('n', '<space>gi', function() vim.lsp.buf.implementation() end, opts)
      vim.keymap.set('n', '<space>D',  function() vim.lsp.buf.type_definition() end, opts)
      vim.keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set('n', '<space>ca', function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set('n', '<space>bf', function() vim.lsp.buf.format({ async = true }) end, opts)

      -- Require telescope lazily inside callbacks so a slow/unloaded telescope
      -- doesn't abort this entire config function at startup
      vim.keymap.set('n', '<space>gr', function() require('telescope.builtin').lsp_references() end, opts)
      vim.keymap.set('n', '<space>ds', function() require('telescope.builtin').lsp_document_symbols() end, opts)
      vim.keymap.set('n', '<space>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, opts)

      vim.keymap.set('n', '<space>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
      vim.keymap.set('n', '<space>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
      vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)

      vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end
  }
}
