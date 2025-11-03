return {
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			-- useLspFoldsWithTreesitterFallback = true,
			-- pauseFoldsOnSearch = true,
			foldtext = {
				lineCount = {
					template = " %d",
				},
				foldKeymaps = {
					setup = true, -- modifies `h`, `l`, and `$`
					hOnlyOpensOnFirstColumn = false,
				},
				autoFold = {
					enabled = false,
				},
			},
			-- diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
			-- gitsignsCount = true, -- requires `gitsigns.nvim`
			disableOnFt = { "snacks_picker_input" }, ---@type string[]
		}, -- needed even when using default config

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		opts = function()
			local builtin = require("statuscol.builtin")
			vim.opt.fillchars = {
				foldopen = "",
				foldclose = "",
				foldsep = " ",
			}
			vim.opt.foldcolumn = "1"
			return {
				setopt = true,
				ft_ignore = { "oil" },
				segments = {
					{
						text = { builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v.lua.ScLa",
					},
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
				},
			}
		end,
	},
}
