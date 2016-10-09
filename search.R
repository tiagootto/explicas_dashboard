
library(lubridate)

searches$data <- as.POSIXlt(searches$data)
searches$date <- as.Date(searches$data)
searches$date_year <- format(searches$data,'%Y')
searches$date_month <- format(searches$data,'%m')
searches$date_week <- paste(searches$date_year, isoweek(searches$data), sep = "")
# searches$date_month <- months(searches$data)


searches_aggr <- aggregate(formula = IP ~ date_week, data = searches, FUN = function(x){length(unique(x))} )


plot(searches_aggr, type = "l", main = "Evolution of Number of Sessions with Search", xlab = paste("Week of Date", max(as.numeric(searches$date_year))), ylab = "Number of sessions with Search")

x <- c(0.5, 2, 4, 8, 12, 16)
y1 <- c(1, 1.3, 1.9, 3.4, 3.9, 4.8)
y2 <- c(4, .8, .5, .45, .4, .3)

par(las=1, mar=c(4, 4, 2, 4), cex=.7)
lines(x, y1)
lines(x, y2)
points(x, y1, pch=16, cex=2)
points(x, y2, pch=21, bg="white", cex=2)
par(col="gray50", fg="gray50", col.axis="gray50")
axis(1, at=seq(0, 16, 4))
axis(2, at=seq(0, 6, 2))
axis(4, at=seq(0, 6, 2))
box(bty="u")
mtext("Travel Time (s)", side=1, line=2, cex=0.8)
mtext("Responses per Travel", side=2, line=2, las=0, cex=0.8)
mtext("Responses per Second", side=4, line=2, las=0, cex=0.8)
text(4, 5, "Bird 131")
par(mar=c(5.1, 4.1, 4.1, 2.1), col="black", fg="black", col.axis="black")