## Exploratory_Data_Analysis - Course Project - Plot 4
## 
## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?
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

## Build dataframe
coalsrc <- filter(SCCode, str_detect(SCCode$Short.Name, "Coal"))
coalsrc <- coalsrc[,1]
PM25_coal <- subset(summPM25, SCC %in% coalsrc)
