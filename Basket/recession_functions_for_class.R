state.panel.plot <- function(x,
                             y,
                             state,
                             vline = NULL,
                             hline = NULL,
                             new = TRUE,
                             legend.xlab = "",
                             legend.ylab = "",
                             title = "",
                             ...)
{
    ## panel positions for pseudo USA layout
    pos.df <- read.table("state_grid_position.txt", header = T)
    par(mfrow = c(8,11),
        mar = c(2, .5, .5, .1),
        oma = c(2, 2, 3, 0),
        bg = "white")                   # this clears an existing plot
    ##  clear the whole layout
    if (new == TRUE){
     for (i in 1:(8*11))
     plot(0, 0,
          type = "n",
          axes = F, xlab = "")
    }
    title(title, outer = T)

    ## now loop through each state
    for (i in 1:length(state.name))
    {
        my.state = state.name[i]
        print(i)
        print(my.state)
        s <- which(pos.df$state == my.state) # index for position data
        if (length(s) > 0)
        {
            my.mfg <- c(pos.df$row[s],pos.df$col[s])
            ## print(my.mfg)
            ## par(mfg = my.mfg, bg = "white")
            ## print(par()$mfg)
            ss <- state == my.state     # index for which state

            ## do legend plot
            if (i == 1)
            {
                par(mfg = c(1,1))
                plot(x[ss], y[ss],
                     axes = F,
                     ## type = "n",
                     xlab = legend.xlab,
                     ylab = legend.ylab,
                     bg = "white",
                     cex.axis = .8,
                     ...) # e.g. ylab
                axis(1, at = c(min(x[ss]),
                               vline,
                               max(x[ss])),
                     cex.axis = .8)
                axis(2, las = 2, cex.axis = .8)
                abline(v = vline, col = "grey")
                abline(h = hline, col = "grey")
                title("Legend", outer = F, line = 0,
                      cex.main = .8)
            }

            ## print(state[ss])
            par(mfg = my.mfg)
            print(par()$mfg)
            ## now do our plot
            plot(x[ss], y[ss],
                 axes = F,
                 ## type = "l",
                 xlab = "",
                 bg = "white",
                 ...) # e.g. ylab
            abline(v = vline, col = "grey")
            abline(h = hline, col = "grey")
            mtext(my.state, side = 1, line = 0, outer = F,
                  cex = .6)
        }
    }
}
