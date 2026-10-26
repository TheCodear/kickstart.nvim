-- Vim Fugitive Git integration plugin
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

local map = vim.keymap.set

map('n', '<leader>gg', '<cmd>Git<CR', { desc = "Git status" })
map('n', '<leader>gb', '<cmd>Git blame<CR', { desc = "Git blame" })
map('n', '<leader>gd', '<cmd>Gdiffsplit<CR', { desc = "Git diff current file" })
map('n', '<leader>gl', '<cmd>Git log<CR', { desc = "Git log" })
map('n', '<leader>gw', '<cmd>Gwrite<CR', { desc = "Git stage current file" })
map('n', '<leader>gp', '<cmd>Git push<CR', { desc = "Git push" })

-- some nice keymaps, when in Git status
--   s     | stage file or hunk
--   u     | unstage file or hunk
--   =     | toggle inline diff
--   dv    | open vertical diff
--   cc    | create commit
--   ca    | amend last commit
--   Enter | open file or commit
--   X     | discard changes
--   g?    | show all availabe fugitive mappings
