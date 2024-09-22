print("telescope_mapping.lua loading...")


---- leader doesn't get mapped here...
---- So I'm mapping one myself!!!
vim.g.mapleader = ' '

---- telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>th', builtin.find_files, {})
vim.keymap.set('n', '<leader>tm', builtin.buffers, {})
vim.keymap.set('n', '<leader>tt', function() vim.cmd('Telescope')end)


-- Configuration
require('telescope').setup{
	defaults = {
		file_ignore_patterns = {"%.git/*", "%.godot/*", "%.import"},
		mappings = {
			n = {
				['<c-b>'] = require('telescope.actions').delete_buffer
			}, -- n
			i = {
				["<c-h>"] = "which_key",
				['<c-b>'] = require('telescope.actions').delete_buffer
			} -- i
		} -- mappings
	}
}

print("telescope_mapping.lua loaded!!")
