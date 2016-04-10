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
# Subset the vehicles data frame for Baltimore City and LA County
vehicles_BCitynLA <- subset(vehicles, vehicles$fips == "24510" | vehicles$fips == "06037")
# Create a function that will return the character strings "Baltimore City" and "LA County" based on the fips entry.
cityname <- function(x){
    if(x == "24510"){
        return("Baltimore City")
    }
    if(x == "06037"){
        return("LA County")
    }
}
# Apply the previously defined function using the lapply function.
cityname <- lapply(vehicles_BCitynLA$fips, cityname)
# Append the cityname vector to the vehicles_BCitynLA dataframe.
vehicles_BCitynLA$city <- cityname
# Subset the newly-created dataframe by City. 
LAvehicles <- subset(vehicles_BCitynLA, vehicles_BCitynLA$city == "LA County")
BCvehicles <- subset(vehicles_BCitynLA, vehicles_BCitynLA$city == "Baltimore City")
# Aggregate each one by year. 
LAvehiclesagg <- aggregate(Emissions~year, LAvehicles, sum)
BCvehiclesagg <- aggregate(Emissions~year, BCvehicles, sum)
# Open the png graphic device.
png("plot6.png", width = 1040, height = 480)
# Generate a bar graph for each city.
par(mfrow=c(1,2))
barplot(height = BCvehiclesagg$Emissions, 
        names.arg=BCvehiclesagg$year, 
        xlab="Years", 
        ylab="Total PM2.5 Emissions (Baltimore City)", 
        main = "Total PM2.5 Emissions By Year in Baltimore City")
barplot(height = LAvehiclesagg$Emissions, 
        names.arg=LAvehiclesagg$year, 
        xlab="Years", 
        ylab="Total PM2.5 Emissions (LA County)", 
        main = "Total PM2.5 Emissions By Year in LA County")
# Close the png display device.
dev.off()