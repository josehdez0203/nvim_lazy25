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
local RemoveComments = function()
	local ts = vim.treesitter
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local lang = ts.language.get_lang(ft) or ft

	local ok, parser = pcall(ts.get_parser, bufnr, lang)
	if not ok then
		return vim.notify("No parser for " .. ft, vim.log.levels.WARN)
	end

	local tree = parser:parse()[1]
	local root = tree:root()
	local query = ts.query.parse(lang, "(comment) @comment")

	local ranges = {}
	for _, node in query:iter_captures(root, bufnr, 0, -1) do
		table.insert(ranges, { node:range() })
	end

	table.sort(ranges, function(a, b)
		if a[1] == b[1] then
			return a[2] < b[2]
		end
		return a[1] > b[1]
	end)

	for _, r in ipairs(ranges) do
		vim.api.nvim_buf_set_text(bufnr, r[1], r[2], r[3], r[4], {})
	end
end
vim.api.nvim_create_user_command("RemoveComments", RemoveComments, {})
