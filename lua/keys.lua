if vim.g.vscode then
	-- https://github.com/vscode-neovim/vscode-multi-cursor.nvim?tab=readme-ov-file
	local map = vim.keymap.set
	local cursors = require("vscode-multi-cursor")
	-- directly use map instead of which-key in vscode to avoid load too muich plugins in vscode
	map("n", "<C-l>", "viwmc*<Cmd>nohl<CR>", { remap = true, desc = "Select Next Word" })
	map({ "n", "x", "v" }, "mc", cursors.create_cursor, { expr = true, desc = "Create cursor" })
	map({ "n", "x", "v" }, "mi", cursors.start_left, { desc = "Start cursors on the left" })
	map({ "n", "x", "v" }, "mI", cursors.start_left_edge, { desc = "Start cursors on the left edge" })
	map({ "n", "x", "v" }, "ma", cursors.start_right, { desc = "Start cursors on the right" })
	map({ "n", "x", "v" }, "mA", cursors.start_right, { desc = "Start cursors on the right" })
	map({ "n" }, "cc", cursors.cancel, { desc = "Cancel/Clear all cursors" })
	map({ "n" }, "mv", cursors.prev_cursor, { desc = "Goto prev cursor" })
	map({ "n" }, "mn", cursors.next_cursor, { desc = "Goto next cursor" })
	-- wk.add({
	-- 	{
	-- 		mode = { "n", "x", "v" },
	-- 		{ "mc", cursors.create_cursor, { expr = true, desc = "Create cursor" } },
	-- 		-- operators like I/A, it worked after multicursor select anything
	-- 		{ "mi", cursors.start_left, { desc = "Start cursors on the left" } },
	-- 		{ "mI", cursors.start_left_edge, { desc = "Start cursors on the left edge" } },
	-- 		{ "ma", cursors.start_right, { desc = "Start cursors on the right" } },
	-- 		{ "mA", cursors.start_right, { desc = "Start cursors on the right" } },
	-- 	},
	-- 	{
	-- 		mode = { "n" },
	-- 		{ "cc", cursors.cancel, { desc = "Cancel/Clear all cursors" } },
	-- 		{ "mv", cursors.prev_cursor, { desc = "Goto prev cursor" } },
	-- 		{ "mn", cursors.next_cursor, { desc = "Goto next cursor" } },
	-- 		-- this one is not working
	-- 		-- { "<C-l>", "viwmc*<cmd>nohl<CR>", { remap = true } },
	-- 		-- keep it but I don't need flash right now
	-- 		-- { "mcs", cursors.flash_char, { desc = "Create cursor using flash" } },
	-- 		-- { "mcw", cursors.flash_word, { desc = "Create selection using flash" } },
	-- 	},
	-- })
else
	local wk = require("which-key")
	local neo_tree_command = require("neo-tree.command")
	local conform = require("conform")
	-- local persistence = require("persistence")
	wk.add({
		{
			mode = { "n", "v" },
			-- neo-tree.nvim: view left file explorer tree
			{
				"<C-n>",
				function()
					neo_tree_command.execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Switch Neo Tree",
			},

			-- telescope.nvim
			{ "<C-p>", "<cmd> Telescope find_files <CR>", desc = "Find Files" },
			-- NOTE: should install https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
			{ "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Grep Word" },
			{ "<leader>rs", "<cmd> Telescope resume <CR>", desc = "Resume Search" },
			{ "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Old Files" },
			{ "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Buffers List" },
			{ "<leader>gs", "<cmd> Telescope git_status <CR>", desc = "Git Status" },

			-- bufferline.nvim mappings
			-- Alt is main key
			{ "<leader>bp", "<cmd> BufferLineTogglePin <CR>", desc = "Pin" },
			{ "<leader>bo", "<cmd> BufferLineCloseOthers <CR>", desc = "Close Others" },
			{ "<leader>br", "<cmd> BufferLineCloseRight <CR>", desc = "Close Right" },
			{ "<leader>bl", "<cmd> BufferLineCloseLeft <CR>", desc = "Close Left" },
			{ "<A-o>", "<cmd> BufferLineCyclePrev <CR>", desc = "Tab Prev" },
			{ "<A-i>", "<cmd> BufferLineCycleNext <CR>", desc = "Tab Next" },
			{ "<A-q>", "<cmd> bd <CR>", desc = "Tab Close" },
			{ "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Goto Buffer 1" },
			{ "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Goto Buffer 2" },
			{ "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Goto Buffer 3" },
			{ "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Goto Buffer 4" },
			{ "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Goto Buffer 5" },
			{ "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Goto Buffer 6" },
			{ "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Goto Buffer 7" },
			{ "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Goto Buffer 8" },
			{ "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Goto Buffer 9" },

			-- conform.nvim: format files
			{
				-- Shift-Alt-f
				"<S-A-f>",
				function()
					conform.format({ async = true })
				end,
				desc = "Format",
			},
			-- persisted.nvim
			{ "<leader>fs", "<cmd> Telescope persisted <CR>", desc = "Find Session" },
			{ "<leader>ss", "<cmd> SessionSave <CR>", desc = "Save Session" },
			{ "<leader>sl", "<cmd> SessionLoad <CR>", desc = "Session Load" },
			{ "<leader>sd", "<cmd> SessionDelete <CR>", desc = "Session Delete" },
		},
	})
end
