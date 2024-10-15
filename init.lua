print("init.lua new")


-- Fast travel XD (gf it!)
---- plugin/telescope_mapping.lua
---- plugin/mappings.lua
---- plugin/beat.lua
---- plugin/neovide_beat.lua
---- plugin/comfy.lua
---- plugin/emoji.lua
---- after/ftplugin/gdscript.lua


-- Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{'tpope/vim-surround'},
	-- {'vim-airline/vim-airline'},
	-- {'vim-airline/vim-airline-themes'},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{'tpope/vim-commentary'},
	{'jiangmiao/auto-pairs'},
	{'tpope/vim-fugitive'},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'BurntSushi/ripgrep',
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("telescope").setup({
				-- the rest of your telescope config goes here
				extensions = {
					undo = {
						-- telescope-undo.nvim config, see below
					},
					-- other extensions:
					-- file_browser = { ... }
				},
			})
			require("telescope").load_extension("undo")
		end
	},
	{
		'navarasu/onedark.nvim'
	},
	{
		  "folke/tokyonight.nvim",
		  lazy = false,
		  priority = 1000,
		  opts = {},
	},
	{
		'ThePrimeagen/harpoon', branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, -- treesitter
	{'nvim-tree/nvim-tree.lua'},

	----Language server manager
	{
		'williamboman/mason.nvim'
	},
	{
		'williamboman/mason-lspconfig.nvim'
	},
	{
		'neovim/nvim-lspconfig',
		config=function()
			local lspconfig = require('lspconfig')

			lspconfig.gdscript.setup({})
			lspconfig.pyright.setup({})
			lspconfig.pylsp.setup{
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = {'W391'},
								maxLineLength = 100
							}
						}
					}
				}
			}

			--Enable (broadcasting) snippet capability for completion
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.vimls.setup({})
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {'vim'},
						},
					},
				},
			})
			lspconfig.emmet_ls.setup({})
		end
	},

	------ snippets
	{'hrsh7th/vim-vsnip'},
	{'hrsh7th/cmp-vsnip'},

	------ helps complete
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-cmdline'},

	---- auto complete
	---- also for neovim auto complete
	{ -- optional completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	-- old auto complete
	-- {'neoclide/coc.nvim', branch = 'release', enable = false},

	---- AI Codium
	-- {'Exafunction/codeium.vim'},

	---- terminal
	-- {'akinsho/toggleterm.nvim', version = "*", config = true},

	---- toggle maximize window
	{
		'declancm/maximize.nvim',
	},
	---- Git sign show diff live
	{
		'lewis6991/gitsigns.nvim',
	},
	-- ---- Better vim message
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- },
	{'mbbill/undotree'},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				backdrop = 1.00, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 160, -- width of the Zen window
				height = 1, -- height of the Zen window
				-- by default, no options are changed for the Zen window
				-- uncomment any of the options below, or add other vim.wo options you want to apply
				options = {
					-- signcolumn = "no", -- disable signcolumn
					number = true, -- disable number column
					relativenumber = true, -- disable relative numbers
					cursorline = true, -- disable cursorline
					-- cursorcolumn = false, -- disable cursor column
					-- foldcolumn = "0", -- disable fold column
					list = true, -- disable whitespace characters
				},
			},
			plugins = {
				options = {
					enabled = true,
					-- ruler = false, -- disables the ruler text in the cmd line area
					-- showcmd = false, -- disables the command in the last line of the screen
					-- you may turn on/off statusline in zen mode by setting 'laststatus' 
					-- statusline will be shown only if 'laststatus' == 3
					laststatus = 3, -- turn off the statusline in zen mode
				},
			}
		}
	}
}
local opts = {}
require("lazy").setup(plugins, opts)


-- Airline configs
-- vim.g.airline_section_z = 'o(> <)o'
-- vim.g.airline_section_c = '%t'
require('lualine').setup({})


-- Neovim tree
require("nvim-tree").setup()


-- Customized
---- set colorscheme
require('onedark').setup {
	--    'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
	style = 'cool',
	transparent = true,
}
require('onedark').load()

require('gitsigns').setup()


-- require('tokyonight').load()
------- Reference
----vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
----vim.cmd.highlight({ "EndOfBuffer", "guibg=NONE"})
---- Status Line
vim.g.airline_theme = 'onedark'


-- Mason Setup
require("mason").setup()
require("mason-lspconfig").setup()


---- treesitter config
local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = {"lua", "vim", "vimdoc", "gdscript"},
	highlight = { enable = true },
	indent = { enable = true },
})


-- More config from kickstart nvim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.foldmethod = 'indent'
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.undofile = true
-- nvim show tabs and trailing spaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true

