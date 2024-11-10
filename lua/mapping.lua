-- DEPRECATED
-- mappings are deprecated due to it's design to be loaded before plugins
-- but some keys require plugins, so use 'keys.lua' instead of it
-- keep it just incase I will need mapping some days

local map = vim.keymap.set

-- neo-tree.nvim: view left file explorer tree
map("n", "<leader>n", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Switch Neo Tree" })

map("n", "<leader>be", function()
	require("neo-tree.command").execute({ source = "buffers", toggle = true })
end, { desc = "Switch Buffers" })

-- telescope.nvim
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
-- NOTE: should install https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>rs", "<cmd> Telescope resume <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>gs", "<CMD> Telescope git_status <CR>")

-- bufferline.nvim mappings
map("n", "<leader>bp", "<cmd> BufferLineTogglePin <CR>", { desc = "Pin Tab" })
map("n", "<leader>bP", "<cmd> BufferLineGroupClose ungrouped <CR>")
map("n", "<leader>bo", "<cmd> BufferLineCloseOthers <CR>")
map("n", "<leader>br", "<cmd> BufferLineCloseRight <CR>")
map("n", "<leader>bl", "<cmd> BufferLineCloseLeft <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<C-q>", "<cmd> bd <CR>", { desc = "Close Tab" })

-- conform.nvim: format files
map("n", "<leader>fm", function()
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

-- mappings ref
--[[
Mode           | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang | ~
Command        +------+-----+-----+-----+-----+-----+------+------+ ~
[nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
[nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |

Modes
normal_mode = "n",
insert_mode = "i",
visual_mode = "v",
visual_block_mode = "x",
term_mode = "t",
command_mode = "c",
]]
