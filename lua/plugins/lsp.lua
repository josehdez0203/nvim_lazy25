return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "cssls", "gopls", "emmet_ls", "html" },
			})
		end,
	},
	-- your lsp config or other stuff
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
					completion = { completionItem = { snippetSupport = true } },
				},
			})
			local lspconfig = require("lspconfig")

			local util = require("lspconfig/util")
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set({ "n", "v" }, "<c-c>", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "fr", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>i", "<cmd>LspInfo<CR>", opts)
			vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
			vim.keymap.set("n", "<leader>,", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
			vim.keymap.set("n", "<leader>.", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
			vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
			vim.keymap.set("n", "k", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			-- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references()<CR>", {})
			vim.keymap.set("n", "gr", function()
				local tel = require("telescope.builtin")
				tel.lsp_references()
			end)

			vim.diagnostic.config({
				-- signs = true,
				virtual_text = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})

			-- local on_attach = function(client, bufnr)
			-- 	if client.server_capabilities.documentSymbolProvider then
			-- 		navic.attach(client, bufnr)
			-- 	end
			-- end
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- configure html server
			lspconfig["html"].setup({
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
				capabilities = capabilities,
				configurationSection = { "html", "css", "javascript" },
				filetypes = { "html" },
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = true,
			})
			-- configure typescript server with plugin
			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
				single_file_support = true,
			})
			-- configure css server
			lspconfig["cssls"].setup({
				capabilities = capabilities,
			})
			lspconfig["gopls"].setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})
			-- configure emmet language server
			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
					"gohtml",
					"templ",
				},
			})
			--Phpactor
			-- lspconfig["phpactor"].setup({
			-- 	capabilities = capabilities,
			-- })
		end,
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- },
}
