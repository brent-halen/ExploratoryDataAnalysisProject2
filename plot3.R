## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}
# Install (if necessary) and load the ggplot2 library.
require(ggplot2)

# Subset the NEI data frame for Baltimore City
NEI_BCity <- subset(NEI, NEI$fips == "24510")
# Aggregate by type and year
NEIBCitytypeagg <- aggregate(Emissions ~ year + type, NEI_BCity, sum)
# Open the png display object. 
png('plot3.png')
# Generate the plot using ggplot function
print(ggplot(NEIBCitytypeagg, aes(year, Emissions, color = type)) + 
          geom_line() + 
          xlab("year") + 
          ylab("Total PM2.5 Emissions By Type for Baltimore City") + 
          ggtitle("Total Emissions in Baltimore City, Maryland for 1999 - 2008 (By Type)"))
# Close png display object.
dev.off()