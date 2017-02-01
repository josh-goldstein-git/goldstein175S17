# goldstein175S17
Repository for Economic Demography (Econ/Demog C175) UC Berkeley, Spring 2017

To build the labs

```
cd Inventory
 R
 source("../Basket/quizify.R")
 quizify(initial.filename = "malthus_sweden_lab_initial.Rmd",
final.filename = "malthus_sweden_lab_final.Rmd",
answer.key.filename = "check_malthus.R")


 source("../Basket/quizify.R")
 quizify(initial.filename = "lab_3_solow_initial.Rmd",
final.filename = "lab_3_solow_final.Rmd",
answer.key.filename = "check_solow.R")

```
To update and make labs live

Best to pull first and then do the following ... but if you edited the
files without pulling, you can push and git will warn and interact with you.


josh@quigley:~$ cd /admin/docroots/courses/goldstein175
