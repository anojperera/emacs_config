vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Remapped keys for navigating windows
vim.keymap.set("n", "<leader>h", function() vim.cmd("wincmd h") end)
vim.keymap.set("n", "<leader>j", function() vim.cmd("wincmd j") end)
vim.keymap.set("n", "<leader>k", function() vim.cmd("wincmd k") end)
vim.keymap.set("n", "<leader>l", function() vim.cmd("wincmd l") end)
vim.keymap.set("n", "<leader>v", function() vim.cmd("wincmd v") end)
vim.keymap.set("n", "<leader>s", function() vim.cmd("wincmd s") end)
vim.keymap.set("n", "<leader>q", function() vim.cmd("wincmd q") end)
vim.keymap.set("n", "<leader>1", vim.cmd.only)
-- vim.keymap.set("n", "<leader>b", ls<CR>:b<Space>
-- vim.keymap.set("n", "<silent> <Leader>+ :vertical resize +5<CR>
-- vim.keymap.set("n", "<silent> <Leader>-5 :vertical resize -5<CR>
-- vim.keymap.set("n", "<leader>ps :Rg<SPACE>

