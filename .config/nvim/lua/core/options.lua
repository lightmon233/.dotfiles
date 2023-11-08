local opt = vim.opt

-- 行号
opt.relativenumber = false -- 显示的行号变为行号偏移值
opt.number = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4 -- 使用`>>`或者`<<`命令时的缩进格数
opt.expandtab = true -- 执行<Tab>时实际插入了空格而不是制表符
opt.autoindent = true -- 换行自动缩进

-- 防止包裹
opt.wrap = true -- 文本行数超出时自动换行

-- 光标行
opt.cursorline = true -- 光标所在行高亮显示

-- 启用鼠标
opt.mouse:append("a") -- mouse是一个table, append是往这个table中加参数

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true -- 忽略大小写
opt.smartcase = true -- 有大写字母时敏感

-- 外观
opt.termguicolors = true -- 真彩色
opt.signcolumn = "yes" -- 使用符号列


