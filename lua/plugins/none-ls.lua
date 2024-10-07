return {
	-- "nvimtools/none-ls.nvim",
	-- lazy=true,
	-- event={"BufReadPre", "BufNewFile"},
	-- config = function()
	--   local null_ls = require("null-ls")
	--   null_ls.setup({
	--     sources = {
	--       null_ls.builtins.formatting.stylua,
	--       null_ls.builtins.formatting.prettier,
	--       null_ls.builtins.diagnostics.eslint_d,
	--     },
	--   })
	--   vim.keymap.set("n", "<leader>xx", vim.lsp.buf.format, {})
	-- end,
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")

		local null_ls = require("null-ls")

		local null_ls_utils = require("null-ls.utils")

		mason_null_ls.setup({
			ensure_installed = {
				"prettierd", -- prettier formatter
				"stylua", -- lua formatter
				"black", -- python formatter
				"gofumpt", -- go formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
			},
		})

		-- for conciseness
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- configure null_ls
		null_ls.setup({
			-- add package.json as identifier for root (for typescript monorepos)
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			-- setup formatters & linters
			sources = {
				--  to disable file types use
				--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
				-- formatting.prettierd.with({
				--   extra_filetypes = { "svelte" },
				-- }), -- js/ts formatter
				formatting.prettierd.with({
					filetypes = { "html", "json", "yaml", "markdown", "toml", "css", "scss", "js", "ts", "jsx", "tsx" },
					-- condition = function(utils)
					--   return utils.root_has_file({ ".prettierrc.js", ".prettierrc" })
					-- end,
				}),
				formatting.prettier,
				formatting.stylua, -- lua formatter
				formatting.isort,
				formatting.black,
				formatting.dart_format,
				formatting.gofumpt,
				-- formatting.phpcbf,
				formatting.pretty_php,
				-- formatting.prettier.with({
				--   filetypes = { "php" },
				--   extra_filetypes = { "php" },
				-- }),
				diagnostics.pylint,
				-- diagnostics.eslint_d.with({ -- js/ts linter
				--   filetypes = { "js", "ts", "tsx", "jsx" },
				--   -- condition = function(utils)
				--   --   return utils.root_has_file({ ".eslintrc.js", ".eslintrc", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
				--   -- end,
				-- }),
			},
			-- configure format on save
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
			vim.keymap.set("n", "<leader>xx", vim.lsp.buf.format, {}),
		})
	end,
}
