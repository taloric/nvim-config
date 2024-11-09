local map = vim.keymap.set

-- neo-tree.nvim: view left file explorer tree
map("n", "<C-n>", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end)
map("n", "<leader>be", function()
	require("neo-tree.command").execute({ source = "buffers", toggle = true })
end)

-- telescope.nvim
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
-- NOTE: should install https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>rs", "<cmd> Telescope resume <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>gs", "<CMD> Telescope git_status <CR>")

-- bufferline.nvim mappings
map("n", "<leader>bp", "<cmd> BufferLineTogglePin <CR>")
map("n", "<leader>bP", "<cmd> BufferLineGroupClose ungrouped <CR>")
map("n", "<leader>bo", "<cmd> BufferLineCloseOthers <CR>")
map("n", "<leader>br", "<cmd> BufferLineCloseRight <CR>")
map("n", "<leader>bl", "<cmd> BufferLineCloseLeft <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- conform.nvim: format files
map("n", "<leader>f", function()
	require("conform").format({ async = true })
end)

-- persistence.nvim
-- restore session
map("n", "<leader>qs", function()
	require("persistence").load()
end)
-- select session
map("n", "<leader>qS", function()
	require("persistence").select()
end)
-- restore last session
map("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end)
-- stop
map("n", "<leader>qd", function()
	require("persistence").stop()
end)
