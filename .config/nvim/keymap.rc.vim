let mapleader = "\<Space>"

noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $

nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
noremap  <C-c> <esc>
noremap! <C-c> <esc>

nnoremap ; :
nnoremap : ;

nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nmap <C-n> ;NERDTreeToggle<CR>
