"""
" ProTips to remember:
" diw to delete the current word
" di( to delete within the current parens
" di" to delete the text between the quotes
"
" vt) select everything up to )
" vT( select everything up before (
" f/F is a greedy version
"
" replace d with v to select
"
" replace i with a to select parents also
"
" surround <select>S<char>
" surround with tag <select>S<tag>
" change the surrounding tag cst<tag>

"""
" Activate bundles (pathogen)
call pathogen#infect()

"""
" Generic stuff

" Enable autoindent
set ai

" Enable options in editable files
set modeline

" Ignore
set wildignore=*.swp,*.bak,*.pyc,*.class,develop-eggs,*.egg-info,*~,node_modules

" Enable filetype detection
filetype on

" Enable loading the plugin files for specific file types
filetype plugin on

" Write the old file out when switching between files
set autowrite

" Backups
set backupdir=~/.vim/tmp/backup//  " backups
set directory=~/.vim/tmp/swap//    " swap files
set noswapfile
set nobackup       " disabled to keep inode numbers unchanged on OSX
set nowritebackup  " disabled to keep inode numbers unchanged on OSX

" Do not store global and local values in a session
set ssop-=options

" Do not store folds
set ssop-=folds

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal g'\"" |
\ endif

command SessionSave mksession .session.vim
command SessionLoad source .session.vim


"""
" User interfaces stuff

" Colors
set t_Co=256
colorscheme solarized
let g:solarized_termcolors=256
set background=dark

" Statusline with Syntastic
set statusline=%<%f%y\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %h%m%r%=%-14.(%l/%L,%c%V%)\ %P

" Show statusline always
set laststatus=2

" Change the terminal's title
set title

" Don't beep
set noerrorbells

" Hide buffers instead of closing them
set hidden

" Enable syntax higlighting
syntax on

" Enable syntastic error signs
let g:syntastic_enable_signs=1

" Show trailing whitespace characters
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Folding
set foldlevel=9999  " initially open all folds
command FoldAll set foldlevel=0
command FoldOne set foldlevel=1

" Show margin column
set colorcolumn=80


"""
" Remove crappy keymappings set by plugings
" search bad plugings with :verbose imap <c-n>

" BufExplorer
au VimEnter * unmap <Leader>bv
au VimEnter * unmap <Leader>bs
au VimEnter * unmap <Leader>be
au VimEnter * unmap <Leader>bd
" LustyExplorer
au VimEnter * unmap <Leader>lf
au VimEnter * unmap <Leader>lb
au VimEnter * unmap <Leader>lj
au VimEnter * unmap <Leader>lg
au VimEnter * unmap <Leader>lr


"""
" Window management

" New vertical split
command Vertical vertical sp

" New horizontal split
command Horizontal sp

" Easily resize split windows with Ctrl+hjkl
nnoremap <C-j> <C-w>+
nnoremap <C-k> <C-w>-
nnoremap <C-h> <C-w><
nnoremap <C-l> <C-w>>


"""
" Misc keybindings

" Leader mappings
let mapleader = ","
let maplocalleader = ";"

" No Vi stuff anymore
set nocompatible

" Make backspace work like most other apps
set backspace=2

" Show error buffer
nnoremap <leader>e :Errors<CR>

" Force redraw to C-l
nnoremap <Leader>r :redraw!<CR>

" Map escape key to jj -- much faster
imap jj <esc>

" h, for line start
map <Leader>h 0

" ,l for line end
map <Leader>l $

" Bubble single lines
" http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Execute file being edited
map <F5> :! %:p <CR>

" Use :w!! to write to a file using sudo if you forgot to "sudo vim file"
cmap w!! %!sudo tee > /dev/null %

" Some aliases
command W w
command Q q
command WQ wq
command Wq wq
command Qa qa
command QA qa
command Wa wa
command WA wa

" Use Q for formatting the current paragraph (or selection).
" Forces 80 character lines.
vmap Q gq
nmap Q gqap

" Move by screen lines instead of file line. Nice with long lines.
nnoremap j gj
nnoremap k gk

" :MM to save and make
command MM wall|make

" Show unsaved changes
command ShowUnsaved w !diff -u % -

" diff will be opened automatically after the git commit.
autocmd FileType gitcommit DiffGitCached | wincmd p

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Makes Caps Lock work as Esc
command EscToCapsLock !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

" Spell checking
set spelllang=en_us

" Toggle spelling
nmap <silent> <leader>S :set spell!<CR>

" Slimux key map
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>A :SlimuxShellLast<CR>

"""
" Use ,c to compile selected text to corresponding output and print it to
" stdout

" CoffeeScript to Javascript
au FileType coffee vmap <leader>c <esc>:'<,'>:w !coffee -scb \| pygmentize -l javascript<CR>

" Jade to HTML
au BufEnter *.jade vmap <leader>c <esc>:'<,'>:w !~/.vim/bin/deindent \| jade<CR>

" Haml to HTML
au BufEnter *.haml vmap <leader>c <esc>:'<,'>:w !~/.vim/bin/deindent \| haml<CR>

" Markdown to HTML
au BufEnter *.md,*.markdown vmap <leader>c <esc>:'<,'>:w !markdown<CR>

" SCSS to CSS
au FileType scss vmap <leader>c <esc>:'<,'>:w !sass --stdin --scss<CR>


"""
" Completion stuff

" Cooler tab completion for vim commands
" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

set completeopt=menuone,longest,preview

" let g:SuperTabDefaultCompletionType = "<C-x><C-]>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<C-n>"


"""
" Search, select, replace, copy and paste

