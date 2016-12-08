## use R to parse the initial.Rmd file

quizify <- function(initial.filename,
                    final.filename,
                    answer.key.filename = "tmp2.R")
 {

## initial.filename = "~/Documents/teaching/econ175/2017/malthus/malthus_sweden_lab_initial.Rmd"
## final.filename = "~/Documents/teaching/econ175/2017/malthus/malthus_sweden_lab_final.Rmd"

    ## x <- scan("q2_initial.Rmd", character(0), sep = "\n")
    x <- scan(initial.filename, character(0), sep = "\n",
              blank.lines.skip = F)
## now deal with chunks
left.bracket.index <- grep("^\\{\\{", x)   # these are at beginnign and end of line
right.bracket.index <- grep("^\\}\\}", x)
## a) write them to a file
chunk.element.list <- mapply(seq,
                   from = left.bracket.index,
                   to = right.bracket.index)
system("rm tmp.R tmp2.R")

## here's where we writet out everything to a file
for (i in 1:length(chunk.element.list))
{
    this.tag <- x[chunk.element.list[[i]]]
    ## get qnumber
    str = this.tag[grep("qnumber", this.tag)]
    qnumber = unlist(strsplit(str, split = " "))[3]

    ## now paste this on to every variable name
    tag.out = gsub(" =", paste0(qnumber, " ="), this.tag)

##    for (j in 1:length(this.tag
    cat(tag.out, sep = "\n", file = "tmp.R", append = TRUE)
}

     ## now replace every variable in "tmp.R" with .thatvariable


y <- scan("tmp.R", sep = "\n", character())
s.nobrace <- !grepl("^\\{\\{|^\\}\\}", y)
y[s.nobrace] <- gsub("^", ".", y[s.nobrace])
     cat(y, sep = "\n", file = "tmp2.R", append = TRUE)
## output to the answer.key.filename
system(paste0("cp tmp2.R ../Basket/", answer.key.filename))
source("tmp2.R")



## b) replace them with
## ```{r}
## # ... instructions ...
## answer2.1 = NA
## check(answer2.1)
## ```

## we repeat by going through the tags

## create x.out with NAs where chunks should go
x.out = x
x.out[unlist(chunk.element.list)] <- NA
tag.start.index.vec <- unlist(lapply(chunk.element.list, min))
##
for (i in 1:length(chunk.element.list))
{
    this.tag <- x[chunk.element.list[[i]]]
    ## get qnumber
    str = this.tag[grep("qnumber", this.tag)]
    qnumber = unlist(strsplit(str, split = " "))[3]
    #
    ## now replace this.tag in x with new.chunk
    this.instructions.name = paste0(".instructions", qnumber)
    this.instructions = get(this.instructions.name)
    this.answer.name = paste0("answer", qnumber)
#
    new.chunk <- capture.output(cat("```{r}\n",
                       "## ", this.instructions, "\n",
                       this.answer.name, " = NA", "\n",
                       "check(", this.answer.name, ")", "\n",
                       "```\n",
                       sep = ""))
    cat(new.chunk, sep = "\n")
    ## works
    ## now replace the elements of x
    ## put in new.chunk after
    k <- tag.start.index.vec[i]
    n <- length(new.chunk) - 1
    x.out[k:(k+n)] <- new.chunk
}

## c) output original file to text
x.out.no.na <- x.out[!is.na(x.out)]
    ## cat(x.out.no.na, sep = "\n", file = "q2_final.Rmd")
    cat(x.out.no.na, sep = "\n", file = final.filename)
 }





