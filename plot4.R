require(data.table)

unzip('exdata-data-household_power_consumption.zip')

# read data and assign column names
data <- fread('household_power_consumption.txt', 
	skip = 66637L, 
	nrows = 2880L, 
	na.strings="?")

setnames(data, as.character(fread('household_power_consumption.txt', nrows = 1, header = FALSE)))

# merge Date and Time columns into a Datetime column of POSIXct type
data$Datetime <- as.POSIXct(
	paste(data$Date, data$Time), 
	format = '%d/%m/%Y %H:%M:%S', 
	tz = 'UTC'
)

lwd = 1.5


png(filename = "plot4.png",
	width = 480, 
	height = 480, 
	units = "px" 
)

par(mfrow = c(2,2), mar = c(5, 5, 2, 2))

#plot 1

plot(data$Datetime, data$Global_active_power, 
	type = 'n',
	xlab = '',
	ylab = 'Global Active Power'
)

lines(data$Datetime, data$Global_active_power,
	lwd = lwd
)

# plot 2

plot(data$Datetime, data$Voltage, 
	type = 'n',
	xlab = 'datetime',
	ylab = 'Voltage'
)

lines(data$Datetime, data$Voltage)

# plot 3

plot(data$Datetime, data$Sub_metering_1, 
	type = 'n',
	xlab = '',
	ylab = 'Energy sub metering')

lines(data$Datetime, data$Sub_metering_1,
	lwd = lwd,
	col = 'black'
)

lines(data$Datetime, data$Sub_metering_2,
	lwd = lwd,
	col = 'red'
)

lines(data$Datetime, data$Sub_metering_3,
	lwd = lwd,
	col = 'blue'
)

legend('topright',
	lwd = lwd,
	col = c('black','red','blue'),
	legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
	bty = 'n'
)

# plot 4

plot(data$Datetime, data$Global_reactive_power, 
	type = 'n',
	xlab = 'datetime',
	ylab = 'Global_reactive_power'
)

lines(data$Datetime, data$Global_reactive_power,
	lwd = lwd,
	col = 'black'
)

dev.off()