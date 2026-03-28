-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Helper function
local keymap = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

--------------------------------------------------
-- 🚫 Disable keys
--------------------------------------------------
-- keymap({ "n", "v" }, "<Space>", "<Nop>", "Disable Space")
keymap({ "n", "i", "v", "c", "t" }, "<C-Space>", "<Nop>", "Disable Ctrl+Space (tmux)")

--------------------------------------------------
-- ✍️ Editing
--------------------------------------------------
keymap("n", "<CR>", "o<Esc>", "New line below")
keymap("n", "<C-c>", "O<Esc>", "New line above")
keymap("n", "x", '"_x', "Delete char without yank")

--------------------------------------------------
-- 💾 File
--------------------------------------------------
keymap("n", "<C-s>", "<cmd>w<CR>", "Save file")
keymap("n", "<leader>w", "<cmd>w<CR>", "Save file (leader)")
keymap("n", "<leader>wn", "<cmd>noautocmd w<CR>", "Save without formatting")
keymap("n", "<leader>q", "<cmd>q<CR>", "Quit file")

--------------------------------------------------
-- 🔍 Search
--------------------------------------------------
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")
keymap("n", "n", "nzzzv", "Next search result (centered)")
keymap("n", "N", "Nzzzv", "Prev search result (centered)")

--------------------------------------------------
-- 📜 Scrolling
--------------------------------------------------
keymap("n", "<C-d>", "<C-d>zz", "Scroll down (centered)")
keymap("n", "<C-u>", "<C-u>zz", "Scroll up (centered)")

--------------------------------------------------
-- 📦 Buffers
--------------------------------------------------
keymap("n", "<Tab>", "<cmd>bnext<CR>", "[B]uffer Next")
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", "[B]uffer Previous")
keymap("n", "<leader>x", "<cmd>bdelete!<CR>", "[B]uffer Close")
keymap("n", "<leader>n", "<cmd>enew<CR>", "[B]uffer New")

--------------------------------------------------
-- 🪟 Windows
--------------------------------------------------
keymap("n", "<leader>ws", "<C-w>s", "Split horizontal")
keymap("n", "<leader>wv", "<C-w>v", "Split vertical")
keymap("n", "<leader>wq", "<cmd>close<CR>", "Close window")

-- Navigation
keymap("n", "<C-h>", "<C-w>h", "Go left window")
keymap("n", "<C-j>", "<C-w>j", "Go down window")
keymap("n", "<C-k>", "<C-w>k", "Go up window")
keymap("n", "<C-l>", "<C-w>l", "Go right window")

--------------------------------------------------
-- 📐 Resize
--------------------------------------------------
keymap("n", "<Up>", "<cmd>resize -2<CR>", "Resize up")
keymap("n", "<Down>", "<cmd>resize +2<CR>", "Resize down")
keymap("n", "<Left>", "<cmd>vertical resize -2<CR>", "Resize left")
keymap("n", "<Right>", "<cmd>vertical resize +2<CR>", "Resize right")

--------------------------------------------------
-- 📑 Tabs
--------------------------------------------------
keymap("n", "<leader>to", "<cmd>tabnew<CR>", "New tab")
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", "Close tab")
keymap("n", "<leader>tn", "<cmd>tabn<CR>", "Next tab")
keymap("n", "<leader>tp", "<cmd>tabp<CR>", "Previous tab")

--------------------------------------------------
-- ⚙️ Toggles
--------------------------------------------------
keymap("n", "<leader>tw", "<cmd>set wrap!<CR>", "Toggle wrap")

--------------------------------------------------
-- 🔀 Move lines (visual)
--------------------------------------------------
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")
keymap("v", "<A-h>", "<gv", "Indent left")

keymap("v", "<A-l>", ">gv", "Indent right")
