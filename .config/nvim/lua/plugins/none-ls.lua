-- none-ls handles diagnostics/linting that don't have a dedicated LSP server.
-- Formatting is handled by conform.nvim to avoid double-formatting conflicts.
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Spell-check completions in cmp
        null_ls.builtins.completion.spell,
      },
    })

    -- Override LspRestart to skip null-ls (not managed by lspconfig)
    vim.api.nvim_create_user_command("LspRestart", function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.name ~= "null-ls" then
          vim.lsp.stop_client(client.id, true)
          require("lspconfig")[client.name].launch()
        end
      end
    end, { desc = "Restart LSP servers (excluding null-ls)" })
  end,
}
