return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "cpp", "rust", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "tsx", "json", "sql", "html", "css", "python" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
