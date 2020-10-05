# Plot1.R
# github.com/suszanna
# coursera/JHU: Exploratory Data Analysis
#
# Our overall goal here is simply to examine how household energy 
#  usage varies over a 2-day period in February, 2007.

#wd <- getwd()  # /Users/susanlmartin/coursera/course4/data
#print(wd)

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

# column data type will be numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# use png for best image quality
png(file = "plot1.png", width = 480, height = 480, units = "px")

# create histogram title is 'Global Active Power', color is red,  x axis label in kw
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#close file device
dev.off()
