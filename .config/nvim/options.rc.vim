set expandtab    "tabを半角スペースで挿入
set tabstop=2    "tab幅をスペース4つ分にする
"set ambiwidth=double    "全角文字の幅を2に固定
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent         "自動インデント
set virtualedit=block   "文字のないところにカーソルを移動できる
set whichwrap=b,s,h,l,[,],<,>   "カーソル回り込み
set backspace=indent,eol,start  "backspaceを空白、行末、行頭でも使用可能に
"set nowrap              "折り返し無効
set scrolloff=8         "上下8行の視界を確保
set sidescrolloff=16    "左右16文字の視界を確保
set sidescroll=1        "左右スクロールは一文字ずつ行う
set title       "ターミナルのタイトルをセット
set number      "行番号
set noswapfile  "swapfileを作らない

if has('nvim')
  set clipboard+=unnamedplus
  if has('mouse')
    set mouse=a
  endif
else
  set laststatus=2
  set wildmenu
  set clipboard=unnamed,autoselect
  set backspace=indent,eol,start
endif

" highlighting zenkaku space
autocmd MyAutoCmd BufRead,BufNew * match Error /　/
