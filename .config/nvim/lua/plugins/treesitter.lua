return {

 -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
    require('nvim-treesitter.configs').setup({
      -- A list of parser names, or "all"
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "c", "cpp", "python",
        "javascript", "typescript", "tsx",
        "json", "json5", "jsonc",
        "html", "css",
        "yaml",
        "latex",
        "astro", "sparql",
      },


      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-SPACE>',
          node_incremental = '<C-SPACE>',
          scope_incremental = '<C-s>',
          node_decremental = '<C-BACKSPACE>',
        },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
    end
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
}
