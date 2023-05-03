local utils = require "utils"
local conditional_func = utils.conditional_func
local is_available = utils.is_available

local function add_buffer_autocmd(augroup, bufnr, autocmds)
    if not vim.tbl_islist(autocmds) then
        autocmds = {autocmds}
    end
    local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, {
        group = augroup,
        buffer = bufnr
    })
    if not cmds_found or vim.tbl_isempty(cmds) then
        vim.api.nvim_create_augroup(augroup, {
            clear = false
        })
        for _, autocmd in ipairs(autocmds) do
            local events = autocmd.events
            autocmd.events = nil
            autocmd.group = augroup
            autocmd.buffer = bufnr
            vim.api.nvim_create_autocmd(events, autocmd)
        end
    end
end

local function set_mappings(map_table, base)
    -- iterate over the first keys for each mode
    base = base or {}
    for mode, maps in pairs(map_table) do
        -- iterate over each keybinding set in the current mode
        for keymap, options in pairs(maps) do
            -- build the options for the command accordingly
            if options then
                local cmd = options
                local keymap_opts = base
                if type(options) == "table" then
                    cmd = options[1]
                    keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
                    keymap_opts[1] = nil
                end
                if not cmd or keymap_opts.name then -- if which-key mapping, queue it
                    -- if not M.which_key_queue then
                    --     M.which_key_queue = {}
                    -- end
                    -- if not M.which_key_queue[mode] then
                    --     M.which_key_queue[mode] = {}
                    -- end
                    -- M.which_key_queue[mode][keymap] = keymap_opts
                else -- if not which-key mapping, set it
                    vim.keymap.set(mode, keymap, cmd, keymap_opts)
                end
            end
        end
    end
    -- if package.loaded["which-key"] then
    --     M.which_key_register()
    -- end -- if which-key is loaded already, register
end

