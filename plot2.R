#load libraries
library(plyr) 

#read data (re-use?)

#subset data
balt <- data[data$fips == "24510",]
#Use ddply to sum emissions for each year
balt_totals <- ddply(balt,'year',function(x) c(totals = sum(x$Emissions)))
#make a bar plot of Baltimore data
barplot(balt_totals$totals, names.arg = balt_totals$year, ylab="Total Emissions (Baltimore)", xlab="Year")
