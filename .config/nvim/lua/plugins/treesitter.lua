-- Highlight, edit, and navigate code
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- Syntax aware text-objects
        {
            'nvim-treesitter/nvim-treesitter-context', -- Show conde context
            opts = { enable = true, mode = 'topline', line_number = true },
        },
    },
    config = function()
        -- treesitter-context is buggy with Markdown files so this disable it:
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'markdown' },
            callback = function(_)
                require('treesitter-context').disable()
            end,
        })

        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'lua',
                'python',
                'vimdoc',
                'vim',
                'regex',
                'terraform',
                'sql',
                'dockerfile',
                'toml',
                'json',
                'java',
                'gitignore',
                'graphql',
                'yaml',
                'make',
                'cmake',
                'markdown',
                'markdown_inline',
                'bash',
                'go',
                'gomod',
                'gosum',
                'gowork',
            },
            indent = { enable = true, disable = { 'ruby' } },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                disable = { 'csv' }, -- install plugin chrisbra/csv.nvim because its better
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },
            textobjects = { select = { enable = true, lookahead = true } },
        }
    end,
}
