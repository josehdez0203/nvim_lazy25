return {
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
		lazy = false,
		config = function()
			local snipe = require("snipe")
			snipe.setup({
				position = "center",
			})
			vim.keymap.set("n", "<leader>g", snipe.open_buffer_menu, { desc = "Abre snipe" })
		end,
	},
}
