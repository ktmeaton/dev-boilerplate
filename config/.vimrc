" Tab settings
set nowrap
set tabstop=2
set shiftwidth=2
set noexpandtab

" Disable auto-insert of comments
augroup auto_comment
  au!
	au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Toggles
set pastetoggle=<F2>

" Plugins
execute pathogen#infect()
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntatistic markdown checker
let g:syntastic_markdown_mdl_exec = "markdownlint"
let g:syntastic_markdown_mdl_args = ""
