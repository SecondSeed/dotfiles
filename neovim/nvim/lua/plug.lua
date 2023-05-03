-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
local utils = require "utils"
local is_available = utils.is_available

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
    -- Packer can manage itself

    use {'wbthomason/packer.nvim'}

    -- Simple plugins can be specified as strings
    use 'rstacruz/vim-closer'

    -- Lazy loading:
    -- Load on specific commands
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

    -- Load on an autocommand event
    use {
        'andymass/vim-matchup',
        event = 'VimEnter'
    }

    -- Load on a combination of conditions: specific filetypes or commands
    -- Also run code after load (see the "config" key)
    use {
        'w0rp/ale',
        ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }

    -- Post-install/update hook with neovim command
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require "plugins/nvim-treesitter"
    }

    -- Post-install/update hook with call of vimscript function with argument
    use {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](0)
        end
    }

    -- Use dependency and run lua function after load
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup()
        end
    }

    -- You can alias plugin names
    use {
        'dracula/vim',
        as = 'dracula'
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {'nvim-tree/nvim-web-devicons' -- optional
        },
        configt = require 'plugins/nvim-tree'
    }

    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                enable_check_bracket_line = false,
                ignored_next_char = "[%w%.]"
            })
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
                cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done {
                    tex = false
                })
            end
        end
    }
    use {
        "ggandor/leap.nvim",
        config = require("leap").add_default_mappings()
    }

    -- lsp 

    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = require 'lsp/mason'
    }
    use {
        "williamboman/mason-lspconfig.nvim",
        config = require 'lsp/mason-lspconfig'
    }
    use {"neovim/nvim-lspconfig"}
    use "kosayoda/nvim-lightbulb"
    use "ray-x/lsp_signature.nvim"

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'}},
        config = require 'plugins/telescope'
    }

    use {
        'marko-cerovac/material.nvim',
        config = require 'plugins/material'
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        },
        config = require "plugins/lualine"
    }

    -- completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
