(TeX-add-style-hook
 "codings"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "letterpaper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("geometry" "margin=1in")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
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
    "sec:orgcf9217e"
    "sec:org09c6723"
    "sec:org348d146"
    "sec:orgc4b6ce5"
    "sec:org55e5be5"
    "sec:orgfaba411"
    "sec:orgdd1f5d9"
    "sec:orgcd142aa"
    "sec:org8c44917"
    "sec:org4a017b2"
    "sec:orge7520ab"
    "sec:org0ee547d"
    "sec:orge1c6f93"
    "sec:org2fed38c"
    "sec:org553f282"
    "sec:org6f880a2"
    "sec:org0ac2509"
    "sec:org084d708"
    "sec:org5468693"
    "sec:orgf845279"
    "sec:org79736e4"
    "sec:org891e6b9"
    "sec:orge9f1d47"
    "sec:org0417910"
    "sec:org125b204"))
 :latex)

