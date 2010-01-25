
"let g:ackprg="ack\\ -H\\ --nocolor\\ --nogroup"

function! Fcshd()
""    execute "silent! ruby fcshd/fcshd.rb server"
    execute "ruby ~/.vim/fcshd/fcshd.rb server"
    exec "redraw!"
endfunction

command! -nargs=* -complete=file Fcshd call Fcshd()
