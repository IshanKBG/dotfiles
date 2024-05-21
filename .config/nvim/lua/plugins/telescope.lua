return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope-smart-history.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").setup({
				defaults = {
					path_display = { "truncate " },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			-- telescope.load_extension("fzf")

			-- set keymaps
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>fd", builtin.find_files, { desc = "Fuzzy find files in cwd" })
			vim.keymap.set("n", "<leader>ft", builtin.git_files, { desc = "Fuzzy find git files" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find help tags" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fuzzy find string in cwd" })
			vim.keymap.set(
				"n",
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				{ desc = "Fuzzy find string in current buffer" }
			)

			vim.keymap.set("n", "<leader>gw", builtin.grep_string, { desc = "Grep string in cwd" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
