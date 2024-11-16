return {
    {
        'stevearc/conform.nvim',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
        },
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true }
                end,
                mode = '',
                desc = 'Format buffer',
            },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { 'stylua' },
                sql = { 'sql_formatter', 'sqlfmt', stop_after_first = true },
                go = { 'goimports', 'gofmt' },
            },
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { '-i', '4' },
                },
                sql_formatter = {
                    prepend_args = { '--language', 'postgresql' },
                },
            },
            -- Set default options
            default_format_opts = {
                lsp_format = 'fallback',
            },
            -- Set up format-on-save
            format_on_save = { lsp_format = 'fallback', timeout_ms = 1000 },
            log_level = vim.log.levels.ERROR,
            notify_on_error = true,
            notify_no_formatters = true,
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        'zapling/mason-conform.nvim',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            { 'stevearc/conform.nvim', config = true },
        },
        opts = {},
    },
}