--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.wrap = true

-- remove mappings
-- lvim.lsp.buffer_mappings.normal_mode["gl"] = nil


-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.terminal.open_mapping = "<c-t>"
-- lvim.keys.normal_mode["gh"] = "<C-w>h"
-- lvim.keys.normal_mode["gl"] = "<C-w>l"
-- lvim.keys.normal_mode["gk"] = "<C-w>k"
-- lvim.keys.normal_mode["gj"] = "<C-w>j"

lvim.keys.normal_mode['<C-a>'] = "ggVG"
lvim.keys.insert_mode['<C-a>'] = "<ESC>ggVG"
lvim.keys.insert_mode["<C-j>"] = "<Down>"
lvim.keys.insert_mode["<C-k>"] = "<Up>"
lvim.keys.insert_mode["<C-h>"] = "<Left>"
lvim.keys.insert_mode["<C-l>"] = "<Right>"
lvim.keys.normal_mode["yil"] = "^y$"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"
lvim.keys.normal_mode["H"] = "^"
lvim.keys.insert_mode["H"] = "^"
lvim.keys.normal_mode["L"] = "$"
lvim.keys.insert_mode["L"] = "$"
lvim.keys.normal_mode["<C-m>"] = ":nohl<CR>"

vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', {})
vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', {})

-- lvim.builtin.which_key.vmappings["/"] = {}
-- lvim.builtin.which_key.mappings["/"] = {}

lvim.keys.normal_mode["]b"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["[b"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

-- nvim-tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.update_focused_file.update_root = false
-- lvim.builtin.nvimtree.setup.sync_root_with_cwd = false
lvim.builtin.which_key.mappings['e'] = {
  name = "Explorer",
  ["t"] = { "<cmd>NvimTreeToggle<CR>", "Toggle" },
  ["T"] = { "<cmd>:NvimTreeFindFileToggle<CR>", "Find file toggle" },
  -- ["s"] = { "<cmd>:NvimTreeFocus<CR>", "Show in explorer" },
  ["F"] = { "<cmd>:NvimTreeFindFile!<CR>", "Find file and update root for current bufname" },
  ["r"] = { "<cmd>:NvimTreeRefresh<CR>", "Reload explorer" }
}

-- project
lvim.builtin.project.patterns = { '.lvimproj' }
lvim.builtin.project.silent_chdir = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- ensure these parsers are always installed, useful for those without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
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
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    url = "https://git.sr.ht/~nedia/auto-save.nvim",
    event = "BufWinEnter",
    config = function()
      require("auto-save").setup()
    end
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = false
          },
          signature = {
            enabled = false
          }
        },
        -- -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        -- routes = {
        --   {
        --     view = "split",
        --     filter = { event = "msg_show", min_height = 20 },
        --   },
        -- },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
