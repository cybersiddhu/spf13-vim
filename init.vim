" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"                    __ _ _____              _
"         ___ _ __  / _/ |___ /      __   __(_)_ __ ___
"        / __| '_ \| |_| | |_ \ _____\ \ / /| | '_ ` _ \
"        \__ \ |_) |  _| |___) |_____|\ V / | | | | | | |
"        |___/ .__/|_| |_|____/        \_/  |_|_| |_| |_|
"            |_|
"
"   This is the personal .vimrc file of Steve Francia.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
" }
"
" Basics {
        set nocompatible        " Must be first line
" }
"
" Custom vim configuration path {
    if exists('$XDG_CONFIG_HOME')
        let $VIMDIR=$XDG_CONFIG_HOME.'/nvim'
        let $MYVIMPLUG=$VIMDIR
        let $MYPLUGINS=$VIMDIR.'/plugged'
    endif

" }

" Before {
"
    " Use before config if available {
        if filereadable(expand($VIMDIR ."/.vimrc.before"))
            let $MYB = $VIMDIR. '/.vimrc.before'
            source $MYB
        endif
    " }
    "
    " Check to see the various options that could be overridden. 
    " Use bundles config. {
        if filereadable(expand($VIMDIR . "/.vimrc.bundles"))
            let $MYB = $VIMDIR. '/.vimrc.bundles'
            source $MYB
        endif
    " }
    " Useful for adding custom bundle or any other bundle related options that
    " cannot be fit into other files.
    "
" }

" General {
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has ('clipboard') " On Linux use + register for copy-paste
        if has('unnamedplus')
            set clipboard=unnamedplus
        else " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set nobackup                  
    set nowritebackup
    set shortmess+=c          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=. " '.' is an end of word designator
    set iskeyword-=# " '#' is an end of word designator
    set iskeyword-=- " '-' is an end of word designator
    set signcolumn=yes " always show signcolumns
    set cmdheight=2    " better display for messages
    set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI

    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

" }

