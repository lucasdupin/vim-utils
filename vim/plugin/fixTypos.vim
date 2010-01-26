" File:         fixCodeTypos
" Author:       Vitor Calejuri
" Version:      0.1
" Description:  Fix some common Typos for people that type too
"               fast. You can define common Typos and also
"               typos specifics to the current buffer filetype. Heavily
"               inspired in snipMate.
"

if exists('loaded_typos') || &cp || version < 700 
    finish
endif
let  loaded_typos = 1 

if !exists('typos_dir')
    let typos_dir = substitute(globpath(&rtp,'typos/'), "\n", ',', 'g' )
endif

fun! MakeTypoAbbr( trigger, content)
    execute "iab " . a:trigger . " " . a:content 
endf

" Load the typo file "
fun! ExtractTyposFile( file, ft)
    if !filereadable(a:file) | return | endif
    let text = readfile(a:file)
    
    for line in text + ["\n"]
        if line[:3] == 'typo'
            let trigger     = strpart(line, 5)
            let spaceIdx    = stridx(  trigger, ' ') + 1
            let content     = strpart( trigger, spaceIdx)
            let trigger     = strpart(trigger, 0, spaceIdx - 1)

            " Make the abbreviation
            call MakeTypoAbbr( trigger, content ) 
        endif
    endfor
endf

" Load the typo file "
fun! ExtractTypos( file, ft)
    for path in split(globpath(a:dir, '*')m "\n")
        if isdirectory(path)
            let pathname = fnamemodify(path, ':t')
            for typoFile in split(globpath(path, '*.typos'),"\n") 
                call s:ProcessFile( typoFile, a:ft, pathname )
            endfor
        elseif fnamemodify(path , ':e') == 'typos'
            call s:ProcessFile( path, a:ft )
        endif
    endfor
endf

" Processes a single-typo file; optionally add the name of the parent
" directory for a typo with multiple matches.
fun s:ProcessFile(file, ft, ...)
	let keyword = fnamemodify(a:file, ':t:r')
	if keyword  == '' | return | endif
	try
		let text = join(readfile(a:file), "\n")
	catch /E484/
		echom "Error in fixTypo.vim: couldn't read file: ".a:file
	endtry
	return a:0 ? MakeTypoAbbr( text, keyword )
			\  : MakeTypoAbbr( keyword, text )
endf

" Load the typos file for this filetype"
let g:typo_did_ft = {}
fun! LoadTypos( dir, filetypes )
    for ft in split(a:filetypes, '\.')
        if has_key(g:typo_did_ft, ft) | continue | endif
        call s:DefineTypos( a:dir, ft, ft )
        let g:typo_did_ft[ft] = 1
    endfor
endf

fun s:DefineTypos( dir, aliasft, realft )
    for path in split(globpath(a:dir, a:aliasft.'/')."\n".
                \     globpath(a:dir, a:aliasft,'-*/'), "\n")
       call ExtractTypos( path , a:realft ) 
    endfor

    for path in split(globpath(a:dir, a:aliasft.'.typos')."\n".
                \     globpath(a:dir, a:aliasft,'-*.typos'), "\n")
       call ExtractTyposFile( path , a:realft ) 
    endfor
endf
