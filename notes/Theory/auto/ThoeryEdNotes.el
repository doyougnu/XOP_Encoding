(TeX-add-style-hook
 "ThoeryEdNotes"
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
    "bussproofs")
   (LaTeX-add-labels
    "sec:org06e7acc"
    "sec:orgc490358"
    "sec:org2256e1e"
    "sec:org8917b23"
    "sec:orgf9650f6"
    "sec:orgf50d7a0"
    "sec:orga8ab073"
    "sec:orga3d0c56"
    "sec:org6d8edf4"
    "sec:org5252c5c"
    "sec:orgc328924"
    "sec:org479aaeb"
    "sec:org07073f0"
    "sec:org49b9e00"
    "sec:orga36dcfe"
    "sec:org033c263"
    "sec:orge100fc3"
    "sec:orgbe8d259"
    "sec:orgbea184d"
    "sec:org30c20fc"
    "sec:org82a1fef"
    "sec:org24650dc"
    "sec:org2fb1c18"
    "sec:org3bc5097"
    "sec:org6277d84"
    "sec:org3e8ea3b"
    "sec:org62a2def"
    "sec:org8bd1112"
    "sec:org6abac78"
    "sec:orgfd1a1bd"
    "sec:org2e5f407"
    "sec:org63ac94d"
    "sec:orgbff0c8c"
    "sec:org241d775"
    "sec:org9363a0e"
    "sec:orge8b64af"
    "sec:orgc3e0044"
    "sec:org72f66ad"
    "sec:org453c604"
    "sec:orga1ae1e3"
    "sec:org20b6ff2"
    "sec:org6a68a5b"
    "sec:orge95fbcd"
    "sec:org991853c"
    "sec:orgcbbf60a")
   (LaTeX-add-bibliographies
    "TheoryEdNotes"))
 :latex)

