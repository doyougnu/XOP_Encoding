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
    "sec:org52540a4"
    "sec:orgf4920be"
    "sec:orgefe9b23"
    "sec:orgf36e1e5"
    "sec:orgea73755"
    "sec:org12c0699"
    "sec:org824b3d5"
    "sec:org5a17417"
    "sec:orgef7e016"
    "sec:org27fcdf0"
    "sec:org5cd4c65"
    "sec:org2fd63c6"
    "sec:org56e525a"
    "sec:org50a9969"
    "sec:orgaa643e9"
    "sec:org9bb137c"
    "sec:orge765c45"
    "sec:org6012247"
    "sec:org7a477c8"
    "sec:org27ed423"
    "sec:org41343ca"
    "sec:org5a3d087"
    "sec:orgbd7294e"
    "sec:org5458230"
    "sec:org4e2c3e5"
    "sec:org91b215b"
    "sec:org738b4fa"
    "sec:org8e7c1a4"
    "sec:org3960daa"
    "sec:orgfc39a09"
    "sec:org1300e88"
    "sec:org1b00c47"
    "sec:org0b73b05"
    "sec:org6e49e38"
    "sec:orgf60cc75"
    "sec:orgc686f4b"
    "sec:org3a236e0"
    "sec:orgfb4e82f"
    "sec:org348127d"
    "sec:org132851f"
    "sec:org48b7743"
    "sec:org3993007"
    "sec:orga390568"
    "sec:org532fef0"
    "sec:orgdb1c94a"
    "sec:org06973c0")
   (LaTeX-add-bibliographies
    "TheoryEdNotes"))
 :latex)

