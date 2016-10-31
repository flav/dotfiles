
" call pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase      " or ic for short

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

colorscheme koehler
set background=dark
syntax enable

"  map <leader>t :FuzzyFinderTextMate<CR>

" always show the filename at the bottom
set modeline
set ls=2

" set mouse=a
" set expandtab
set tabstop=4 " numbers of spaces of tab character
set shiftwidth=4 " numbers of spaces to (auto)indent

" ctrl-jklm changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" shortcuts for saving with ctrl-s
nmap <c-s> :w<CR>
vmap <c-s> <esc><c-s>
imap <c-s> <esc><c-s>

" http://vim.wikia.com/wiki/VimTip906
" nnoremap <F2> :set invpaste paste?<CR>
" imap <F2> <C-O><F2>
" set pastetoggle=<F2>

" Toggle spell checking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>

" Set region to British English
set spelllang=en_us


" http://ctrlpvim.github.io/ctrlp.vim/#installation
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

    " By Wouter Hanegraaff
    augroup encrypted
      au!
      " First make sure nothing is written to ~/.viminfo while editing
      " an encrypted file.
      autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
      " We don't want a swap file, as it writes unencrypted data to disk
      autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
      " Switch to binary mode to read the encrypted file
      autocmd BufReadPre,FileReadPre      *.gpg set bin
      autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
      autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
      " Switch to normal mode for editing
      autocmd BufReadPost,FileReadPost    *.gpg set nobin
      autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
      autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
      " Convert all text to encrypted text before writing
      autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
      " Undo the encryption so we are back in the normal text, directly
      " after the file has been written.
      autocmd BufWritePost,FileWritePost    *.gpg   u
    augroup END

endif " has("autocmd")


" vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
au! Syntax vala source $VIM/vim71/syntax/cs.vim

