-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		-- Add a custom format function to show error codes
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = false,
	update_in_insert = true,
	float = {
		source = "if_many", -- Or "if_many"
	},
	-- Make diagnostic background transparent
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- vim.cmd([[
-- autocmd BufNewFile, BufRead *.go colorscheme gitgo
-- ]])

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true)
vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
-- snippet para js para console log activar con ql
vim.api.nvim_create_autocmd("FileType", {
	group = "JSLogMacro",
	pattern = { "javascript", "typescript" },
	callback = function()
		vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:', " .. esc .. "pa)" .. esc)
	end,
})
vim.cmd([[
		autocmd BufRead,BufNewFile *.templ setfiletype html
		]])
-- _G.shift_k_enabled = false
vim.api.nvim_create_augroup("LspGroup", {})

vim.api.nvim_create_autocmd("CursorHold", {
	group = "LspGroup",
	callback = function()
		-- if not _G.shift_k_enabled then
		vim.diagnostic.open_float(nil, {
			scope = "cursor",
			focusable = false,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
			},
		})
	end,
	-- end,
	desc = "Show diagnostic error info on CursorHold",
})
-- vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
-- 	callback = function()
-- 		_G.shift_k_enabled = false
-- 	end,
-- })
-- function _G.show_docs()
-- 	_G.shift_k_enabled = true
-- 	vim.api.nvim_command("doautocmd CursorMovedI") -- Run autocmd to close diagnostic window if already open
--
-- 	local cw = vim.fn.expand("<cword>")
-- 	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
-- 		vim.api.nvim_command("h " .. cw)
-- 	else
-- 		vim.lsp.buf.hover() -- use if you want to use builtin LSP hover
-- 		-- vim.api.nvim_command("Lspsaga hover_doc")
-- 	end
-- end
--
-- vim.keymap.set("n", "K", _G.show_docs, { noremap = true, silent = true })

-- vim.g.vimwiki_list = { {
-- 	path = "~/wiki",
-- 	syntax = "markdown",
-- 	ext = "md",
-- 	diary_rel_path = "Notes",
-- } }
-- vim.g.vimwiki_auto_header = 1
