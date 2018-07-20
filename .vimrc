let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
set runtimepath+=$CONFIG/nvim
runtime! $CONFIG/nvim/init.vim
source $CONFIG/nvim/init.vim
