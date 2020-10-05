# Plot3.R
# github.com/suszanna
# coursera/JHU: Exploratory Data Analysis
#
# Our overall goal here is simply to examine how household energy 
#  usage varies over a 2-day period in February, 2007.

wd <- getwd()  # /Users/susanlmartin/coursera/course4/data
print(wd)

file.name <- "./household_power_consumption.txt"
url       <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file  <- "./data.zip"

# download, unzip file in (current) working directory - getwd()
if (!file.exists(file.name)) {
        download.file(url, destfile = zip.file)
        unzip(zip.file)
        file.remove(zip.file)
}

# load package that returns column vector on fread
library(data.table)

# Read file
data <- fread(file.name, sep = ";", header = TRUE, colClasses = rep("character",9))

# missing data in this data set noted as "?". Replace.
data[data == "?"] <- NA

# get specific 2 days in feb 2007
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

# make time data type with strptime
data$posix <- as.POSIXct(strptime(paste(data$Date, data$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))

# column data type will be numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# use png for best image quality
png(file = "plot3.png", width = 480, height = 480, units = "px")

#create line graph with title & labels, using plot  and points functions
#black data
with(data,
     plot(posix,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
#red data
with(data,
     points(posix,
            type = "l",
            Sub_metering_2,
            col = "red")
)
# blue data
with(data,
     points(posix,
            type = "l",
            Sub_metering_3,
            col = "blue")
)

# 1 black, 2 blue, 3 red submetering data required in top right legend:
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

# close png file device
dev.off() 


