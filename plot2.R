### Making Plot 2 - Coursera Exploratory Data Analysis Cuorse###

# Installing libaries
library(lubridate)

# Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

# Reading the data
file <- "household_power_consumption.txt"
power <- read.table(file, header = TRUE, sep = ";", na.strings = "?", 
                    colClasses=c(rep('character', 2), rep('numeric', 7)))
dim(power) # 2075259 x 9

# Subsetting the data
power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
dim(power)  # 2880 x 9

# Convert date and time
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)
power$Date.Time <- power$Date + power$Time

# Starting graphic devise
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Drawing the plot
plot(power$Global_active_power ~ power$Date.Time,
     type = "l", lwd = 1,
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# Closing the graphic device
dev.off()

# Cleaning up environment and remove unwanted files
rm(list=ls(all=TRUE))
file.remove(c("household_power_consumption.zip", "household_power_consumption.txt"))
