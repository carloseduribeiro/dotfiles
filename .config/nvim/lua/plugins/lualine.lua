return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'navarasu/onedark.nvim',
        'meuter/lualine-so-fancy.nvim',
    },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto', -- Set theme based on environment variable
                -- Some useful glyphs:
                -- https://www.nerdfonts.com/cheat-sheet
                --        
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                always_divide_middle = true,
                disabled_filetypes = {
                    'alpha',
                    'neo-tree',
                    'Trouble',
                },
            },
            sections = {
                lualine_a = { 'fancy_mode' },
                lualine_b = {
                    'fancy_branch',
                    'fancy_diff',
                    { 'fancy_diagnostics', sources = { 'nvim_lsp' }, symbols = { error = ' ', warn = ' ', info = ' ' } },
                },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'encoding', 'fileformat', { 'fancy_filetype', ts_icon = '' } },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                -- lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { 'neo-tree', 'lazy' },
        }
    end,
}
