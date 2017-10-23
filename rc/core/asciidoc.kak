# http://asciidoc.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.(a(scii)?doc|asc) %{
    set buffer filetype asciidoc
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter -group / group asciidoc

add-highlighter -group /asciidoc regex (\A|\n\n)[^\n]+\n={2,}\h*$ 0:title
add-highlighter -group /asciidoc regex (\A|\n\n)[^\n]+\n-{2,}\h*$ 0:header
add-highlighter -group /asciidoc regex (\A|\n\n)[^\n]+\n~{2,}\h*$ 0:header
add-highlighter -group /asciidoc regex (\A|\n\n)[^\n]+\n\^{2,}\h*$ 0:header
add-highlighter -group /asciidoc regex ^\h+([-\*])\h+[^\n]*(\n\h+[^-\*]\S+[^\n]*)*$ 0:list 1:bullet
add-highlighter -group /asciidoc regex ^([-=~]{3,})\n[^\n\h].*?\n([-=~]{3,})$ 0:block
add-highlighter -group /asciidoc regex \B(?:\+[^\n]+?\+|`[^\n]+?`)\B 0:mono
add-highlighter -group /asciidoc regex \B_[^\n]+?_\B 0:italic
add-highlighter -group /asciidoc regex \B\*[^\n]+?\*\B 0:bold
add-highlighter -group /asciidoc regex ^:[-\w]+: 0:meta

# Commands
# ‾‾‾‾‾‾‾‾

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾
#
hook -group asciidoc-highlight global WinSetOption filetype=asciidoc %{ add-highlighter ref asciidoc }
hook -group asciidoc-highlight global WinSetOption filetype=(?!asciidoc).* %{ remove-highlighter asciidoc }
