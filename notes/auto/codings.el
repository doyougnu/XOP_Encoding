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
    "sec:org4a7044d"
    "sec:orga71438d"
    "sec:org6ba551f"
    "sec:org46b19b6"
    "sec:orgcaa2f5b"
    "sec:org1759d46"
    "sec:orgd0f16eb"
    "sec:orge1d42a6"
    "sec:org6412cf7"
    "sec:org0dbc9f3"
    "sec:orgeee69bd"
    "sec:org5b3cade"
    "sec:orgf1c5cfa"
    "sec:org84499b3"
    "sec:org5dd1a10"
    "sec:orgad5b425"
    "sec:org2f6906d"
    "sec:org9c8578b"
    "sec:orgb4e3638"
    "sec:orgaaac6ca"
    "sec:orga13d218"
    "sec:org58cd3dd"))
 :latex)

