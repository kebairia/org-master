# -*- mode: org; -*-
#+NAME: init
#+begin_src shell :exports none
  rm -rf infra_thesis.{acn,acr,alg,glg,glo,gls,ist,log,bbl,ilg,ind}
  rm -rf infra_thesis.tex
  rm -rf _minted-infra_thesis
  rm -rf bibliography-mimosis.fdb_latexmk
  rm -rf bibliography-mimosis.{fls,aux}
#+end_src


#+NAME: clean_tmp
#+begin_src shell :exports none
  rm -rf /tmp/test/*
#+end_src
