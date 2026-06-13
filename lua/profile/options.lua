local options = {
  termguicolors = true,
  tabstop = 2,
  softtabstop = 0,
  shiftwidth = 2,
  smarttab = true,
	number = true,
	relativenumber = true,
	wrap = false,
	smartindent = false, -- used to be true
	hlsearch = false,
	incsearch = true,
	scrolloff = 8,
	colorcolumn = "80",
}
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end
