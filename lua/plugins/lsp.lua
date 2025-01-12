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
		-- require = {
		-- 	"onsails/lspkind.nvim",
		-- },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			-- local navic = require("nvim-navic")
			-- navic.setup({ lsp = { auto_attach = true } })
			vim.keymap.set("n", "k", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			-- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references()<CR>", {})
			vim.keymap.set("n", "gr", function()
				local tel = require("telescope.builtin")
				tel.lsp_references()
			end)

			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<c-a>", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>i", "<cmd>LspInfo<CR>", {})
			vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader><", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "<leader>>", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "D", "<cmd>Telescope diagnostics bufnr=0<CR>", {})
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
				capabilities = capabilities,
				configurationSection = { "html", "css", "javascript" },
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = true,
			})
			-- configure typescript server with plugin
			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
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
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
					"gohtml",
				},
			})
			--Phpactor
			lspconfig["phpactor"].setup({
				capabilities = capabilities,
			})
		end,
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- },
}
