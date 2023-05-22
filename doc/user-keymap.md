# 核心插件keymap配置

全局帮助相关：
keymap | note
---|---
leader+Lk | 查看lvim所有当前可用的keymap
leader+sC | 搜索lvim所有当前可用命令
leader+sk | 搜索lvim所有当前可用keymap


实用：
keymap | note
---|---
leader+e | 弹出nvim-tree目录树
leader+f | 当前目录搜索文件
leader+; | 打开dashboard页面
`<C-4>` | 调出terminal窗口
leader+uc | 切换nvim-tree为当前文件所在目录


git相关：
keymap | note
---|---
,gd | 弹出git diff窗口
,go | 弹出修改过的文件窗口
,gb | 弹出分支窗口，按下`<CR>`切换到分支
,gc | 弹出git log窗口，按下`<CR>`切换到commit。注意提前保存当前未提交代码
,gC | 弹出git log窗口，但只显示当前文件的commit信息，使用`<CR>`切换到commit


lsp相关：
keymap | note
---|---
S | 显示当前指针下字符的帮助信息
gd | 跳转到当前指针的定义项
gr | 跳转到当前指针的引用项
gI | 跳转到当前指针的实现项


IDE相关：
keymap | note
---|---
leader+/ | 注释一行
gb | 以块的方式注释
`<M-j>` | 当前行向下移动
`<M-K>` | 当前行向上移动
`<C-space>` |  插入模式下弹出候选词组


窗口相关：
keymap | note
---|---
`<C-w>` | 切换窗口焦点
`<C-h>` | 左边的窗口获取焦点
`<C-l>` | 右边的窗口获取焦点
`<C-j>` | 下面的窗口获取焦点
`<C-k>` | 上面的窗口获取焦点
Q | 关掉当前Buffer
`<A-h>` `<A-Left>` | 左边的buffer获取焦点
`<A-l>` `<A-Right>` | 右边的bufferl获取焦点


Buffer相关：
keymap | note
---|---
`,c` | 关闭当前buffer
`,bb` | 左边的buffer获取焦点
`,bn` | 右边的buffer获取焦点
`,bf` | 搜索打开的buffer

ChatGPT相关：
注意：关闭gpt窗口要使用`<C-c>`，否则会导致无法再次打开
keymap | note
---|---
`,G` | 打开GPT窗口
`<C-t>` | 提交当前的问题
`<C-n>` | 打开一个新的session
`<C-o>` | 打开setting窗口
`<C-s>` | 打开系统窗口
`<Tab>` | 切换窗口
`<C-c>` | 关闭GPT窗口
`<Space>` | 选中Session
`r` | 给session重命名
`d` | 删除行或者session

# 用户插件keymap设置

keymap | note | plugin
---|---|--
E or R | 向前或向后快速跳转字符 | leap.nvim
ysiw' | 选中当前指针的字在两边插入符号 | nvim-surround
% | 跳转到下一个匹配的符号 | matchup 
,lq | 增强的quickfix窗口 | nvim-bqf
,Sa | 重新载入上一个关闭窗口的会话 | persistence.nvim
zr | 展开当前文件所有的内容，可折叠的内容左侧会有`-`标识 | nvim-ufo 
zm | 折叠当前文件所有的内容，可展开的内容左侧会有`+`标识 | nvim-ufo 
zc | 当前行折叠，可折叠的内容左侧会有`-`标识 | nvim-ufo
zo | 当前行展开，可展开的内容左侧会有`+`标识 | nvim-ufo
B | 预览折叠的内容 | nvim-ufo
,o | 文件大纲预览，显示标题符号等 | symbols-outline.nvim
`<A-s>` | 在当前行保存轨迹坐标| trailblazer.nvim
`<A-d>` | 回到上一个轨迹，并删除坐标| trailblazer.nvim
`<A-o>` | 使用quickfix窗口打开记录的轨迹坐标| trailblazer.nvim
`<A-L>` | 删除所有的轨迹坐标| trailblazer.nvim
`<A-P>` | 在所有的坐标处粘贴| trailblazer.nvim
gp | 使用goto-preview which-key | goto-preview

