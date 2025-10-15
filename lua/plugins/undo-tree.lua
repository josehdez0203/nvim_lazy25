return {
	-- { "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<F4>", "<cmd>UndotreeToggle<cr>", { desc = "undotree" })
		end,
	},
}
