# Get column names
initial <- read.table("household_power_consumption.txt", nrows = 10, sep = ";", header = T, na.strings = "?")
columnNames <- colnames(initial)
classes <- sapply(initial, class)

# Read only relevant data (between dates of 2007-02-01 and 2007-02-02)
# (Separately, I investigated the date and time of the first row. I figured each row is separated by a minute and
# calculated the amount of rows to get to 2007-02-01 00:00:00 and read the amount of rows for the next 24 hours)
# (Skip 66637 rows = (60*24*47) - (60*17) - 23 and read the next 2880 rows = 60*24*2)
df <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 66637, nrows = 2880)

# Set column names
colnames(df) <- columnNames

# Graph the plot1.png directly into png graphic device
png("plot1.png")
hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

# Turn date and time into X axis for Plot 2
plot2X <- as.POSIXct(paste(as.Date(df$Date, "%d/%m/%Y"), df$Time))

# Graph the plot2.png directly into png graphic device
png("plot2.png")
plot(plot2X, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()

# Graph the plot3.png directly into png graphic device
png("plot3.png")
plot(plot2X, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
points(plot2X, df$Sub_metering_2, type = "l", col = "red")
points(plot2X, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()

# Graph the plot4.png directly into png graphic device
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
