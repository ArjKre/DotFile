-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Appearance of diagnostics
vim.diagnostic.config {
	-- virtual_lines = {
	-- 	current_line = true
	-- },
  virtual_text = {
    prefix = '●',
    -- Add a custom format function to show error codes
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true, -- Or "if_many"
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
    },
  },
  -- Make diagnostic background transparent
  on_ready = function()
    vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}

-- vim.api.nvim_create_augroup("TransparentBackground", { clear = true })
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	group = "TransparentBackground",
-- 	callback = function()
-- 		vim.cmd("highlight Normal guibg=none ctermbg=none")
-- 		vim.cmd("highlight NonText guibg=none ctermbg=none")
-- 	end,
-- })
