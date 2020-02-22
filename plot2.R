#Read the PM2.5 Emissions Data and Source Classification Code Table

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data where Baltimore's fip is 24510

bal_NEI <- subset(NEI, fips == "24510")

# Aggregate using sum the Baltimore emissions data by year
aggData_bal <- aggregate(Emissions ~ year, bal_NEI,sum)

png("plot2.png",width=480,height=480,units="px")

barplot(
        aggData_bal$Emissions,
        names.arg=aggData_bal$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()
