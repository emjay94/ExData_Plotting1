##Create a R code file "plot3.R" that construct the "plot3.png" plot.
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

#create the plot and save it to the "plot3.png" file
png("plot3.png")
plot(powerconsump2days$date.time, powerconsump2days$sub.metering.1, type="l", xlab="", ylab="Energy sub metering")
lines(powerconsump2days$date.time, powerconsump2days$sub.metering.2, type="l", col="red")
lines(powerconsump2days$date.time, powerconsump2days$sub.metering.3, type="l", col="blue")
#add legends on the top right corner of the plot
legend("topright", lty=c(1, 1, 1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
