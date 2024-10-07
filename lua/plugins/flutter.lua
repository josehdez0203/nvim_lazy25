return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		require("flutter-tools").setup({
			widget_guides = {
				enabled = true,
			},
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			closing_tags = {
				highlight = "Comment", -- highlight for the closing tag
				prefix = "//", -- character to use for close tag e.g. > Widget
				enabled = true, -- set to false to disable
			},
			dev_log = {
				enabled = true,
				notify_errors = false, -- if there is an error whilst running then notify the user
				open_cmd = "54vs", -- command to use to open the log buffer
			},
		}) -- use defaults
		require("telescope").load_extension("flutter")
		vim.keymap.set("n", "<C-f>", "<CMD>Telescope flutter commands<CR>", {})
		vim.keymap.set("n", "<space>f", "<C-W>K", {})
		vim.keymap.set("n", "<space>s", ":54vsplit<CR>", {})
	end,
}
