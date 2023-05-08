# lunarvim
## quick install
note: preinstall please check you network.

```
bash <(curl -s https://raw.githubusercontent.com/lunarvim   /lunarvim/master/utils/installer/install.sh)
```

## person keymap
first, you need to use the `leader` key to weak which-key.

I list some important keymap:

about help:
keymap | note
---|---
leader+LK | view lvim keymappings
leader+sC | search lvim command
leader+sk | search lvim key map


about plug:
keymap | note
---|---
leader+e | popup nvim-tree
leader+f | find file 
leader+; | jump to dashboard
`<C-4>` or `<C-\>` | popup terminal windows


about lsp:
keymap | note
---|---
S | show documention hover current point
gd | jump to definition
gr | jump to references
gI | jump to implemention


about IDE:
keymap | note
---|---
leader+/ | comment line 
gb | comment block
`<M-j>` | move down current line
`<M-K>` | move up current line
`<C-space>` |  popup code lsp


about windows:
keymap | note
---|---
`<C-w>` | switch windows focus
`<C-h>` | focus to left
`<C-l>` | focus to right
`<C-j>` | focus to down
`<C-k>` | focus to up


## nerd font support
download nerd font:
```shell
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf"
```

then flush font:
```shell
fc-cache -f -v .
```

finally, select the nerd font on your terminal.




