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
    "sec:org8f20302"
    "sec:orgc5740c5"
    "sec:orga0d09cd"
    "sec:orgb940c01"
    "sec:org6a7b010"
    "sec:orgdd5253c"
    "sec:org6d4a6c2"
    "sec:orgb38110a"
    "sec:org18fb9f8"
    "sec:orgb4deb70"
    "sec:org0724b64"
    "sec:org472f2f5"
    "sec:org2b85eea"
    "sec:org9bf87d3"
    "sec:org12aa42b"
    "sec:org55a2e61"
    "sec:orgce7b283"
    "sec:org6c7bc6d"
    "sec:org24abbe1"
    "sec:orgc635753"
    "sec:orgd2eff74"
    "sec:org425c03c"
    "sec:org23007c4"
    "sec:orgcbb2810"
    "sec:orgf86c833"
    "sec:orgf0b8de0"
    "sec:orgc0b6830"
    "sec:orga087562"
    "sec:org9cd4ef1"
    "sec:org202f8a9"
    "sec:orgbb1cef1"
    "sec:org8e2aed4"
    "sec:orgef48162"
    "sec:orga036d1e"
    "sec:orgf6ed415"
    "sec:org1b10bd5"
    "sec:org0e0e1b3"
    "sec:org66a408a"
    "sec:org36f42be"
    "sec:org353244a"
    "sec:org952b30b"
    "sec:orgdbcdb3c"
    "sec:orga4fffa9"
    "sec:orga4b2c78"
    "sec:org4395641"
    "sec:org91f0c94")
   (LaTeX-add-bibliographies
    "TheoryEdNotes"))
 :latex)

