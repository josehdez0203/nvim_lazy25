return {
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
}
