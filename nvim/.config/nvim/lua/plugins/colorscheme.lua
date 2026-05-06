return {

	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd([[colorscheme tokyonight]])

		local bg_transparent = true

		local toggle_transparency = function()
			bg_transparent = not bg_transparent

			require("tokyonight").setup({
				transparent = bg_transparent,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})

			vim.cmd("colorscheme tokyonight")
		end

		vim.keymap.set(
			"n",
			"<leader>tb",
			toggle_transparency,
			{ noremap = true, silent = false, desc = "[T]oggle transparent Background" }
		)
	end,
}
