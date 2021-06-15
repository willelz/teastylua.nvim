local api = vim.api

local handle = io.popen("command -v stylua")
local out = handle:read("*a")
handle:close()

if out == "" then
	api.nvim_command('echoerr "Could not find stylua."')
	return
end

local function formatBuffer()
	local bufLines = api.nvim_buf_get_lines(0, 0, -1, 1)
	local bufLine = table.concat(bufLines, "\n")

	local command = ""
	if vim.g.teastylua_options then
		command = "stylua " .. vim.g.teastylua_options .. " -"
	else
		command = "stylua -"
	end

	local new = vim.fn.systemlist(command, bufLine)
	return vim.v.shell_error, new
end

function Teastylua()
	local winview = vim.fn.winsaveview()
	local errorCode, result = formatBuffer()

	if errorCode == 1 then
		print(vim.inspect(result))
		return
	end

	api.nvim_command("silent! execute 'lockmarks %delete _'")
	api.nvim_buf_set_lines(0, 0, 0, 0, result)

	vim.fn.winrestview(winview)
end

api.nvim_set_keymap("n", "<Plug>teastyluaFormat", "<cmd>call v:lua.Teastylua()<CR>", {})

