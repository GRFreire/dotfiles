function setTheme(theme)
	if theme == 'bamboo' then
		require('bamboo').setup({});
		require('bamboo').load();
	elseif theme == 'sonokai' then
		vim.cmd 'colorscheme sonokai';
		vim.opt.termguicolors = false;
	end
end

setTheme('sonokai')
