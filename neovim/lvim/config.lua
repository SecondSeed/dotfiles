local os_sysname = vim.loop.os_uname().sysname
local is_windows = os_sysname:find 'Windows' and true or false
if is_windows then
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
end
--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.et = true
vim.opt.cot = "menu,preview,noinsert,noselect"
-- vim.g.translator_proxy_url =  'http://x00664994:xxm-HUAWEI123@proxy.huawei.com:8080'

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

lvim.keys.normal_mode['<C-a>'] = "ggVG"
lvim.keys.insert_mode['<C-a>'] = "<ESC>ggVG"
lvim.keys.insert_mode["<C-j>"] = "<Down>"
lvim.keys.insert_mode["<C-k>"] = "<Up>"
lvim.keys.insert_mode["<C-h>"] = "<Left>"
lvim.keys.insert_mode["<C-l>"] = "<Right>"
lvim.keys.insert_mode["<C-v>"] = '<C-r>+'
lvim.keys.visual_mode["<C-v>"] = '"+P'
lvim.keys.normal_mode["yil"] = "^y$"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"
lvim.keys.normal_mode["H"] = "^"
lvim.keys.visual_mode["H"] = "^"
lvim.keys.normal_mode["L"] = "$"
lvim.keys.visual_mode["L"] = "$"
lvim.keys.normal_mode["<C-m>"] = ":nohl<CR>"
lvim.keys.visual_mode['gs'] = false
lvim.keys.normal_mode['gs'] = false

-- command map
vim.api.nvim_set_keymap("c", "<C-V>", '<C-R>+', {})

-- remove for replace-with-register
vim.api.nvim_set_keymap("n", 'gr', '<Plug>(ReplaceWithRegisterOperator)', {})
vim.api.nvim_set_keymap("x", 'gr', '<Plug>(ReplaceWithRegisterVisual)', {})
vim.api.nvim_set_keymap("x", 'grr', '<Plug>(ReplaceWithRegisterLine)', {})

-- vim-easy-align
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})

