" Use pathogen to easily modify the runtime path to include all
" " plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#infect()

" Powerline setup
set rtp+=/usr/lib/python3.5/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" change the mapleader from \ to ,
" when using a leader key, vim waits 1000ms for next keystroke
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" If you are currently editing it:
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set hidden
" startinsert
filetype plugin indent on
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mod
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set expandtab

set autowriteall
:au FocusLost * silent! :wa

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells          " don't beep
set nobackup
set noswapfile
set showcmd
"set spell spelllang=en_us
"set colorcolumn=120		"Vertical line at 120 characters

set wildmenu
set wildmode=list:longest
set cursorline

" Use normal regex
nnoremap / /\v
vnoremap / /\vi

" Auto position cursor between open and close stuffs
inoremap () ()<ESC>i
inoremap {} {}<ESC>i
inoremap [] []<ESC>i
inoremap "" ""<ESC>i
inoremap '' ''<ESC>i
inoremap <C-j> <ESC>/[)}"'\]>]<CR>:nohl<CR>a
inoremap <C-d> """<CR>
nnoremap <C-d> a"""<CR>

" This will disable the arrow keys while you’re in normal mode to help you
" learn to use hjkl. Trust me, you want to learn to use hjkl. Playing a 
" lot of Nethack also helps.

" It also disables the arrow keys in insert mode to force you to get back 
" into normal mode the instant you’re done inserting text, which is the 
" “right way” to do things.

" It also makes j and k work the way you expect instead of working in some
" archaic “movement by file line instead of screen line” fashion.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Next, get rid of that stupid goddamned help key that you will invaribly 
" hit constantly while aiming for escape:
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" I also like to make ; do the same thing as : — it’s one less key to 
" hit every time I want to save a file:
nnoremap ; :

" Finally, I really like TextMate’s “save on losing focus” feature. I can’t 
" remember a time when I didn’t want to save a file after tabbing away from
" my editor (especially with version control and Vim’s persistent undo):
au FocusLost * :wa

" I personally use jj to exit back to normal mode. The only time I’ve ever 
" actually tried to hit two j‘s in a row is just now while writing this entry, 
" so it doesn’t conflict with my normal typing at all:
inoremap jj <ESC>

" This first mapping makes ,w open a new vertical split and switch over to it.
" Because really, how often do you split your window and not want to do 
" something in the new split?

nnoremap <leader>w <C-w>v<C-w>l

" Close current vim split.
nnoremap <leader>q <C-w>q

" This next set of mappings maps <C-[h/j/k/l]> to the commands needed to
" move around your splits. If you remap your capslock key to Ctrl it makes
" for very easy navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" gdefault applies substitutions globally on lines. For example,
" instead of :%s/foo/bar/g you just type :%s/foo/bar/. This is
" almost always what you want (when was the last time you wanted
" to only replace the first occurrence of a word on a line?) and
" if you need the previous behavior you just tack on the g again.
set gdefault

noremap <F3> :set hlsearch!

" The <leader><space> mapping makes it easy to clear out a search
" by typing ,<space>. This gets rid of the distracting highlighting
" once I’ve found what I’m looking for.
nnoremap <leader><space> :noh<cr>

" Make the tab key match bracket pairs. I use this to move around
" all the time and <tab> is a hell of a lot easier to type than %.
nnoremap <tab> %
vnoremap <tab> %

if &t_Co >= 256 || has("gui_running")
     colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
     " switch syntax highlighting on, when the terminal has colors
    syntax on
endif


" Turn on paste mode automatically
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"


" Show trailing/extra spaces
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
"autocmd filetype html,xml set listchars-=tab:>.

" vim:fdm=marker

" Editor basics {{{
" Behave like Vim instead of Vi
set nocompatible

" Show the current cursor position
" set ruler

" }}}
" Mouse {{{
" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=nicr

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

"""""""""""""""""""""""""""
" C programming options.  "
"""""""""""""""""""""""""""
set exrc " Automatically source a .vimrc if it exists in the current directory.
set secure " Don't allow insecure things in the local .vimrc.

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
augroup c
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
    autocmd FileType c set colorcolumn=80
    autocmd FileType c highlight ColorColumn ctermbg=darkgray
augroup END

"
" YouCompleteMe options
"

"let g:ycm_register_as_syntastic_checker = 0 "default 1
"let g:Show_diagnostics_ui = 0 "default 1

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
"let g:ycm_enable_diagnostic_signs = 1
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_always_populate_location_list = 1 "default 0
"let g:ycm_open_loclist_on_ycm_diags = 1 "default 1


"let g:ycm_complete_in_strings = 1 "default 1
"let g:ycm_collect_identifiers_from_tags_files = 0 "default 0
"let g:ycm_path_to_python_interpreter = '' "default ''


"let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
"let g:ycm_server_log_level = 'info' "default info


"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found
"let g:ycm_confirm_extra_conf = 1


"let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
"let g:ycm_filetype_whitelist = { '*': 1 }
"let g:ycm_key_invoke_completion = '<C-Space>'


"nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>


autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
