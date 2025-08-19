local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '\\', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})


require("telescope").load_extension "file_browser"
vim.keymap.set('n', '<leader>fd', ":Telescope file_browser<CR>", {})


-- Org File
require('telescope').load_extension('orgmode')
vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading)
vim.keymap.set("n", "<leader>oh", require("telescope").extensions.orgmode.search_headings)
vim.keymap.set("n", "<leader>oi", require("telescope").extensions.orgmode.insert_link)
