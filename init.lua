local file = vim.api.nvim_buf_get_name(0) -- 获取当前缓冲区文件名
local file_size = vim.loop.fs_stat(file) and vim.loop.fs_stat(file).size or 0 -- 获取文件大小

local max_allow_size = 300000 -- 300k

-- global options (vim option) for both vs-code & neovim
require("options")
-- lazy init
local lazy_init = require("lazy_init")
lazy_init:lazy_load()

-- init plugin & conf by lazy
-- NOTE: setup("plugins") cause auto-load lua/plugins/*.lua files
require("lazy").setup("plugins", lazy_init:lazy_conf())
require("keys")

local function handle_large_size_file()
	-- 对太大的文件，减少动作，避免卡死，此类文件一般是纯日志
	-- 检查当前缓冲区文件大小并根据情况调整设置
	if file_size > max_allow_size then
		-- disable all settings below
		vim.cmd("syntax off") -- 关闭语法高亮
		vim.cmd("filetype off") -- 关闭文件类型检测
		vim.opt.swapfile = false -- 禁用 swap 文件
		vim.opt.lazyredraw = true -- 减少重绘
		vim.cmd("au! BufReadPre *") -- 禁用所有自动命令

		vim.g.loaded_gopls = 1 -- 禁用 Go LSP
		vim.g.loaded_lua_ls = 1 -- 禁用 Lua LSP
		vim.g.loaded_telescope = 1 -- 禁用 telescope
		vim.g.mason_enabled = false
		vim.cmd.colorscheme("default") -- default colorscheme

		print("Large file detected: Performance optimizations applied.")
	end
end

vim.api.nvim_create_augroup("numbertoggle", { clear = true })
if vim.g.vscode then
	-- extension for vscode
	vim.g.clipboard = vim.g.vscode_clipboard
	local vscode = require("vscode")
	-- smart line number in vscode
	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		group = "numbertoggle",
		callback = function()
			vscode.update_config("editor.lineNumbers", "on")
		end,
	})
	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		group = "numbertoggle",
		callback = function()
			vscode.update_config("editor.lineNumbers", "relative")
		end,
	})
else
	-- extension for neovim
	vim.o.clipboard = "unnamedplus"
	vim.o.cursorline = true
	vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })

	-- smart line number
	-- when in I mode, show abosolute line number
	-- when in N+V mode, show relative number
	vim.wo.number = true
	vim.wo.relativenumber = true
	vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
		group = "numbertoggle",
		callback = function()
			if vim.wo.number and vim.fn.mode() ~= "i" then
				vim.wo.relativenumber = true
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
		group = "numbertoggle",
		callback = function()
			if vim.wo.number then
				vim.wo.relativenumber = false
			end
		end,
	})
	-- colorscheme for neovim
	local themes = { "visual_studio_code", "catppuccin" }
	local date = os.date("*t")
	local day = date.day
	local index = day % #themes
	-- pick themes by date%len
	vim.cmd("colorscheme " .. themes[index + 1]) -- Lua start index from 1
end

-- 自动触发处理函数
vim.api.nvim_create_autocmd("BufReadPre", {
	callback = handle_large_size_file,
	desc = "Optimize settings for large files",
})
