-- 在 Vim 中，mapleader 是一个特殊的变量，用于定义自定义键映射的前缀。当你创建自定义的键映射时，可以使用 mapleader 变量作为前缀，使其与 Vim 的内置键映射分隔开来。
-- 通过将 mapleader 设置为一个空格，你可以定义空格键作为自定义键映射的前缀。这样，在定义自己的键映射时，可以将空格键作为前缀，以避免与 Vim 的内置键映射冲突。
-- 例如，如果你设置了 vim.g.mapleader = " "，然后定义了一个键映射：
-- vim
-- nnoremap <Leader>t :tabnew<CR>
-- 在这个例子中，<Leader> 表示空格键，所以按下空格键后再按下 t 将触发一个新建标签页的操作。
-- 通过设置 mapleader 变量，你可以自定义键映射的前缀，以提高自定义功能的灵活性和可扩展性。

vim.g.mapleader = " " -- 相当于设置一个主键，mod键

local keymap = vim.keymap

-- 插入模式
keymap.set("i", "jk", "<ESC>") -- 快速按jk以替代ESC键

-- 视觉模式
---- 单行或多行移动
---- 这些按键映射可以在可视模式下对选中的文本进行操作。它们使用 :m 命令（移动行）将选中的文本行移动到指定位置，并使用 gv=gv 重新选中移动后的文本。其中，'>+1 表示选中文本的最后一行的下一行，'<-2 表示选中文本的第一行的上两行。
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- 将选中文本下移1行
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- 上移2行

-- 正常模式
---- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口, <C-w>是Ctrl和w键的组合
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

---- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>") -- <CR>表示Enter

---- 切换buffer
---- keymap.set("n", "<C-L>", ":bnext<CR>")：这行代码创建了一个 Normal 模式下的按键映射。当你按下 Ctrl 键和 L 键的组合 <C-L> 时，将执行命令 :bnext<CR>，该命令的作用是切换到下一个缓冲区（buffer）。
---- keymap.set("n", "<C-H>", ":bprevious<CR>")：这行代码创建了另一个 Normal 模式下的按键映射。当你按下 Ctrl 键和 H 键的组合 <C-H> 时，将执行命令 :bprevious<CR>，该命令的作用是切换到上一个缓冲区。
---- 这些按键映射允许你在 Normal 模式下使用 <C-L> 和 <C-H> 来快速切换缓冲区。通过定义这些按键映射，你可以更方便地在不同的缓冲区之间进行导航和编辑。
---- 需要注意的是，<C-L> 和 <C-H> 是自定义的按键组合，可以根据个人喜好进行定义。它们选择了 <C-L> 和 <C-H> 是因为在 Vim 中，Ctrl + L 用于重绘屏幕（类似于清屏操作），而 Ctrl + H 通常用于删除前一个字符。因此，这些组合键在普通编辑中很少使用，可以被用于自定义其他功能。
---- 在 Vim 或 Neovim 中，"切换缓冲区" 是指在打开的多个文件之间进行切换，即在不同的缓冲区之间切换焦点和编辑内容。
---- 在编辑器中打开一个文件时，该文件会加载到一个缓冲区中。当你打开多个文件时，每个文件都会在独立的缓冲区中打开，并且每个缓冲区都有一个唯一的编号。
---- 切换缓冲区允许你在打开的多个文件之间快速切换，以便查看和编辑不同的文件内容。你可以使用不同的命令或快捷键来切换缓冲区。
---- 一些常用的切换缓冲区的命令和快捷键包括：
---- :bnext 或 :bn：切换到下一个缓冲区。
---- :bprevious 或 :bp：切换到上一个缓冲区。
---- :bfirst：切换到第一个缓冲区。
---- :blast：切换到最后一个缓冲区。
---- :bnext <buffer-number>：切换到指定编号的缓冲区。
---- <C-^>：在 Normal 模式下，按下 Ctrl 键和 ^ 键的组合，切换到上一个编辑的缓冲区。
---- 这些命令和快捷键可以帮助你在多个文件之间快速导航和编辑，提高工作效率和便利性。
keymap.set("n", "<C-L>", ":bnext<CR>")
keymap.set("n", "<C-H>", ":bprevious<CR>")

-- 插件
---- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap.set("n", "<F5>", ":!g++ main.cpp -o main && ./main < input.txt > output.txt<CR>")

keymap.set("n", "<leader>tp", [[:lua loadTemplate()<CR>]], { noremap = true, silent = true })

function loadTemplate()
    local template_path = vim.fn.expand("~/.config/nvim/template.cpp")
    if vim.fn.filereadable(template_path) == 1 then
        local template_content = vim.fn.readfile(template_path)
        local current_line = vim.fn.line('.')
        vim.fn.append(current_line, template_content)
        print("Template loaded.")
    else
        print("Loading failed.")
    end
end
