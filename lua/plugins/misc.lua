-- Standalone plugins with less than 10 lines of config go here
return {
	-- {
	-- 	-- Tmux & split window navigation
	-- 	"christoomey/vim-tmux-navigator",
	-- },
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	-- {
	-- 	-- Hints keybinds
	-- 	"folke/which-key.nvim",
	-- },
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
		keys = {
			{ "gt", "<cmd>TodoTelescope<cr>", desc = "Ver Todos" },
		},
	},
	{
		"echasnovski/mini.hipatterns",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		lazy = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"folke/noice.nvim",
		-- event = "VeryLazy",
		lazy = false,
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		config = function()
			local opts = {
				timeout = 2000,
				-- render = "minimal",
				-- stages = "fade",
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.4)
				end,
				on_open = function(win)
					vim.api.nvim_win_set_config(win, { zindex = 100 })
				end,
			}
			require("notify").setup(opts)
			-- when noice is not enabled, install notify on VeryLazy
			-- if not Util.has("noice.nvim") then
			-- 	Util.on_very_lazy(function()
			-- 		vim.notify = require("notify")
			-- 	end)
			-- end
		end,
	},
	{
		{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use

		{
			"mbbill/undotree",
			config = function()
				vim.keymap.set("n", "<F4>", "<cmd>UndotreeToggle<cr>", { desc = "undotree" })
			end,
		},
	},
	-- {
	-- 	"voldikss/vim-floaterm",
	-- 	lazy = false,
	-- 	config = function()
	-- 		vim.keymap.set("n", "<F12>", ":FloatermToggle<CR>", { desc = "FloatermToggle" })
	-- 		vim.keymap.set("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>", { desc = "FloatermToggle" })
	-- 	end,
	-- },
	{
		"folke/zen-mode.nvim",
		lazy = false,
		dependencies = { "folke/twilight.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>", { desc = "ZenMode" }) -- ZenMode
			vim.keymap.set("n", "<leader>zt", ":Twilight<CR>", { desc = "Twilight" }) --Twilight
		end,
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		init = function()
			require("mini.animate").setup()
		end,
	},
	-- {
	-- 	"sphamba/smear-cursor.nvim",
	--
	-- 	opts = {
	-- 		-- Smear cursor color. Defaults to Cursor GUI color if not set.
	-- 		-- Set to "none" to match the text color at the target cursor position.
	-- 		cursor_color = "#d3cdc3",
	--
	-- 		-- Background color. Defaults to Normal GUI background color if not set.
	-- 		normal_bg = "#282828",
	--
	-- 		-- Smear cursor when switching buffers or windows.
	-- 		smear_between_buffers = true,
	--
	-- 		-- Smear cursor when moving within line or to neighbor lines.
	-- 		smear_between_neighbor_lines = true,
	--
	-- 		-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
	-- 		-- Smears will blend better on all backgrounds.
	-- 		legacy_computing_symbols_support = false,
	-- 	},
	-- },
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				mappings = { -- Keys to be mapped to their corresponding default scrolling animation
					"<C-u>",
					"<C-d>",
					"<C-b>",
					-- "<C-f>",
					"<C-y>",
					"<C-e>",
					"zt",
					"zz",
					"zb",
				},
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				duration_multiplier = 1.0, -- Global duration multiplier
				easing = "linear", -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
				ignored_events = { -- Events ignored while scrolling
					"WinScrolled",
					"CursorMoved",
				},
			})
		end,
	},
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	opts = {},
	-- 	config = function()
	-- 		neoscroll = require("neoscroll")
	-- 		local keymap = {
	-- 			["<C-u>"] = function()
	-- 				neoscroll.ctrl_u({ duration = 250 })
	-- 			end,
	-- 			["<C-d>"] = function()
	-- 				neoscroll.ctrl_d({ duration = 250 })
	-- 			end,
	-- 			["<C-b>"] = function()
	-- 				neoscroll.ctrl_b({ duration = 450 })
	-- 			end,
	-- 			["<C-f>"] = function()
	-- 				neoscroll.ctrl_f({ duration = 450 })
	-- 			end,
	-- 			["<C-y>"] = function()
	-- 				neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
	-- 			end,
	-- 			["<C-e>"] = function()
	-- 				neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
	-- 			end,
	-- 			["zt"] = function()
	-- 				neoscroll.zt({ half_win_duration = 250 })
	-- 			end,
	-- 			["zz"] = function()
	-- 				neoscroll.zz({ half_win_duration = 250 })
	-- 			end,
	-- 			["zb"] = function()
	-- 				neoscroll.zb({ half_win_duration = 250 })
	-- 			end,
	-- 		}
	-- 		local modes = { "n", "v", "x" }
	-- 		for key, func in pairs(keymap) do
	-- 			vim.keymap.set(modes, key, func)
	-- 		end
	-- 	end,
	-- },
	{
		"bitfield/vim-gitgo",
		lazy = false,
	},
	{
		"SmiteshP/nvim-navbuddy",
		lazy = false,
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		-- commands={Navbuddy}
		-- opts = { lsp = { auto_attach = true } },
		config = function()
			local navbuddy = require("nvim-navbuddy")
			navbuddy.setup({
				lsp = { auto_attach = true },
			})
			vim.keymap.set("n", "gl", "<cmd>Navbuddy<CR>", {})
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	{
		"leath-dub/snipe.nvim",
		config = function()
			local snipe = require("snipe")
			snipe.setup({
				position = "center",
			})
			vim.keymap.set("n", "gb", snipe.open_buffer_menu, { desc = "Abre snipe" })
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			-- This module contains a number of default definitions
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					-- "RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = { "n", "c", "t" },
		},
	},
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	version = false, -- Never set this value to "*"! Never!
	-- 	opts = {
	-- 		-- add any opts here
	-- 		-- for example
	-- 		provider = "openai",
	-- 		providers = {
	-- 			openai = {
	-- 				endpoint = "https://api.openai.com/v1",
	-- 				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
	-- 				extra_request_body = {
	-- 					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
	-- 					temperature = 0.75,
	-- 					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
	-- 					--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"echasnovski/mini.pick", -- for file_selector provider mini.pick
	-- 		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	-- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
	-- 		"stevearc/dressing.nvim", -- for input provider dressing
	-- 		"folke/snacks.nvim", -- for input provider snacks
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"tpope/vim-surround",
	-- 	dependencies = { "tpope/vim-repeat" },
	-- },
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"<C-p>",
				":lua require'telescope'.extensions.project.project{}<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
	-- {
	-- 	"serenevoid/kiwi.nvim",
	-- 	config = function()
	-- 		local kiwi = require("kiwi")
	--
	-- 		-- Necessary keybindings
	-- 		vim.keymap.set("n", "<leader>ww", kiwi.open_wiki_index, {})
	-- 		vim.keymap.set("n", "T", kiwi.todo.toggle, {})
	-- 	end,
	-- 	lazy = false,
	-- },
	{
		"echaya/neowiki.nvim",
		opts = {
			wiki_dirs = {
				-- neowiki.nvim supports both absolute and relative paths
				{ name = "Work", path = "~/wiki/work" },
				{ name = "Personal", path = "~/wiki/personal" },
			},
		},
		keys = {
			-- 	-- { "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>", desc = "Open Wiki" },
			{ "<leader>ww", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Floating Wiki" },
			-- 	{ "T", "<cmd>lua require('neowiki').open_wiki_new_tab()<cr>", desc = "Open Wiki in Tab" },
		},
	},
	{
		"vimpostor/vim-tpipeline",
		config = function()
			vim.g.tpipeline_autoembeb = 1
			vim.g.tpipeline_restore = 1
			vim.g.tpipeline_clearstl = 1
		end,
	},
	{
		"nvzone/floaterm",
		dependencies = "nvzone/volt",
		opts = {},
		lazy = false,
		-- cmd = "FloatermToggle",
		config = function()
			vim.keymap.set("n", "<F12>", ":FloatermToggle<CR>", { desc = "FloatermToggle", silent = true })
			vim.keymap.set("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>", { desc = "FloatermToggle", silent = true })
		end,
	},
	{
		"folke/snacks.nvim",
		opts = {
			image = {},
			picker = {},
		},
		keys = {
			{
				"ff",
				function()
					Snacks.picker.files()
				end,
				desc = "File picker",
				silent = true,
			},
		},
	},
}
