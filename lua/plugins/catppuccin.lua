return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		local opts = {
			custom_highlights = function(C)
				return {
					WinSeparator = { fg = C.pink },
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		}
		require("catppuccin").setup({ opts })
		vim.cmd.colorscheme("catppuccin")
	end,
}
