return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	-- branch = '0.1.x',
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- Two important keymaps to use while in Telescope are:
		--
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		require("telescope").setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				path_display = { "truncate" },

				sorting_strategy = "Recent",
				layout_config = {
					prompt_position = "top",
				},
			},
			mappings = {
				i = {
					["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
					["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
					["<C-l>"] = require("telescope.actions").select_default, -- open file
				},
			},
			pickers = {
				find_files = {
					file_ignore_patterns = { "node_modules", "%.git", "%.venv" },
					hidden = true,
				},
				live_grep = {
					file_ignore_patterns = { "node_modules", "%.git", "%.venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		local function ivy(opts)
			return themes.get_ivy(vim.tbl_extend("force", {
				winblend = 0,
			}, opts or {}))
		end

		local function dropdown(opts)
			return themes.get_dropdown(vim.tbl_extend("force", {
				previewer = false,
			}, opts or {}))
		end
		-- 📂 FILES (dropdown)
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files(dropdown())
		end, { desc = "[F]ind [F]iles" })

		-- Find files in current buffer directory (without file browser extension)
		vim.keymap.set("n", "<leader>fF", function()
			local cwd = vim.fn.expand("%:p:h")
			builtin.find_files(dropdown({ cwd = cwd }))
		end, { desc = "[F] Files (cwd)" })

		vim.keymap.set("n", "<leader>f.", function()
			builtin.oldfiles(dropdown())
		end, { desc = "Recent Files" })

		vim.keymap.set("n", "<leader><leader>", function()
			builtin.buffers(dropdown({
				previewer = true,
				sort_mru = true,
				ignore_current_buffer = false,
			}))
		end, { desc = "Buffers" })

		vim.keymap.set("n", "<leader>fc", function()
			builtin.find_files(dropdown({
				cwd = vim.fn.stdpath("config"),
			}))
		end, { desc = "Config Files" })

		-- 🔍 SEARCH (ivy)
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep(ivy({ previewer = true }))
		end, { desc = "[F]ind by [G]rep" })

		vim.keymap.set("n", "<leader>fw", function()
			builtin.grep_string(ivy())
		end, { desc = "Find Word" })

		vim.keymap.set("n", "<leader>fd", function()
			builtin.diagnostics(ivy({ previewer = true }))
		end, { desc = "Diagnostics" })

		vim.keymap.set("n", "<leader>fh", function()
			builtin.help_tags(ivy())
		end, { desc = "Help" })

		vim.keymap.set("n", "<leader>fk", function()
			builtin.keymaps(ivy())
		end, { desc = "Keymaps" })

		vim.keymap.set("n", "<leader>fs", function()
			builtin.builtin(ivy())
		end, { desc = "Telescope" })

		vim.keymap.set("n", "<leader>fr", function()
			builtin.resume(ivy())
		end, { desc = "Resume" })

		-- 🔎 SPECIAL
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(ivy({
				previewer = false,
			}))
		end, { desc = "Search in buffer" })

		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep(ivy({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			}))
		end, { desc = "Search open files" })
	end,
}
