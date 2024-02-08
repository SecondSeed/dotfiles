vim.g.mapleader = " "

-- option
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.g.vscode then
    -- nvim_set_keymap

    local map = vim.api.nvim_set_keymap

    -- operation
    map('n', 'yil', '^y$', {
        noremap = true
    })

    -- move
    map('n', 'H', '^', {
        noremap = true
    })
    map('n', 'L', '$', {
        noremap = true
    })
    map('n', 'j', 'gj', {
        noremap = true
    })
    map('n', 'k', 'gk', {
        noremap = true
    })
    map('n', '<leader>lf', "<cmd>call VSCodeNotify('editor.action.formatDocument')<cr>", {})
    map('n', '<leader>lr', "<cmd>call VSCodeCall('editor.action.rename')<cr>", {})
    map('x', '<leader>ls', "<cmd>call VSCodeCallVisual('editor.action.surroundWithSnippet', 1)<cr>", {})
    map('n', '<leader>lc', "<cmd>call VSCodeNotify('references-view.showCallHierarchy')<cr>", {})
    map('n', '<leader>li', "<cmd>call VSCodeNotify('editor.action.organizeImports')<cr>", {})

    -- buffer
    map('n', '<leader>br', "<cmd>call VSCodeNotify('revealFileInOS')<cr>", {})
    map('n', '<leader>bc', "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>", {})
    map('n', '<leader>ba', "<cmd>call VSCodeNotify('workbench.action.closeAllEditors')<cr>", {})
    map('n', '<leader>bh', "<cmd>call VSCodeNotify('workbench.action.closeEditorsToTheLeft')<cr>", {})
    map('n', '<leader>bl', "<cmd>call VSCodeNotify('workbench.action.closeEditorsToTheRight')<cr>", {})
    map('n', ']b', "<cmd>call VSCodeNotify('workbench.action.nextEditorInGroup')<cr>", {})
    map('n', '[b', "<cmd>call VSCodeNotify('workbench.action.previousEditorInGroup')<cr>", {})
    map('n', '<leader>bP', "<cmd>call VSCodeNotify('copyFilePath')<cr>", {})
    map('n', '<leader>bp', "<cmd>call VSCodeNotify('copyRelativeFilePath')<cr>", {})

    -- navigation
    map('n', 'gi', "<cmd>call VSCodeNotify('editor.action.goToImplementation')<cr>", {})
    map('n', 'gs', "<cmd>call VSCodeNotify('editor.showSupertypes')<cr>", {})
    map('n', 'gR', "<cmd>call VSCodeNotify('editor.action.goToReferences')<cr>", {})
    map('n', '<C-o>', "<cmd>call VSCodeNotify('workbench.action.navigateBack')<cr>", {})
    map('n', '<C-i>', "<cmd>call VSCodeNotify('workbench.action.navigateForward')<cr>", {})
    map('n', '<leader>ne', "<cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<cr>", {})
    map('n', '<leader>pe', "<cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<cr>", {})

    map('n', "<leader>t", "<cmd>call VSCodeNotify('workbench.action.toggleZenMode')<cr>", {})

    -- easy-align
    map('n', 'ga', "<Plug>(EasyAlign)", {})
    map('x', 'ga', "<Plug>(EasyAlign)", {})

    -- debug
    map('n', '<leader>ds', "<cmd>call VSCodeNotify('workbench.action.debug.start')<cr>", {})
    map('n', '<leader>dt', "<cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<cr>", {})
    map('n', '<leader>dC', "<cmd>call VSCodeNotify('editor.debug.action.runToCursor')<cr>", {})
    map('n', '<leader>dc', "<cmd>call VSCodeNotify('workbench.action.debug.continue')<cr>", {})
    map('n', '<leader>dn', "<cmd>call VSCodeNotify('workbench.action.debug.stepOver')<cr>", {})
    map('n', '<leader>do', "<cmd>call VSCodeNotify('workbench.action.debug.stepOut')<cr>", {})
    map('n', '<leader>di', "<cmd>call VSCodeNotify('workbench.action.debug.stepInto')<cr>", {})
    map('n', '<leader>df', "<cmd>call VSCodeNotify('workbench.action.debug.stop')<cr>", {})

    -- quickscope color
    -- vim.cmd [[
    --     highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    --     highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    -- ]]

    -- window
    map('n', '<leader>wz', "<cmd>call VSCodeNotify('workbench.action.toggleZenMode')<cr>", {})

    -- git
    map('n', '<leader>gd', "<cmd>call VSCodeNotify('gitlens.diffWithPrevious')<cr>", {})

    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
                       "--branch=stable", -- latest stable release
        lazypath})
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({{
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }, {
        "ggandor/leap.nvim",
        event = "BufWinEnter",
        config = function()
            require('leap').add_default_mappings()
        end
    }, {
        "vim-scripts/ReplaceWithRegister",
        event = "BufWinEnter"
    }, {
        'keaising/im-select.nvim',
        event = "BufWinEnter",
        config = function()
            require('im_select').setup({
                set_default_events = {"InsertLeave"}
            })
        end
    }, {
        "mg979/vim-visual-multi",
        event = "BufWinEnter"
    }, {"junegunn/vim-easy-align"}, {'vim-scripts/argtextobj.vim'}, {'machakann/vim-highlightedyank'}})
else
    -- ordinary Neovim
end

