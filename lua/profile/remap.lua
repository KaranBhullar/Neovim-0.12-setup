vim.g.mapleader = " "

vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- Move highlighted up/down 1
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor in place when appending from prev line 
vim.keymap.set("n", "J", "mzJ`z")

-- Better highlight-replace functionality 
vim.keymap.set("x", "<leader>p", "\"_dP")

-- These 3 copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Globally changes hovered word
-- vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Adds easy Tab/DeTab to visual mode
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Delete word in Insert mode
vim.keymap.set("i", "<S-BS>", "<C-w>")

-- Adding double quotations around highlighted word
vim.keymap.set("v", '"', ":s/\\%V\\(.*\\)\\%V/\"\\1\"/<CR>")

-- Adding single quotations around highlighted word
vim.keymap.set("v", "'", ":s/\\%V\\(.*\\)\\%V/\'\\1\'/<CR>")

-- "Disabling" Ctrl + U because it deletes the line and is very annoying
vim.keymap.set("i", "<C-u>", "")

-- Change Shift + Tab to Escape
vim.keymap.set("i", "<S-Tab>", "<ESC>")
