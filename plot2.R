## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset the NEI data frame for Baltimore City
NEI_BCity <- subset(NEI, NEI$fips == "24510")
# Determine aggregate emissions per year using the "aggregate" function.
NEIaggregate_BCity <- aggregate(Emissions ~ year, NEI_BCity, sum)

# Open the png display device.
png('plot2.png')
# Construct the bar graph for each year.
barplot(height = NEIaggregate_BCity$Emissions, 
        names.arg=NEIaggregate_BCity$year, 
        xlab="Years", 
        ylab="Total PM2.5 Emissions (Baltimore City)", 
        main = "Total PM2.5 Emissions By Year in Baltimore City")
# Close the display device
dev.off()