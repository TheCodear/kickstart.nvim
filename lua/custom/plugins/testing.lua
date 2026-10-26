-- Test integration
vim.pack.add({
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/fredrikaverpil/neotest-golang',
  'https://github.com/andythigpen/nvim-coverage',
})

-- setup
local neotest = require('neotest')
local coverage = require('coverage')

neotest.setup({
  adapters = {
    require('neotest-golang')({
      runner = 'gotestsum',
      go_test_args = {
        '-v',
        '-race',
        '-count=1'
      },
    }),
  },
  diagnostic = {
    enabled = true,
  },
  output = {
    enabled = true,
    open_on_run = 'short',
  },
  quickfix = {
    enabled = false
  },
})

coverage.setup({
  auto_reload = true,
  lang = {
    go = {
      coverage_file = vim.fn.getcwd() .. '/coverage.out',
    },
  },
})

-- keymaps
local map = vim.keymap.set

map('n', '<leader>tn', function() neotest.run.run() end, { desc = '[t]est [n]earest' })
map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = '[t]est [f]ile' })
map('n', '<leader>ta', function() neotest.run.run(vim.fn.getcwd()) end, { desc = '[t]est [a]ll' })
map('n', '<leader>tl', function() neotest.run.run_last() end, { desc = '[t]est [l]ast' })
map('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = '[t]est [s]ummary' })
map('n', '<leader>to', function() neotest.output.open({ enter = true }) end, { desc = '[t]est [o]utput' })
map('n', '<leader>tO', function() neotest.output_panel.toggle() end, { desc = '[t]est [O]utput panel' })
map('n', '<leader>tw', function() neotest.watch.toggle(vim.fn.expand('%')) end, { desc = '[t]est [w]atch file' })
map('n', '<leader>tx', function() neotest.run.stop() end, { desc = '[t]est [x]kill / stop' })

local coverage_visible = false

map('n', '<leader>tc', function()
  if coverage_visible then
    vim.cmd('CoverageHide')
  else
    vim.cmd('Coverage')
  end

  coverage_visible = not coverage_visible
end, { desc = '[t]est toggle [c]overage' })

map('n', '<leader>tC', function()
  vim.cmd('CoverageLoad')
  vim.cmd('CoverageSummary')
end, { desc = '[t]est [C]overage summary' })

map('n', '<leader>tR', function()
  local root = vim.fn.getcwd()
  local profile = root .. '/coverage.out'

  if vim.fn.filereadable(root .. '/go.mod') == 0 then
    vim.notify(
      'Open Neovim from a Go module root',
      vim.log.levels.WARN
    )
    return
  end

  vim.notify('Running Go tests with coverage...')

  vim.system({
    'go', 'test', './...',
    '-coverprofile=' .. profile,
    '-count=1',
  }, { cwd = root, text = true }, function(result)
    vim.schedule(function()
        if result.code ~= 0 then
          vim.notify(
            'Go tests failed:\n' .. (result.stderr or ''),
            vim.log.levels.ERROR
          )
          return
        end

        vim.cmd('Coverage')
        coverage_visible = true
        vim.notify('Coverage updated!')
      end)
  end)
end, { desc = '[t]est [R]un with coverage' })

