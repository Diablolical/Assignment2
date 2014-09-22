#import libraries
library(ggplot2)

#read data
emissions <- readRDS("summarySCC_PM25.rds")
scc_data <-readRDS("Source_Classification_Code.rds")

#subset emissions data for Baltimore and LA
balt <- emissions[emissions$fips == "24510",]
la <- emissions[emissions$fips == "06037",]

#coal sources are identified in EI.Sector, so get the identities of those sectors by using grep
sectors <- grep("Mobile",unique(scc_data$EI.Sector),value=TRUE)

#get a vector of all of the the SCC numbers from coal
scc_subset <-scc_data[scc_data$EI.Sector %in% sectors,]
scc_numbers_vehicle <- scc_subset$SCC

#subset Emissions data frames by SCC numbers found above
mobile_emissions_balt <- balt[balt$SCC %in% scc_numbers_vehicle,]
mobile_emissions_la <- la[la$SCC %in% scc_numbers_vehicle,]

#change fips column to be more descriptive
mobile_emissions_balt$fips = "Baltimore"
mobile_emissions_la$fips = "Los Angeles"

#merge data
comparison_data <- merge(mobile_emissions_balt,mobile_emissions_la,all=TRUE)

#plot both on single bar plot using position_dodge(), color by location
ggplot(comparison_data,aes(x=factor(year),y=Emissions,fill=fips)) + geom_bar(stat="identity",position=position_dodge()) + labs(title="Total Vehicle Emissions per Year in Baltimore and Los Angeles")

