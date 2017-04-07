(TeX-add-style-hook
 "XOP_Paper"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("IEEEtran" "conference")))
   (TeX-run-style-hooks
    "latex2e"
    "IEEEtran"
    "IEEEtran10"
    "color"
    "enumerate"
    "todo"
    "lambda")
   (LaTeX-add-labels
    "contrib:codes"
    "contrib:data"
    "contrib:valid")
   (LaTeX-add-bibitems
    "IEEEhowto:kopka"))
 :latex)

