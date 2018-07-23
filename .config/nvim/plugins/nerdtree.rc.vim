let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeShowBookmarks=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
