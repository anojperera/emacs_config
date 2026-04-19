return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- nvim-treesitter is used only for parser installation.
      -- Highlighting is handled by Neovim's built-in vim.treesitter API.
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "c", "cpp", "python",
          "javascript", "typescript", "tsx",
          "json", "json5", "jsonc",
          "html", "css",
          "yaml",
          "astro", "sparql",
        },
        auto_install = true,
        highlight = { enable = false },
        indent    = { enable = false },
      })

      -- Enable native Neovim treesitter highlighting on every file open.
      -- pcall silences errors for filetypes with no parser installed yet.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },

  { "nvim-treesitter/nvim-treesitter-context" },
}
