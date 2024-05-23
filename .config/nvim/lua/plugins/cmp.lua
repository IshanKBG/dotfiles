return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local ls = require("luasnip")

			-- Set up luasnip
			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				override_builtin = true,
			})

			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				return ls.expand_or_jumpable() and ls.expand_or_jump()
					or vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
			end, { silent = true, noremap = true })

			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				return ls.jumpable(-1) and ls.jump(-1)
					or vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
			end, { silent = true, noremap = true })

			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			vim.opt.shortmess:append("c")

			local lspkind = require("lspkind")
			lspkind.init({})

			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body) -- Use LuaSnip for snippet expansion
					end,
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- Add LuaSnip as a source
					{ name = "path" },
					{ name = "buffer" },
				},
				formatting = {
					format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
				},
			})

			-- Set up vim-dadbod for SQL files
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
