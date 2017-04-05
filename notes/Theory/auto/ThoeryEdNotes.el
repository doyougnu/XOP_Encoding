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
    "sec:orga054185"
    "sec:orgebaf5f0"
    "sec:orgde82871"
    "sec:orgfbc37c2"
    "sec:org34b5560"
    "sec:org4b348a4"
    "sec:org2074d3c"
    "sec:org599425c"
    "sec:org96e4b8a"
    "sec:orgde6d823"
    "sec:org42e41cf"
    "sec:orgd99c77c"
    "sec:org3647930"
    "sec:orge9829af"
    "sec:orgce56327"
    "sec:org1e8bcd9"
    "sec:org80f3d45"
    "sec:org05b9a2a"
    "sec:org1c19bb4"
    "sec:org5457457"
    "sec:org5589d96"
    "sec:orgde5f035"
    "sec:orgf0ddbb9"
    "sec:orga1141e4"
    "sec:org70118ed"
    "sec:org7705199"
    "sec:orga96e694"
    "sec:org280ac8b"
    "sec:org51c5005"
    "sec:org20f056f"
    "sec:org9b85048"
    "sec:orgb4a02fa"
    "sec:org38eb95d"
    "sec:orgc932d94"
    "sec:org28e97b1"
    "sec:org42c6820"
    "sec:orge1a1dc4"
    "sec:org8c6cb58"
    "sec:org3b99572"
    "sec:org5565f25"
    "sec:orgc7431ff"
    "sec:orgb5718f5"
    "sec:orga86009e"
    "sec:org2173858"
    "sec:org300af10"
    "sec:orgc321f9f")
   (LaTeX-add-bibliographies
    "TheoryEdNotes"))
 :latex)

