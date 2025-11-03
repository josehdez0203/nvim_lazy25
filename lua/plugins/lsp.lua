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
			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set({ "n", "v" }, "<c-c>", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "fr", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>i", "<cmd>LspInfo<CR>", opts)
			vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
			vim.keymap.set("n", "<leader>,", "<cmd>lua vim.diagnostic.jump({count=-1, float=false})<cr>", opts)
			vim.keymap.set("n", "<leader>.", "<cmd>lua vim.diagnostic.jump({count=1, float=false})<cr>", opts)
			-- vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			-- vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#81a1c1" })
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
			-- lspconfig.lua_ls.setup({
			vim.lsp.enable("lua_ls")
			-- vim.lsp.config.lua_ls.setup()
			-- configure html server
			vim.lsp.enable("html")

			-- lspconfig["html"].setup()
			-- configure typescript server with plugin
			vim.lsp.enable("ts_ls")

			-- lspconfig["ts_ls"].setup()
			-- configure css server
			-- lspconfig["cssls"].setup({
			-- 	capabilities = capabilities,
			-- })
			vim.lsp.enable("cssls")
			vim.lsp.enable("gopls")

			-- lspconfig["gopls"].setup()
			-- configure emmet language server
			vim.lsp.enable("emmet_ls")

			-- lspconfig["emmet_ls"].setup()
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
