return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'navarasu/onedark.nvim',
    },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'onedark', -- Set theme based on environment variable
                -- Some useful glyphs:
                -- https://www.nerdfonts.com/cheat-sheet
                --        
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                disabled_filetypes = { 'alpha', 'neo-tree' },
                always_divide_middle = true,
            },
        }
    end,
}
