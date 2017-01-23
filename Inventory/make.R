## creates all of the labs

source("../Basket/quizify.R")

quizify(initial.filename="malthus_sweden_lab_initial.Rmd", final.filename="malthus_sweden_lab_final.Rmd", answer.key.filename="../Basket/check_malthus.R")

quizify(initial.filename="lab_4_thebet_initial.Rmd", final.filename="lab_4_thebet_final.Rmd", answer.key.filename="../Basket/check_thebet.R")