require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers { -- The first entry (without a key) will be the default handler
-- and will be called for each installed server that doesn't have
-- a dedicated handler.
function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
        on_attach = function(client, bufnr)
            local capabilities = client.server_capabilities
            local lsp_mappings = {
                n = {
                    ["<leader>ld"] = {
                        function()
                            vim.diagnostic.open_float()
                        end,
                        desc = "Hover diagnostics"
                    },
                    ["[d"] = {
                        function()
                            vim.diagnostic.goto_prev()
                        end,
                        desc = "Previous diagnostic"
                    },
                    ["]d"] = {
                        function()
                            vim.diagnostic.goto_next()
                        end,
                        desc = "Next diagnostic"
                    },
                    ["gl"] = {
                        function()
                            vim.diagnostic.open_float()
                        end,
                        desc = "Hover diagnostics"
                    }
                },
                v = {}
            }

            if is_available "mason-lspconfig.nvim" then
                lsp_mappings.n["<leader>li"] = {
                    "<cmd>LspInfo<cr>",
                    desc = "LSP information"
                }
            end

            if is_available "null-ls.nvim" then
                lsp_mappings.n["<leader>lI"] = {
                    "<cmd>NullLsInfo<cr>",
                    desc = "Null-ls information"
                }
            end

            if capabilities.codeActionProvider then
                lsp_mappings.n["<leader>la"] = {
                    function()
                        vim.lsp.buf.code_action()
                    end,
                    desc = "LSP code action"
                }
                lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
            end

            if capabilities.codeLensProvider then
                add_buffer_autocmd("lsp_codelens_refresh", bufnr, {
                    events = {"InsertLeave", "BufEnter"},
                    desc = "Refresh codelens",
                    callback = function()
                        if vim.g.codelens_enabled then
                            vim.lsp.codelens.refresh()
                        end
                    end
                })
                vim.lsp.codelens.refresh()
                lsp_mappings.n["<leader>ll"] = {
                    function()
                        vim.lsp.codelens.refresh()
                    end,
                    desc = "LSP CodeLens refresh"
                }
                lsp_mappings.n["<leader>lL"] = {
                    function()
                        vim.lsp.codelens.run()
                    end,
                    desc = "LSP CodeLens run"
                }
            end

            if capabilities.declarationProvider then
                lsp_mappings.n["gD"] = {
                    function()
                        vim.lsp.buf.declaration()
                    end,
                    desc = "Declaration of current symbol"
                }
            end

            if capabilities.definitionProvider then
                lsp_mappings.n["gd"] = {
                    function()
                        vim.lsp.buf.definition()
                    end,
                    desc = "Show the definition of current symbol"
                }
            end

            if capabilities.documentFormattingProvider then
                lsp_mappings.n["<leader>lf"] = {
                    function()
                        vim.lsp.buf.format()
                    end,
                    desc = "Format buffer"
                }
                lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

                vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
                    vim.lsp.buf.format()
                end, {
                    desc = "Format file with LSP"
                })
                local autoformat = {}
                local filetype = vim.api.nvim_get_option_value("filetype", {
                    buf = bufnr
                })
                if autoformat.enabled and
                    (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype)) and
                    (tbl_isempty(autoformat.ignore_filetypes or {}) or
                        not tbl_contains(autoformat.ignore_filetypes, filetype)) then
                    add_buffer_autocmd("lsp_auto_format", bufnr, {
                        events = "BufWritePre",
                        desc = "autoformat on save",
                        callback = function()
                            local autoformat_enabled = vim.b.autoformat_enabled
                            if autoformat_enabled == nil then
                                autoformat_enabled = vim.g.autoformat_enabled
                            end
                            if autoformat_enabled and ((not autoformat.filter) or autoformat.filter(bufnr)) then
                                vim.lsp.buf.format(require("utils").extend_tbl({}, {
                                    bufnr = bufnr
                                }))
                            end
                        end
                    })
                    -- lsp_mappings.n["<leader>uf"] = {
                    --     function()
                    --         require("astronvim.utils.ui").toggle_buffer_autoformat()
                    --     end,
                    --     desc = "Toggle autoformatting (buffer)"
                    -- }
                    -- lsp_mappings.n["<leader>uF"] = {
                    --     function()
                    --         require("astronvim.utils.ui").toggle_autoformat()
                    --     end,
                    --     desc = "Toggle autoformatting (global)"
                    -- }
                end
            end

            if capabilities.documentHighlightProvider then
                add_buffer_autocmd("lsp_document_highlight", bufnr, {{
                    events = {"CursorHold", "CursorHoldI"},
                    desc = "highlight references when cursor holds",
                    callback = function()
                        vim.lsp.buf.document_highlight()
                    end
                }, {
                    events = {"CursorMoved", "CursorMovedI"},
                    desc = "clear references when cursor moves",
                    callback = function()
                        vim.lsp.buf.clear_references()
                    end
                }})
            end

            if capabilities.hoverProvider then
                lsp_mappings.n["K"] = {
                    function()
                        vim.lsp.buf.hover()
                    end,
                    desc = "Hover symbol details"
                }
            end

            if capabilities.implementationProvider then
                lsp_mappings.n["gI"] = {
                    function()
                        vim.lsp.buf.implementation()
                    end,
                    desc = "Implementation of current symbol"
                }
            end

            if capabilities.referencesProvider then
                lsp_mappings.n["gr"] = {
                    function()
                        vim.lsp.buf.references()
                    end,
                    desc = "References of current symbol"
                }
                lsp_mappings.n["<leader>lR"] = {
                    function()
                        vim.lsp.buf.references()
                    end,
                    desc = "Search references"
                }
            end

            if capabilities.renameProvider then
                lsp_mappings.n["<leader>lr"] = {
                    function()
                        vim.lsp.buf.rename()
                    end,
                    desc = "Rename current symbol"
                }
            end

            if capabilities.signatureHelpProvider then
                lsp_mappings.n["<leader>lh"] = {
                    function()
                        vim.lsp.buf.signature_help()
                    end,
                    desc = "Signature help"
                }
            end

            if capabilities.typeDefinitionProvider then
                lsp_mappings.n["gT"] = {
                    function()
                        vim.lsp.buf.type_definition()
                    end,
                    desc = "Definition of current type"
                }
            end

            if capabilities.workspaceSymbolProvider then
                lsp_mappings.n["<leader>lG"] = {
                    function()
                        vim.lsp.buf.workspace_symbol()
                    end,
                    desc = "Search workspace symbols"
                }
            end

            -- if capabilities.semanticTokensProvider and vim.lsp.semantic_tokens then
            --     lsp_mappings.n["<leader>uY"] = {
            --         function()
            --             require("astronvim.utils.ui").toggle_buffer_semantic_tokens(bufnr)
            --         end,
            --         desc = "Toggle LSP semantic highlight (buffer)"
            --     }
            -- end

            if is_available "telescope.nvim" then -- setup telescope mappings if available
                if lsp_mappings.n.gd then
                    lsp_mappings.n.gd[1] = function()
                        require("telescope.builtin").lsp_definitions()
                    end
                end
                if lsp_mappings.n.gI then
                    lsp_mappings.n.gI[1] = function()
                        require("telescope.builtin").lsp_implementations()
                    end
                end
                if lsp_mappings.n.gr then
                    lsp_mappings.n.gr[1] = function()
                        require("telescope.builtin").lsp_references()
                    end
                end
                if lsp_mappings.n["<leader>lR"] then
                    lsp_mappings.n["<leader>lR"][1] = function()
                        require("telescope.builtin").lsp_references()
                    end
                end
                if lsp_mappings.n.gT then
                    lsp_mappings.n.gT[1] = function()
                        require("telescope.builtin").lsp_type_definitions()
                    end
                end
                if lsp_mappings.n["<leader>lG"] then
                    lsp_mappings.n["<leader>lG"][1] = function()
                        require("telescope.builtin").lsp_workspace_symbols()
                    end
                end
            end

            if not vim.tbl_isempty(lsp_mappings.v) then
                lsp_mappings.v["<leader>l"] = {
                    name = (vim.g.icons_enabled and " " or "") .. "LSP"
                }
            end
            set_mappings(lsp_mappings)
        end
    })
end}
