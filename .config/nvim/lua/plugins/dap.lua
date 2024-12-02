---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
    local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str)) --[[@as string]]
        if config.type and config.type == 'java' then
            ---@diagnostic disable-next-line: return-type-mismatch
            return new_args
        end
        return require('dap.utils').splitstr(new_args)
    end
    return config
end

-- Debug Adapter Protocol
return {
    'mfussenegger/nvim-dap',
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
            dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
            config = function()
                require('dapui').setup()
            end,
        },
        { 'leoluz/nvim-dap-go' },
        { 'theHamsta/nvim-dap-virtual-text' },
        {
            'jay-babu/mason-nvim-dap.nvim',
            dependencies = 'mason.nvim',
            cmd = { 'DapInstall', 'DapUninstall' },
            opts = {
                automatic_installation = true,
                handlers = {},
                ensure_installed = {
                    'delve',
                },
            },
        },
    },
    config = function()
        require('mason-nvim-dap').setup()
        require('nvim-dap-virtual-text').setup()

        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { desc = 'DAP: ' .. desc })
        end

        local dap = require 'dap'
        local widgets = require 'dap.ui.widgets'

        -- Keymaps
        -- stylua: ignore start
        map('<F5>', function() dap.continue() end, "Run/Continue")
        map('<S-F5>', function() dap.continue({ before = get_args }) end, "Run with Args")
        map('<F6>', function() dap.run_to_cursor() end, "Run to Cursor")
        map('<F10>', function() dap.step_over() end, "Step Over")
        map('<F11>', function() dap.step_into() end, "Step Into")
        map('<F12>', function() dap.step_out() end, "Step Out")
        map('<leader>b', function() dap.toggle_breakpoint() end, "Toggle Breakpoint")
        map('<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Set a conditional breakpoint")
        map('<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "Log point message")
        map('<leader>dr', function() dap.repl.toggle() end, "Toggle REPL")
        map('<leader>dl', function() dap.run_last() end, "Run Last")

        map('<leader>dh', function() widgets.hover() end, "Evaluates the expression and displays the result in a floating window", {'n', 'v'})
        map('<leader>dp', function() widgets.preview() end, "Like hover but uses the preview window", {'n', 'v'})
        map('<leader>df', function() widgets.centered_float(widgets.frames) end, "View current frames in a sidebar", {'n', 'v'})
        --map('<leader>ds', function() widgets.centered_float(widgets.scopes) end, "Show current scopes", {'n', 'v'})

        map('<leader>dj', function() dap.down() end, "Go down in current stacktrace without stepping")
        map('<leader>dk', function() dap.up() end, "Go up in current stacktrace without stepping")
        --map('<leader>ds', function() dap.session() end, "Session")
        map('<leader>dt', function() dap.terminate() end, "Terminate")
        -- stylua: ignore end

        local dapui = require 'dapui'

        dapui.setup()
        -- DAP UI settings
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        require('dap-go').setup()

        vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
        local icons = {
            Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
            Breakpoint = ' ',
            BreakpointCondition = ' ',
            BreakpointRejected = { ' ', 'DiagnosticError' },
            LogPoint = '.>',
        }
        for name, sign in pairs(icons) do
            sign = type(sign) == 'table' and sign or { sign }
            vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
        end
    end,
}
