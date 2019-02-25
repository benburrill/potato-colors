" Fallback to murphy when <256 colors?
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "potato"


" good bg colors: 3a3528 3a3929-3a392f 302d25 303025 303227
" I actually am starting to prefer 303227 to this.
" However, I think I should stop worrying about trying to fine tune the
" background for now and come back to that once I have everything else
" in place.
hi Normal ctermbg=234 ctermfg=254 guifg=#EDEDE1 guibg=#303025
hi Visual ctermbg=237 guibg=#464636
hi! link MatchParen Visual
hi! link QuickFixLine Visual
hi VisualNOS ctermbg=236 guibg=#3A3A3A cterm=NONE gui=NONE

" Conceal looks like visually selected bright white text
hi Conceal ctermbg=237 ctermfg=15 guibg=#464636 guifg=#FFFFFF gui=bold cterm=bold

hi SpecialKey ctermfg=237 guifg=#464636
hi NonText ctermfg=101 guifg=#5C5C47 gui=bold cterm=bold

" ColorColumn, SignColumn, and LineNr all use the same background color
hi ColorColumn ctermbg=235 guibg=#37372B
hi! link SignColumn ColorColumn
hi LineNr ctermfg=241 ctermbg=235 guifg=#898969 guibg=#37372B

" In most (if not all) cases, the ctermbg is not used here, but might as
" well define it anyway...
hi Cursor ctermbg=172 guibg=#F6A329

" Made by mixing visual selection color with cursor color
hi CursorColumn ctermbg=95 guibg=#6F5838
hi! link CursorLine CursorColumn
hi CursorLineNr ctermfg=226 guifg=#FFFF00 gui=bold cterm=bold
"
" The gui uses bold because the colors I chose are somewhat dull and
" hard to see otherwise, but the cterm equivalents are already quite
" vibrant, so I didn't bold them.
hi Search ctermbg=53 ctermfg=220 guibg=#4C3736 guifg=#FFE737 gui=bold cterm=NONE
hi IncSearch ctermfg=53 ctermbg=220 guifg=#4C3736 guibg=#FFE737 gui=bold cterm=NONE
hi! link WildMenu IncSearch

hi DiffAdd ctermbg=22 guibg=#35531b
hi DiffChange ctermbg=58 guibg=#4C4800
hi DiffDelete ctermbg=88 ctermfg=131 guibg=#6C3434 guifg=#FF4545 gui=bold cterm=bold
hi DiffText ctermbg=23 guibg=#314F66 gui=italic,bold cterm=italic,bold

hi SpellBad ctermbg=52 guisp=#FF2020 gui=undercurl
hi SpellCap ctermbg=17 guisp=#0035DF gui=undercurl
hi SpellLocal ctermbg=89 guisp=#BF2A77 gui=undercurl
hi SpellRare ctermbg=56 guisp=#772ABF gui=undercurl

hi VertSplit ctermfg=144 guifg=#BFB585
hi StatusLine ctermbg=232 ctermfg=144 guibg=#1E221A guifg=#BFB585
hi StatusLineNC ctermfg=232 ctermbg=144 guifg=#1E221A guibg=#BFB585
hi StatusLineTerm ctermfg=232 ctermbg=107 guifg=#1E221A guibg=#6F9966
hi StatusLineTermNC ctermbg=232 ctermfg=107 guibg=#1E221A guifg=#6F9966

hi ModeMsg ctermfg=172 guifg=#F6A329 gui=bold cterm=bold
hi WarningMsg ctermfg=220 guifg=#FFE737 gui=bold cterm=bold

" Folded uses NonText color for fg and not-current window status color for bg
hi Folded ctermfg=101 ctermbg=232 guifg=#5C5C47 guibg=#1E221A gui=bold,italic cterm=bold,italic
hi! link FoldColumn Folded

" Unselected items in the Pmenu use the Folded colors, selected items
" use visual selection color as bg, current window status color as fg,
" the scrollbar uses the LineNr/ColorColumn bg color with current window
" status color for the thumb.
hi Pmenu ctermfg=101 ctermbg=232 guifg=#5C5C47 guibg=#1E221A
hi PmenuSel ctermfg=144 ctermbg=237 guifg=#BFB585 guibg=#464636
hi PmenuSbar ctermbg=235 guibg=#37372B
hi PmenuThumb ctermbg=144 guibg=#BFB585

hi TabLine ctermfg=bg ctermbg=101 guifg=bg guibg=#5C5C47 cterm=NONE gui=NONE
hi TabLineFill ctermfg=144 guifg=#BFB585
hi TabLineSel ctermfg=144 ctermbg=NONE guifg=#BFB585 guibg=NONE gui=bold cterm=bold

" --- Syntax -----------------------------------------------------------

hi Comment ctermfg=243 guifg=#8A835C
hi String ctermfg=107 guifg=#AFCE57

" TODO: can't decide if I prefer italics or underline here
hi Todo ctermfg=220 ctermbg=NONE guifg=#FFE737 guibg=NONE gui=bold,italic cterm=bold,italic

hi Statement ctermfg=133 guifg=#CC78B2 cterm=bold gui=bold
hi PreProc ctermfg=161 guifg=#E44269 cterm=bold gui=bold
hi Identifier ctermfg=75 guifg=#5CACED cterm=NONE
hi Type ctermfg=155 guifg=#A0FF40 cterm=NONE gui=NONE

hi Special ctermfg=72 guifg=#86C393
hi Operator ctermfg=72 guifg=#86C393 cterm=NONE gui=bold

hi Constant ctermfg=173 guifg=#FB9C6E

" --- Debug ------------------------------------------------------------

function! <SID>show_syntax()
    for id in synstack(line("."), col("."))
        let transID = synIDtrans(id)
        if id != transID
            echo synIDattr(id, "name") "=>" synIDattr(transID, "name")
        else
            echo synIDattr(id, "name")
        endif
    endfor
endfunc

sign define potato_sign text=>> texthl=Search
function! <SID>toggle_sign()
    let ln = line(".")
    let buf = bufname("")
    let gname = "potato_sign_group"
    if empty(sign_getplaced(buf, {'group': gname, 'lnum': ln})[0]['signs'])
        call sign_place(ln, gname, "potato_sign", buf, {'lnum': ln})
    else
        call sign_unplace(gname, {'buffer': buf, 'id': ln})
    endif
endfunc

nmap <Leader>s :call <SID>show_syntax()<CR>
nmap <Leader>r :colo potato<CR>
nmap <Leader>h <Plug>ToggleHexHighlight
nmap <Leader>n :call <SID>toggle_sign()<CR>
