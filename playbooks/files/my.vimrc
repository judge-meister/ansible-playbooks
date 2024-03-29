" enable syntax highlighting, duh
:syntax enable

" set the current working folder to the same as the file shown
"		useful for then entering clearcase commands or using
"		% to get the current file and it works
:autocmd BufEnter * cd %:p:h

" set the coloUr scheme
"colorscheme desert
set bg=dark

" set the line numbering colours
:hi linenr guifg=grey guibg=black

" set the font and size
:set guifont=Monospace\ 9

" incrementally search
:set incsearch

" shortcuts for clearcase commands
:map <F1> :! cleartool co -nc %
:map <F2> :! cleartool lsco -cview -all
:map <F3> :! cleartool ci -nc %
:map <F4> :! xlsvtree %&
:map <F5> :! cleartool diff -g -pred %&
:map <F6> :! cdiff0 %&
:map <F8> :! cleartool co -nc %

:map <F9> :vertical wincmd f<CR>

:map <F12> :r! date
:map <C-T> :tabnew<CR>

" make return indent to the same as previous line
:set autoindent

" only search case sensitive for something containing uppercase letters
:set smartcase

" turn tabs into spaces
:set expandtab

" show line numbers
:set number

" set the indenting amount (for >> and <<)
:set shiftwidth=4

" set the tab amount
:set tabstop=4

:set wildmenu

:set scrolloff=2
:set guioptions=aegimrLt
set hlsearch

autocmd! bufwritepost .vimrc source ~/.vimrc

" always show the line number and column width
:set ruler

" be able to use the mouse in the terminal
:set mouse=a

" visible tabs chars
set list
set listchars=tab:>-

" execute a command for all buffers ther are shown in windows
fun! AllWindows(cmnd)
	let cmnd = a:cmnd
	let origw = winnr()
	let i = 1
	while (i <= bufnr(*$))
		if bufexists(i)
			let w = bufwinnr(i)
			if w != -1
				echo "=== window: " . w . " files " . bufname(i)
				execute "normal \<c-w>" . w . "w"
				execute cmnd
			endif
		endif
		let i = i+1
	endwhile
	execute "normal \<c-w>" . origw . "w"
endfun

" Adding those quotes is pretty boring. That is easy to fix. Just make a command like
command! -nargs=+ -complete=command AllBuf call AllWindows(<q-args>)

" removed trailing spaces on save
autocmd BufWritePre * :%s/\s+$//e

" Added 20/02/14 - for moving lines up and down using Alt+direction key, useful for re-ordering lists

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

set modeline

