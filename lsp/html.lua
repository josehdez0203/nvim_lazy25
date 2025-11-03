return {
	settings = {
		html = {
			format = {
				templating = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},
	-- capabilities = capabilities,
	configurationSection = { "html", "css", "javascript" },
	filetypes = { "html" },
	embeddedLanguages = {
		css = true,
		javascript = true,
	},
	provideFormatter = true,
}
