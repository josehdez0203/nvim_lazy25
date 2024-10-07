return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
	opts = {
		signs = {
			add = { text = "" },
			change = { text = "" },
			delete = { text = "󰧧" },
			topdelete = { text = "󰚃 " },
			changedelete = { text = "󰠙" },
			untracked = { text = " " },
		},
		signcolumn = true,
	},
	keys = {
		{ "tl", ":Gitsigns toggle_signs<CR>", desc = "Alternar line signs", silent = true },
		{ "tg", ":Gitsigns toggle_current_line_blame<CR>", desc = "Alternar line blame", silent = true },
	},
}
