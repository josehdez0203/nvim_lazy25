return {
	-- {
	-- 	-- Hints keybinds
	-- 	"folke/which-key.nvim",
	-- },
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
		"folke/paint.nvim",
		config = function()
			require("paint").setup({
				---@type PaintHighlight[]
				highlights = {
					{
						-- filter can be a table of buffer options that should match,
						-- or a function called with buf as param that should return true.
						-- The example below will paint @something in comments with Constant
						filter = { filetype = "lua" },
						pattern = "%s*%-%-%-%s*(@%w+)",
						hl = "Constant",
					},
				},
			})
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
		"folke/snacks.nvim",
		opts = {
			image = {},
			picker = {
				exclude = {
					"node_modules",
					".git",
				},
			},
		},
		keys = {
			{
				"ff",
				function()
					Snacks.picker.files()
				end,
				"File picker",
			},
			{
				"<leader>df",
				function()
					Snacks.picker.diagnostics()
				end,
				"Diagnostics",
			},
			{
				"<leader>dd",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				"Buffer Diagnostics",
			},
			-- vim.keymap.set("n", "fo", require("telescope.builtin").oldfiles, {})
			{
				"fg",
				function()
					Snacks.picker.grep()
				end,
				"Grep",
			},
			{
				"ft",
				function()
					Snacks.picker.help()
				end,
				"Keymaps",
			},
			{
				"fk",
				function()
					Snacks.picker.keymaps()
				end,
				"Keymaps",
			},
			{
				"fs",
				function()
					Snacks.picker.colorschemes()
				end,
				"colorschemes",
			},
			{
				"fv",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				"Vim config",
			},
		},
	},
}
