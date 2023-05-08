# lunarvim
## quick install
注意：安装前检查网络，尽量使用科学上网

```
bash <(curl -s https://raw.githubusercontent.com/lunarvim   /lunarvim/master/utils/installer/install.sh)
```

## person keymap
首先，你需要尽量多的使用`leader`键去唤起which-key。

我列举了一些我认为比较重要的keymap：

全局帮助相关：
keymap | note
---|---
leader+LK | 查看lvim所有当前可用的keymap
leader+sC | 搜索lvim所有当前可用命令
leader+sk | 搜索lvim所有当前可用keymap


插件相关：
keymap | note
---|---
leader+e | 弹出nvim-tree目录树
leader+f | 当前目录搜索文件
leader+; | 打开dashboard页面
`<C-4>` or `<C-\>` | 弹出terminal窗口
leader+uc | 切换nvim-tree为当前文件所在目录
(noremal mode)E or R | 向前或向后快速跳转字符
ysiw' | 选中当前指针的字在两边插入符号
(noremal mod)% | 跳转到下一个匹配的符号

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


## nerd font support
下载nerd font：
```shell
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf"
```

然后刷新字体：
```shell
fc-cache -f -v .
```

最后，翻阅你的terminal设置选项，配置nerd字体为控制台字体




