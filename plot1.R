#load libraries
library(plyr) 

#read data
data <- readRDS("summarySCC_PM25.rds")
#don't need the Classification_Code data for this plot

#sum Emissions by year using the plyr package function dpply
total_emissions <- ddply(data,'year',function(x) c(totals = sum(x$Emissions)))

#create a bar plot of the summarized data
barplot(total_emissions$totals, names.arg=total_emissions$year,ylab="Total Emissions",xlab="Year")