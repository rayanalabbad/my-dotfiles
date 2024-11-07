return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({})
	end
}
