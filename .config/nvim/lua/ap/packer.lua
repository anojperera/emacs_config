-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Telescope for navigation
  use({
    'nvim-telescope/telescope.nvim',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })

  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-orgmode/telescope-orgmode.nvim" })

  -- Using Packer
  use('navarasu/onedark.nvim')

  -- Tree sitter
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use 'nvim-treesitter/nvim-treesitter-context'

  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('tpope/vim-commentary')
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use('nvim-lualine/lualine.nvim')

  use('lewis6991/gitsigns.nvim')

  use('jremmen/vim-ripgrep')
  use('stevearc/conform.nvim')

  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }

  use('rcarriga/nvim-notify')

  use({
    'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/org_files/**/*',
        org_default_notes_file = '~/org_files/refile.org',
      })
    end
  })

  use({
    "akinsho/org-bullets.nvim",
    config = function()
      require('org-bullets').setup()
    end
  })

  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  })
end)
