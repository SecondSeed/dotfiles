vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},
{
  "ggandor/leap.nvim",
  event = "BufWinEnter",
  config = function()
      require('leap').add_default_mappings()
      vim.api.nvim_set_keymap('n', 'gw', '<Plug>(leap-cross-window)', {})
      vim.api.nvim_set_keymap('x', 'gw', '<Plug>(leap-cross-window)', {})
      vim.api.nvim_set_keymap('o', 'gw', '<Plug>(leap-cross-window)', {})
  end
},
{
  "vim-scripts/ReplaceWithRegister",
  event = "BufWinEnter",
},
{
  'keaising/im-select.nvim',
  event = "BufWinEnter",
  config = function()
      require('im_select').setup({
          set_default_events = { "InsertLeave" }
      })
  end
},
{
  "mg979/vim-visual-multi",
  event = "BufWinEnter"
},
{
  "junegunn/vim-easy-align"
},
{
  'vim-scripts/argtextobj.vim'
}
})
