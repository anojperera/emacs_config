return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,
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
