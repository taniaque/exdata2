#Load ggplot2

library(ggplot2)

#Read the PM2.5 Emissions Data and Source Classification Code Table

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
bal_VehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
bal_VehiclesNEI$city <- "Baltimore City"

la_VehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
la_VehiclesNEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
comb_NEI <- rbind(bal_VehiclesNEI,la_VehiclesNEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")


ggplot(comb_NEI, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
