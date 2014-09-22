#import libraries
library(ggplot2)

#read data
emissions <- readRDS("summarySCC_PM25.rds")
scc_data <-readRDS("Source_Classification_Code.rds")

#coal sources are identified in EI.Sector, so get the identities of those sectors by using grep
sectors <- grep("Coal",unique(scc_data$EI.Sector),value=TRUE)

#get a vector of all of the the SCC numbers from coal
scc_subset <-scc_data[scc_data$EI.Sector %in% sectors,]
scc_numbers_coal <- scc_subset$SCC

#subset Emissions data frame by SCC numbers found above
coal_emissions <- emissions[emissions$SCC %in% scc_numbers_coal,]

#plot emissions by year
ggplot(coal_emissions,aes(x=factor(year),y=Emissions)) + geom_bar(stat="identity") + labs(title="Total Coal Emissions per Year")