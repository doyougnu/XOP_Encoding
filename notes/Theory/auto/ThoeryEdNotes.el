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
    "sec:orgda5377e"
    "sec:org6616844"
    "sec:orgfb70c14"
    "sec:orgd5c1f20"
    "sec:orge2d7b49"
    "sec:org5e16833"
    "sec:org22c161e"
    "sec:org8dc1f9f"
    "sec:orgb578665"
    "sec:org0bbfc52"
    "sec:org8901c17"
    "sec:org10a0172"
    "sec:org7f00cd3"
    "sec:org8983dde"
    "sec:org902ce50"
    "sec:org3d2ba4b"
    "sec:orgff12ffb"
    "sec:orgf64857b"
    "sec:org102b42f"
    "sec:org6e77596"
    "sec:org5928c5a"
    "sec:orgc0e47a1"
    "sec:org6110fd3"
    "sec:org4b458cc"
    "sec:org71c0260"
    "sec:org0432f8b"
    "sec:orge7c1662"
    "sec:org894f2f1"
    "sec:orgc7a3098"
    "sec:org7c18127"
    "sec:orgc756ae1"
    "sec:orgfb19bca"
    "sec:orgc57a80c"
    "sec:org6e9fa60"
    "sec:org4096af0"
    "sec:orgbc109fb"
    "sec:orgf509a5f"
    "sec:org97ed69c"
    "sec:org36b0280"
    "sec:org0fc7955"
    "sec:org6e10264"
    "sec:org3d7f4fa"
    "sec:org13b904d"
    "sec:orgfee2088"
    "sec:orgecd5873"
    "sec:org71f65e5"))
 :latex)

