" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>vl :PluginList<cr>
noremap <leader>vi :PluginInstall<cr>
noremap <leader>vu :PluginUpdate<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [[ 'lineinfo' ], ['percent'], ['fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator' : { 'left': ' ', 'right' : ' ' },
      \ 'subseparator' : { 'left': ' ', 'right' : '|' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open Ack and put the cursor in the right position
map <leader>c :Ack 

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
" let g:bufExplorerSortBy='name'
noremap <leader>o :BufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'node_modules', 'bin']
let g:NERDTreeWinSize=35
noremap <leader>nn :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark<Space>
noremap <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-rooter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh', 'package.json']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-clang-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" On my mac had to spell out the complete clang-format path
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ClangFormat()
	let g:clang_format#style_options = {
				\ "AccessModifierOffset" : -4,
				\ "AllowShortIfStatementsOnASingleLine" : "true",
				\ "AlwaysBreakTemplateDeclarations" : "true",
				\ "Standard" : "C++11",
                \ "ColumnLimit": 80}
    let g:clang_format#command='/usr/local/bin/clang-format'
    let g:clang_format#auto_format=1
endfunction

augroup CCppGroup
    au!
    au BufEnter,BufNewFile *.c,*.cc,*.h,*.hpp,*.hh,*.cpp call ClangFormat()
augroup END

" We do this to stop cursor from going to the top of the file after undo
" Idea taken from: https://github.com/rhysd/vim-clang-format/issues/8
function! ClangFormatSafeUndo()
    let s:pos = getpos('.')
    let s:view = winsaveview()        
    undo
    call setpos('.', s:pos)
    call winrestview(s:view)
endfunc

function! ClangFormatSafeRedo()
    let s:pos = getpos('.')
    let s:view = winsaveview()        
    redo
    call setpos('.', s:pos)
    call winrestview(s:view)
endfunc
nnoremap u :call ClangFormatSafeUndo()<cr>
nnoremap <C-r> :call ClangFormatSafeRedo()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ale_linters = {
" \   'javascript': ['jshint'],
" \   'python': ['flake8'],
" \   'go': ['go', 'golint', 'errcheck']
" \}

nmap <silent> <leader>an <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_c_parse_makefile = 1
let g:ale_floating_preview = 1
nnoremap <leader>ad :ALEGoToDefinition<cr>
nnoremap <leader>ai :ALEInfo<cr>
nnoremap <leader>ar :ALEFindReferences<cr>
nnoremap <leader>av :ALEGoToDefinitionInVSplit<cr>
nnoremap <leader>ah :ALEHover<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => base16 colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" making colorscheme work inside tmux

set termguicolors
if &term == "screen"
    set t_Co=256
    set t_ut=
endif
colorscheme base16-gruvbox-dark-hard

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-highlightedyank
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <C-g>a :Git add .<cr>
noremap <C-g>c :Git commit<cr>
noremap <C-g>p :Git push origin 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled = 0

function! GitGutterOn()
    set signcolumn=yes
    call gitgutter#enable()
endfunction

function! GitGutterOff()
    set signcolumn=number
    call gitgutter#disable()
endfunction

noremap <C-o>o :call GitGutterOn()<cr>
noremap <C-o>n :call GitGutterOff()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-lsp-cxx-highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'
" let g:lsp_cxx_hl_verbose_log = 1
let g:lsp_cxx_hl_use_text_props = 1
hi default LspCxxHlGroupMemberVariable ctermfg=67 guifg=#5F87AF cterm=none gui=none
noremap <C-h>o :LspCxxHighlight<cr>
