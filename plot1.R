require(data.table)

unzip('exdata-data-household_power_consumption.zip')

# read data and assign column names
data <- fread('household_power_consumption.txt', 
	skip = 66637L, 
	nrows = 2880L, 
	na.strings="?")

setnames(data, as.character(fread('household_power_consumption.txt', nrows = 1, header = FALSE)))

png(filename = "plot1.png",
	width = 480, 
	height = 480, 
	units = "px", 
)

hist(data$Global_active_power,
	col = 'red',
	xlab = 'Global Active Power (kilowatts)',
	main = 'Global Active Power'
)

dev.off()