" Mappings for fixTypos "
if !exists('loaded_typos') 
    finish
endif

if empty(typos_dir)
    finish
endif

" Load typos file "
call LoadTypos( typos_dir, '_' )
au FileType * if &ft != 'help' | call LoadTypos( typos_dir, &ft) | endif

" Create a command line abbrv
cnoreabbr typo call MakeTypoAbbr( 
