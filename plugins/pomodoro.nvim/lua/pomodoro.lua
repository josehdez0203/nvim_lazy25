local M = {
	task = nil,
	start = nil,
	_end = nil,
	cycles = 0,
	type = "running",
	opts = {
		running = 25,
		shortPause = 5,
		longPause = 15,
		icons = {
			running = "",
			shortPause = "",
			longPause = "",
		},
	},
}

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts)

	vim.api.nvim_create_user_command("PMCreate", M.create, {})

	-- vim.api.nvim_create_user_command("PMStop", M.create, {})
	-- vim.api.nvim_create_user_command("PMResume", M.create, {})
end

function M.hasTask()
	return M.task ~= nil
end

function M.getStatus()
	if not M.task then
		return "No task running"
	end

	-- check if the timer ends
	if os.time() > M._end then
		if M.type == "running" then
			if M.cycles >= 3 then
				M.type = "longPause"
				M._end = os.time() + M.opts.longPause * 60
				M.cycles = 0
				M.showInfo(vim.log.levels.ERROR, "Descanzo largo")
			else
				M.type = "shortPause"
				M._end = os.time() + M.opts.shortPause * 60
				M.cycles = M.cycles + 1
				M.showInfo(vim.log.levels.WARN, "Descanzo corto")
			end
		else
			M.type = "running"
			M.start = os.time()
			M._end = M.start + M.opts.running * 60
			M.showInfo(vim.log.levels.INFO, "Pomodoro" + M.cycles)
		end
	end

	return string.format(
		"%s %.2d:%.2d %s",
		M.opts.icons[M.type],
		math.floor((M._end - os.time()) / 60),
		(M._end - os.time()) % 60,
		M.task
	)
end

function M.create()
	vim.ui.input({ prompt = "Name The task:" }, function(input)
		if not input then
			return
		end
		M.task = input
		M.start = os.time()
		M._end = M.start + M.opts.running * 60
		M.cycles = 0
	end)
end

function M.showInfo(infoLevel, msg)
	vim.notify(msg, infoLevel, { title = "Pomodoro: " + M.task })
end

function M.currentTaskinfo()
	if not M.task then
		vim.notify("No task running", vim.log.levels.WARN, { title = "Pomodoro" })
		return
	end

	vim.notify(
		string.format(
			[[
Task: %s
Status: %s
Start: %s
End: %s
Cycles: %d
]],
			M.task,
			M.type,
			os.date("%H:%M", M.start),
			os.date("%H:%M", M._end),
			M.cycles
		),
		vim.log.levels.INFO,
		{ title = "Pomodoro: <<" + M.task + ">>" }
	)
end

return M
