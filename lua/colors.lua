---@class palette
---@field rosewater string
---@field flamingo string
---@field mauve string
---@field pink string
---@field red string
---@field maroon string
---@field peach string
---@field yellow string
---@field green string
---@field sapphire string
---@field blue string
---@field sky string
---@field teal string
---@field lavender string
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field none "NONE"

local palette = vim.g.colors_name:find("catppuccin") and require("catppuccin.palettes").get_palette()
	or {
		rosewater = "#DC8A78",
		flamingo = "#DD7878",
		mauve = "#CBA6F7",
		pink = "#F5C2E7",
		red = "#E95678",
		maroon = "#B33076",
		peach = "#FF8700",
		yellow = "#F7BB3B",
		green = "#AFD700",
		sapphire = "#36D0E0",
		blue = "#61AFEF",
		sky = "#04A5E5",
		teal = "#B5E8E0",
		lavender = "#7287FD",

		text = "#F2F2BF",
		subtext1 = "#BAC2DE",
		subtext0 = "#A6ADC8",
		overlay2 = "#C3BAC6",
		overlay1 = "#988BA2",
		overlay0 = "#6E6B6B",
		surface2 = "#6E6C7E",
		surface1 = "#575268",
		surface0 = "#302D41",

		base = "#1D1536",
		mantle = "#1C1C19",
		crust = "#161320",
	}
palette = vim.tbl_extend("force", { none = "NONE" }, palette, require("core.settings").palette_overwrite)

return palette
