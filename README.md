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
sudo apt install powerline
pip install powerline-status
pip show powerline-status

echo -e "\n" >> ~/.bash_rc
echo -e "\n" >> ~/.bash_profile
echo "./.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh" >> ~/.bash_rc
echo "./.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh" >> ~/.bash_profile

ln -s ${PWD}/dev-env.cfg/powerline.conf/powerline.conf ~/.powerline.conf
```

### powerline-fonts

http://cenalulu.github.io/linux/mac-powerline/

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


### Chrome

```sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo apt-get update
sudo apt-get install google-chrome-stable
# sudo apt-get install google-chrome-beta
# sudo apt-get install google-chrome-unstable
```

