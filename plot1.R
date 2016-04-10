## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}
# Determine aggregate emissions per year using the "aggregate" function.
NEIaggregate <- aggregate(Emissions ~ year, NEI, sum)
# Open the png display device.
png('plot1.png')
# Construct the bar graph for each year.
barplot(height = NEIaggregate$Emissions, 
        names.arg=NEIaggregate$year, 
        xlab="Years", 
        ylab="Total PM2.5 Emissions", 
        main = "Total PM2.5 Emissions by Year")
# Close the display device
dev.off()