local map = vim.api.nvim_set_keymap

-- operation
map('n', 'yil', '^y$', {noremap = true})
-- map('n', '<C-m>', ':nohl<CR>', {noremap = true})
-- map('i', '<C-m>', '<ESC>:nohl<CR>', {noremap = true})

-- move
map('n', 'H', '^', {noremap = true})
map('n', 'L', '$', {noremap = true})
map('i', 'H', '^', {noremap = true})
map('i', 'L', '$', {noremap = true})
map('i', '<C-j>', '<Down>', {noremap = true})
map('i', '<C-k>', '<Up>', {noremap = true})
map('i', '<C-h>', '<Left>', {noremap = true})
map('i', '<C-l>', '<Right>', {noremap = true})
map('n', 'j', 'gj', {noremap = true})
map('n', 'k', 'gk', {noremap = true})

-- split 
map('n', 'gh', '<C-W>h', {noremap = true})
map('n', 'gl', '<C-W>l', {noremap = true})
map('n', 'gk', '<C-W>k', {noremap = true})
map('n', 'gj', '<C-W>j', {noremap = true})


-- nvim-tree
map('n', '<leader>tp', '<cmd>NvimTreeToggle<cr>', {desc = "Toggle Explorer"})
map('n', '<leader>si', '<cmd>NvimTreeFocus<cr>', {desc = "Focus Explorer"})

-- lsp management
map('n', '<leader>lm', '<cmd>Mason<cr>', {desc = "LSP Management"})

-- package management
map('n', '<leader>pm', '<cmd>PackerStatus<cr>', {desc = "Package Management"})