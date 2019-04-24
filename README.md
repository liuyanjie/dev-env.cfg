dev-env.cfg
===========


### zsh

```sh
apt install zsh
```

### oh-my-zsh

```sh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

### install

* git

```sh
sudo apt install git
```

* vim

```sh
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
sudo apt install powerline python-pip
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

### Chrome

```sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo apt-get update
sudo apt-get install google-chrome-stable
# sudo apt-get install google-chrome-beta
# sudo apt-get install google-chrome-unstable
```


### Mosh

* https://github.com/shadowsocks/ShadowsocksX-NG
* http://blog.mattgauger.com/blog/2012/04/21/mosh-ssh-tunnels-tmux/
* https://blog.filippo.io/my-remote-shell-session-setup/
* https://monda.hu/2013/01/26/how-to-rule-remote-shell-sessions-with-tmux-and-mosh
* http://freemind.pluskid.org/misc/mosh-the-mobile-shell/
* https://mosh.org/

