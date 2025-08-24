# Load necessary data
data_file <- "household_power_consumption.txt" # Path to your dataset

# Read only the relevant dates to save memory
data <- read.table(data_file, sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

# Convert Date and Time into a single datetime column
datetime <- strptime(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")
subset_data$Datetime <- datetime

# Set output to PNG
png("plot1.png", width=480, height=480)

# Plot histogram
hist(subset_data$Global_active_power, col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")

# Close PNG device
dev.off()
