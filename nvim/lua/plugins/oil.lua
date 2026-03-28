return {
	"stevearc/oil.nvim",
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			use_default_keymaps = false,
			default_file_explorer = true,
			view_options = { show_hidden = true },
			preview = {
				enabled = true,
				floating = false,
			},
			preview_win = {
				win_options = {
					wrap = true,
				},
			},

			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				-- ["<leader>s"] = { "actions.select", opts = { vertical = true } },
				-- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
				-- ["<leader>/"] = "actions.toggle_hidden",
				--
				["<leader>s"] = {
					function()
						local oil = require("oil")

						-- Get list of normal buffers (not Oil, help, etc.)
						local normal_buffers = vim.tbl_filter(function(buf)
							return vim.api.nvim_buf_is_valid(buf)
								and vim.bo[buf].buflisted
								and vim.bo[buf].buftype == ""
								and not vim.startswith(vim.api.nvim_buf_get_name(buf), "oil://")
						end, vim.api.nvim_list_bufs())

						if #normal_buffers == 0 then
							vim.notify("No buffer to split into", vim.log.levels.WARN)
							return
						end

						oil.select({ vertical = true, close = true })
						-- vim.notify("Hello from Oil!", vim.log.levels.INFO)
					end,
					desc = "Open in VERTICAL split (if buffer exists)",
				},

				["<leader>h"] = {
					function()
						local oil = require("oil")

						-- Get list of normal buffers (not Oil, help, etc.)
						local normal_buffers = vim.tbl_filter(function(buf)
							return vim.api.nvim_buf_is_valid(buf)
								and vim.bo[buf].buflisted
								and vim.bo[buf].buftype == ""
								and not vim.startswith(vim.api.nvim_buf_get_name(buf), "oil://")
						end, vim.api.nvim_list_bufs())

						if #normal_buffers == 0 then
							vim.notify("No buffer to split into", vim.log.levels.WARN)
							return
						end

						oil.select({ horizontal = true, close = true })
						-- vim.notify("Hello from Oil!", vim.log.levels.INFO)
					end,
					desc = "Open in HORIZONTAL split (if buffer exists)",
				},
			},
			-- keymaps = {
			-- Add preview scroll keymaps directly in Oil's setup
			-- ["<C-j>"] = "actions.preview_scroll_down",
			-- ["<C-k>"] = "actions.preview_scroll_up",

			-- ["<leader>s"] = {
			-- 	function()
			-- 		local oil = require("oil")
			--
			-- 		-- Get list of normal buffers (not Oil, help, etc.)
			-- 		local normal_buffers = vim.tbl_filter(function(buf)
			-- 			return vim.api.nvim_buf_is_valid(buf)
			-- 				and vim.bo[buf].buflisted
			-- 				and vim.bo[buf].buftype == ""
			-- 				and not vim.startswith(vim.api.nvim_buf_get_name(buf), "oil://")
			-- 		end, vim.api.nvim_list_bufs())
			--
			-- 		if #normal_buffers == 0 then
			-- 			vim.notify("No buffer to split into", vim.log.levels.WARN)
			-- 			return
			-- 		end
			--
			-- 		oil.select({ vertical = true, close = true })
			-- 		-- vim.notify("Hello from Oil!", vim.log.levels.INFO)
			-- 	end,
			-- 	desc = "Open in VERTICAL split (if buffer exists)",
			-- },
			--
			-- ["<leader>h"] = {
			-- 	function()
			-- 		local oil = require("oil")
			--
			-- 		-- Get list of normal buffers (not Oil, help, etc.)
			-- 		local normal_buffers = vim.tbl_filter(function(buf)
			-- 			return vim.api.nvim_buf_is_valid(buf)
			-- 				and vim.bo[buf].buflisted
			-- 				and vim.bo[buf].buftype == ""
			-- 				and not vim.startswith(vim.api.nvim_buf_get_name(buf), "oil://")
			-- 		end, vim.api.nvim_list_bufs())
			--
			-- 		if #normal_buffers == 0 then
			-- 			vim.notify("No buffer to split into", vim.log.levels.WARN)
			-- 			return
			-- 		end
			--
			-- 		oil.select({ horizontal = true, close = true })
			-- 		-- vim.notify("Hello from Oil!", vim.log.levels.INFO)
			-- 	end,
			-- 	desc = "Open in HORIZONTAL split (if buffer exists)",
			-- },
			-- },
		})
		--
		-- auto opens preview when oil is opened
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "oil://*",
			once = true,
			callback = function()
				local ok, oil = pcall(require, "oil")
				if ok then
					vim.wait(500, function()
						return oil.get_cursor_entry() ~= nil
					end)
					if oil.get_cursor_entry() then
						oil.open_preview()
					end
				end
			end,
		})

		vim.keymap.set("n", "<leader><C-e>", function()
			local oil = require("oil")
			local root = vim.fn.getcwd()
			oil.open(root)
		end, { desc = "File Explorer (cwd)" })

		vim.keymap.set("n", "<C-e>", "<CMD>Oil<CR>", { desc = "Open File Explorer" })
	end,
}
