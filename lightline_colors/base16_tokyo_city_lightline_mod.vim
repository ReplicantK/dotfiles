let s:p = {'normal': {}, 'insert': {}, 'visual': {}, 'replace': {}}

let s:p.normal.left = [ [ '#0f1419', '#7aa2f7' ], [ '#d8e2ec', '#0f1419' ] ]
"let s:p.normal.middle = [ [ '#3e4b59', '#0f1419' ] ]
let s:p.normal.middle = [ [ '#3e4b59', '#0b1417' ] ]
let s:p.normal.right = [ [ '#1d252c', '#e6e1cf' ], [ '#d8e2ec', '#14191f' ] ]
let s:p.normal.error = [ [ '#0f1419', '#f7768e' ] ]
let s:p.normal.warning = [ [ '#1d252c', '#e6e1cf' ] ]

let s:p.insert.left = [ [ '#0f1419', '#9ece6a'], [ '#d8e2ec', '#0f1419' ] ]
let s:p.visual.left = [ [ '#0f1419', '#ff9e64'], [ '#d8e2ec', '#0f1419' ] ]
let s:p.replace.left = [ [ '#0f1419', '#bb9af7' ], [ '#d8e2ec', '#0f1419' ] ]

let g:lightline#colorscheme#base16_tokyo_city_lightline_mod#palette = lightline#colorscheme#fill(s:p)
