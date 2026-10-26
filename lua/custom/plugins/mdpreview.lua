-- Preview for Markdown files
vim.pack.add { 'https://github.com/henriklovhaug/Preview.nvim' }

require('preview').setup()

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	callback = function(event)
		vim.keymap.set('n', '<leader>mp', '<cmd>Preview<CR>', {
			buffer = event.buf,
			desc = 'Preview Markdown',
		})
	end,
})
