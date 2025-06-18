local M = {
	task = nil,
	start = nil,
	_end = nil,
	cycles = 0,
	type = "running",
	pomodoro = 0,
	minuto = 1000 * 60,
	tiempo_pausado = 0,
	opts = {
		running = 25,
		shortPause = 5,
		longPause = 15,
		timeOut = 5000,
		total = 4,
		icons = {
			detenido = "󰙦",
			running = "",
			shortPause = "",
			longPause = "",
		},
	},
}

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts)

	-- vim.api.nvim_create_user_command("PMCreate", M.create, {})

	vim.api.nvim_create_user_command("PMInfo", M.currentTaskinfo, {})
	vim.api.nvim_create_user_command("PMPopup", M.showPopupMenu, {})
	print(M.opts.timeOut)
end

function M.hasTask()
	return M.task ~= nil
end

function M.getStatus()
	if not M.task then
		return "No hay tarea"
	end

	-- check if the timer ends
	if M.tiempo_pausado > 0 then
		return string.format(
			"%s %.2d:%.2d %s",
			M.opts.icons["detenido"],
			math.floor(M.tiempo_pausado / 60),
			(M.tiempo_pausado % 60),
			M.task .. "(" .. M.pomodoro .. " " .. (M.cycles + 1) .. "/4)"
		)
	else
		if os.time() > M._end then
			if M.type == "running" then
				if M.cycles >= M.opts.total then
					M.type = "longPause"
					M._end = os.time() + M.opts.longPause * 60
					M.cycles = 0
					M.pomodoro = M.pomodoro + 1
					local tiempo = M.opts.longPause * M.minuto
					M.showInfo(vim.log.levels.ERROR, "Descanzo largo ", tiempo)
				else
					M.type = "shortPause"
					M._end = os.time() + M.opts.shortPause * 60
					local tiempo = M.opts.shortPause * M.minuto
					M.showInfo(vim.log.levels.WARN, "Descanzo corto ", tiempo)
				end
			else
				M.cycles = M.cycles + 1
				M.type = "running"
				M.start = os.time()
				M._end = M.start + M.opts.running * 60
				local tiempo = M.opts.running * M.minuto
				M.showInfo(vim.log.levels.INFO, "Reanudar: ", tiempo)
			end
		end
		return string.format(
			"%s %.2d:%.2d %s",
			M.opts.icons[M.type],
			math.floor((M._end - os.time()) / 60),
			(M._end - os.time()) % 60,
			M.task .. "(" .. M.pomodoro .. " " .. (M.cycles + 1) .. "/4)"
		)
	end
end

function M.create()
	vim.ui.input({ prompt = "Nombre de tarea:" }, function(input)
		if not input then
			return
		end
		M.task = input
		M.start = os.time()
		M._end = M.start + M.opts.running * 60
		M.cycles = 0
		M.showInfo(vim.log.levels.INFO, "Inicia Pomodoro")
	end)
end

function M.showInfo(infoLevel, msg, tiempo)
	local message = string.format(
		[[
	%s
	Ciclos: %d %d/%d
	]],
		M.task,
		M.pomodoro,
		M.cycles + 1,
		M.opts.total
	)
	vim.notify(message, infoLevel, { title = msg, timeout = tiempo })
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
			Cycles: %d, %d/%d
			]],
			M.task,
			M.type,
			os.date("%H:%M", M.start),
			os.date("%H:%M", M._end),
			M.pomodoro,
			M.cycles + 1,
			M.opts.total
		),
		vim.log.levels.INFO,
		{ title = "Pomodoro: [[ " .. string.format(M.task) .. "]]", timeout = 5000 }
	)
end
function M.showPopupMenu()
	local items = {
		"Nuevo",
		"Pausar/Continuar",
		"Iniciar Break",
		"Iniciar Trabajo",
	}
	local options = {
		prompt = "Seleccione una opción:",
		format = function(item)
			return item[1]
		end,
		stepper = "rounded",
		scrollable = true,
		select_only_one = false,
	}
	vim.ui.select(items, options, function(choice)
		if choice ~= nil then
			if choice == "Nuevo" then
				M.create()
			elseif choice == "Pausar/Continuar" then
				if M.type == "running" then
					if M.tiempo_pausado == 0 then
						-- Pausar
						M.tiempo_pausado = M._end - os.time() --tiempo faltante
						M.showInfo(vim.log.levels.WARN, "Pausa Pomodoro")
					else
						-- Reanudar
						M._end = os.time() + M.tiempo_pausado --reponemos tiempo faltante
						M.tiempo_pausado = 0
						M.showInfo(vim.log.levels.INFO, "Continua Pomodoro")
					end
				end
			elseif choice == "Iniciar Break" then
				if M.type == "running" then
					if M.cycles == M.opts.total then
						M.type = "longPause"
						M.start = os.time()
						M._end = M.start + M.opts.longPause * 60
						M.showInfo(vim.log.levels.INFO, "Se pausa Pomodoro")
					else
						M.type = "shortPause"
						M.start = os.time()
						M._end = M.start + M.opts.shortPause * 60
						M.showInfo(vim.log.levels.INFO, "Se pausa Pomodoro")
					end
				end
			elseif choice == "Iniciar Trabajo" then
				if M.type == "shortPause" or M.type == "longPause" then
					M.type = "running"
					M.start = os.time()
					M._end = M.start + M.opts.running * 60
					M.showInfo(vim.log.levels.INFO, "Se inicia Pomodoro")
				end
			else
				vim.notify("No se seleccionó", vim.log.levels.INFO)
			end
		else
		end
	end)
end

return M
