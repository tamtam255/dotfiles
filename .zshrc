# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
  return 0
fi

if [ -d ~/.zplug ];
then
  ;
else
  echo "Installing Zplug."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [[ -f ~/.zplug/init.zsh ]]; then
  export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
  source ~/.zplug/init.zsh

  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "chrissicool/zsh-256color"
  # zplug "themes/steeef", from:oh-my-zsh
  zplug "themes/rkj-repos", from:oh-my-zsh
  # zplug "themes/ys", from:oh-my-zsh
  # zplug "themes/tjkirch", from:oh-my-zsh
  zstyle ':completion:*' menu select=1
  #zplug "mollifier/anyframe"


  # if ! zplug check --verbose; then
  #   printf "Install? [y/N]: "
  #   if read -q; then
  #     echo; zplug install
  #   fi
  #   echo
  # fi
  if ! zplug check; then
    zplug install
  fi
  zplug load
fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi


XDG_CONFIG_HOME='~/.config/'

alias nv='nvim'
alias py='python3'
alias relogin='exec $SHELL -l'

if [ $SHLVL = 1 ]; then
  tmux
fi

# Ctrl-PとCtrl-Nで前方一致検索
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
bindkey "\e[Z" reverse-menu-complete
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*' list-colors di=34 ln=35 ex=31

# if [ "$(uname)" == "Darwin" ]; then
#   OS='Mac'
# elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
#   OS='Linux'
# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then                                                                                           
#   OS='Cygwin'
# elif [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
#   OS='WSL'
# else
#   echo "Your platform ($(uname -a)) is not supported."
#   # exit 1
# fi

case ${OSTYPE} in
  darwin*)
    export PATH=$PATH:/Users/tamtam/.nodebrew/current/bin
    source /sw/bin/init.sh
    # alias vim='/usr/local/bin/vim'
    alias vi='/usr/local/bin/vim'
    alias vim='/Applications/MacVim.app/Contents/bin/vim' 
    # alias vi='/Applications/MacVim.app/Contents/bin/vim'
    alias ls="ls -G"
    ;;
  linux*)
    alias ls="ls --color"
    ;;
esac

