# lunarvim
## 快速安装
注意：安装前检查网络，尽量使用科学上网

```
bash <(curl -s https://raw.githubusercontent.com/lunarvim   /lunarvim/master/utils/installer/install.sh)
```

## nerd font支持
如果打开后的开始页面存在乱码，则需要给你的terminal安装nerd font。

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

最后，翻阅你的terminal设置选项，配置nerd字体为控制台字体即可。

## 快速使用
首先，你需要尽量多的使用`leader`键去唤起which-key，默认配置的`leader`键为`,`，使用`lvim`打开任意文件后，按下`,`等待1秒会弹出which-key的菜单。

使用`,Lk`会显示当前文件下所有配置过的按键命令，`,sC`会显示当前文件下所有的nvim命令。当遇到记不住的内容时，可以多使用这2个命令获取相关帮助。

## 文本反向搜索支持
`telescope.nvim`中提供的live-group和grep_string功能支持根据文本内容搜索文件，但需要安装ripgrep，使用如下命令：

`homebrew`
```shell
brew install ripgrep
```

`ubuntu`
```shell
sudo apt-get install ripgrep
```
