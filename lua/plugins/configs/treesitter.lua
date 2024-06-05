local options = {
  ensure_installed = {
    "lua",
    "vim", "vimdoc",
    "python",
    "go", "gomod", "gosum", "gowork",
    "yaml", "json", "regex",
    "dockerfile", "terraform",
    "bash", "make"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
