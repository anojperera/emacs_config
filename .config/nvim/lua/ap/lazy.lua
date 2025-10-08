-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- plugins
local plugins = {

  -- Telescope for navigation
  {
    'nvim-telescope/telescope.nvim',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-orgmode/telescope-orgmode.nvim" },

  -- Using Packer
  {'navarasu/onedark.nvim' },

  -- Tree sitter
  {'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate'  },
  { 'nvim-treesitter/nvim-treesitter-context' },

  {'mbbill/undotree'},
  {'tpope/vim-fugitive'},
  {'tpope/vim-commentary'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
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
  },

  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  { 'nvim-lualine/lualine.nvim' },

  {'lewis6991/gitsigns.nvim' },

  {'jremmen/vim-ripgrep' },
  {'stevearc/conform.nvim'},

  {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  },

  {'rcarriga/nvim-notify'},

  {
    'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/org_files/**/*',
        org_default_notes_file = '~/org_files/refile.org',
      })
    end
  },

  {
    "akinsho/org-bullets.nvim",
    config = function()
      require('org-bullets').setup()
    end
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }
}
require("lazy").setup(plugins, {})
