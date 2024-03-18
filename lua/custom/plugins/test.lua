return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-python',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local neotest = require 'neotest'
    neotest.setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
        },
      },
    }

    vim.keymap.set('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = '[T]est Current [F]ile' })
    vim.keymap.set('n', '<leader>tn', function()
      neotest.run.run()
    end, { desc = '[T]est [N]earest' })
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end, { desc = '[T]est Toggle [S]ummary' })
    vim.keymap.set('n', '<leader>ta', function()
      neotest.run.run(vim.loop.cwd())
    end, { desc = '[T]est [A]ll' })
    vim.keymap.set('n', '<leader>tl', function()
      neotest.run.run_last()
    end, { desc = '[T]est [L]ast' })

    vim.keymap.set('n', '<leader>tS', function()
      neotest.run.stop()
    end, { desc = '[T]est [S]top' })

    vim.keymap.set('n', '<leader>tt', function()
      neotest.output.open { enter = true, auto_close = true }
    end, { desc = '[T]est [T]oggle Output' })
    vim.keymap.set('n', '<leader>tT', function()
      neotest.output_panel.toggle()
    end, { desc = '[T]est [T]oggle Output Panel' })
  end,
}
