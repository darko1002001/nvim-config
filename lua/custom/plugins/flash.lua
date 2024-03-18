return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    label = {
      style = 'inline',
    },
    highlight = { backdrop = false },
    modes = {
      search = { enabled = false },
      char = { enabled = false },
    },
  },

  -- stylua: ignore
  keys = {
    { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
