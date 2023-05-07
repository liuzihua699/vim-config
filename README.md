# Quick start

## vim for server
only config for vim, exclude plug.

```shell
mv ~/.vimrc ~/.vimrc.old
cp .vimrc ~/.vimrc
# vim -c "PlugInstall" -c "q" -c "q"
```


## lunarvim 
lunarvim is an IDE layer for nvim, so you need pre-install nvim, then apply this configure.

```shell
mv ~/.config/lvim/config.lua ~/.config/lvim/config.lua.old
cp config.lua ~/.config/lvim/config.lua
lvim
```
