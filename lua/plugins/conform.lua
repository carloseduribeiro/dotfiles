return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				go = { "gofmt", "gci" },
				lua = { "stylua", "lua-format" },
				-- yaml = { { "yamlfmt", "yq", stop_after_first = true } },
			},
			notify_on_error = true,
		})

		vim.keymap.set({ "n", "v" }, "<leader>l", function()
			local success, err = pcall(function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 2000,
				})
			end)
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
