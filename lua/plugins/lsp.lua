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
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
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
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
				capabilities = capabilities,
			})
			-- configure html server
			lspconfig["html"].setup({
				capabilities = capabilities,
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
			})
			-- configure emmet language server
			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
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
