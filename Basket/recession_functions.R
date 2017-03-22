## some functions for working with recession fertility data



library(data.table)

system.time(
dt <- fread("usa_00142.csv")
)
## 1 sec

library(readstata13)
system.time(
df <- readstata13::read.dta13("usa_00143.dta")
)
## 7 secs

tt <- dt[AGE == 30 & YEAR == 2007 & SEX == 2,
         table(FERTYR)]
tt["2"]/sum(tt)

tt <- dt[AGE == 30 & YEAR == 2005 & SEX == 2,
         table(FERTYR)]
tt["2"]/sum(tt)


get.fxt <- function(x, t, dt)
{
    ## get the births per female PYL from ACS
    tt <- dt[AGE == x & YEAR  == t & SEX == 2,
             table(AGE)]
    fxt <- tt["2"]/sum(tt)              # 2 = birth
    fxt
}

get.tfr <- function(t, dt)
{
    tt <- dt[AGE %in% 15:50 & YEAR  == t & SEX == 2,
             table(AGE, FERTYR)]
    fx <- tt[,"2"]/(tt[,"1"] + tt[,"2"])
    tfr = sum(fx)              # 2 = birth
    tfr
}

get.tfr(2007, dt)

get.tfr(2010, dt)
get.tfr(2014, dt)

get.tfr(2014, dt[HISPAN == 1,])
get.tfr(2014, dt[HISPAN == 0,])

get.tfr(2014, dt[EDUC == 10,])
get.tfr(2014, dt[EDUC == 3,])


get.fxt(25, 2006, dt[HISPAN == 1,])
get.fxt(25, 2006, dt[HISPAN == 0,])
get.fxt(25, 2008, dt[HISPAN == 1,])
get.fxt(25, 2008, dt[HISPAN == 0,])

## let's compare hispanic fertility to non-hispanic fertility from
## 2001 to 2014

year.vec <- 2001:2014
hisp.f25.vec <- NULL
nonhisp.f25.vec <- NULL
hisp.tfr.vec <- NULL
nonhisp.tfr.vec <- NULL
for (i in 1:length(year.vec))
{
    this.year = year.vec[i]
    hisp.f25.vec[i] <- get.fxt(25, this.year,
                               dt[HISPAN == 1,])
    nonhisp.f25.vec[i] <- get.fxt(25, this.year,
                                  dt[HISPAN == 0,])
    hisp.tfr.vec[i] <- get.tfr(this.year,
                               dt[HISPAN == 1,])
    nonhisp.tfr.vec[i] <- get.tfr(this.year,
                                  dt[HISPAN == 0,])
}

plot(year.vec, hisp.f25.vec, type= "o", ylim = c(0, .4))
lines(year.vec, nonhisp.f25.vec)

plot(year.vec, hisp.tfr.vec, type= "o", ylim = c(0, 4))
lines(year.vec, nonhisp.tfr.vec)

## cool.


get.ue <- function(t, dt)
{
    ## get the births per female PYL from ACS
    tt <- dt[YEAR  == t,
             table(EMPSTAT)]
    ue <- tt["2"]/(tt["1"] + tt["2"])
    ue
}

get.ue(2006, dt)
get.ue(2009, dt)
get.ue(2011, dt)
get.ue(2014, dt)


## PA very little hispanic pop

pa.tfr.vec <- pa.ue.vec <- NA
for (i in 1:length(year.vec))
{
    this.year <- year.vec[i]
    pa.ue.vec[i] <- get.ue(this.year, dt[STATEFIP == 42,])
    pa.tfr.vec[i] <- get.tfr(this.year, dt[STATEFIP == 42,])
}

## let's plot the two time series
par(mfrow = c(2,1))
plot(year.vec, pa.ue.vec, type = "o")
plot(year.vec, pa.tfr.vec, type = "o")

par(mfrow = c(2,2))
plot(pa.ue.vec, pa.tfr.vec)
plot(pa.ue.vec[-1], pa.tfr.vec[-length(pa.tfr.vec)])
plot(diff(pa.ue.vec), diff(pa.tfr.vec))
plot(diff(pa.ue.vec[-1]), diff(pa.tfr.vec[-length(pa.tfr.vec)]))
