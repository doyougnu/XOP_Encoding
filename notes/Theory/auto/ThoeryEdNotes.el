(TeX-add-style-hook
 "ThoeryEdNotes"
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
    "bussproofs")
   (LaTeX-add-labels
    "sec:org537e346"
    "sec:org564d1bf"
    "sec:org5c22cc4"
    "sec:org03415b2"
    "sec:org7e2f1e6"
    "sec:org546c812"
    "sec:orgb505335"
    "sec:org100db2f"
    "sec:org23584d7"
    "sec:orgf29f32d"
    "sec:org984eb08"
    "sec:orgf31f2db"
    "sec:org575cbf7"
    "sec:org75f4009"
    "sec:org1c3a3c2"
    "sec:org2867fe5"
    "sec:org87cd0bc"
    "sec:org73fc097"
    "sec:org1233146"
    "sec:org4d14ec2"
    "sec:org7001730"
    "sec:org286d9ff"
    "sec:orga5ddad9"
    "sec:orgd94ad60"
    "sec:org12e7c9b"
    "sec:orga429eee"
    "sec:org059aa06"
    "sec:org5ea2999"
    "sec:org9cd25d4"
    "sec:orgd5d94c7"
    "sec:org698fd97"
    "sec:orgcebac40"
    "sec:orgdb4e1e0"
    "sec:org72e921a"
    "sec:org50a0a74"
    "sec:org29554d7"
    "sec:org9e908da")
   (LaTeX-add-bibliographies
    "TheoryEdNotes"))
 :latex)

