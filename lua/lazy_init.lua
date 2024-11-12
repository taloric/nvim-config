-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

-- use a struct to do lazy_load & lazy_conf
LazyInit = {}

-- directly copy from folke/lazy.nvim
function LazyInit:lazy_load()
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--branch=stable",
			lazyrepo,
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

-- lazy_config
-- https://lazy.folke.io/configuration
function LazyInit:lazy_conf()
	return {
		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		-- install = { colorscheme = { "habamax" } },
		-- git = { url_format = "git@github.com:%s.git" },
		-- automatically check for plugin updates
		checker = { enabled = false },
	}
end

return LazyInit
