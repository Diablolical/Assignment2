#import libraries
library(ggplot2)

#read data
data <- readRDS("summarySCC_PM25.rds")

#subset data
balt <- data[data$fips == "24510",]
#plot using ggplot with geom_bar(stat="identity") to plot a bar graph using the sum of the columns and facet by type.
ggplot(balt,aes(x=factor(year),y=Emissions)) + geom_bar(stat="identity")+facet_wrap(~type) + labs(title="Total Emissions in Baltimore each year by type")
