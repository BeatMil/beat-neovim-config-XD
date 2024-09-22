print('neovide_beat.lua ✓✓✓')


if vim.g.neovide then
	vim.g.neovide_scale_factor = 0.7
	vim.o.guifont = "Hack Nerd Font" -- text below applies for VimScript
	-- vim.cmd('hi Normal guibg=#282E3A')
end
vim.cmd('hi Normal guibg=#232936')
