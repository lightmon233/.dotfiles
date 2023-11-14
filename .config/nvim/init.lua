-- 调用各种配置和插件

-- 在 Lua 中，使用 require 函数加载模块时，可以省略 .lua 文件的扩展名和文件夹目录的路径。这是因为 Lua 在加载模块时会按照一定的规则搜索指定的模块名。
-- 默认情况下，require 函数会按照以下步骤搜索模块：
-- 首先，它会在预定义的搜索路径中查找，包括 Lua 标准库和用户自定义的搜索路径。
-- 如果在预定义的搜索路径中找不到模块，那么它会尝试查找与模块名相同的 Lua 文件（.lua 扩展名）。
-- 如果还是找不到，它会尝试查找与模块名相同的 C 程序库。
-- 这种搜索规则使得可以直接使用模块名来加载对应的 Lua 模块，而无需显式指定文件夹目录路径和扩展名。

if vim.g.neovide then
    vim.o.guifont = "MesloLGL Nerd Font:h12:b"
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_transparency = 0.9
end

-- 最先调用
require("plugins.lazy-nvim")
require("plugins.onedark")

-- 配置
require("core.options") -- 实际上应该是"lua.core.options", 但是lua可以省略
require("core.keymaps")

-- 插件, 主要是各个插件的具体配置，下载交给了lazy.nvim来完成
require("plugins.lualine")
require("plugins/nvim-tree")
require("plugins/treesitter")
require("plugins/lsp")
require("plugins/cmp")
require("plugins/comment")
require("plugins/autopairs")
require("plugins/bufferline")
require("plugins/gitsigns")
require("plugins/telescope")
require("plugins/copilot")
require("plugins/indent-blankline")
require("plugins/ufo")
