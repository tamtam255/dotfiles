""""""""""""""""""""""""""""""
"プラグイン導入
""""""""""""""""""""""""""""""
if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

if exists('g:nyaovim_version')
  let s:dein_cache_path = expand('$CACHE/nyaovim/dein')
elseif has('nvim')
  let s:dein_cache_path = expand('$CACHE/nvim/dein')
else
  let s:dein_cache_path = expand('$CACHE/vim/dein')
endif

let s:dein_dir = s:dein_cache_path
      \ .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif



if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
  let s:lazytoml_file = fnamemodify(expand('<sfile>'), ':h').'/deinlazy.toml'
  call dein#load_toml(s:toml_file, {'lazy' : 0})
  call dein#load_toml(s:lazytoml_file, {'lazy' : 1})

  if exists('g:nyaovim_version')
    " add nyaovim plugin
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

runtime! options.rc.vim
runtime! keymap.rc.vim
