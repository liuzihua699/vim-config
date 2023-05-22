# chatgpt
![chatgpt](chatgpt.img) 

# keymap
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

# 可能出现的问题
1.  Cursor position outside buffer报错
删除 ~/.local/state/nvim/chatgpt

2. 按下<CR>或者<C-Enter>不会提交
改为<C-t>提交

3. 报错API ERROR
没有配置Api-key
