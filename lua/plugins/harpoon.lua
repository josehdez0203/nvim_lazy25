return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED
		vim.keymap.set("n", "<c-m>", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "hj", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "hk", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "hl", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "h;", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
		-- vim.keymap.set("n", "<leader>a", function()
		-- 	harpoon:list():add()
		-- end)
		--
		-- vim.keymap.set("n", "<C-1>", function()
		-- 	harpoon:list():select(1)
		-- end)
		-- vim.keymap.set("n", "<C-2>", function()
		-- 	harpoon:list():select(2)
		-- end)
		-- vim.keymap.set("n", "<C-3>", function()
		-- 	harpoon:list():select(3)
		-- end)
		-- vim.keymap.set("n", "<C-4>", function()
		-- 	harpoon:list():select(4)
		-- end)

		-- Toggle previous & next buffers stored within Harpoon list
		-- vim.keymap.set("n", "<C-S-P>", function()
		-- 	harpoon:list():prev()
		-- end)
		-- vim.keymap.set("n", "<C-S-N>", function()
		-- 	harpoon:list():next()
		-- end)
		-- local function replace(index)
		-- 	local rel_path = vim.fn.expand("%")
		-- 	local length = harpoon:list():length()
		--
		-- 	if index <= length then
		-- 		local replaced = harpoon:list()["items"][index].value
		--
		-- 		for i, val in ipairs(harpoon:list()["items"]) do
		-- 			if val.value == rel_path then
		-- 				harpoon:list()["items"][i].value = replaced
		-- 				break
		-- 			end
		-- 		end
		--
		-- 		harpoon:list()["items"][index].value = rel_path
		-- 	else
		-- 		harpoon:list():add()
		-- 	end
		-- end
		-- --
		-- vim.keymap.set("n", "<C-e>", function()
		-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
		-- end)
		--
		-- local keys = { "j", "k", "l", ";" }
		--
		-- for i, key in ipairs(keys) do
		-- 	vim.keymap.set("n", "g" .. key, function()
		-- 		harpoon:list():select(i)
		-- 	end)
		-- 	vim.keymap.set("n", "m" .. key, function()
		-- 		replace(i)
		-- 	end)
		-- end
	end,
}
