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
ln -s ${PWD}/dev-env.cfg/powerline.conf/powerline.conf ~/.powerline.conf
```


