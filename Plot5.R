## Exploratory_Data_Analysis - Course Project - Plot 5
## 
## How have emissions from motor vehicle sources changed from 1999–2008 in
## Baltimore City (fips == 24510)?
##
## Author: Scott D. Zwick, 2018/01/31

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

## Plot
##png(filename = "plot5.png", width = 480, height = 480)
plot(as.numeric(names(PM25_coal_tot)), PM25_coal_tot, 
     xlab = "Year", ylab = "PM2.5 Emissions (tons)", 
     type="o", col="red", pch=19,
     ylim=c(325000,600000),
     main="PM2.5 Emissions from Coal for 1999, 2002, 2005, 2008")
text(x=as.numeric(names(PM25_coal_tot)), PM25_coal_tot, 
     label=names(PM25_coal_tot), pos=1)
##dev.off()