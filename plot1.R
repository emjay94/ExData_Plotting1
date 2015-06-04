##Create a R code file "plot1.R" that construct the "plot1.png" plot.
##This script implements the following procedures.
##1. Download the dataset from the UC Irvine Machine Learning Repository.
##2. Unzip the dataset file and read the dataset into R.
##3. After renaming the descriptions of the 9 variables, convert the date and time variables to Date/Time classes in R.
##4. Read the data from the dates 2007-02-01 and 2007-02-02
##5. Construct the plot.

#download the dataset from the URL and unzip the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip")
dataset <- unzip("./data/household_power_consumption.zip", list=TRUE)$Name
unzip("./data/household_power_consumption.zip")

#read the dataset into R and rename the variables
powerconsumption <- read.table(dataset, header=TRUE, sep=";", na.strings="?")
renamed <- gsub("_", ".", names(powerconsumption))
renamed <- tolower(renamed)
names(powerconsumption) <- renamed

#convert the date and time variables to Date/Time classes in R using as.Data() and strptime() functions
powerconsumption$date <- as.Date(powerconsumption$date, "%d/%m/%Y")
powerconsump2days <- subset(powerconsumption, date=="2007-02-01" | date=="2007-02-02")
powerconsump2days$date.time <- strptime(paste(powerconsump2days$date, powerconsump2days$time), "%Y-%m-%d %H:%M:%S")

#save the .RData image file
save(powerconsump2days, file="powerconsump2days.RData")
View(powerconsump2days)

#construct the plot and save it to a PNG file, "plot1.png"
png("plot1.png")
hist(powerconsump2days$global.active.power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
