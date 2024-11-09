local wk = require("which-key")

wk.add({
	{
		mode = { "n", "v" },
		-- neo-tree.nvim: view left file explorer tree
		{
			"<leader>n",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
			end,
			desc = "Switch Neo Tree",
		},
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({ source = "buffers", toggle = true })
			end,
			desc = "Switch Buffers",
		},

		-- telescope.nvim
		{ "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find Files" },
		-- NOTE: should install https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
		{ "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Grep Word" },
		{ "<leader>rs", "<cmd> Telescope resume <CR>", desc = "Resume Search" },
		{ "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Old Files" },
		{ "<leader>gs", "<CMD> Telescope git_status <CR>", desc = "Git Status" },

		-- bufferline.nvim mappings
		{ "<leader>bp", "<cmd> BufferLineTogglePin <CR>", desc = "Pin" },
		{ "<leader>bo", "<cmd> BufferLineCloseOthers <CR>", desc = "Close Others" },
		{ "<leader>br", "<cmd> BufferLineCloseRight <CR>", desc = "Close Right" },
		{ "<leader>bl", "<cmd> BufferLineCloseLeft <CR>", desc = "Close Left" },
		{ "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>", desc = "Tab Prev" },
		{ "<Tab>", "<cmd> BufferLineCycleNext <CR>", desc = "Tab Next" },
		{ "<C-q>", "<cmd> bd <CR>", desc = "Tab Close" },

		-- conform.nvim: format files
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format",
		},
		-- persistence.nvim
		-- restore session
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Quick Session",
		},
		-- select session
		{
			"<leader>sl",
			function()
				require("persistence").select()
			end,
			desc = "Session Select",
		},
		-- restore last session
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Quick Last Session",
		},
		-- stop
		{
			"<leader>ss",
			function()
				require("persistence").stop()
			end,
			desc = "Stop Record Session",
		},
	},
})
