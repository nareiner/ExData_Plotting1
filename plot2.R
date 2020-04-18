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

plot(data$Global_active_power ~ data$DateTime, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()