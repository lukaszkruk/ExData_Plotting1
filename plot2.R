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

png(filename = "plot2.png",
	width = 480, 
	height = 480, 
	units = "px", 
)

plot(data$Datetime, data$Global_active_power, 
	type = 'n',
	xlab = '',
	ylab = 'Global Active Power (kilowatts)'
)

lines(data$Datetime, data$Global_active_power,
	lwd = 1.5
)

dev.off()