-- Easily comment visual regions/lines
return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = {},
	config = function()
		local opts = { noremap = true, silent = true }
		require("Comment").setup({
			enable_autocmd = false,
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
		-- vim.keymap.set('n', '<C-_>', require('Comment.api').toggle.linewise.current, opts)
		vim.keymap.set("n", "<C-f>", require("Comment.api").toggle.linewise.current, opts)
		-- vim.keymap.set('n', '<C-/>', require('Comment.api').toggle.linewise.current, opts)
		-- vim.keymap.set('v', '<C-_>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
		vim.keymap.set(
			"v",
			"<C-f>",
			"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			opts
		)
		-- vim.keymap.set('v', '<C-/>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
	end,
}
