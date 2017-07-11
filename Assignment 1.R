initial <- read.table("household_power_consumption.txt", nrows = 10, sep = ";", header = T, na.strings = "?")
columnNames <- colnames(initial)
classes <- sapply(initial, class)

df <- read.table("household_power_consumption.txt", nrows = 2880, sep = ";", na.strings = "?", skip = 66637)
colnames(df) <- columnNames

png("plot1.png")
hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

plot2X <- as.POSIXct(paste(as.Date(df$Date, "%d/%m/%Y"), df$Time))
png("plot2.png")
plot(plot2X, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()

png("plot3.png")
plot(plot2X, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
points(plot2X, df$Sub_metering_2, type = "l", col = "red")
points(plot2X, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()

png("plot4.png")
par(mfrow = c(2, 2))
plot(plot2X, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
plot(plot2X, df$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(plot2X, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
points(plot2X, df$Sub_metering_2, type = "l", col = "red")
points(plot2X, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
plot(plot2X, df$Global_reactive_power, xlab = "datetime", type = "l")
dev.off()