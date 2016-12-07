tot <- 0 # the running total
tot.all <- 2 # the number of "tests"
check <- function(ans)
{
  ## check value
  if(is.na(ans))
  {
  stop("Your answer is 'NA'. Please change.")
  }
  ## parse which answer
  name.of.ans <- deparse(substitute(ans))
#  print(name.of.ans)
  ## now call the rite check function
  ## 1. change "answer1" to "check1"
  name.of.check  =  gsub("answer", "check", name.of.ans)
  assign("my.check", get(name.of.check)) # this assigns my.check the right function
#  print(my.check)
  cat("Your ",  name.of.ans, ": ")
  cat(ans)
  cat("\n")
  message <-  my.check(ans) # this applies the functions to our answer
  cat(message)
  ## return hint if wrong
  ## return correct if right
}


check1 <- function(ans)
{
  correct.answer = "Paris"
  hint = "Hint: The French are not as opposed to centralized power as the Americans"
  message.if.correct = "Correct."
  message.if.incorrect = "Sorry, incorrect. Try again."
  message.if.not.answered = "Question still lacks answer."
  if (ans == correct.answer){
    tot <<- tot + 1
    return(message.if.correct)
  }
  if (ans != correct.answer)
    return(paste(message.if.incorrect, "\n", hint))
}

check2 <- function(ans)
{
  if (!is.numeric(ans))
    return("Incorrect. Your answer can not be parsed as a number")
  if (ans == length(3:10)){
    tot <<- tot + 1
    return("Correct")
  }
  if (ans != length(3:10))
    return("Sorry, incorrect")
}


count.words <- function(str1)
{
  if(length(str1) < 1)
    return(NA)
  if (length(str1) > 0)
   sapply(gregexpr("\\W+", str1), length) + 1
}

check3 <- function(answer3)
{
  ## count words
  wc <- count.words(answer3)
  if (wc >= 10)
    return("  Too long. Please shorten answer to _less_ than 10 words")
  print(answer3)
}


tot.fun <- function()
{
  print(paste("You have answered", tot, "of", tot.all, "auto-graded questions correctly"))
}
        

