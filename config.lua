--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.wrap = true


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
lvim.leader = ","


-- lunarvim colorscheme
-- lvim.colorscheme = "lunar"
-- lvim.colorscheme = "OceanicNext"
lvim.colorscheme = "duskfox"


-- add your own keymapping
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["S"] = { vim.lsp.buf.hover, "Show documentation" }
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["WQ"] = ":wq<cr>"
lvim.keys.normal_mode["Q"] = "<cmd>BufferCloseOrQuit<CR>"
lvim.keys.normal_mode["J"] = "5j"
lvim.keys.normal_mode["K"] = "5k"
lvim.keys.normal_mode["H"] = "0"
lvim.keys.normal_mode["L"] = "$"
lvim.keys.normal_mode["<A-h>"] = "<cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<A-left>"] = "<cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<A-l>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<A-right>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.visual_mode["J"] = "5j"
lvim.keys.visual_mode["K"] = "5k"


-- -- Change theme settings
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false


-- -- Change plug Lazy
-- lvim.builtin.c


-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true


-- add <Esc> to close lsp complete windowtest
lvim.builtin.cmp.mapping["<Esc>"] = require("cmp.config.mapping").abort()


-- nvim-tree configure
-- lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.ignore_buffer_on_setup = nil


-- nvim-tree solution based on QuitPre that checks if it's the last window
-- see: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd({ "QuitPre" }, {
    callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
                table.insert(invalid_win, w)
            end
        end
        if #invalid_win == #wins - 1 then
            -- Should quit, so we close all invalid windows
            for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
        end
    end
})


-- judge current windows buffer count and if current buffer not nvim-tree then close buffer
vim.api.nvim_create_user_command("BufferCloseOrQuit", function()
    local buffer_count = #vim.fn.filter(vim.fn.range(1, vim.fn.bufnr '$'), 'buflisted(v:val)')

    -- only dashboard page
    if buffer_count == 0 then
        vim.cmd("quit")
    end

    -- if not nvim-tree buff and buffer_count>1 then close current buffer-window
    if not require("nvim-tree.utils").is_nvim_tree_buf() and buffer_count > 1 then
        vim.cmd("BufferKill")
    else
        vim.cmd("quit")
    end

    -- vim.cmd(string.format('echo "bufnum=%s, istree=%s"', buffer_count, require("nvim-tree.utils").is_nvim_tree_buf()))
end, { desc = "close current window buffer, if has open mutil buffer then close current buffer." })


