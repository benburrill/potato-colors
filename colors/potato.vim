" === Potato Colors ====================================================
" Colors fit for a potato.
"
" And by "a potato", I mean me.  This is a colorscheme tuned (to the
" best of my ability) to what I personally think looks pretty good.

" TODO: Fallback to murphy when <256 colors?
set background=dark
highlight clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'potato'

" --- Utility Functions ------------------------------------------------
" {{{
" These functions make it a little easier to highlight stuff.
" Originally, I just used :hi directly, but color reuse soon became very
" confusing, and it was annoying to have to reset the default colors.
" Making the :hi command into a function allows colors to be set as
" variables and it also allows the default style to be completely
" overriden (by setting everything to NONE by default).

function! s:attr_list(list)
    if empty(a:list)
        return 'NONE'
    else
        return join(a:list, ",")
    endif
endfunc

function! s:HL(group, args)
    " fg and bg keys set both gui and cterm
    let [guifg, ctermfg] = get(a:args, 'fg', ['NONE', 'NONE'])
    let [guibg, ctermbg] = get(a:args, 'bg', ['NONE', 'NONE'])
    " fg and bg can be overridden by gui/cterm specific keys
    let guifg = get(a:args, 'guifg', guifg)
    let ctermfg = get(a:args, 'ctermfg', ctermfg)
    let guibg = get(a:args, 'guibg', guibg)
    let ctermbg = get(a:args, 'ctermbg', ctermbg)
    let guisp = get(a:args, 'guisp', 'NONE')

    " attr-lists for all interfaces can best with all
    let all = get(a:args, 'all', [])
    " additional interface specific attributes can also be added
    let gui = s:attr_list(all + get(a:args, 'gui', []))
    let cterm = s:attr_list(all + get(a:args, 'cterm', []))
    let term = s:attr_list(all + get(a:args, 'term', []))

    exe 'highlight' a:group 'guifg='.guifg 'guibg='.guibg 'guisp='.guisp
                          \ 'ctermfg='.ctermfg 'ctermbg='.ctermbg
                          \ 'gui='.gui 'cterm='.cterm 'term='.term
endfunc
" }}}

" --- Colors -----------------------------------------------------------
" {{{
" Note: this is not every color used by potato.  The colors defined here
" generally either get reused or have some relationship to colors that
" get reused or seem important enough to warrant putting in a variable.
" Also, the variable names don't necessarily reflect how the colors get
" used and don't always mean much of anything to begin with (coming up
" with names for these colors is hard!)

let s:FG = ['fg', 'fg']
let s:BG = ['bg', 'bg']

let s:primary = ['#303025', 234]
let s:secondary = ['#EDEDE1', 254]
let s:edge = ['#37372B', 235]
let s:extra = ['#5C5C47', 101]

let s:select = ['#464636', 237]
let s:noselect = ['#3A3A3A', 236]

let s:cursor = ['#F6A329', 172]
let s:cursorcolumn = ['#6F5838', 95]

let s:search = ['#4C3736', 53]
let s:attn = ['#FFE737', 220]

let s:activewin = ['#BFB585', 144]
let s:otherwin = ['#1E221A', 232]
let s:activeterm = ['#6F9966', 107]

" }}}

" --- Interface --------------------------------------------------------
" {{{
" TODO: When I'm done s:HL'ing everything, it would be a good idea to do
" a diff of the output of :hi (like with :redir) to check that I didn't
" fuck anything up.

" good bg colors: 3a3528 3a3929-3a392f 302d25 303025 303227
" I actually am starting to prefer 303227 to this.
" However, I think I should stop worrying about trying to fine tune the
" background for now and come back to that once I have everything else
" in place.
call s:HL('Normal', {'bg': s:primary, 'fg': s:secondary})
call s:HL('Visual', {'bg': s:select})
highlight! link MatchParen Visual
highlight! link QuickFixLine Visual
call s:HL('VisualNOS', {'bg': s:noselect})

" Conceal looks like visually selected bright white text
call s:HL('Conceal', {'bg': s:select, 'fg': ['#FFFFFF', 15], 'all': ['bold']})

call s:HL('SpecialKey', {'fg': s:select})
call s:HL('NonText', {'fg': s:extra, 'all': ['bold']})

" ColorColumn, SignColumn, and LineNr all use the same background color
call s:HL('ColorColumn', {'bg': s:edge})
highlight! link SignColumn ColorColumn
call s:HL('LineNr', {'bg': s:edge, 'fg': ['#898969', 241]})

" In most (if not all) cases, the ctermbg is not used here, but might as
" well define it anyway...
call s:HL('Cursor', {'bg': s:cursor, 'fg': s:BG})

" Made by mixing visual selection color with cursor color
call s:HL('CursorColumn', {'bg': s:cursorcolumn})
highlight! link CursorLine CursorColumn
call s:HL('CursorLineNr', {'fg': ['#FFFF00', 226], 'all': ['bold']})

