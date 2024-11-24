return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            enabled = true,
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-file-browser.nvim', enabled = true },
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'TelescopeResults',
            callback = function(ctx)
                vim.api.nvim_buf_call(ctx.buf, function()
                    vim.fn.matchadd('TelescopeParent', '\t\t.*$')
                    vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
                end)
            end,
        })

        local function formattedName(_, path)
            local tail = vim.fs.basename(path)
            local parent = vim.fs.dirname(path)
            if parent == '.' then
                return tail
            end
            return string.format('%s\t\t%s', tail, parent)
        end

        local telescope = require 'telescope'
        local actions = require 'telescope.actions'
        --local trouble = require 'trouble.sources.telescope'
        local icons = require 'config.icons'

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous, -- move to prev result
                        ['<C-j>'] = actions.move_selection_next, -- move to next result
                        ['<C-l>'] = actions.select_default, -- open file
                        -- ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                    },
                },
                layout_strategy = 'horizontal',
                previewer = false,
                prompt_prefix = ' ' .. icons.ui.Telescope .. ' ',
                selection_caret = icons.ui.BoldArrowRight .. ' ',
                file_ignore_patterns = { 'node_modules', 'package-lock.json' },
                initial_mode = 'insert',
                select_strategy = 'reset',
                sorting_strategy = 'ascending',
                color_devicons = true,
                set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                layout_config = {
                    prompt_position = 'top',
                    preview_cutoff = 120,
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob=!.git/',
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    previewer = false,
                    path_display = formattedName,
                    layout_config = {
                        height = 0.4,
                        prompt_position = 'top',
                        preview_cutoff = 120,
                    },
                    file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                },
                git_files = {
                    previewer = false,
                    path_display = formattedName,
                    layout_config = {
                        height = 0.4,
                        prompt_position = 'top',
                        preview_cutoff = 120,
                    },
                },
                buffers = {
                    path_display = formattedName,
                    mappings = {
                        i = {
                            ['<c-d>'] = actions.delete_buffer,
                        },
                        n = {
                            ['<c-d>'] = actions.delete_buffer,
                        },
                    },
                    previewer = false,
                    initial_mode = 'normal',
                    -- theme = "dropdown",
                    layout_config = {
                        height = 0.4,
                        width = 0.6,
                        prompt_position = 'top',
                        preview_cutoff = 120,
                    },
                },
                current_buffer_fuzzy_find = {
                    previewer = true,
                    layout_config = {
                        prompt_position = 'top',
                        preview_cutoff = 120,
                    },
                },
                live_grep = {
                    only_sort_text = true,
                    previewer = true,
                },
                grep_string = {
                    only_sort_text = true,
                    previewer = true,
                },
                lsp_references = {
                    show_line = false,
                    previewer = true,
                },
                treesitter = {
                    show_line = false,
                    previewer = true,
                },
                colorscheme = {
                    enable_preview = true,
                },
            },
            live_grep = {
                file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                additional_args = function(_)
                    return { '--hidden' }
                end,
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                },
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown {
                        previewer = false,
                        initial_mode = 'normal',
                        sorting_strategy = 'ascending',
                        layout_strategy = 'horizontal',
                        layout_config = {
                            horizontal = {
                                width = 0.5,
                                height = 0.4,
                                preview_width = 0.6,
                            },
                        },
                    },
                },
                file_browser = {
                    path = '%:p:h', -- open from within the folder of your current buffer
                    display_stat = false, -- don't show file stat
                    grouped = true, -- group initial sorting by directories and then files
                    hidden = true, -- show hidden files
                    hide_parent_dir = true, -- hide `../` in the file browser
                    hijack_netrw = true, -- use telescope file browser when opening directory paths
                    prompt_path = true, -- show the current relative path from cwd as the prompt prefix
                    use_fd = true, -- use `fd` instead of plenary, make sure to install `fd`
                },
                package_info = {
                    -- Optional theme (the extension doesn't set a default theme)
                    -- theme = "ivy",
                },
            },
        }

        telescope.load_extension 'fzf'
        telescope.load_extension 'ui-select'
        telescope.load_extension 'dap'
        telescope.load_extension 'file_browser'
        telescope.load_extension 'noice'

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        local map = vim.keymap.set

        map('n', '-', ':Telescope file_browser<CR>', { desc = '[ ] Open file browser' })
        map('n', '<leader>ss', builtin.treesitter, { desc = '[S]earch treesitter [S]ymbols in current buffer' })
        map('n', '<leader>fs', builtin.spell_suggest, { desc = 'List spell options' })

        map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        map('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        map('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

        --vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        --vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    end,
}
