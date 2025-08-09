print("beat.lua loading...")

-- beat try his first lua function
function spawnWindow()
	print("Testing floating window")
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 60
	local height = 10
	local opts = {
		style = "minimal",
		relative = "editor",
		border = "rounded",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2
	}
	_G.win_id = vim.api.nvim_open_win(buf, true, opts)
	print("Window ID: " .. win_id)
	print("type(win_id) = " .. type(win_id))
	local lines = {
		"This is a floating window!",
		"Isn't it cool?",
		"",
		"[1] Button 1",
		"[2] Button 2"
	}
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_add_highlight(buf, -1, "Question", 3, 0, -1)
	vim.api.nvim_buf_add_highlight(buf, -1, "Question", 4, 0, -1)

	_G.selected = 1

	function _G.update_selection()
		vim.api.nvim_buf_clear_namespace(buf, 0, 3, 5)
		vim.api.nvim_buf_add_highlight(buf, 0, "Visual", 3 + _G.selected, 0, -1)
	end

	update_selection()

	-- Mappings for navigating and selecting buttons
	vim.api.nvim_buf_set_keymap(buf, 'n', 'h', ':lua _G.selected = 0; _G.update_selection()<CR>', { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, 'n', 'l', ':lua _G.selected = 1; _G.update_selection()<CR>', { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua handle_selection(_G.selected, _G.win_id)<CR>', { noremap = true, silent = true })
end


function _G.handle_selection(selected, win)
	print("ΓûªΓûªΓûªhandle_selectionΓûªΓûªΓûªΓûª")
	print("selected = " .. selected)
	print(win)
	if selected == 0 then
		print("Button 1 selected")
	elseif selected == 1 then
		print("Button 2 selected")
	end
	vim.api.nvim_win_close(tonumber(win), true)
end

---- leader doesn't get mapped here...
---- So I'm mapping one myself!!!
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>0', function() spawnWindow() end)


-- On exit vim
-- vim.api.nvim_create_autocmd({"VimLeave", "VimLeavePre", "WinClosed", "WinLeave"}, {
-- 	callback = "input('Meet Bob then continue')",
-- })

-- autocmd events
-- {"VimLeave", "VimLeavePre", "WinClosed", "WinLeave"}

-- On exit vim
vim.api.nvim_create_autocmd({"WinLeave"}, {
	-- callback = vim.ui.input({ prompt = 'Prompt: '}, function(input) return input end)
	callback = function ()
		--		S = io.read("*a") -- read the complete stdin --- !!!Scary line!!!
		-- os.execute("start https://www.pixiv.net/en/")
		-- os.execute("$PlayWav=New-Object System.Media.SoundPlayer;$PlayWav.SoundLocation='C:/Users/beatmil/beatmil/godot/TobPaCharge/media/sfx/gura_a.wav';$PlayWav.playsync()")
		-- os.execute("$PlayWav.SoundLocation='C:/Users/beatmil/beatmil/godot/TobPaCharge/media/sfx/gura_a.wav'")
		-- os.execute("$PlayWav.playsync()")
	end
})

print("beat.lua loaded!")


-- move godot lsp thing here
function Activate_godot_lsp ()
	print("Activate godot LSP")
	local port = os.getenv('GDScript_Port') or '6005'
	local cmd = {'ncat', 'localhost', port}
	local pipe = [[\\.\pipe\godot.pipe]]

	vim.lsp.start({
		name = 'Godot',
		cmd = cmd,
		root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
		on_attach = function(client, bufnr)
			vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
		end
	})
end

-- vim.keymap.set('n', '<leader>9', function() Activate_godot_lsp() end)


