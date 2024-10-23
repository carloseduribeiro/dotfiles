return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
		-- "telescope-dap.nvim"
	},
	keys = {
		-- { "<leader>f", function() require("config.utils").telescope_git_or_file() end, desc = "Find Files (Root)" },
		-- File Pickers:
		{ "<leader>ff", function() require("telescope.builtin").find_files() end,   desc = "Search file in your current working directory, respects .gitignore" },
		{ "<leader>fg", function() require("telescope.builtin").grep_string() end,  desc = "Searches for the string under your cursor or selection in your current working directory" },
		{ "<leader>fs", function() require("telescope.builtin").live_grep() end,    desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore" },
		-- Vim Pickers:
		{ "<leader>o",  function() require("telescope.builtin").buffers() end,      desc = "Lists open buffers in current neovim instance" },
		-- Neovim LSP Pickers
		-- Git Pickers
		-- { "<leader>sg", function() require("telescope.builtin").git_files() end,    desc = "Search Git Files" },
		-- { "<leader>sh", function() require("telescope.builtin").help_tags() end,    desc = "Find Help" },
		-- { "<leader>sH", function() require("telescope.builtin").highlights() end,   desc = "Find highlight groups" },
		-- { "<leader>sM", function() require("telescope.builtin").man_pages() end,    desc = "Map Pages" },
		-- { "<leader>so", function() require("telescope.builtin").oldfiles() end,     desc = "Open Recent File" },
		-- { "<leader>sR", function() require("telescope.builtin").registers() end,    desc = "Registers" },
		-- { "<leader>sk", function() require("telescope.builtin").keymaps() end,      desc = "Keymaps" },
		-- { "<leader>sC", function() require("telescope.builtin").commands() end,     desc = "Commands" },
		-- { "<leader>sl", function() require("telescope.builtin").resume() end,       desc = "Resume last search" },
		-- { "<leader>sc", function() require("telescope.builtin").git_commits() end,  desc = "Git commits" },
		-- { "<leader>sB", function() require("telescope.builtin").git_branches() end, desc = "Git branches" },
		-- { "<leader>sm", function() require("telescope.builtin").git_status() end,   desc = "Git status" },
		-- { "<leader>sS", function() require("telescope.builtin").git_stash() end,    desc = "Git stash" },
	},
}
