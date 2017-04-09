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
    "sec:org5a0ec8e"
    "sec:org0e31e8c"
    "sec:org461ffc0"
    "sec:org38d88ac"
    "sec:org33cfddb"
    "sec:org42d7aa1"
    "sec:org1d69eb8"
    "sec:org24482e1"
    "sec:org171114b"
    "sec:org167b3de"
    "sec:org95e3007"
    "sec:org5f2d277"
    "sec:org3bf13b5"
    "sec:orgbfc5dc2"
    "sec:orgb0c2c3f"
    "sec:orgc10ee5d"
    "sec:org216cff1"
    "sec:org8b5b6d8"
    "sec:orgb101b66"
    "sec:org4eb29e3"
    "sec:org757c3c6"
    "sec:org1c63983"
    "sec:org85317f1"
    "sec:org5fbd053"
    "sec:orgbd87497"
    "sec:org79b2c93"
    "sec:orgb3b580c"
    "sec:orgefb0efb"
    "sec:orgaee5330"
    "sec:orgbd5d8a7"
    "sec:org73982fd"
    "sec:org89db2fc"
    "sec:org86aad10"
    "sec:org8597085"
    "sec:orgb0a82bd"
    "sec:org59522b5"
    "sec:org7ec6833"
    "sec:org34f00d4"
    "sec:orgaabe2eb"
    "sec:org513df32"
    "sec:org2119a8f"
    "sec:org0f0cd8b"
    "sec:orgba7b0d2"
    "sec:orgc55a2f4"
    "sec:orga065f25"
    "sec:orga738562")
   (LaTeX-add-bibliographies
    "TheoryEdNotes"))
 :latex)

