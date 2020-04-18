#Read the data table
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?", colClasses = 
                     c('character', 'character', 
                       'numeric','numeric','numeric','numeric',
                       'numeric','numeric','numeric'))
#Format date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#Subset since Feb 1-2, 2007 are the only dates being used
data <- subset(data, subset = (Date>="2007-02-01" &
                                 Date<="2007-02-02"))
#Incomplete data removed
data <- data[complete.cases(data),]
#Date and time pasted together
DateTime <- paste(data$Date, data$Time)
#Add the new DateTime column
data <- cbind(DateTime, data)
#Store the date and time
data$DateTime <- as.POSIXct(DateTime)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
  plot(Global_active_power ~ DateTime, type = "l",
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ DateTime, type = "l",
       ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ DateTime, type = "l",
       ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ DateTime, col = 'red')
  lines(Sub_metering_3 ~ DateTime, col = 'blue')
    legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1),
       bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ DateTime, type = "l",
       ylab = "Global_reactive_power", xlab = "datetime")
})

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()