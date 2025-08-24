# Load necessary data
data_file <- "household_power_consumption.txt" # Path to your dataset

# Read only the relevant dates to save memory
data <- read.table(data_file, sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

# Convert Date and Time into a single datetime column
datetime <- strptime(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")
subset_data$Datetime <- datetime
png("plot4.png", width=480, height=480)

# Set 2x2 layout
par(mfrow=c(2,2))

# Top-left: Global Active Power
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power")

# Top-right: Voltage
plot(subset_data$Datetime, subset_data$Voltage, 
     type="l", xlab="datetime", ylab="Voltage")

# Bottom-left: Energy sub metering
plot(subset_data$Datetime, subset_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col="red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), lty=1, bty="n")

# Bottom-right: Global Reactive Power
plot(subset_data$Datetime, subset_data$Global_reactive_power, 
     type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