" Make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Apply  substitutions globally on lines. For example, instead of
" :%s/foo/bar/g you just type :%s/foo/bar/. This is almost always what you
" want (when was the last time you wanted to only replace the first occurrence
" of a word on a line?) and if you need the previous behavior you just tack on
" the g again.
set gdefault

" This turns off Vim’s crazy default regex characters and makes searches use
" normal regexes.
nnoremap / /\v
vnoremap / /\v

" Work together to highlight search results (as you type). It’s really quite
" handy, as long as you have the next line as well.
set incsearch
set showmatch
set hlsearch

" Toggle pastemode easily in insert and command mode
set pastetoggle=<F2>

" Always disable paste mode when leaving insert mode
au InsertLeave * set nopaste

" Reselect the text that was just pasted
nnoremap <leader>v V`]

" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-e> :py EvaluateCurrentRange()<CR>


"""
" File management

" Open file tree
" nnoremap <Leader>n :LustyFilesystemExplorer<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
"
" Open bufexplorer
nnoremap <Leader>m :LustyBufferExplorer <CR>

" Opens filesystem explorer at the directory of the current file
nnoremap <Leader>f :LustyFilesystemExplorerFromHere <CR>

" Opens buffer grep
nnoremap <Leader>g :LustyBufferGrep <CR>

" Show path of the edited file
map <Leader>p :echo expand('%:p') <CR>

" Easily change directory to the file being edited.
nmap <Leader>cd :cd %:p:h<CR>

" Copy whole file to OS clipboard
nmap <Leader>x :%y+<CR>

" Delete last linebreak, leading spaces and trailing spaces
nnoremap <Leader>u I" <C-c>hvk$xh " up
nnoremap <Leader>d jI" <C-c>hvk$xh " Down


"""
" PHP stuff
autocmd FileType php set omnifunc=phpcomplete#CompletePHP


"""
" Clojure stuff
let g:clj_highlight_builtins=1  " Highlight Clojure's builtins
let g:clj_paren_rainbow=1  " Rainbow parentheses'!


"""
" Python stuff

autocmd BufRead,BufNewFile *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead,BufNewFile *.py set nonumber!
let python_highlight_all = 1

" Autocomplete
autocmd FileType python set omnifunc=RopeOmni

"""
" Python-mode

" Auto jump on first error
let g:pymode_lint_jump = 1

" Lint with pyflakes and pep8
let g:pymode_lint_checker = "pyflakes,pep8"

" Speed up rope
let g:pymode_rope_guess_project = 0

" Organize imports
map <C-c>o :call RopeOrganizeImports()


"""
" Exuberant Ctags and Omelette

nnoremap <leader>T g]


" Find tags|omelette directory by going up from cwd
py << EOF
import os
import sys
import vim
parts = os.getcwd().split("/")
max = len(parts)
for i in range(max):
    tags = "%s/tags" % "/".join(i and parts[:-i] or parts)
    if os.path.isfile(tags):
        vim.command(r"set tags=%s" % tags)
        break
    i += 1
for i in range(max):
    omelette = "%s/parts/omelette" % "/".join(i and parts[:-i] or parts)
    if os.path.isdir(omelette):
        if os.environ.get("PYTHONPATH"):
            os.environ["PYTHONPATH"] += ":" + omelette
        else:
            os.environ["PYTHONPATH"] = omelette
        sys.path.append(omelette)
        vim.command(r"set path+=%s" % omelette)
        break
    i += 1
EOF


"""
" Indenting stuff

" Use smart indenting
set smarttab expandtab autoindent

" By default use 4 spaces as indentation
set tabstop=4 shiftwidth=4 softtabstop=4

" Command for resetting tab width
command -nargs=1 TabWidth setlocal shiftwidth=<args> tabstop=<args> softtabstop=<args>

" Ruby uses 2 spaces as indentation
au FileType ruby,haml,eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Makefiles and gitconfig require tab
au FileType make,gitconfig setlocal noexpandtab


""
" Other plugin stuff

" Tasklist
map <leader>t <Plug>TaskList
let g:tlTokenList = ["FIXME", "TODO", "XXX", "WONTFIX"]

" Command for reloading snipMate snippets
command SnippetsReload call ReloadAllSnippets()
command SnippetsEditSelect e ~/.vim/bundle/snipmate/snippets/

" Open corresponding snipets file
command SnippetsEdit execute "edit ~/.vim/bundle/snipmate/snippets/" . &ft . ".snippets"

" Reload snippets after saving
au BufWritePost *.snippets call ReloadAllSnippets()

" EasyGrep https://github.com/vim-scripts/EasyGrep
let g:EasyGrepMode=0
let g:EasyGrepRecursive=1
let g:EasyGrepIgnoreCase=1
let g:EasyGrepCommand=1

" Mr. Igor
nmap <C-i> :!igor %<CR> <bar> :e!<CR>


"""
" File type association stuff

" Define custom file types
au BufNewFile,BufRead *.zcml setfiletype xml
au BufNewFile,BufRead *.coffee setfiletype coffee
au BufNewFile,BufRead *.json setfiletype json
au BufNewFile,BufRead *.ru setfiletype ruby
au BufNewFile,BufRead *.conf setfiletype conf
au BufNewFile,BufRead *.jade setfiletype jade
au BufNewFile,BufRead *.md setfiletype markdown
au BufNewFile,BufRead *.markdown setfiletype markdown
au BufNewFile,BufRead *.pt set filetype=xml