-- lvim extension themes configure
local lvim_themes = {
    {
        "mhartington/oceanic-next",
        priority = 1000,
        -- lazy = lvim.colorscheme ~= "OceanicNext",
    },
    { "shaunsingh/nord.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    { "ray-x/aurora" },
    { "nxstynate/catppuccin.nvim" }
}
-- lvim extension plugins configure
local lvim_plugins = {
    {
        -- note: cursor quick jump
        "ggandor/leap.nvim",
        lazy = true,
        keys = { "E", "R", "W", "dE", "dR", "yE", "yR", "cE", "cR" },
        config = function()
            require("leap").opts.highlight_unlabeled_phase_one_kargets = true
            -- leap.add_default_mappings()
            vim.keymap.set({ "x", "o", "n" }, "E", "<Plug>(leap-forward-to)")
            vim.keymap.set({ "x", "o", "n" }, "R", "<Plug>(leap-backward-to)")
            vim.keymap.set({ "x", "o", "n" }, "W", "<Plug>(leap-from-window)")
        end,
    },
    {
        -- note: fixed method head
        "romgrk/nvim-treesitter-context",
        lazy = false,
        event = { "User FileOpened" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                throttle = true,
                max_lines = 0,
                patterns = {
                    default = {
                        "class",
                        "function",
                        "method",
                    },
                },
            })
        end,
    },
    {
        -- note: record the last open location of the file, limited to the current session only
        "ethanholz/nvim-lastplace",
        lazy = true,
        event = { "User FileOpened" },
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit",
                    "gitrebase",
                    "svn",
                    "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    },
    {
        -- note: quick append pairs, you can ysiw"
        "kylechui/nvim-surround",
        lazy = true,
        keys = { "cs", "ds", "ys" },
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        -- note: quickfix preview and other functions
        "kevinhwang91/nvim-bqf",
        lazy = true,
        ft = "qf",
        config = function()
            require("bqf").setup({
                auto_enable = true,
                auto_resize_height = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
                    should_preview_cb = function(bufnr, qwinid)
                        local ret = true
                        local bufname = vim.api.nvim_buf_get_name(bufnr)
                        local fsize = vim.fn.getfsize(bufname)
                        if fsize > 100 * 1024 then
                            -- skip file size greater than 100k
                            ret = false
                        elseif bufname:match("^fugitive://") then
                            -- skip fugitive buffer
                            ret = false
                        end
                        return ret
                    end,
                },
                func_map = {
                    drop = "o",
                    openc = "O",
                    split = "<C-s>",
                    tabdrop = "<C-t>",
                    tabc = "",
                    vsplit = "<C-v>",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },
    {
        -- note: Highlight, jump between pairs like if..else
        "andymass/vim-matchup",
        lazy = true,
        event = { "User FileOpened" },
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
            lvim.builtin.treesitter.matchup.enable = true
        end,
    },
    {
        -- note: Restore last session of current dir
        "folke/persistence.nvim",
        lazy = true,
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        config = function()
            require("persistence").setup({
                dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
                options = { "buffers", "curdir", "tabpages", "winsize" },
                pre_save = nil,
            })
        end,
    },
    {
        -- note: flod conteng
        "kevinhwang91/nvim-ufo",
        lazy = false,
        cmd = { "UfoDisable", "UfoEnable" },
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true


            vim.cmd([[highlight AdCustomFold guifg=#bf8040]])
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ("  %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end

                -- Second line
                local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)
                local secondLine = nil
                if #lines == 1 then
                    secondLine = lines[1]
                elseif #lines > 1 then
                    secondLine = lines[2]
                end
                if secondLine ~= nil then
                    table.insert(newVirtText, { secondLine, "AdCustomFold" })
                end

                table.insert(newVirtText, { suffix, "MoreMsg" })

                return newVirtText
            end

            require("ufo").setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
                fold_virt_text_handler = handler,
            })
        end,
    },
    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        config = function()
            local opts = {
                highlight_hovered_item = true,
                show_guides = true,
                auto_preview = true,
                position = "right",
                relative_width = true,
                width = 40,
                auto_close = true,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = "Pmenu",
                autofold_depth = 1,
                auto_unfold_hover = true,
                fold_markers = { "", "" },
                wrap = false,
                keymaps = {
                    -- These keymaps can be a string or a table for multiple keys
                    close = { "<Esc>", "q" },
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "S",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "P",
                    unfold_all = "U",
                    fold_reset = "R",
                },
                lsp_blacklist = {},
                symbol_blacklist = {},
                symbols = {
                    File = { icon = "", hl = "@text.uri" },
                    Module = { icon = "", hl = "@namespace" },
                    Namespace = { icon = "", hl = "@namespace" },
                    Package = { icon = "", hl = "@namespace" },
                    Class = { icon = "𝓒", hl = "@type" },
                    Method = { icon = "ƒ", hl = "@method" },
                    Property = { icon = "", hl = "@method" },
                    Field = { icon = "", hl = "@field" },
                    Constructor = { icon = "", hl = "@constructor" },
                    Enum = { icon = "", hl = "@type" },
                    Interface = { icon = "ﰮ", hl = "@type" },
                    Function = { icon = "", hl = "@function" },
                    Variable = { icon = "", hl = "@constant" },
                    Constant = { icon = "", hl = "@constant" },
                    String = { icon = "𝓐", hl = "@string" },
                    Number = { icon = "#", hl = "@number" },
                    Boolean = { icon = "", hl = "@boolean" },
                    Array = { icon = "", hl = "@constant" },
                    Object = { icon = "", hl = "@type" },
                    Key = { icon = "🔐", hl = "@type" },
                    Null = { icon = "NULL", hl = "@type" },
                    EnumMember = { icon = "", hl = "@field" },
                    Struct = { icon = "𝓢", hl = "@type" },
                    Event = { icon = "🗲", hl = "@type" },
                    Operator = { icon = "+", hl = "@operator" },
                    TypeParameter = { icon = "𝙏", hl = "@parameter" },
                    Component = { icon = "󰡀", hl = "@function" },
                    Fragment = { icon = "", hl = "@constant" },
                },
            }
            require("symbols-outline").setup(opts)
        end,
    },
    {
        "LeonHeidelbach/trailblazer.nvim",
        lazy = true,
        keys = { "<A-s>", "<A-d>" },
        config = function()
            -- local HOME = os.getenv("HOME")
            require("trailblazer").setup({
                auto_save_trailblazer_state_on_exit = false,
                auto_load_trailblazer_state_on_enter = false,
                -- custom_session_storage_dir = HOME .. "/.local/share/trail_blazer_sessions/",
                trail_options = {
                    mark_symbol = "•",        --  will only be used if trail_mark_symbol_line_indicators_enabled = true
                    newest_mark_symbol = "󰝥", -- disable this mark symbol by setting its value to ""
                    cursor_mark_symbol = "󰺕", -- disable this mark symbol by setting its value to ""
                    next_mark_symbol = "󰬦",  -- disable this mark symbol by setting its value to ""
                    previous_mark_symbol = "󰬬", -- disable this mark symbol by setting its value to ""
                },
                mappings = {
                    nv = {
                        motions = {
                            new_trail_mark = "<A-s>",
                            track_back = "<A-d>",
                            peek_move_next_down = "<A-J>",
                            peek_move_previous_up = "<A-K>",
                            move_to_nearest = "<A-n>",
                            toggle_trail_mark_list = "<A-o>",
                        },
                        actions = {
                            delete_all_trail_marks = "<A-L>",
                            paste_at_last_trail_mark = "<A-p>",
                            paste_at_all_trail_marks = "<A-P>",
                            set_trail_mark_select_mode = "<A-t>",
                            switch_to_next_trail_mark_stack = "<A-.>",
                            switch_to_previous_trail_mark_stack = "<A-,>",
                            set_trail_mark_stack_sort_mode = "<A-S>",
                        },
                    },
                },
                quickfix_mappings = { -- rename this to "force_quickfix_mappings" to completely override default mappings and not merge with them
                    -- nv = {
                    --  motions = {
                    --   qf_motion_move_trail_mark_stack_cursor = "<CR>",
                    --  },
                    --  actions = {
                    --   qf_action_delete_trail_mark_selection = "d",
                    --   qf_action_save_visual_selection_start_line = "v",
                    --  },
                    --  alt_actions = {
                    --   qf_action_save_visual_selection_start_line = "V",
                    --  },
                    -- },
                    -- v = {
                    --  actions = {
                    --   qf_action_move_selected_trail_marks_down = "<C-j>",
                    --   qf_action_move_selected_trail_marks_up = "<C-k>",
                    --  },
                    -- },
                },
            })
        end,
    },
    -- note: exter lsp complete
    { "lukas-reineke/cmp-under-comparator", lazy = true },
    {
        "f3fora/cmp-spell",
        lazy = true,
        config = function()
            vim.opt.spell = true
            vim.opt.spelllang:append "en_us"
        end,
    },
    {
        "ray-x/cmp-treesitter",
        lazy = true,
    },
    {
        -- note: preview goto plug
        "rmagatti/goto-preview",
        lazy = false,
        keys = { "gp" },
        config = function()
            require("goto-preview").setup({
                width = 120,
                height = 25,
                default_mappings = true,
                debug = false,
                opacity = nil,
                post_open_hook = nil,
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
            })
        end,
    },
    {
        -- note: startuptime
        "liuzihua699/startuptime.nvim",
        -- config = function()
        --     require("startuptime").setup()
        -- end
    },
    {
        --note: chatgpt-3 powerful
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "",
                keymaps = {
                    close = { "<Esc>" },
                    new_session = "<C-n>",
                    cycle_windows = "<Tab>",
                    cycle_modes = "<C-f>",
                    select_session = "<Space>",
                    rename_session = "r",
                    delete_session = "d",
                    toggle_settings = "<C-o>",
                    toggle_message_role = "<C-r>",
                    toggle_system_role_open = "<C-s>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                },
                popup_input = {
                    submit = "<C-g>",
                }
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        -- lsp ui
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
    -- {
    --     -- rust tools
    --     "simrat39/rust-tools.nvim",
    --     {
    --         -- rust dependencies
    --         "saecki/crates.nvim",
    --         version = "v0.3.0",
    --         dependencies = { "nvim-lua/plenary.nvim" },
    --         config = function()
    --             require("crates").setup {
    --                 null_ls = {
    --                     enabled = true,
    --                     name = "crates.nvim",
    --                 },
    --                 popup = {
    --                     border = "rounded",
    --                 },
    --             }
    --         end,
    --     },
    -- },
}
for _, v in pairs(lvim_themes) do
    table.insert(lvim_plugins, v)
end
lvim.plugins = lvim_plugins


-- global keymap definition
local keymap = lvim.builtin.which_key.mappings
local vkeymap = lvim.builtin.which_key.vmappings
local wk = require("which-key")

-- delete and rename some whichkey describe
wk.register({ gp = { name = "goto-preview" } })

-- -- Use which-key to add extra bindings with the leader-key prefix
keymap["u"] = {
    name = "+Use keymap",
    c = { "<cmd>cd %:p:h<CR>:pwd<CR>", "change current file directory" }
}

-- disable leader whichkey
keymap["T"] = nil
keymap["w"] = nil
keymap["q"] = nil

-- which-key from "folke/persistence.nvim", file session
keymap["S"] = { name = "+Session" }
keymap["Sa"] = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" }
keymap["Sl"] = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" }
keymap["SQ"] = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" }

-- "kevinhwang91/nvim-ufo" keymap configure, fold code
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set("n", "B", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.lsp.buf.hover()
    end
end)

-- which-key from "simrat39/symbols-outline.nvim", outline windows
-- keymap["o"] = { name = "+Symbol outline" }
keymap["o"] = { "<cmd>SymbolsOutline<cr>", "toggle symbols-outline windows" }

-- which-key for ChatGPT.nvim
vkeymap["g"] = { name = "+ChatGPT" }
vkeymap["ge"] = { "<cmd>lua require('chatgpt').edit_with_instructions()<cr>", "Edit with instructions" }
keymap["G"] = { "<cmd>ChatGPT<cr>", "Open ChatGPT windows" }
keymap["A"] = { "<cmd>ChatGPTActAs<cr>", "Open ChatGPTActAs windows" }






-- ==================================================================================================
-- -- -- dap and lsp configure
lvim.builtin.treesitter.ensure_installed = {
    "lua",
    "rust",
    "toml",
}
