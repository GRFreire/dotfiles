function SetColor(color)
	color = color or "oxocarbon"
	vim.cmd.colorscheme(color)

	-- Transparent background
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColor()
