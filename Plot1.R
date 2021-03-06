## Exploratory_Data_Analysis - Course Project - Plot 1
## 
## Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.
## Upload a PNG file containing your plot addressing this question.
##
## Author: Scott D. Zwick, 2018/01/31

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

     SrcClsCode <- readRDS("Source_Classification_Code.rds")
     ## This table provides a mapping from the SCC digit strings in the
     ## Emissions table to the actual name of the PM2.5 source. The sources
     ## are categorized in a few different ways from more general to more
     ## specific and you may choose to explore whatever categories you think
     ## are most useful. For example, source “10100101” is known as
     ## “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

## Calculate mean for each year
     PM25_total <- tapply(summPM25$Emissions, summPM25$year, sum)

## Plot total
     png(filename = "plot1.png", width = 480, height = 480)
     plot(as.numeric(names(PM25_total)), PM25_total, 
          xlab = "Year", ylab = "PM2.5 Emissions (tons)", 
          axes = FALSE,
          type="o", lwd=2, col="red", pch=19,
          ylim=c(3250000,7500000),
          main="PM2.5 Emissions 1999, 2002, 2005, 2008")
     axis(1, at=c(1999, 2002, 2005, 2008))
     axis(2, at=c(3.5e+06, 4.5e+06, 5.5e+06, 6.5e+06, 7.5e+06))
     dev.off()

