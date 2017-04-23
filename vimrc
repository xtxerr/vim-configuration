"""""""""""""""""""""
" VIM CONFIGURATION "
"""""""""""""""""""""
	" Vundle Plugins {{{
		"""""""""""""""""""""""""""""""""""
		set rtp+=~/.vim/bundle/Vundle.vim "
		call vundle#begin()               "
		Plugin 'VundleVim/Vundle.vim'     "
		"""""""""""""""""""""""""""""""""""
		Plugin 'scrooloose/nerdtree'
		Plugin 'vim-airline/vim-airline'
		Plugin 'vim-airline/vim-airline-themes'
		Plugin 'ctrlpvim/ctrlp.vim'
		Plugin 'lervag/vimtex'
		Plugin 'tpope/vim-surround'
		Plugin 'mbbill/undotree'
		" filetype off needed to enable vim-go, can be enabled later on again
		filetype off
		Plugin 'fatih/vim-go'
		"Plugin 'powerline/powerline' , {'rtp': 'powerline/bindings/vim/'}
		"Plugin 'Valloric/YouCompleteMe'
		"Plugin 'ajh17/VimCompletesMe'
		"Plugin 'tpope/vim-fugitive'
		"Plugin 'majutsushi/tagbar'
		"Plugin 'git://git.wincent.com/command-t.git'
		"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
		"Plugin 'ascenator/L9', {'name': 'newL9'}
		"Plugin 'Valloric/YouCompleteMe'
		"Plugin 'Shougo/neocomplete.vim'
		"Plugin 'altercation/vim-colors-solarized'
		"Plugin 'chriskempson/tomorrow-theme'
		"Plugin 'tomasr/molokai'
		"Plugin 'molokai'
		"Plugin 'sjl/badwolf'
		"Plugin 'chriskempson/base16-vim'
		" All of your Plugins must be added before the following line
		call vundle#end()
	" }}}
	" General {{{
		set nocompatible				" be iMproved, required
		"set omnifunc=syntaxcomplete#Complete
		"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
		filetype on
		filetype plugin on
		filetype indent on
		set confirm
		set encoding=utf-8
		set termencoding=utf-8
		"set formatoptions+=tcrqwnl1j	" ftplugins will override this mostly
		set nomodeline
		set viewoptions=folds,options,cursor,unix,slash
		set backspace=indent,eol,start			" allow backspacing
		set virtualedit=block
		set ttimeoutlen=10				" remove delays from ESC
		" Instantly leave insert mode when pressing <Esc>
		augroup FastEscape
			autocmd!
			au InsertEnter * set timeoutlen=0
			au InsertLeave * set timeoutlen=1000
		augroup END
		set showcmd
		set number
	" }}}
	" Mappings {{{
		" Set default leader from "\" to ","
		let mapleader = ","
		let maplocalleader = ","
		" toggle folding
		nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
		vnoremap <Space> zf
		" F-Key Mappings {{{
			map <F1> :NERDTreeToggle<CR>
			nnoremap <F2> :UndotreeToggle<CR>
			set pastetoggle=<F12>
		" }}}
		" buffer cycling
		nnoremap <PageUp>   :bprevious<CR>
		nnoremap <PageDown> :bnext<CR>
		" make <c-l> clear the (search-)highlight as well as redraw
		nnoremap <C-L> :nohls<CR><C-L>
		inoremap <C-L> <C-O>:nohls<CR>
		" change to directory of current file and display it
		nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

		" advanced inside-tag-mappings
		"""""""""""""""""""""""
		" CUSTOM TEXT-OBJECTS "
		"""""""""""""""""""""""
		for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`', '-' ]
			execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
			execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
			execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
			execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
		endfor
	" }}}
	" Tabs / Indentation {{{
		let g:tabwidth = 4
		exec 'set tabstop='     . g:tabwidth
		exec 'set shiftwidth='  . g:tabwidth
		exec 'set softtabstop=' . g:tabwidth
		"set tabstop=4		" a hard TAB displays as 4 columns
		"set shiftwidth=4	" >> indents 4 columns; << unindents 8 columns
		"set expandtab		" insert spaces when hitting TABs
		"set softtabstop=4	" insert/delete 4 spaces when hitting a TAB/BACKSPACE
		set shiftround		" round indent to multiple of 'shiftwidth'
		set autoindent		" align the new line indent with the previous line
		set smartindent		" with autoindent it reacts to style of the code
	" }}}
	" Wrapping / Linebreak {{{
		"set textwidth=80	" lines longer than 80 columns will be broken
		set wrap
		set linebreak
	" }}}
	" Formatting {{{
		augroup Formatting " {{{
			autocmd!
			" Format plain text and e-mails correctly {{{
				au FileType mail,text,tex,txt setl formatoptions+=t formatoptions-=l textwidth=72 colorcolumn=72
			" }}}
		augroup END " }}}
	" }}}
	" Navigation {{{
		set scrolloff=3     " Keep 3 lines below and above the cursor
		" set scrolljump=10	" lines to scroll when cursor leaves screen
		" set nostartofline   " cursor stays on current column when moving
	" }}}
	"" Folding {{{
		augroup Folding " {{{
			autocmd!
			" Use foldmarkers for specific filetypes {{{
				au FileType sass,javascript,psql,vim setl foldmethod=marker foldlevel=0
			" }}}
		augroup END " }}}
		set foldcolumn=0
		set foldenable
		set foldlevel=0
		set foldmethod=marker
		" Set a nicer foldtext function
		set foldtext=FoldText()
		" Universal FoldText function
		function! FoldText(...)
			" This function uses code from doy's vim-foldtext: https://github.com/doy/vim-foldtext
			" Prepare fold variables
				" Use function argument as line text if provided
				let l:line = a:0 > 0 ? a:1 : getline(v:foldstart)

				let l:line_count = v:foldend - v:foldstart + 1
				let l:indent = repeat(' ', indent(v:foldstart))

				let l:w_win = winwidth(0)
				let l:w_num = getwinvar(0, '&number') * getwinvar(0, '&numberwidth')
				let l:w_fold = getwinvar(0, '&foldcolumn')
			" Handle diff foldmethod
				if &fdm == 'diff'
					let l:text = printf('┤ %s matching lines ├', l:line_count)

					" Center-align the foldtext
					return repeat('┄', (l:w_win - strchars(l:text) - l:w_num - l:w_fold) / 2) . l:text
				endif
			" Handle other foldmethods
				let l:text = l:line
				" Remove foldmarkers
					let l:foldmarkers = split(&foldmarker, ',')
					let l:text = substitute(l:text, '\V' . l:foldmarkers[0] . '\%(\d\+\)\?\s\*', '', '')
				" Remove comments
					let l:comment = split(&commentstring, '%s')
					if l:comment[0] != ''
						let l:comment_begin = l:comment[0]
						let l:comment_end = ''
						if len(l:comment) > 1
							let l:comment_end = l:comment[1]
						endif
						let l:pattern = '\V' . l:comment_begin . '\s\*' . l:comment_end . '\s\*\$'
						if l:text =~ l:pattern
							let l:text = substitute(l:text, l:pattern, ' ', '')
						else
							let l:text = substitute(l:text, '.*\V' . l:comment_begin, ' ', '')
							if l:comment_end != ''
								let l:text = substitute(l:text, '\V' . l:comment_end, ' ', '')
							endif
						endif
					endif
				" Remove preceding non-word characters
					let l:text = substitute(l:text, '^\W*', '', '')
				" Remove surrounding whitespace
					let l:text = substitute(l:text, '^\s*\(.\{-}\)\s*$', '\1', '')
				" Make unmatched block delimiters prettier
					let l:text = substitute(l:text, '([^)]*$',   '⟯ ⋯ ⟮', '')
					let l:text = substitute(l:text, '{[^}]*$',   '⟯ ⋯ ⟮', '')
					let l:text = substitute(l:text, '\[[^\]]*$', '⟯ ⋯ ⟮', '')
				" Add arrows when indent level > 2 spaces
					if indent(v:foldstart) > 2
						let l:cline = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '')
						let l:clen = strlen(matchstr(l:cline, '^\W*'))

						let l:indent = repeat(' ', indent(v:foldstart) - 2)
						let l:text = '▸ ' . l:text
					endif
				" Prepare fold text
					let l:fnum = printf('┤ %s  ', printf('%4s', l:line_count))
					let l:ftext = printf('%s%s ', l:indent, l:text)
				return l:ftext . repeat('┄', l:w_win - strchars(l:fnum) - strchars(l:ftext) - l:w_num - l:w_fold) . l:fnum
		endfunction
	" }}}
	" History / Undoing {{{
		set history=10000       " remember more commands and search history
		set undodir=~/.vim/tmp
		set undofile
		set undolevels=1000
		set updatetime=1500
		set noswapfile
	" }}}
	" Visuals {{{
		syntax on
		set showmatch          " set show matching parenthesis
		set numberwidth=3      " number width of set number
		set colorcolumn+=72,80
		set title              " change the terminal's title
		set visualbell         " don't beep
		set noerrorbells       " don't beep
		set noshowmode         " disable status line "-- INSERT --" on very bottom
		set wildmenu
		set wildmode=list:longest,full
		set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj
		set wildignore+=*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*/.tox/*
		set wildignore+=*.egg-info/*,*/node_modules/*
		:autocmd InsertEnter * set cul
		:autocmd InsertLeave * set nocul
		set laststatus=2    " To display the status line always
		set conceallevel=2
		set list
		set fillchars=vert:│,fold:┄,diff:╱
		set listchars=tab:⁞\ ,trail:⌟,eol:·,precedes:◂,extends:▸
		set showbreak=↪
		" COLORSCHEME-BEGIN
		" set t_Co=256
		" set background=dark
		" colorscheme solarized
		" let g:solarized_termcolors=256
		" colorscheme Tomorrow
		" colorscheme Tomorrow-Night
		" colorscheme Tomorrow-Night-Bright
		" colorscheme Tomorrow-Night-Eighties
		" colorscheme Tomorrow-Night-Blue
		" colorscheme molokai
		" colorscheme badwolf
		" Make the gutters darker than the background.
		" let g:badwolf_darkgutter = 0
		" Make the tab line the same color as the background.
		" let g:badwolf_tabline = 3
		" let g:airline_theme="badwolf"
		" let base16colorspace=256  " Access colors present in 256 colorspace
		" colorscheme base16-default-dark
		colorscheme distinguished
		if has("gui_running")
			" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
			" colorscheme torte
			colorscheme distinguished
		endif
		" }}}
	" Searching {{{
		set hlsearch		" highlight search terms
		set incsearch		" incremental searching - works well with highlighting
		set wrapscan		" wrap around buffer when searching
		set ignorecase		" do not match case
		set smartcase		" type upper case anywhere is case sensitive
	" }}}
	"  Buffer {{{
		set hidden " This is almost a must if you wish to use buffers in this way.
		set path=.,**
		set switchbuf=useopen,usetab " buffer handling
	" }}}
	" Statusline {{{
		"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		" from https://github.com/scrooloose/vimfiles/blob/master/vimrc "
		"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		"statusline setup
		set statusline =%#identifier#
		set statusline+=[%f]    "tail of the filename
		set statusline+=%*

		"display a warning if fileformat isnt unix
		set statusline+=%#warningmsg#
		set statusline+=%{&ff!='unix'?'['.&ff.']':''}
		set statusline+=%*

		"display a warning if file encoding isnt utf-8
		set statusline+=%#warningmsg#
		set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
		set statusline+=%*

		set statusline+=%h      "help file flag
		set statusline+=%y      "filetype

		"read only flag
		set statusline+=%#identifier#
		set statusline+=%r
		set statusline+=%*

		"modified flag
		set statusline+=%#warningmsg#
		set statusline+=%m
		set statusline+=%*

		set statusline+=%{fugitive#statusline()}

		"display a warning if &et is wrong, or we have mixed-indenting
		set statusline+=%#error#
		set statusline+=%{StatuslineTabWarning()}
		set statusline+=%*

		set statusline+=%{StatuslineTrailingSpaceWarning()}

		set statusline+=%{StatuslineLongLineWarning()}

		set statusline+=%#warningmsg#
		"set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*

		"display a warning if &paste is set
		set statusline+=%#error#
		set statusline+=%{&paste?'[paste]':''}
		set statusline+=%*

		set statusline+=%=      "left/right separator
		set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
		set statusline+=%c,     "cursor column
		set statusline+=%l/%L   "cursor line/total lines
		set statusline+=\ %P    "percent through file
		set laststatus=2

		"recalculate the trailing whitespace warning when idle, and after saving
		autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

		"return '[\s]' if trailing white space is detected
		"return '' otherwise
		function! StatuslineTrailingSpaceWarning()
			if !exists("b:statusline_trailing_space_warning")
				if !&modifiable
					let b:statusline_trailing_space_warning = ''
					return b:statusline_trailing_space_warning
				endif
				if search('\s\+$', 'nw') != 0
					let b:statusline_trailing_space_warning = '[\s]'
				else
					let b:statusline_trailing_space_warning = ''
				endif
			endif
			return b:statusline_trailing_space_warning
		endfunction

		"return the syntax highlight group under the cursor ''
		function! StatuslineCurrentHighlight()
			let name = synIDattr(synID(line('.'),col('.'),1),'name')
			if name == ''
				return ''
			else
				return '[' . name . ']'
			endif
		endfunction

		"recalculate the tab warning flag when idle and after writing
		autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

		"return '[&et]' if &et is set wrong
		"return '[mixed-indenting]' if spaces and tabs are used to indent
		"return an empty string if everything is fine
		function! StatuslineTabWarning()
			if !exists("b:statusline_tab_warning")
				let b:statusline_tab_warning = ''
				if !&modifiable
					return b:statusline_tab_warning
				endif
				let tabs = search('^\t', 'nw') != 0
				"find spaces that arent used as alignment in the first indent column
				let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
				if tabs && spaces
					let b:statusline_tab_warning =  '[mixed-indenting]'
				elseif (spaces && !&et) || (tabs && &et)
					let b:statusline_tab_warning = '[&et]'
				endif
			endif
			return b:statusline_tab_warning
		endfunction
		" }}}
	" Various functions  {{{
		"recalculate the long line warning when idle and after saving
		autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

		"return a warning for "long lines" where "long" is either &textwidth or 80 (if
		"no &textwidth is set)
		"
		"return '' if no long lines
		"return '[#x,my,$z] if long lines are found, were x is the number of long
		"lines, y is the median length of the long lines and z is the length of the
		"longest line
		function! StatuslineLongLineWarning()
			if !exists("b:statusline_long_line_warning")
				if !&modifiable
					let b:statusline_long_line_warning = ''
					return b:statusline_long_line_warning
				endif
				let long_line_lens = s:LongLines()
				if len(long_line_lens) > 0
					let b:statusline_long_line_warning = "[" .
						\ '#' . len(long_line_lens) . "," .
						\ 'm' . s:Median(long_line_lens) . "," .
						\ '$' . max(long_line_lens) . "]"
				else
					let b:statusline_long_line_warning = ""
				endif
			endif
			return b:statusline_long_line_warning
		endfunction

		"return a list containing the lengths of the long lines in this buffer
		function! s:LongLines()
			let threshold = (&tw ? &tw : 80)
			let spaces = repeat(" ", &ts)
			let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces,
			"g"))')
			return filter(line_lens, 'v:val > threshold')
		endfunction

		"find the median of the given array of numbers
		function! s:Median(nums)
			let nums = sort(a:nums)
			let l = len(nums)
			if l % 2 == 1
				let i = (l-1) / 2
				return nums[i]
			else
				return (nums[l/2] + nums[(l/2)-1]) / 2
			endif
		endfunction

		"jump to last cursor position when opening a file
		"dont do it when writing a commit log entry
		autocmd BufReadPost * call SetCursorPosition()
		function! SetCursorPosition()
			if &filetype !~ 'svn\|commit\c'
				if line("'\"") > 0 && line("'\"") <= line("$")
					exe "normal! g`\""
					normal! zz
				endif
			else
				call cursor(1,1)
			endif
		endfunction

	" }}}
	" Plugin Configurations {{{
" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
		""""""""""""
		" NERDtree "
		""""""""""""
		" Close VIM if only the Nerdtree window is the last remaining opened one
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
		let g:NERDTreeShowHidden=1
		" alternatively Shift + I = toggles hidden (dot) files on/off
		" nerdtree directoy arrows
		"let g:NERDTreeDirArrowExpandable = '▸'
		"let g:NERDTreeDirArrowCollapsible = '▾'
		"""""""""""""""
		" CTRLP-BEGIN "
		"""""""""""""""
		" Set no max file limit
		"let g:ctrlp_max_files = 0
		" Search from current directory instead of project root
		"let g:ctrlp_working_path_mode = 0
		"let g:ctrlp_show_hidden = 0
		let g:ctrlp_map = '<c-p>'
		let g:ctrlp_cmd = 'CtrlPMixed'
		let g:ctrlp_working_path_mode = 'ra'
		"""""""""""
		" AIRLINE "
		"""""""""""
		" show statusline always (airline makes use of it)
		set laststatus=2
		" create airline symbols
		let g:airline_powerline_fonts = 1
		" Automatically displays all buffers when there's only one tab open.
		let g:airline#extensions#tabline#enabled = 1
		" airline fallback to unicode symbols if powerline fonts not installed
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif
		"""""""""""""""""""
		" unicode symbols "
		"""""""""""""""""""
		let g:airline_left_sep = '»'
		let g:airline_left_sep = '▶'
		let g:airline_right_sep = '«'
		let g:airline_right_sep = '◀'
		let g:airline_symbols.linenr = '␊'
		let g:airline_symbols.linenr = '␤'
		let g:airline_symbols.linenr = '¶'
		let g:airline_symbols.branch = '⎇'
		let g:airline_symbols.paste = 'ρ'
		let g:airline_symbols.paste = 'Þ'
		let g:airline_symbols.paste = '∥'
		let g:airline_symbols.whitespace = 'Ξ'
		"""""""""""""""""""
		" airline symbols "
		"""""""""""""""""""
		let g:airline_left_sep = ''
		let g:airline_left_alt_sep = ''
		let g:airline_right_sep = ''
		let g:airline_right_alt_sep = ''
		let g:airline_symbols.branch = ''
		let g:airline_symbols.readonly = ''
		let g:airline_symbols.linenr = ''
		let g:airline#extensions#tabline#enabled = 1
		" Show just the filename
		let g:airline#extensions#tabline#fnamemod = ':t'
		" This allows buffers to be hidden if you've modified a buffer.
		" This is almost a must if you wish to use buffers in this way.
		""""""""""
		" vimtex "
		""""""""""
		let g:tex_flavor='latex'
		let g:vimtex_enabled = 1
		let g:vimtex_complete_enabled = 1
		let g:vimtex_complete_close_braces = 1
		let g:gvimtex_mappings_enabled = 1
		let g:vimtex_latexmk_callback = 1
		let g:vimtex_fold_enabled = 1
		let g:vimtex_toc_enabled = 1
		let g:vimtex_labels_enabled = 1
		let g:vimtex_index_show_help = 1
		"let g:vimtex_quickfix_ignored_warnings = [
		"\ 'Underfull',
		"\ 'Overfull',
		"\ 'specifier changed to',
		"\ ]
		"let g:vimtex_quickfix_open_on_warning = 0
	" }}}
