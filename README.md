dev-env.cfg
===========

### install

* vim

```bash
git clone https://github.com/liuyanjie/dev-env.cfg.git \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
    && ln -s ${PWD}/dev-env.cfg/vimrc/vimrc ~/.vimrc \
    && vim +PluginInstall +qall
```

* tmux

```sh
ln -s ${PWD}/dev-env.cfg/tmuxrc/tmux.conf ~/.tmux.conf
```

* powerline

```sh
pip install powerline-status
pip show powerline-status

echo "\n" >> ~/.bash_rc
echo "\n" >> ~/.bash_profile
echo ". /Library/Python/2.7/site-packages/powerline/bindings/bash/powerline.sh" >> ~/.bash_rc
echo ". /Library/Python/2.7/site-packages/powerline/bindings/bash/powerline.sh" >> ~/.bash_profile

ln -s ${PWD}/dev-env.cfg/powerline.conf/powerline.conf ~/.powerline.conf
```

### powerline-fonts

```sh
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```
安装完成后就可以在`iTerm2`或者`Terminal`的字体选项里看到并选择多个xxx for powerline的字体了。 

**注意：对于ASCII fonts和non-ASCII fonts都需要选择for powerline的字体。**

Refs:


### zsh

```sh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

http://cenalulu.github.io/linux/mac-powerline/