" Vim UI {

    if isdirectory(expand($MYPLUGINS."/nord-vim"))
        colorscheme nord
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set nocursorline                  

    highlight clear SignColumn      " SignColumn should match background for
                                    " things like vim-gitgutter
    highlight clear LineNr          " Current line number row will have same background color in relative mode.
                                    " Things like vim-gitgutter will match LineNr highlight
    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options

        if isdirectory(expand($MYPLUGINS.'/vim-fugitive'))
            set statusline+=%{fugitive#statusline()} " Git Hotness
            nnoremap <silent> <Leader>ga :Gwrite<CR>
        endif

        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {

    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following to your .vimrc.before.local file:
    let mapleader = ','
    let maplocalleader = '_'

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Find merge conflict markers 
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
    nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
    " Type :e %%
    cabbr <expr> %% expand('%:p:h')

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

" }

" Plugins {

    " TextObj Sentence {
        "augroup textobj_sentence
            "autocmd!
            "autocmd FileType markdown call textobj#sentence#init()
            "autocmd FileType text call textobj#sentence#init()
        "augroup END
    " }

    " TextObj Quote {
        "augroup textobj_quote
            "autocmd!
            "autocmd FileType markdown call textobj#quote#init()
            "autocmd FileType text call textobj#quote#init({'educate': 0})
        "augroup END
    " }

    " Misc {
        if isdirectory(expand($MYPLUGINS."/nerdtree"))
            let g:NERDShutUp=1
        endif
        if isdirectory(expand($MYPLUGINS."/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }

	" NerdTree {
        if isdirectory(expand($MYPLUGINS."/nerdtree"))
		    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
		    map <leader>e :NERDTreeFind<CR>
		    nmap <leader>nt :NERDTreeFind<CR>

		    let NERDTreeShowBookmarks=1
		    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
		    let NERDTreeChDirMode=0
		    let NERDTreeQuitOnOpen=1
		    let NERDTreeShowHidden=1
		    let NERDTreeKeepTreeInNewTab=1
        endif
	" }
    
    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand($MYPLUGINS."/sessionman.vim"))
            let  sessionman_save_on_exit=1
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }

    " ctrlp {
        if isdirectory(expand($MYPLUGINS."/ctrlp.vim"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        " On Windows use "dir" as fallback command.
            if has('win32') || has('win64')
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            elseif executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            let g:ctrlp_user_command = {
                        \ 'types': {
                        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                        \ },
                        \ 'fallback': s:ctrlp_fallback
                        \ }
        endif
    "}

    " TagBar {
        if isdirectory(expand($MYPLUGINS."/tagbar"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>

            " If using go please install the gotags program using the following
            " go install github.com/jstemmer/gotags
            " And make sure gotags is in your path
            let g:tagbar_type_go = {
                \ 'ctagstype' : 'go',
                \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                    \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                    \ 'r:constructor', 'f:functions' ],
                \ 'sro' : '.',
                \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
                \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
                \ 'ctagsbin'  : 'gotags',
                \ 'ctagsargs' : '-sort -silent'
                \ }
        endif
    "}

    " Fugitive {
        if isdirectory(expand($MYPLUGINS."/vim-fugitive"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            nnoremap <silent> <leader>gg :GitGutterToggle<CR>
        endif
    "}
    
    " UndoTree {
        if isdirectory(expand($MYPLUGINS.'/undotree'))
            nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " indent_guides {
        if isdirectory(expand($MYPLUGINS.'/vim-indent-guides'))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }

    "  vim-lightline {
    " Set configuration options for the statusline plugin vim-lightline.
    if isdirectory(expand($MYPLUGINS."/lightline.vim"))
        let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightLineFugitive',
            \   'readonly': 'LightLineReadonly',
            \   'modified': 'LightLineModified',
            \   'filetype': 'LightLineFiletype',
            \   'fileformat': 'LightLineFileformat',
            \   'fileencoding': 'LightLineFileencoding'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
        \ }
    endif
    "  }
    
    fu! LightLineFileencoding()
        return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
    endfunction

    fu! LightLineFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    endfunction

    fu! LightLineFileformat()
        return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
    endfunction

   fu! LightLineModified()
        if &filetype == "help"
            return ""
        elseif &modified
            return "+"
        elseif &modifiable
            return ""
        else
            return ""
        endif
    endfunction 

    fu! LightLineReadOnly()
        if &filetype == "help"
            return ""
        elseif &readonly
            return "\ue0a2"
        else
            return ""
        endif
    endfunction

    fu! LightLineFugitive()
        if exists("*fugitive#head")
            let branch = fugitive#head()
            return branch !=# '' ? "\ue0a0".branch : ''
        endif
        return ''
    endfunction

" }

" syntastic {
        "if isdirectory(expand($MYPLUGINS."/syntastic"))
            "let g:syntastic_always_populate_loc_list = 1
            "let g:syntastic_auto_loc_list = 1
            "let g:syntastic_check_on_wq = 0
        "endif
" }
"
" snippets {
        "let g:UltiSnipsExpandTrigger="<C-j>"
        "let g:UltiSnipsJumpForwardTrigger="<C-n>"
        "let g:UltiSnipsJumpBackwardTrigger="<C-k>"
        "if isdirectory($MYPLUGINS."/vim-go/gosnippets/UltiSnips")
            "if isdirectory($MYPLUGINS."/vim-snippets/UltiSnips")
                "let g:UltiSnipsSnippetDirectories=[$MYPLUGINS."/vim-go/gosnippets/UltiSnips", $MYPLUGINS."/vim-snippets/UltiSnips"]
            "else
                "let g:UltiSnipsSnippetDirectories=[$MYPLUGINS."/vim-go/gosnippets/UltiSnips"]
            "endif
        "endif
" }

" coc.vim {
    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " open the definition/declaration under the cursor
    nmap <silent> pc <Plug>(coc-definition)
    nmap <silent> ds <Plug>(coc-type-definition)
    " Show the interfaces that the type under the cursor implements
    nmap <silent> pi <Plug>(coc-implementation)
    nmap <silent> pr <Plug>(coc-references)
    " Use U to show documentation in preview window
    nnoremap <silent> U :call <SID>show_documentation()<CR>
    " Remap for rename current word
    nmap <Leader>pn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <Leader>f  <Plug>(coc-format-selected)
    nmap <Leader>f  <Plug>(coc-format-selected)

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" }"
    
" Functions {
    fu! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    fu! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Initialize directories {
    fu! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " Directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories
        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    "call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

" }
"
" Override or add new configuration for .vimrc
" Also a place to deactivate default bundles. It cannot be done in
" .vimrc.bundles.local because the default .vimrc might set options in them
" which might throw error.
" Use local vimrc if available {
   if filereadable(expand($VIMDIR. "/.vimrc.local"))
       let $MYL = $VIMDIR. '/.vimrc.local'
       source $MYL
   endif
" }
