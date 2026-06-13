require("Profile")
require('vim._core.ui2').enable()

--: LSP Config, Mason, and Treesitter
vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		version = "v0.10.0",
	},
})

-- LSP Config
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action({
			filter = function(action)
				return not action.disabled
			end,
		})
	end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '<leader>]', function() vim.diagnostic.jump({ count = 1 }) end, opts)
	vim.keymap.set('n', '<leader>[', function() vim.diagnostic.jump({ count = -1 }) end, opts)
end

vim.lsp.config("djlsp", { on_attach = on_attach })
vim.lsp.config("eslint", { on_attach = on_attach })
vim.lsp.config("ts_ls", { on_attach = on_attach })
vim.lsp.config("tailwindcss", { on_attach = on_attach })
vim.lsp.config("ruby_lsp", { on_attach = on_attach, })

vim.lsp.config("basedpyright", {
	on_attach = on_attach,
	root_dir = require("lspconfig.util").root_pattern(".git", "setup.py", "pyproject.toml", "requirements.txt"),
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = 'basic'
			},
		},
	},
})


vim.lsp.config("lua_ls", { on_attach = on_attach })
vim.diagnostic.config({
	virtual_text = false, -- Turn off inline diagnostics
})
--

-- Mason Config
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "emmet_ls", "eslint", "ts_ls", "tailwindcss", "ruby_lsp" },
})
--

--:

--: Telescope and Harpoon
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2"
	}
})
-- Telescope Config
local builtin = require('telescope.builtin')

require('telescope').setup({
	defaults = {
		preview = {
			treesitter = false,
		},
	},
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		bookmarks = {
			initial_mode = "normal",
		},
	},
})

function SearchClasses()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Class" },
		prompt_title = "Search Classes"
	})
end

function SearchFunctions()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Function", "Method" },
		prompt_title = "Search Functions"
	})
end

function SearchVariables()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Variable", "Constant" },
		prompt_title = "Search Variables"
	})
end

-- Very important
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find all files' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pp', SearchFunctions, {})
vim.keymap.set('n', '<leader>pc', SearchClasses, {})
vim.keymap.set('n', '<leader>pv', SearchVariables, {})
--
vim.keymap.set('n', '<leader>ps', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>pw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>pq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>pk', builtin.keymaps, {})
--

-- HARPOON CONFIG
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-5>", function() harpoon:list():select(5) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

--: Blink CMP
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
})
require("blink.cmp").setup({
	keymap = { preset = 'default' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "prefer_rust" }
})
--:

--: Lualine
vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim'
})

-- Lualine Config

local everforest = require("everforest")
local colours = require("everforest.colours")

-- Instead of `everforest.config`, you can add in your own config here by using
-- `everforest.setup({ show_eob = false)` before you generate the palette.
local palette = colours.generate_palette(everforest.config, vim.o.background)
local everforest_theme = {}

-- everforest custom theme
everforest_theme.normal = {
	a = { bg = palette.statusline1, fg = palette.bg0 },
	b = { bg = palette.bg0, fg = palette.bf1 },
	c = { bg = palette.bg_dim, fg = palette.yellow },
	y = { bg = palette.bg0, fg = palette.orange },
	z = { bg = palette.bf2, fg = palette.yellow }
}

everforest_theme.insert = {
	a = { bg = palette.purple, fg = palette.bg_purple},
	b = { bg = palette.bg0, fg = palette.bf1 },
	y = { bg = palette.bg0, fg = palette.orange },
	z = { bg = palette.bf2, fg = palette.yellow }
}

everforest_theme.terminal = {
	a = { bg = palette.statusline1, fg = palette.base},
	b = { bg = palette.bg0, fg = palette.bf1 },
	y = { bg = palette.bg0, fg = palette.orange },
	z = { bg = palette.bf2, fg = palette.yellow }
}

everforest_theme.command = {
	a = { bg = palette.red, fg = palette.bg_red},
	b = { bg = palette.bg0, fg = palette.bf1 },
	y = { bg = palette.bg0, fg = palette.orange },
	z = { bg = palette.bf2, fg = palette.yellow }
}

everforest_theme.visual = {
	a = { bg = palette.statusline3, fg = palette.bg_visual},
	b = { bg = palette.bg0, fg = palette.bf1 },
	y = { bg = palette.bg0, fg = palette.orange },
	z = { bg = palette.bf2, fg = palette.yellow }
}

everforest_theme.replace = {
	a = { bg = palette.yellow, fg = palette.bg_yellow},
	b = { bg = palette.bg0, fg = palette.bf1 },
	y = { bg = palette.bg0, fg = palette.orange },
	z = { bg = palette.bf2, fg = palette.yellow }
}

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = everforest_theme,
		component_separators = { left = ' ', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = {
			{
				'mode',
				icons_enabled = true,
				icon = {'', allign = 'left'}
			}
		},
		lualine_b = {'branch', 'diff' },
		lualine_c = {'diagnostics'},
		lualine_x = {'location','progress'},
		lualine_z = {
			{
				'filename',
				icon = {'󰧮', allign = 'left'}
				-- path=1
			}
		},
		lualine_y = {
			{
				'filetype',
				colored = false,
				icon = { allign = 'left'}
			}
		}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {'location'},
		lualine_y = {'filename'},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
--:

--: Icons
vim.pack.add( { "https://github.com/onsails/lspkind.nvim" } )
--:

--: Markview
vim.pack.add( { "https://github.com/OXY2DEV/markview.nvim" } )
--
