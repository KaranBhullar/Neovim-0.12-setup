require("Profile.remap")
require("Profile.options")

-- To ignore node_modules -- 
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules"
    }
  }
}

require("everforest").setup({
	background = "hard",
	colours_override = function(palette)
		palette.bg0 = "#1e2326"
	end,

})

vim.cmd.colorscheme("everforest")

-- Diagnostic icons
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
})

-- Markdown
local presets = require("markview.presets");

require("markview").setup({
    markdown = {
        headings = presets.headings.slanted
    }
});

