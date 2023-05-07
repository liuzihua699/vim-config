#!/bin/bash

set -e

# ---------------------------------- argument progress start ----------------------------------
INSTALL_MODE="easy"
COMPLETE_PLUG="coc"

while [ $# -gt 0 ]; do
    case "$1" in
        --huge)
            INSTALL_MODE="huge"
            ;;
        --easy)
            INSTALL_MODE="easy"
            ;;
        --uninstall)
            INSTALL_MODE="uninstall"
            ;;
        --complete-coc)
            COMPLETE_PLUG="coc"
            ;;
        --complete-apc)
            COMPLETE_PLUG="apc"
            ;;
        --help)
            # todo
            ;;
        --*)
            log_write "Illegal option" 3
            exit 1
            ;;
    esac
    shift $(( $# > 0 ? 1 : 0 ))
done
# ---------------------------------- argument progress end ----------------------------------


# ----------------------------------  main progress start ----------------------------------
case $INSTALL_MODE in
    easy)
        backup_vimrc
        ;;
    huge)
        backup_vimrc
        install
        ;;
    uninstall)
        if check_isinstall; then
            do_uninstall
        fi
        ;;
esac
print_finish
# ----------------------------------  main progress end ----------------------------------

function print_finish() {
    log_write "Installed ok."
    log_write "Just enjoy it!"
}


function backup_vimrc() {
    old_vim=$HOME/.vimrc
    time=$(date "+%Y%m%d%H%M%S")
    if [ -f $old_vim ]; then
        read -p "Find "$old_vim" already exists, backup to "$old_vim"."$time"? [Y/N] " ch
        if [[ $ch == "N" ]] || [[ $ch == "n" ]] || [[ -z $ch ]]; then
            # mv $old_vim $old_vim.bak
            log_write "Backup ok. Please to see "$old_vim"."$time" to view old configure." 
        fi
    fi

    if [ -d $HOME/.vim ]; then
        read -p "Find "$HOME"/.vim already exists, backup to "$HOME"/.vim."$time"? [Y/N] " ch
        if [[ $ch == "N" ]] || [[ $ch == "n" ]] || [[ -z $ch ]]; then
            # mv $old_vim $old_vim.bak
            log_write "Backup ok. Please to see "$HOME"/.vim."$time" to view old configure." 
        fi
    fi
}


function install_require_on_ubuntu() {
    sudo apt-get update
    sudo apt-get install -y vim
    sudo apt-get install -y curl git wget ripgrep
    sudo apt-get install -y build-essential python python-dev python3-dev fontconfig libfile-next-perl ack-grep ack
}


# todo
function install_and_config_nodejs() {
    if [  command_exists node ]; then
        # 如果存在node，判断node的版本，如果太小则退出并要求用户卸载
        exit 1
    fi

    # url : https://nodejs.org/dist/v16.17.1/node-v16.17.1-linux-x64.tar.xz    
    NODE_VERSION=v16.17.1
    PKG_NAME=node-v16.17.1-linux-x64.tar.xz
    PKG_URL=https://nodejs.org/dist/v16.17.1/node-v16.17.1-linux-x64.tar.xz
    INSTALL_PATH=/usr/local/

    cd $HOME && wget $PKG_URL
    if [ $? -eq 0 ]; then
        log_write "Download $PKG_NAME success, start extract into $INSTALL_PATH ."
    else
        log_write "Download $PKG_NAME faile, please check the newtork is connected to website $PKG_URL." 3
        exit 1
    fi
    sudo tar xf $PKG_NAME -C "${INSTALL_PATH}"
    npm config set registry https://registry.npmmirror.com
    rm -rf $PKG_NAME
}


function pre_install() {
    install_require_on_ubuntu
    install_and_config_nodejs
}


function vimplug_install() {
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    if [ $? -ne 0 ]; then
        log_write "Download plug.vim into ~/.vim/autoload/plug.vim sueccess."
    else
        log_write "Download plug.vim failed, please check your network." 3
        exit 1
    fi
}


function install() {
    pre_install
    vimplug_install

#     git clone https://github.com/neoclide/coc.nvim ~/.vim/plugged/coc.nvim >/dev/null
    git clone https://gitee.com/zgpio/coc.nvim.git ~/.vim/plugged/coc.nvim >/dev/null
    if [ $? -eq 0 ]; then
       log_write "Download coc.nvim into ~/.vim/plugged/coc.nvim ."
    else
        log_write "Download coc.nvim failed, please check your network."
        exit 1
    fi

    cd ~/.vim/plugged/coc.nvim
    git checkout release
    git reset --hard v0.0.80

    vim -c "PlugInstall" -c "q" -c "q"
}


# Uninstall more plugin and only saved user .vimrc configure.
function do_uninstall() {
    rm -rf ~/.config/coc
    rm -rf ~/.vim
    rm -rf ~/.vimrc
}


# $1: log content
# $2: log level, like INFO/WARN/ERROR
# $3: log file path
logpath="/tmp/vimserver.log"
function log_write() {
    level="INFO"
    case $2 in
        2)
            level="WARN"
            ;;
        3)
            level="ERROR"
            ;;
    esac

    if [ $3 ]; then
        logpath=$3
    fi

    now=`date +"%Y-%m-%d %H:%M:%S"`
    echo "["$level"] "$now" "$1 | tee -a $logpath
}


function command_exists() {
    command -v "$@" >/dev/null 2>$1
}
