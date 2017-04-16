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
    "sec:org304ba2b"
    "sec:org1760a85"
    "sec:orga066dcb"
    "sec:org888abd0"
    "sec:orgeef03b9"
    "sec:org7a4a481"
    "sec:org99d552a"
    "sec:org3e41e11"
    "sec:org1835e48"
    "sec:org18364a5"
    "sec:orgdb67230"
    "sec:org497cd77"
    "sec:orgc90aa15"
    "sec:orgf269e0a"
    "sec:org913267a"
    "sec:orgeddf66a"
    "sec:orga1b69fd"
    "sec:org53a4076"
    "sec:org4ae7e40"
    "sec:orgf6ae6d4"
    "sec:orgc4fdd6e"
    "sec:orgaf60ffa"
    "sec:orgb470dca"
    "sec:orga32a336"
    "sec:org4cb7c54"
    "sec:orgf8d5264"))
 :latex)

