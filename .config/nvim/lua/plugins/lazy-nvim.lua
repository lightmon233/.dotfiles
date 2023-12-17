-- 这段代码是一段 Lua 代码，用于在 Neovim 中加载和配置 lazy.nvim 插件。
-- 让我们逐行解释这段代码的含义：
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"：这一行定义了一个变量 lazypath，它存储了 lazy.nvim 插件的路径。vim.fn.stdpath("data") 是一个 Vim 函数，用于获取 Neovim 的数据目录路径，然后通过字符串拼接形成 lazypath 的完整路径。
-- if not vim.loop.fs_stat(lazypath) then：这一行通过调用 vim.loop.fs_stat() 函数检查 lazypath 是否存在。vim.loop.fs_stat() 用于获取文件或目录的状态信息，如果 lazypath 不存在，即表示 lazy.nvim 还没有被安装。
-- vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })：这一行使用 vim.fn.system() 函数执行外部命令，即执行 Git 命令来克隆 lazy.nvim 插件的稳定版本到 lazypath 指定的路径。--filter=blob:none 参数用于减小克隆的数据量，--branch=stable 指定克隆稳定版本。
-- vim.opt.rtp:prepend(lazypath)：这一行将 lazypath 添加到 rtp（runtimepath）中。vim.opt.rtp 用于获取或设置 Neovim 的 runtimepath，它是一个包含插件和运行时文件的目录列表。通过 :prepend() 方法将 lazypath 添加到 rtp 的开头，确保 lazy.nvim 插件在其他插件之前被加载。
-- 综合起来，这段代码的作用是检查 lazy.nvim 插件是否已经安装，如果没有安装则通过 Git 克隆插件的稳定版本，并将其路径添加到 Neovim 的 runtimepath 中，以便在编辑会话中加载和使用 lazy.nvim 插件的功能。

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  -- "folke/which-key.nvim",
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },
  -- "folke/neodev.nvim",

  "navarasu/onedark.nvim", -- 主题

  { 
    "nvim-lualine/lualine.nvim", -- 状态栏
    -- dependencies = { 
    --   'lightmon233/nvim-web-devicons-lualine', optional = true -- 状态栏图标，状态栏的依赖, 可选包
    -- }
  },

  {
    "nvim-tree/nvim-tree.lua", -- 文档树
    dependencies = {
      "nvim-tree/nvim-web-devicons" -- 文档树图标
    }
  },

  "christoomey/vim-tmux-navigator", -- 用ctl-hjkl来定位窗口

  "nvim-treesitter/nvim-treesitter", -- 语法高亮

  "p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",  -- 这个相当于mason.nvim和lspconfig的桥梁
  "neovim/nvim-lspconfig",

  -- 自动补全
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip", -- snippets引擎，不装这个自动补全会出问题
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "hrsh7th/cmp-path", -- 文件路径

  "numToStr/Comment.nvim", -- gcc和gc注释
  "windwp/nvim-autopairs", -- 自动补全括号

  "akinsho/bufferline.nvim", -- buffer分割线
  "lewis6991/gitsigns.nvim", -- 左则git提示

  {
    "nvim-telescope/telescope.nvim", tag = "0.1.1",  -- 文件检索
    dependencies = { {'nvim-lua/plenary.nvim'} } -- 也可以{}
  },

    -- Github Copilot
    "github/copilot.vim",

    -- Indent Blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },

    -- fold 
    'kevinhwang91/promise-async',
    {
        "kevinhwang91/nvim-ufo",
        requires = 'kevinhwang91/promise-async',
        run = ':TSUpdate'
    },

    -- rainbow
    'hiphish/rainbow-delimiters.nvim',

    -- markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    }
})
