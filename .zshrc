
source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# antigen theme bhilburn/powerlevel9k powerlevel9k
# antigen theme spaceship
antigen apply

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="alanpeabody"
# ZSH_THEME="avit"
# ZSH_THEME="spaceship"
ZSH_THEME="ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew docker git-flow gitignore gulp tmux ssh-agent)

# User configuration
source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export RCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# ssh-add -A
# ssh-add ~/.ssh/id_rsa

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export NODE_PATH=/usr/local/lib/node_modules/

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export GO15VENDOREXPERIMENT=1

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

if brew list | grep coreutils > /dev/null ; then
  # PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  # alias ls='ls -F --show-control-chars --color=auto'
  # eval `gdircolors -b $HOME/.dir_colors`
fi

# 查看ip测试是否生效 curl -i http://ip.cn
alias set_all_proxy="export ALL_PROXY=socks5://127.0.0.1:1086"
alias set_http_proxy="export http_proxy=http://127.0.0.1:6789"
alias set_https_proxy="export https_proxy=https://127.0.0.1:6789"
alias unset_proxy="unset ALL_PROXY && unset http_proxy && unset https_proxy"

alias atom="/Applications/Atom.app/Contents/MacOS/Atom"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias vscode="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

function gitdd () {
	echo 'deploy current branch to demo'
	git branch -f develop HEAD 
	git push -f origin develop
}

function gitdp () {
	echo 'deploy current branch to prod'
	git branch release/$1
	git push origin release/$1
}

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/local/etc/profile.d/z.sh ] && . /usr/local/etc/profile.d/z.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval $(thefuck --alias)
