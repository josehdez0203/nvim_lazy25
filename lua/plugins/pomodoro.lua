-- local dir_path = vim.fn.expand("~/.config/nvim/plugins/pomodoro/")
return {
	-- "~/.config/nvim/plugins/pomodoro/init",
	dir = "~/.config/nvim/plugins/pomodoro.nvim",
	config = function()
		-- print(dir_path)
		require("pomodoro").setup({
			running = 20, -- Duration of work sessions in minutes
			shortPause = 5, -- Duration of short breaks in minutes
			longPause = 15, -- Duration of long breaks in minutes
			icons = {
				running = "", -- Icon for work sessions
				shortPause = "", -- Icon for short breaks
				longPause = "", -- Icon for long breaks
			},
		})
		vim.api.nvim_set_keymap(
			"n",
			"<S-T>",
			":lua require'pomodoro'.showInfo()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("n", "<S-C>", ":PMCreate<CR>", { noremap = true, silent = true })
	end,
}
