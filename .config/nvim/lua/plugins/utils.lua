return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  {'jremmen/vim-ripgrep' },

  {
    "folke/lsp-trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function() 
      local builtin = require("trouble")
      vim.keymap.set("n", "<leader>xx", function() builtin.toggle() end)
      vim.keymap.set("n", "<leader>xw", function() builtin.toggle("workspace_diagnostics") end)
      vim.keymap.set("n", "<leader>xd", function() builtin.toggle("document_diagnostics") end)
      vim.keymap.set("n", "<leader>xq", function() builtin.toggle("quickfix") end)
      vim.keymap.set("n", "<leader>xl", function() builtin.toggle("loclist") end)
      vim.keymap.set("n", "gR", function() builtin.toggle("lsp_references") end)
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      preset = "helix"
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
