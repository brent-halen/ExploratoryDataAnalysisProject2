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
# Subset the NEInSCC dataset for coal sources.
matchcoal <- grepl("coal", NEInSCC$Short.Name, ignore.case=TRUE)
NEInSCCcoal <- NEInSCC[matchcoal, ]

# Aggregate the coal emissions by year.
AggNEInSCCcoal <- aggregate(Emissions ~ year, NEInSCCcoal, sum)

# Open the png display element
png("plot4.png", width = 640, height = 480)
# Create coal emissions plot and print it to the png display element.
print(ggplot(AggNEInSCCcoal, aes(factor(year), Emissions)) + 
          geom_bar(stat="identity") + 
          xlab("Year") + 
          ylab("Total PM2.5 Emissions") + 
          ggtitle("Total Coal Emissions for 1999 - 2008"))
# Close the png display element. 
dev.off()