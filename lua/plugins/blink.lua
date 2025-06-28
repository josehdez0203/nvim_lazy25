return {
	{ "L3MON4D3/LuaSnip", keys = {} },
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"moyiz/blink-emoji.nvim",
		},
		version = "*",
		config = function()
			require("blink.cmp").setup({
				enabled = function()
					return vim.tbl_contains({
						"lua",
						"go",
						"markdown",
						"html",
						"yaml",
						"markdown",
						"toml",
						"css",
						"scss",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"templ",
						-- "template",
						"gohtml",
						"json",
						"jsonc",
						"c",
						"cpp",
						"dart",
						"toml",
					}, vim.bo.filetype)
				end,

				snippets = { preset = "luasnip" },
				signature = { enabled = true },
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "normal",
				},
				sources = {
					default = { "snippets", "lsp", "path", "buffer", "emoji" },
					providers = {
						emoji = {
							module = "blink-emoji",
							name = "Emoji",
							score_offset = 15, -- Tune by preference
							opts = {
								insert = true, -- Insert emoji (default) or complete its name
								---@type string|table|fun():table
								trigger = function()
									return { ":" }
								end,
							},
						},
					},
				},
				keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },
				cmdline = {
					enabled = false,
				},
				completion = {
					accept = { auto_brackets = { enabled = true } },
					menu = {
						border = nil,
						scrolloff = 1,
						scrollbar = false,
						draw = {
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "kind" },
								{ "source_name" },
							},
						},
					},
					documentation = {
						window = {
							border = nil,
							scrollbar = false,
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()
			-- require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	},
}