-- vim-visual-multi
vim.api.nvim_set_keymap('n', '<C-M-Down>', "<Plug>(VM-Add-Cursor-Down)", {})
vim.api.nvim_set_keymap('n', '<C-M-Up>', "<Plug>(VM-Add-Cursor-Up)", {})
lvim.keys.normal_mode["]b"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["[b"] = ":BufferLineCyclePrev<CR>"

-- -- Change theme settings
lvim.colorscheme = "lunar"

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

-- custom text operation
lvim.builtin.which_key.vmappings['u'] = {
    name = "Utilities",
    ['S'] = { "<cmd>'<,'>s/\\s\\+/ /g<CR>", "Replace all mutiSpace with Single one" },
    ['s'] = { "<cmd>'<,'>s/\\s\\+/ /<CR>", "Replace first mutiSpace with Single one" },
}

lvim.builtin.which_key.mappings['u'] = {
    name = "Utilities",
    ['S'] = { "<cmd>s/\\s\\+/ /g<CR>", "Replace all mutiSpace with Single one" },
    ['s'] = { "<cmd>s/\\s\\+/ /<CR>", "Replace first mutiSpace with Single one" },
}

-- telescope
lvim.builtin.which_key.mappings["sb"] = { "<cmd>Telescope buffers<cr>", "Find buffers" }
lvim.builtin.which_key.mappings["sP"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.telescope.defaults.layout_strategy = 'horizontal'
lvim.builtin.telescope.defaults.layout_config = {
    height = 0.9,
    width = 0.9,
    prompt_position = 'bottom',
    preview_width = 0.45
}
lvim.builtin.telescope.defaults.file_ignore_patterns = { '.obsidian', '.git', '.idea', '.vscode' }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<cr>", "Find files" }
vim.api.nvim_set_keymap("n", "<C-S-f>", "<cmd>Telescope live_grep<CR>", {})


-- snippets
lvim.builtin.luasnip.sources.friendly_snippets = true

-- obsidian
lvim.builtin.which_key.mappings['o'] = {
    name = "Obsidian",
    ['d'] = { "<cmd>ObsidianToday<cr>", "ObsidianToday" },
    ['p'] = { "<cmd>ObsidianProject<cr>", "ObsidianProject" },
    ['g'] = { "<cmd>Telescope live_grep search_dirs=D:/note/note<CR>", "Search text" },
    ['f'] = { "<cmd>Telescope find_files search_dirs=D:/note/note<CR>", "Find file" }
}

-- gitsigns
lvim.builtin.gitsigns.opts.current_line_blame = false

-- markdown
lvim.builtin.which_key.mappings['m'] = {
    name = "Markdown",
    ['u'] = { "<cmd>lua require'nvim-picgo'.upload_clipboard()<cr>", "Upload clipboard" },
    ['p'] = { "<cmd>MarkdownPreview<cr>", "Markdown preview" },
    ['c'] = { "<cmd>EditMarkdownTable<cr>", "Edit table cell" },
}

-- cmp
lvim.builtin.cmp.preselect = require('cmp').PreselectMode.None

-- project
lvim.builtin.project.patterns = { '.lvimproj', '.idea' }
-- lvim.builtin.project.silent_chdir = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.lsp.buffer_mappings.normal_mode['gD'] = { "<cmd>Telescope lsp_type_definitions<cr> ", 'Goto declaration telescope' }
lvim.lsp.buffer_mappings.normal_mode['gd'] = { "<cmd>Telescope lsp_definitions<cr>", "Goto definitions telescope" }
lvim.lsp.buffer_mappings.normal_mode['gR'] = { "<cmd>Telescope lsp_references<cr>", "Goto references telescope" }
lvim.lsp.buffer_mappings.normal_mode['gi'] = { "<cmd>Telescope lsp_implementations<cr>", "Goto implementations telescope" }

lvim.lsp.buffer_mappings.normal_mode['gr'] = nil

if vim.g.neovide then
    vim.g.neovide_transparency = 0.85
    -- vim.g.transparency = 1
    -- vim.g.neovide_profiler = true
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_scroll_animation_length = 0
    vim.o.guifont = "SauceCodePro Nerd Font Mono"
    lvim.transparent_window = true
end

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
        event = "BufWinEnter",
        config = function()
            require('leap').add_default_mappings()
            vim.api.nvim_set_keymap('n', 'gw', '<Plug>(leap-cross-window)', {})
            vim.api.nvim_set_keymap('x', 'gw', '<Plug>(leap-cross-window)', {})
            vim.api.nvim_set_keymap('o', 'gw', '<Plug>(leap-cross-window)', {})
        end
    },
    {
        url = "https://git.sr.ht/~nedia/auto-save.nvim",
        event = "BufWinEnter",
        config = function()
            require("auto-save").setup({
                save_fn = function()
                    vim.cmd("silent! w")
                end
            })
        end
    },
    {
        'leoluz/nvim-dap-go',
        ft = { "go", "golang", "gosum" },
        config = function()
            require("dap-go").setup({
                -- add any options here
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port
                    port = "2345"
                },
            })
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app ; npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        pin = true,
    },
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow"
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
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
        "epwalsh/obsidian.nvim",
        lazy = true,
        event = { "BufReadPre D:/note/note/**.md", "VeryLazy" },
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
        -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- Optional, for completion.
            "hrsh7th/nvim-cmp",

            -- Optional, for search and quick-switch functionality.
            "nvim-telescope/telescope.nvim",

            -- Optional, alternative to nvim-treesitter for syntax highlighting.
            "godlygeek/tabular",
            "preservim/vim-markdown",
        },
        opts = {
            dir = "D:/note/note", -- no need to call 'vim.fn.expand' here
            -- Optional, if you keep notes in a specific subdirectory of your vault.
            -- notes_subdir = "notes",
            -- Optional, if you keep daily notes in a separate directory.
            daily_notes = {
                folder = "dairy",
            },
            -- Optional, completion.
            completion = {
                nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
            },
            -- Optional, customize how names/IDs for new notes are created.
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,
            -- Optional, set to true if you don't want Obsidian to manage frontmatter.
            disable_frontmatter = false,
            -- Optional, alternatively you can customize the frontmatter data.
            note_frontmatter_func = function(note)
                -- This is equivalent to the default frontmatter function.
                local out = { id = note.id, aliases = note.aliases, tags = note.tags }
                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end
                return out
            end,
            -- Optional, for templates (see below).
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d-%a",
                time_format = "%H:%M",
            },
            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
            -- URL it will be ignored but you can customize this behavior here.
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,
            -- Optional, set to true if you use the Obsidian Advanced URI plugin.
            -- https://github.com/Vinzent03/obsidian-advanced-uri
            use_advanced_uri = true,
            -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
            open_app_foreground = false,
        },
        config = function(_, opts)
            require("obsidian").setup(opts)

            -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
            -- see also: 'follow_url_func' config option above.
            vim.keymap.set("n", "gf", function()
                if require("obsidian").util.cursor_on_markdown_link() then
                    return "<cmd>ObsidianFollowLink<CR>"
                else
                    return "gf"
                end
            end, { noremap = false, expr = true })
            vim.api.nvim_create_user_command("ObsidianProject", function()
                require('project_nvim.project').set_pwd(opts.dir, "open obsidian path")
                vim.cmd("NvimTreeToggle")
                vim.cmd("ObsidianToday")
            end, {})
        end,
    },
    {
        "askfiy/nvim-picgo",
        branch = 'for_hw',
        pin = true,
        config = function()
            -- it doesn't require you to do any configuration
            require("nvim-picgo").setup()
        end
    },
    {
        "mg979/vim-visual-multi",
        event = "BufWinEnter"
    },
    {
        'kiran94/edit-markdown-table.nvim',
        config = function()
            require('edit-markdown-table').setup()
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "EditMarkdownTable",
    },
    {
        "junegunn/vim-easy-align"
    },
    {
        'vim-scripts/argtextobj.vim'
    }
}

vim.api.nvim_create_user_command("GoImportsOrganize", function()
    if vim.bo.filetype == 'go' then
        local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
        params.context = { only = { "source.organizeImports" } }

        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 10000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(0))
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end
end
, {})

-- vim.api.nvim_create_autocmd({ "BufLeave", "BufHidden" }, {
--     pattern = "*.go",
--     callback = function()
--         local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
--         if next(active_clients) ~= nil then
--             vim.lsp.buf.format()
--             vim.cmd("silent! w")
--         end
--     end
-- })
