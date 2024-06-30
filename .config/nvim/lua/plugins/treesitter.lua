return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			vim.treesitter.language.register("markdown", "mdx")
			config.setup({
				ensure_installed = {
					"go",
					"typescript",
					"javascript",
					"astro",
					"rust",
					"python",
					"lua",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
