return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    -- basic telescope configuration
    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local make_finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end

        return require('telescope.finders').new_table {
          results = paths,
        }
      end
      local function remove_and_refresh(prompt_buffer_number)
        local state = require 'telescope.actions.state'
        local selected_entry = state.get_selected_entry()
        local current_picker = state.get_current_picker(prompt_buffer_number)
        harpoon:list():removeAt(selected_entry.index)
        current_picker:refresh(make_finder())
      end
      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = make_finder(),
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_buffer_number, map)
            map('i', '<M-d>', function()
              remove_and_refresh(prompt_buffer_number)
            end)
            map('n', 'd', function()
              remove_and_refresh(prompt_buffer_number)
            end)
            return true
          end,
        })
        :find()
    end

    vim.keymap.set('n', '<leader>hh', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon Show List' })

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():append()
    end, { desc = '[H]arpoon Append' })

    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = '[H]arpoon Remove' })
  end,
}
