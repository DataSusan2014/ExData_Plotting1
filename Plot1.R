##Reset environment and Set working directory
rm(list = ls(all = TRUE)) 

setwd("C:/Users/Susan/Documents/R")

##Retrieve file and read into R
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, temp)
myData <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

##myData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

##Subset data by required Dates
febOne <- myData[myData$Date == "1/2/2007",]
febTwo <- myData[myData$Date == "2/2/2007",]
febBoth <- rbind(febOne, febTwo)

##Create Histogram
png(file = "plot1.png")
par(mfrow = c(1, 1))
hist(as.numeric(as.character(febBoth$Global_active_power)), 
     main="Global Active Power",  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()  