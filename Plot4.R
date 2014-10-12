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
##Combine date and time in a new column
times <- febOne$Time
times <- paste("2007-02-01", times, sep=" ")
DateTime <- strptime(times, format = "%Y-%m-%d %H:%M:%S")
febOne <- cbind(febOne, DateTime)

febTwo <- myData[myData$Date == "2/2/2007",]
times <- febTwo$Time
times <- paste("2007-02-02", times, sep=" ")
DateTime <- strptime(times, format = "%Y-%m-%d %H:%M:%S")
febTwo <- cbind(febTwo, DateTime)
##Combine both dates
febBoth <- rbind(febOne, febTwo)

library("lubridate")


##Create Plot
png(file = "plot4.png")
par(mfrow = c(2, 2))

##Create Plot a
plot(febBoth$DateTime, as.numeric(as.character(febBoth$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")




##Create Plot b
plot(febBoth$DateTime, as.numeric(as.character(febBoth$Voltage)), type = "l", xlab = "datetime", ylab = "Voltage")

##Create Plot c
plot(febBoth$DateTime, as.numeric(as.character(febBoth$Sub_metering_1)), type = "l", xlab="", ylab="Energy sub metering")
lines(febBoth$DateTime, as.numeric(as.character(febBoth$Sub_metering_2)), type = "l", col="red")
lines(febBoth$DateTime, as.numeric(as.character(febBoth$Sub_metering_3)), type = "l", col="blue")
legend("topright", lty=1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Create Plot d

plot(febBoth$DateTime, as.numeric(as.character(febBoth$Global_reactive_power)), type = "l", xlab = "", ylab = "Global reactive Power ")

dev.off()  