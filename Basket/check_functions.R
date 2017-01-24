## this file has the function that performs
## check(answer1.2)

## 1. need to parse "answer1.2" so we get
## hint1.2
## answer1.2
## explanation1.2


check <- function(ans)
{

    message.if.correct = "Correct."
    message.if.incorrect = "Sorry, incorrect. Try again."
    message.if.not.answered = "Question still lacks answer."
    message.if.not.in.quotes = paste("Your multiple choice answer needs to be in quotes. (For example, try \"A\" instead of A.)")
    message.if.numeric = paste("Please answer with the letter of your choice, not a number. (For example, \"A\", with the quotation marks.)")
    ##     if(!is.character(ans) &  length(ans) > 1) # to also detect char vector
    ## If NA
    if(is.na(ans))
        stop(message.if.not.answered)

    ## If A,B,C,D exists and is a numeric vector longer than 1
    if(is.numeric(ans) & length(ans) > 1)
        stop(message.if.not.in.quotes)

    ## If a single number
    if(is.numeric(ans) & length(ans) == 1)
        stop(message.if.numeric)

    ## If other answer not in quotes
    if(!is.character(ans))
        stop(message.if.not.in.quotes)


    ## parse name of ans
    name.of.ans <- deparse(substitute(ans))
    ## get qnumber
    qnumber = gsub("answer", "", name.of.ans)
    ## get names of vars we need
    this.correct.answer.name = paste0(".correct.answer", qnumber)
    this.hint.name = paste0(".hint", qnumber)
    this.explanation.name = paste0(".explanation", qnumber)

    this.correct.answer = get(this.correct.answer.name)
    this.hint = get(this.hint.name)
    this.explanation = get(this.explanation.name)

    cat("Your ",  name.of.ans, ": ")
    cat(ans)
    cat("\n")

    if (ans == this.correct.answer) {
        tot <<- tot + 1
        cat(message.if.correct)
        cat("\n")
        cat("Explanation: ", this.explanation)
        cat("\n")
    }
    if (ans != this.correct.answer) {
        ## cat(message.if.incorrect)
        ## cat("\n")
        ## cat("Hint:", this.hint)
        ## cat("\n")
        warning(message.if.incorrect)
        warning("\n")
        warning("Hint: ", this.hint)
        warning("\n")
    }
}
