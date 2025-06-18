-- local dir_path = vim.fn.expand("~/.config/nvim/plugins/pomodoro/")
return {
	-- "~/.config/nvim/plugins/pomodoro/init",
	dir = "~/.config/nvim/plugins/pomodoro.nvim",
	config = function()
		-- print(dir_path)
		require("pomodoro").setup({
			running = 5, -- Duration of work sessions in minutes
			shortPause = 1, -- Duration of short breaks in minutes
			longPause = 2, -- Duration of long breaks in minuter
			timeOut = 1000 * 60,
			total = 2,
			icons = {
				detenido = "󰙦",
				running = "", -- Icon for work sessions
				shortPause = "", -- Icon for short breaks
				longPause = "", -- Icon for long breaks
			},
		})
		vim.api.nvim_set_keymap("n", "<S-R>", ":PMInfo<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>t", ":PMPopup<CR>", { noremap = true, silent = true })
	end,
}
