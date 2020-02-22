#Read the PM2.5 Emissions Data and Source Classification Code Table

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Sum of all emissions group by individual years
aggData<- aggregate(Emissions ~ year,NEI, sum)



png("plot1.png",width=480,height=480,units="px")

barplot(aggData$Emissions/10^6, names.arg=aggData$year,
        xlab="Year",
        ylab="PM2.5 Emissions (10^6 Tons)",
        main="Total PM2.5 Emissions From All US Sources Between 1999-2008")

dev.off()
