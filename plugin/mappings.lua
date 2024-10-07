print("mappings.lua ✓✓✓")


---- leader doesn't get mapped here...
---- So I'm mapping one myself!!!
vim.g.mapleader = ' '

--  Beat maps
-- vim.keymap.set('n', '<leader>oeu', ':Vex<cr>:vert resize 40<cr><c-w>l')
-- vim.keymap.set('n', '<leader>tm', builtin.buffers, {})
vim.keymap.set('n', '<leader>oeu', ':NvimTreeOpen<cr>:vert resize+30<cr><c-w>l')