" The gui uses bold because the colors I chose are somewhat dull and
" hard to see otherwise, but the cterm equivalents are already quite
" vibrant, so I didn't bold them.
call s:HL('Search', {'bg': s:search, 'fg': s:attn, 'gui': ['bold']})
call s:HL('IncSearch', {'bg': s:attn, 'fg': s:search, 'gui': ['bold']})
highlight link WildMenu IncSearch

call s:HL('DiffAdd', {'bg': ['#35531B', 22]})
call s:HL('DiffChange', {'bg': ['#4C4800', 58]})
call s:HL('DiffDelete', {'bg': ['#6C3434', 88], 'fg': ['#FF4545', 131], 'all': ['bold']})
call s:HL('DiffText', {'bg': ['#314F66', 23], 'all': ['italic', 'bold']})

call s:HL('SpellBad', {'ctermbg': 52, 'guisp': '#FF2020', 'gui': ['undercurl']})
call s:HL('SpellCap', {'ctermbg': 17, 'guisp': '#0035DF', 'gui': ['undercurl']})
call s:HL('SpellLocal', {'ctermbg': 89, 'guisp': '#BF2A77', 'gui': ['undercurl']})
call s:HL('SpellRare', {'ctermbg': 56, 'guisp': '#772ABF', 'gui': ['undercurl']})

call s:HL('StatusLine', {'bg': s:activewin, 'fg': s:otherwin, 'all': ['bold']})
call s:HL('StatusLineNC', {'bg': s:otherwin, 'fg': s:activewin})
call s:HL('StatusLineTerm', {'bg': s:activeterm, 'fg': s:otherwin, 'all': ['bold']})
call s:HL('StatusLineTermNC', {'bg': s:otherwin, 'fg': s:activeterm})
call s:HL('VertSplit', {'bg': s:activewin})

call s:HL('ModeMsg', {'fg': s:cursor, 'all': ['bold']})
call s:HL('WarningMsg', {'fg': s:attn, 'all': ['bold']})

" Folded uses NonText color for fg and not-current window status color for bg
call s:HL('Folded', {'bg': s:otherwin, 'fg': s:extra, 'all': ['bold', 'italic']})
highlight! link FoldColumn Folded

" Unselected items in the Pmenu use the Folded colors, selected items
" use visual selection color as bg, current window status color as fg,
" the scrollbar uses the LineNr/ColorColumn bg color with current window
" status color for the thumb.
call s:HL('Pmenu', {'bg': s:otherwin, 'fg': s:extra})
call s:HL('PmenuSel', {'bg': s:select, 'fg': s:activewin})
call s:HL('PmenuSbar', {'bg': s:edge})
call s:HL('PmenuThumb', {'bg': s:activewin})

call s:HL('TabLine', {'bg': s:extra, 'fg': s:BG})
call s:HL('TabLineFill', {'bg': s:activewin})
call s:HL('TabLineSel', {'fg': s:activewin, 'all': ['bold']})
" }}}

" --- Syntax -----------------------------------------------------------
" {{{

call s:HL('Comment', {'fg': ['#8A835C', 243]})
call s:HL('String', {'fg': ['#AFCE57', 107]})

" TODO: can't decide if I prefer italics or underline here
call s:HL('Todo', {'fg': s:attn, 'all': ['bold', 'italic']})

call s:HL('Statement', {'fg': ['#CC78B2', 133], 'all': ['bold']})
call s:HL('PreProc', {'fg': ['#E44269', 161], 'all': ['bold']})
call s:HL('Identifier', {'fg': ['#5CACED', 75]})
call s:HL('Type', {'fg': ['#A0FF40', 155]})

let s:opcol = ['#86C393', 72]
call s:HL('Special', {'fg': s:opcol})
" Earlier I didn't have bold in cterm for Operator, but IDK why
" Should test to see if there was a reason
call s:HL('Operator', {'fg': s:opcol, 'all': ['bold']})

call s:HL('Constant', {'fg': ['#FB9C6E', 173]})
" }}}

" --- Debug ------------------------------------------------------------
" {{{

function! <SID>show_syntax()
    for id in synstack(line('.'), col('.'))
        let transID = synIDtrans(id)
        if id != transID
            echo synIDattr(id, 'name') '=>' synIDattr(transID, 'name')
        else
            echo synIDattr(id, 'name')
        endif
    endfor
endfunc

sign define potato_sign text=>> texthl=Search
function! <SID>toggle_sign()
    let ln = line('.')
    let buf = bufname('')
    let gname = 'potato_sign_group'
    if empty(sign_getplaced(buf, {'group': gname, 'lnum': ln})[0]['signs'])
        call sign_place(ln, gname, 'potato_sign', buf, {'lnum': ln})
    else
        call sign_unplace(gname, {'buffer': buf, 'id': ln})
    endif
endfunc

nmap <Leader>s :call <SID>show_syntax()<CR>
nmap <Leader>r :colo potato<CR>
nmap <Leader>h <Plug>ToggleHexHighlight
nmap <Leader>n :call <SID>toggle_sign()<CR>
" }}}

" vim: foldmethod=marker
