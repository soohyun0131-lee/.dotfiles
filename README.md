# How to set my zsh shell

```shell
# Please be note that you should install followings to use my configurations

# vim-plug : https://github.com/junegunn/vim-plug
# yarn : https://classic.yarnpkg.com/en/docs/install/#debian-stable
# nodejs : https://github.com/nodesource/distributions/blob/master/README.md
# powerlevel10k : https://github.com/romkatv/powerlevel10k

$ sudo apt install zsh
$ chsh -s $(which zsh)

$ git clone git@github.com:mozzi0131/.dotfiles.git

$ ln -sf ~/.dotfiles/.bashrc ~
$ ln -sf ~/.dotfiles/.zshrc ~
$ ln -sf ~/.dotfiles/.vimrc ~
$ ln -sf ~/.dotfiles/.gitconfig ~

$ vi ~/.vimrc
$ PlugInstall

# then restart the shell
```
