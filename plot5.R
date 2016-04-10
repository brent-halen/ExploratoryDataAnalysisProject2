## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}
# Install (if necessary) and load the ggplot2 library.
require(ggplot2)
# Merge the NEI and SCC datasets
if(!exists("NEInSCC")){
    NEInSCC <- merge(NEI, SCC, by="SCC")
}
# Create a logical vector for vehicular sources. 
vehiclesNEInSCC <- grepl("vehicle", NEInSCC$SCC.Level.Two, ignore.case=TRUE)
# Subset the NEInSCC dataset using the previously created logical vector.
vehicles <- subset(NEInSCC, vehiclesNEInSCC == TRUE)
# Subset the vehicles data frame for Baltimore City
vehicles_BCity <- subset(vehicles, vehicles$fips == "24510")
# Open the PNG display device.
png("plot5.png")
print(ggplot(vehicles_BCity, aes(factor(year), Emissions)) + 
          geom_bar(stat="identity") + 
          xlab("Year") + 
          ylab("Total PM2.5 Emissions") + 
          ggtitle("Total Vehicle Emissions in Baltimore City for 1999 - 2008"))
dev.off()