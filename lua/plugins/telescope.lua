return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						filesize_limit = 0.1,
						mime_hook = function(filepath, bufnr, opts)
							local is_image = function(filepath)
								local image_extensions = { "png", "jpg" } -- Supported image formats
								local split_path = vim.split(filepath:lower(), ".", { plain = true })
								local extension = split_path[#split_path]
								return vim.tbl_contains(image_extensions, extension)
							end
							if is_image(filepath) then
								local term = vim.api.nvim_open_term(bufnr, {})
								local function send_output(_, data, _)
									for _, d in ipairs(data) do
										vim.api.nvim_chan_send(term, d .. "\r\n")
									end
								end
								vim.fn.jobstart({
									"catimg",
									filepath, -- Terminal image viewer command
								}, { on_stdout = send_output, stdout_buffered = true, pty = true })
							else
								require("telescope.previewers.utils").set_preview_message(
									bufnr,
									opts.winid,
									"Binary cannot be previewed"
								)
							end
						end,
					},
				},
				pickers = {
					find_files = {
						-- theme = "cursor",
					},
				},
				extensions = {
					fzf = {},
				},
			})

			require("telescope").load_extension("fzf")

			-- vim.keymap.set("n", "ff", require("telescope.builtin").find_files, {})
			vim.keymap.set("n", "fo", require("telescope.builtin").oldfiles, {})
			vim.keymap.set("n", "fg", require("telescope.builtin").live_grep, {})
			vim.keymap.set("n", "ft", require("telescope.builtin").help_tags, {})
			vim.keymap.set("n", "fk", require("telescope.builtin").keymaps, {})
			vim.keymap.set("n", "fs", require("telescope.builtin").colorscheme, {})
			vim.keymap.set("n", "fv", function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)
		end,
	},
}
