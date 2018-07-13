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
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "chrissicool/zsh-256color"
  zplug "themes/steeef", from:oh-my-zsh
  zstyle ':completion:*' menu select
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

source /sw/bin/init.sh
# alias vim='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'
alias vim='/Applications/MacVim.app/Contents/bin/vim'
alias nv='/usr/local/bin/nvim'
# alias vi='/Applications/MacVim.app/Contents/bin/vim'
alias relogin='exec $SHELL -l'
alias py='python3'

if [ $SHLVL = 1 ]; then
  tmux
fi
export PATH=$PATH:/Users/tamtam/.nodebrew/current/bin

# Ctrl-PとCtrl-Nで前方一致検索
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
