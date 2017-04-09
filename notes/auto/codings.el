(TeX-add-style-hook
 "codings"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "letterpaper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("geometry" "margin=1in")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref"
    "geometry"
    "adjustbox")
   (LaTeX-add-labels
    "sec:org2a22781"
    "sec:org14a4dc2"
    "sec:orgcb0dfcd"
    "sec:orgd647f84"
    "sec:org7fc34d1"
    "sec:org57f3fbf"
    "sec:org58c161c"
    "sec:org8a9eb98"
    "sec:org8327f3a"
    "sec:org43afd12"
    "sec:orge065711"
    "sec:orgae6911c"
    "sec:org9eb4349"
    "sec:org527f03d"
    "sec:orgc7994b8"
    "sec:orgcc9fa38"
    "sec:orgd751d63"
    "sec:org37c9ed3"
    "sec:orgfd0af08"
    "sec:orgf4f0f6e"
    "sec:orgb738125"
    "sec:orga886580"))
 :latex)

