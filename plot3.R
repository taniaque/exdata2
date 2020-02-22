#Load ggplot2

library(ggplot2)

#Read the PM2.5 Emissions Data and Source Classification Code Table

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data where Baltimore's fip is 24510

bal_NEI <- subset(NEI, fips == "24510")

# Aggregate using sum the Baltimore emissions data by year
aggData_bal <- aggregate(Emissions ~ year, bal_NEI,sum)

png("plot4.png",width=480,height=480,units="px")


ggplot(bal_NEI,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