-- Mappings
---- leader desu
vim.g.mapleader = ' '
vim.g.localleader = ' '

---- cursor navigation
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', 'H', '0')
vim.keymap.set('v', 'L', '$')
vim.keymap.set('v', 'H', '0')
vim.keymap.set('i', 'jk', '<esc>')

---- save, close, discard changes
vim.keymap.set('n', '<leader>w', function() vim.cmd("w") end)
vim.keymap.set('n', '<leader>q', function() vim.cmd("q!") end)
vim.keymap.set('n', '<leader>e', function() vim.cmd("e!") end)
vim.keymap.set('n', '<leader>a', function() vim.cmd("q") end)

---- screen navigation
vim.keymap.set('n', '<leader>l', '<c-w>l')
vim.keymap.set('n', '<leader>h', '<c-w>h')
vim.keymap.set('n', '<leader>k', '<c-w>k')
vim.keymap.set('n', '<leader>j', '<c-w>j')

---- buffer navigation
vim.keymap.set('n', '^', '<c-^>')

---- open init.lua, source init.lua
vim.keymap.set('n', '<leader>se', function() vim.cmd.vsplit('~/.config/nvim/init.lua')end)
vim.keymap.set('n', '<leader>sv', function() vim.cmd.source('~/.config/nvim/init.lua')end)

---- Package manager binds
-- vim.keymap.set('n', '<leader>si', function() vim.cmd('PackerInstall')end)
-- vim.keymap.set('n', '<leader>sc', function() vim.cmd('PackerClean')end)

---- fzf mappings
-- vim.keymap.set('n', '<leader>th', function() vim.cmd('Files')end)
-- vim.keymap.set('n', '<leader>tm', function() vim.cmd('Buffers')end)
-- vim.keymap.set('n', '<leader>tc', function() vim.cmd('Colors')end)


---- harpoon mappings
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>uu", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>ue", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>uh", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>ut", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>un", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>us", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>um", function() harpoon:list():select(9) end)
vim.keymap.set("n", "<leader>uw", function() harpoon:list():select(10) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)


---- Vimgrep search files
vim.keymap.set('n', '<leader>f', ':vimgrep//**<left><left><left>')

---- Change variable name
vim.keymap.set('n', '<leader>rr', ':%s/<c-r><c-w>//g<left><left>')

---- Fugivite Mappings
vim.keymap.set('n', '<leader>gg', function() vim.cmd('Git')end)

---- Terminal Mappings
vim.keymap.set('t', '<F2>', '<C-\\><C-n>')
-- do pwd before run this command in terminal buffer
vim.keymap.set('n', '<F3>', '4kVy:lcd <c-r>0<cr>')
vim.keymap.set('n', '<leader>9`', ':vsplit term://powershell<cr>i')

-- Maximize
vim.keymap.set("n", "<leader>96", ":Maximize<CR>")

-- relativenumber toggle
vim.keymap.set("n", "<leader>97", ":se rnu!<CR>")


--
-- Ends (Mappings)


-- Add numbered movement to jump list
vim.cmd([[
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
]])

---- commentary
vim.cmd([[
	autocmd FileType gdscript setlocal commentstring=#\ %s
]])


---- man I wanna use lua lsp but it's not working...
-- vim.cmd('CocDisable')


-- trim trailing whitespace
vim.cmd([[
fun! TrimWhitespace()
let l:save = winsaveview()
keeppatterns %s/\s\+$//e
call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
]])


-- python maps
vim.cmd([[
	autocmd FileType python vnoremap <leader>p yiprint(f"<esc>ea: {<esc>pa}")<esc>
	autocmd FileType gdscript vnoremap <leader>p yiprint(f"<esc>ea: {<esc>pa}")<esc>
	autocmd FileType lua nnoremap <leader>rc :luafile %<cr>
]])

-- Random maps
vim.keymap.set('n', '<leader>9h', ':NvimTreeOpen<cr>')
vim.keymap.set('n', '<leader>98', function ()
	if vim.g.neovide_fullscreen == true or vim.g.neovide_fullscreen == 1 then
		vim.g.neovide_fullscreen = 0
	else
		vim.g.neovide_fullscreen = 1
	end
end)

vim.keymap.set('n', '<leader>91', ':let g:neovide_scale_factor=')


if vim.g.neovide then
	vim.cmd('hi Normal guibg=#232936')
	vim.g.neovide_cursor_vfx_mode = "sonicboom"
end

-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', {}),
	desc = 'Hightlight selection on yank',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank { higroup = 'IncSearch', timeout = 10 }
	end,
})


-- Disable Codium
-- vim.cmd("CodeiumDisable")
