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
  # zplug "themes/rkj-repos", from:oh-my-zsh
  # zplug "themes/ys", from:oh-my-zsh
  # zplug "themes/tjkirch", from:oh-my-zsh
  # zplug "halfo/lambda-mod-zsh-theme", as:theme
  # zplug "skylerlee/zeta-zsh-theme", as:theme
  # zplug "eendroroy/alien-minimal"
  # zplug "eendroroy/alien"
  zplug "dannynimmo/punctual-zsh-theme", as:theme
  # zplug denysdovhan/spaceship-zsh-theme, use:spaceship.zsh, from:github, as:theme
  zplug "mafredri/zsh-async"
  # zplug "sindresorhus/pure"
  zstyle ':completion:*' menu select=1
  #zplug "mollifier/anyframe"
  # ZSH_THEME="lambda-mod"
  PUNCTUAL_PROMPT="$";
  PUNCTUAL_TIMESTAMP_BOLD="true";
  PUNCTUAL_USER_BOLD="true";
  PUNCTUAL_ROOT_USER_BOLD="true";
  PUNCTUAL_HOSTNAME_BOLD="true";
  PUNCTUAL_CURRENT_DIR_BOLD="true";
  PUNCTUAL_GIT_BOLD="true";


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

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias nv='nvim'
alias py='python3'
alias relogin='exec $SHELL -l'

# if [ $SHLVL = 1 ]; then
#   if [ -d ~/.tmux ]; then
#     ;
#   else
#     TMUX_VERSION=$(tmux -V | awk '{print $2}' | awk -F. '{printf "%2d%02d", $1,$2}')
#     if [ "$TMUX_VERSION" -ge 109 ]; then
#       echo "Installing Tmux Plugin Manager."
#       git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#       tmux source ~/.tmux.conf
#     else
#       echo "Tmux Plugin Manager is not supported in this version of tmux"
#     fi
#   fi
#   tmux
# fi

if [[ -x ~/bin/tmuxx ]]; then
  if [ -d ~/.tmux ]; then
    ;
  else
    TMUX_VERSION=$(tmux -V | awk '{print $2}' | awk -F. '{printf "%2d%02d", $1,$2}')
    if [ "$TMUX_VERSION" -ge 109 ]; then
      echo "Installing Tmux Plugin Manager."
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      tmux source ~/.tmux.conf
      echo "Installing Tmux Plugins."
      ~/.tmux/plugins/tpm/bindings/install_plugins
    else
      echo "Tmux Plugin Manager is not supported in this version of tmux"
    fi
  fi
  ~/bin/tmuxx
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

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
