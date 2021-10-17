" Special file for fzf as it is pretty large
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" - down / up / left / right
let g:fzf_layout = {  'down': '30%' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler
"  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

noremap <silent> <C-f> :FZF<CR>
noremap <silent> <leader>g :GFiles<CR>
noremap <silent> <leader>gf :GFiles?<CR>
noremap <silent> <leader>f :Files<CR>
noremap <silent> <leader>b :Buffers<CR>
noremap <silent> <leader>m :Marks<CR>
noremap <silent> <leader>gc :Commits<CR>
map <silent> <leader>s :Ag<CR>
map <leader>s<leader> :Ag 

" query, ag options, fzf#run options, fullscreen
"'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>)
" ag --no-group --column --color --recurse --depth=100 -- 'with' .
" 'ag --no-group --column --color --recurse --skip-vcs-ignore -- '.shellescape(<q-args>)
autocmd VimEnter *
\ command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>, { 'down' : '60%', 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--info=inline']}, <bang>0)

command! -bang -nargs=? GFiles 
    \  call fzf#vim#gitfiles('?', { 'down' : '60%', 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-n:preview-up,ctrl-m:preview-down' }, <bang>1)
