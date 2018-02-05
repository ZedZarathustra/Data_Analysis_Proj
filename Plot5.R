## Exploratory_Data_Analysis - Course Project - Plot 5
## 
## How have emissions from motor vehicle sources changed from 1999–2008 in
## Baltimore City (fips == 24510)?
##
## Author: Scott D. Zwick, 2018/02/03

library(dplyr)
library(stringr)
library(ggplot2)
setwd("C:/Users/sdzwick/Documents/R/Coursera/4-Exploratory_Data_Analysis/Data_Analysis_Proj")
## read files
summPM25 <- readRDS("summarySCC_PM25.rds")
## This file contains a data frame with all of the PM2.5 emissions data for
## 1999, 2002, 2005, and 2008. For each year, the table contains number
## of tons of PM2.5 emitted from a specific type of source for the
## entire year.
## 
## fips: A five-digit number (represented as a string) indicating the
## U.S. county
## SCC: The name of the source as indicated by a digit string (see
## source code classification table)
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded

SCCode <- readRDS("Source_Classification_Code.rds")
## This table provides a mapping from the SCC digit strings in the
## Emissions table to the actual name of the PM2.5 source. The sources
## are categorized in a few different ways from more general to more
## specific and you may choose to explore whatever categories you think
## are most useful. For example, source “10100101” is known as
## “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

## Subset Baltimore City, Maryland
PM25_Balt <- subset(summPM25, summPM25$fips==24510)
PM25_Balt <- subset(PM25_Balt, PM25_Balt$type=="ON-ROAD")
PM25_Balt_tot <- tapply(PM25_Balt$Emissions, PM25_Balt$year, sum)

## Plot
png(filename = "plot5.png", width = 480, height = 480)
plot(as.numeric(names(PM25_Balt_tot)), PM25_Balt_tot, 
     axes=FALSE,
     xlab = "Year", ylab = "PM2.5 Emissions (tons)", 
     ylim=c(50,350),
     type="o", lwd=2, col="red", pch=19,
     main=paste("PM2.5 Emissions from Motor Vehicles in Baltimore", "\n", "for 1999, 2002, 2005, 2008"))
axis(1, at=c(1999, 2002, 2005, 2008))
axis(2, at=c(50, 100, 150, 200, 250, 300, 350))
dev.off()
