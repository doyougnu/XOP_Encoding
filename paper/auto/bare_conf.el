(TeX-add-style-hook
 "bare_conf"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("IEEEtran" "conference")))
   (TeX-run-style-hooks
    "latex2e"
    "IEEEtran"
    "IEEEtran10")
   (LaTeX-add-bibitems
    "IEEEhowto:kopka"))
 :latex)

