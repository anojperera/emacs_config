local builtin = require('telescope.builtin')
vim.keymap.set('n', '/', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.git_files, {})
vim.keymap.set('n', '\\', function() 
	builtin.grep_string( { search = vim.fn.input("Grep > ")})
end)

