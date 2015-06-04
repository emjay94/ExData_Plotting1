fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip")
dataset <- unzip("./data/household_power_consumption.zip", list=TRUE)$Name
unzip("./data/household_power_consumption.zip")
powerconsumption <- read.table(dataset, header=TRUE, sep=";", na.strings="?")
renamed <- gsub("_", ".", names(powerconsumption))
renamed <- tolower(renamed)
names(powerconsumption) <- renamed
powerconsumption$date <- as.Date(powerconsumption$date, "%d/%m/%Y")
powerconsump2days <- subset(powerconsumption, date=="2007-02-01" | date=="2007-02-02")
powerconsump2days$date.time <- strptime(paste(powerconsump2days$date, powerconsump2days$time), "%Y-%m-%d %H:%M:%S")
save(powerconsump2days, file="powerconsump2days.RData")
View(powerconsump2days)
png("plot1.png")
hist(powerconsump2days$global.active.power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
