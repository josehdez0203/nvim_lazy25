return {
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
}
