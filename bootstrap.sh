#!/bin/bash
set -xe

DIR="$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )"

mkdir -p ~/.vimswap
rm -f ~/.vimrc
ln -snf ${DIR}/vim/vimrc ~/.vimrc
rm -Rf ~/.vim
ln -snf ${DIR}/vim ~/.vim

rm -f ~/.gitconfig
ln -snf ${DIR}/git/gitconfig ~/.gitconfig
rm -f ~/.gitignore
ln -snf ${DIR}/git/gitignore ~/.gitignore

rm -Rf ~/.tmux.conf
ln -snf ${DIR}/tmux/tmux.conf ~/.tmux.conf

cat <<EOF > ~/.zshenv
export DOTFILES="${DIR}"
export ZDOTDIR="\${DOTFILES}/zsh"
source \${ZDOTDIR}/.zshenv
EOF
