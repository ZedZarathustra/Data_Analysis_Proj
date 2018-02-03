## Exploratory_Data_Analysis - Course Project - Plot 3
## 
## Of the four types of sources indicated by the type (point, nonpoint,
## onroad, nonroad) variable, which of these four sources have seen decreases
## in emissions from 1999–2008 for Baltimore City(fips == 24510)? Which have
## seen increases in emissions from 1999–2008? Use the ggplot2plotting
## system to make a plot answer this question.
##
## Author: Scott D. Zwick, 2018/01/31

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

SrcClsCode <- readRDS("Source_Classification_Code.rds")
## This table provides a mapping from the SCC digit strings in the
## Emissions table to the actual name of the PM2.5 source. The sources
## are categorized in a few different ways from more general to more
## specific and you may choose to explore whatever categories you think
## are most useful. For example, source “10100101” is known as
## “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.


## Subset Baltimore City, Maryland
     PM25_Balt <- subset(summPM25, summPM25$fips==24510)

## Subset by type
     PM25_Balt_pt <- subset(PM25_Balt, PM25_Balt$type=="POINT")
     PM25_Balt_npt <- subset(PM25_Balt, PM25_Balt$type=="NONPOINT")
     PM25_Balt_rd <- subset(PM25_Balt, PM25_Balt$type=="ON-ROAD")
     PM25_Balt_nrd <- subset(PM25_Balt, PM25_Balt$type=="NON-ROAD")

## Calculate total for each type by year
     PM25_B_Pt<- tapply(PM25_Balt_pt$Emissions, PM25_Balt_pt$year, sum)
     PM25_B_Npt<- tapply(PM25_Balt_npt$Emissions, PM25_Balt_npt$year, sum)
     PM25_B_Rd<- tapply(PM25_Balt_rd$Emissions, PM25_Balt_rd$year, sum)
     PM25_B_Nrd<- tapply(PM25_Balt_nrd$Emissions, PM25_Balt_nrd$year, sum)


## Combine files
     year <- names(PM25_B_Pt)
     PM25_B_Pt2 <- data.frame(year, PM25_B_Pt)
     PM25_B_Pt2$type <- "POINT"
     colnames(PM25_B_Pt2)[2] <- "Emissions" 
     PM25_B_Npt2 <- data.frame(year, PM25_B_Npt)
     PM25_B_Npt2$type <- "NONPOINT"
     colnames(PM25_B_Npt2)[2] <- "Emissions" 
     PM25_B_Rd2 <- data.frame(year, PM25_B_Rd)
     PM25_B_Rd2$type <- "ON-ROAD"
     colnames(PM25_B_Rd2)[2] <- "Emissions" 
     PM25_B_Nrd2 <- data.frame(year, PM25_B_Nrd)
     PM25_B_Nrd2$type <- "NON-ROAD"
     colnames(PM25_B_Nrd2)[2] <- "Emissions" 
     PM25_B_Tot <- rbind(PM25_B_Pt2, PM25_B_Npt2, PM25_B_Rd2, PM25_B_Nrd2)
     rownames(PM25_B_Tot) <- c()

## Plot
     png(filename = "plot3.png", width = 480, height = 480)
     plt <- ggplot(PM25_B_Tot, aes(year, Emissions))
     plt + geom_col(aes(fill = year)) + facet_grid(. ~ type)
     dev.off()
