#import libraries
library(ggplot2)

#read data
emissions <- readRDS("summarySCC_PM25.rds")
scc_data <-readRDS("Source_Classification_Code.rds")

#subset emissions data for Baltimore
balt <- emissions[emissions$fips == "24510",]

#coal sources are identified in EI.Sector, so get the identities of those sectors by using grep
sectors <- grep("Mobile",unique(scc_data$EI.Sector),value=TRUE)

#get a vector of all of the the SCC numbers from coal
scc_subset <-scc_data[scc_data$EI.Sector %in% sectors,]
scc_numbers_vehicle <- scc_subset$SCC

#subset Emissions data frame by SCC numbers found above
mobile_emissions_balt <- balt[balt$SCC %in% scc_numbers_vehicle,]

#plot emissions by year
ggplot(mobile_emissions_balt,aes(x=factor(year),y=Emissions)) + geom_bar(stat="identity") + labs(title="Total Vehicle Emissions per Year in Baltimore")