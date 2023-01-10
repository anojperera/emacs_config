vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", vim.cmd.Ex)
-- Remapped keys for navigating windows
vim.keymap.set("n", "<leader>h", function() vim.cmd("wincmd h") end)
vim.keymap.set("n", "<leader>j", function() vim.cmd("wincmd j") end)
vim.keymap.set("n", "<leader>k", function() vim.cmd("wincmd k") end)
vim.keymap.set("n", "<leader>l", function() vim.cmd("wincmd l") end)
vim.keymap.set("n", "<leader>v", function() vim.cmd("wincmd v") end)
vim.keymap.set("n", "<leader>s", function() vim.cmd("wincmd s") end)
vim.keymap.set("n", "<leader>q", function() vim.cmd("wincmd q") end)
vim.keymap.set("n", "<leader>1", vim.cmd.only)
-- vim.keymap.set("n", "<leader>b", function() vim.cmd("ls") end) -- This is used by telescope
-- vim.keymap.set("n", "<silent> <Leader>+ :vertical reoize +5<CR>
-- vim.keymap.set("n", "<silent> <Leader>-5 :vertical resize -5<CR>
--
-- use :Rg <keyword> -g '*.py' to filter out file types
vim.keymap.set("n", "<leader>fr", ":Rg<SPACE>")

-- Move highlited region
vim.keymap.set("v", "J", ":m '>+<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- keep pasting
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- make chmod
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})
