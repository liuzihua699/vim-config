# describe
This project integrates the configuration of `vim` and `nvim`. vimrc is a vim server configuration that did not introduce too many plugins.

`nvim` uses Lunarvim as the base and makes some personalized configurations on top of it. LSP supports various syntax completion such as `java`, `c`, `go`, etc., supports `dap`,`gdb` for debugging, and others also support `nvim-tree`,`git` and and other personalized plugins.

Currently being gradually updated...

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
