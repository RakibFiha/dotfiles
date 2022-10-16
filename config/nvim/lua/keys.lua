local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Snip...

-- move betweeen buffer with control j and control k
keymap("n", "<C-J>", ":bprev<CR>", opts) -- nnoremap <C-J> :bprev<CR>
keymap("n", "<C-K>", ":bnext<CR>", opts) -- nnoremap <C-K> :bnext<CR>

-- move between tabs with control h and l
keymap("n", "<C-H>", ":tabprev<CR>", opts) -- nnoremap <C-H> :tabprev<CR>
keymap("n", "<C-L>", ":tabnext<CR>", opts) -- nnoremap <C-L> :tabnext<CR>

-- save with control s
keymap("n", "<C-S>", ":w<CR>", opts) -- nnoremap <C-S> :w<CR>

-- file tree CHADtree
keymap("n", "<Space>f", "<CMD>CHADopen<CR>", opts) -- nnoremap <SPACE>f <cmd>CHADopen<cr>
keymap("n", "<Space><C-F>", ":CHADopen --version-ctl<CR>", opts)-- nnoremap <SPACE><C-F> <cmd>CHADopen --version-ctl<cr>

-- disable arrow up down left right
keymap("n", "<Up>", "<Nop>", opts) -- noremap <Up> <Nop>
keymap("n", "Down", "<Nop>", opts) -- noremap <Down> <Nop>
keymap("n", "Left", "<Nop>", opts) -- noremap <Left> <Nop>
keymap("n", "Right", "<Nop>", opts) -- noremap <Right> <Nop>
