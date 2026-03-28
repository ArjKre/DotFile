return {
	{
		"polirritmico/dashboard-nvim", -- nvimdev
		dependencies = {
			{
				"folke/persistence.nvim",
				opts = {},
				-- add any custom options here
			},
		},
		cmd = "Dashboard",
		lazy = false,
		opts = function()
			local opts = {
				theme = "doom",
				hide = {
					statusline = false, -- handled by Lualine itself
				},
				config = {
					vertical_center = true,
					header = {
						"",
						[[Neovim :: A R J K R E]],
						[[🄯 2026]],
						"",
						"",
					},
					center = {
						{
							action = "ene | startinsert",
							desc = " New file",
							icon = " ",
							key = "n",
						},
						{
							action = "Telescope find_files",
							desc = " Find file",
							icon = " ",
							key = "ff",
						},
						{
							action = "Telescope oldfiles",
							desc = " Recent files",
							icon = " ",
							key = "fr",
						},
						{
							action = "<cmd>Telescope live_grep<CR>",
							desc = "Find Text",
							icon = "  ",
							key = "fw",
						},
						{
							action = function()
								require("persistence").load()
							end,
							desc = " Restore Session",
							icon = " ",
							key = "ss",
						},
						-- {
						-- 	action = "lua require('osv').launch({ port = 8086 })",
						-- 	desc = " Debug session",
						-- 	icon = "󰖷 ",
						-- 	key = "<F10>",
						-- },
						{
							action = "Telescope find_files cwd=~/.config/nvim",
							desc = " Config",
							icon = " ",
							key = "cc",
						},
						{
							action = "Lazy",
							desc = " Lazy",
							icon = "󰒲 ",
							key = "cl",
						},
						{ action = "qa", desc = "Quit", icon = " ", key = "q" },
					},
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            -- stylua: ignore
            return { "⚡ Neovim loaded "..stats.loaded.."/"..stats.count.." plugins in "..ms.."ms" }
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			return opts
		end,
	},

	-- {
	-- 	"goolord/alpha-nvim",
	-- 	config = function()
	-- 		local alpha = require("alpha")
	-- 		local dashboard = require("alpha.themes.dashboard")
	-- 		local tb = require("telescope.builtin")
	--
	-- 		local function read_ascii(path)
	-- 			local lines = {}
	-- 			for line in io.lines(path) do
	-- 				table.insert(lines, line)
	-- 			end
	-- 			return lines
	-- 		end
	--
	-- 		dashboard.section.header.val = read_ascii(vim.fn.stdpath("config") .. "/ascii/header.txt")
	--
	-- 		dashboard.section.buttons.val = {
	-- 			dashboard.button("f", "  Find File", function()
	-- 				tb.find_files()
	-- 			end),
	-- 			dashboard.button("n", "  New File", ":ene | startinsert<CR>"),
	-- 			dashboard.button("g", "  Find Text", function()
	-- 				tb.live_grep()
	-- 			end),
	-- 			dashboard.button("r", "  Recent Files", function()
	-- 				tb.oldfiles()
	-- 			end),
	--
	-- 			dashboard.button("c", "  Config", function()
	-- 				tb.find_files({ cwd = vim.fn.stdpath("config") })
	-- 			end),
	--
	-- 			dashboard.button("s", "  Restore Session", "<cmd>SessionRestore<CR>"),
	-- 			dashboard.button("x", "  Lazy Extras", "<cmd>LazyExtras<CR>"),
	-- 			dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
	-- 			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
	-- 		}
	--
	-- 		dashboard.section.footer.val =
	-- 			function()
	-- 				local stats = require("lazy").stats()
	-- 				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
	--            -- stylua: ignore
	--            return { "⚡ Neovim loaded "..stats.loaded.."/"..stats.count.." plugins in "..ms.."ms" }
	-- 			end, alpha.setup(dashboard.opts)
	-- 	end,
	-- },
}
