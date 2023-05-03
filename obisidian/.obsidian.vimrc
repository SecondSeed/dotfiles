"""""""""""""""""""""""""""""""""basic""""""""""""""""""""
" Have j and k navigate visual lines rather than logical ones
noremap j gj
noremap k gk
" I like using H and L for beginning/end of line
noremap H ^
noremap L $
set clipboard=unnamed
nmap <C-m> :nohl

vunmap s
nunmap s
unmap <Space>
unmap ;

"""""""""""""""""""""jump""""""""""""""""""""""
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward
exmap followlink obcommand editor:follow-link
map gd :followlink
exmap showbacklinks obcommand backlink:open
map gb :showbacklinks
exmap openlinkleaf obcommand editor:open-link-in-new-leaf
map gD :openlinkleaf

""""""""""""""""""""""surround"""""""""""""""""""
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
map s" :surround_double_quotes
map s' :surround_single_quotes
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

"""""""""""""""""""""""""""""window""""""""""""""""
exmap toggleleft obcommand app:toggle-left-sidebar
map <Space>tl :toggleleft
exmap toggleright obcommand app:toggle-right-sidebar
map <Space>tr :toggleright
exmap closeothers obcommand workspace:close-others
map <Space>co :closeothers
exmap sp obcommand workspace:split-horizontal
exmap vsp obcommand workspace:split-vertical
exmap revealfile obcommand file-explorer:reveal-active-file
map <Space>si :revealfile
exmap only obcommand workspace:close-others
exmap focusleftgroup obcommand editor:focus-left
map gh :focusleftgroup
exmap focusrightgroup obcommand editor:focus-right
map gl :focusrightgroup
exmap focustopgroup obcommand editor:focus-top
map gk :focustopgroup
exmap focusbottomgroup obcommand editor:focus-bottom
map gj :focusbottomgroup
exmap tabnext obcommand cycle-through-panes:cycle-through-panes
nmap gt :tabnext
exmap tabprev obcommand cycle-through-panes:cycle-through-panes-reverse
nmap gT :tabprev

"""""""""""""""""""""""""utilities"""""""""""""""""
exmap deletefile obcommand app:delete-file
map <Space>df :deletefile
exmap opensettings obcommand app:open-settings
map <Space>ss :opensettings
" Maps pasteinto to Alt-p
map <A-p> :pasteinto