local wk = require("which-key")
if vim.g.vscode then
	-- https://github.com/vscode-neovim/vscode-multi-cursor.nvim?tab=readme-ov-file
	local map = vim.keymap.set
	local cursors = require("vscode-multi-cursor")
	-- which key config was override by vscode (why??)
	-- but I like this mapping, so keep it and use vim.keymap to map it
	map("n", "<C-l>", "viwmc*<Cmd>nohl<CR>", { remap = true })
	-- keep it, incase it's also override by vscode some days T^T
	-- map({ "n", "x" }, "mc", cursors.create_cursor, { expr = true, desc = "Create cursor" })
	-- map({ "n" }, "mcc", cursors.cancel, { desc = "Cancel/Clear all cursors" })
	-- map({ "n", "x" }, "mi", cursors.start_left, { desc = "Start cursors on the left" })
	-- map({ "n", "x" }, "mI", cursors.start_left_edge, { desc = "Start cursors on the left edge" })
	-- map({ "n", "x" }, "ma", cursors.start_right, { desc = "Start cursors on the right" })
	-- map({ "n", "x" }, "mA", cursors.start_right, { desc = "Start cursors on the right" })
	-- map({ "n" }, "mv", cursors.prev_cursor, { desc = "Goto prev cursor" })
	-- map({ "n" }, "mn", cursors.next_cursor, { desc = "Goto next cursor" })
	wk.add({
		{
			mode = { "n", "x", "v" },
			{ "mc", cursors.create_cursor, { expr = true, desc = "Create cursor" } },
			-- operators like I/A, it worked after multicursor select anything
			{ "mi", cursors.start_left, { desc = "Start cursors on the left" } },
			{ "mI", cursors.start_left_edge, { desc = "Start cursors on the left edge" } },
			{ "ma", cursors.start_right, { desc = "Start cursors on the right" } },
			{ "mA", cursors.start_right, { desc = "Start cursors on the right" } },
		},
		{
			mode = { "n" },
			-- cancel cursor
			{ "cc", cursors.cancel, { desc = "Cancel/Clear all cursors" } },
			-- move prev
			{ "mv", cursors.prev_cursor, { desc = "Goto prev cursor" } },
			-- move next
			{ "mn", cursors.next_cursor, { desc = "Goto next cursor" } },
			-- not working T^T
			-- { "<C-l>", "viwmc*<cmd>nohl<CR>", { remap = true } },
			-- keep it but I don't need flash right now
			-- { "mcs", cursors.flash_char, { desc = "Create cursor using flash" } },
			-- { "mcw", cursors.flash_word, { desc = "Create selection using flash" } },
		},
	})
else
	local neo_tree_command = require("neo-tree.command")
	local conform = require("conform")
	local persistence = require("persistence")
	wk.add({
		{
			mode = { "n", "v" },
			-- neo-tree.nvim: view left file explorer tree
			{
				"<leader>n",
				function()
					neo_tree_command.execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Switch Neo Tree",
			},
			{
				"<leader>be",
				function()
					neo_tree_command.execute({ source = "buffers", toggle = true })
				end,
				desc = "Switch Buffers",
			},

			-- telescope.nvim
			{ "<C-p>", "<cmd> Telescope find_files <CR>", desc = "Find Files" },
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
			{ "<C-w>q", "<cmd> bd <CR>", desc = "Tab Close" },

			-- conform.nvim: format files
			{
				"<leader>fm",
				function()
					conform.format({ async = true })
				end,
				desc = "Format",
			},
			-- persistence.nvim
			-- restore session
			{
				"<leader>qs",
				function()
					persistence.load()
				end,
				desc = "Quick Session",
			},
			-- select session
			{
				"<leader>sl",
				function()
					persistence.select()
				end,
				desc = "Session Select",
			},
			-- restore last session
			{
				"<leader>ql",
				function()
					persistence.load({ last = true })
				end,
				desc = "Quick Last Session",
			},
			{
				"<leader>ss",
				function()
					persistence.stop()
				end,
				desc = "Stop Record Session",
			},
		},
	})
end
