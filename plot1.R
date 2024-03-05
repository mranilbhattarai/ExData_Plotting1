
## READ DATA FROM THE ELECTRIC POWER CONSUMPTION DATA SET

power <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header=T, stringsAsFactors = F)


## PREPARE AND CLEAN DATA

## STEP 1 - Convert the Date and Time variables to Date/Time classes in R using the as.Date() function
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## STEP 2 - Read data only from the dates 2007-02-01 and 2007-02-02
power <- subset(power,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## STEP 3 - Create a single column for Date and Time and store it using the POSIXct function
D_and_T <- paste(power$Date, power$Time)
D_and_T <- setNames(D_and_T, "Date and Time")
power <- power[ ,!(names(power) %in% c("Date","Time"))]
power <- cbind(D_and_T, power)
power$D_and_T <- as.POSIXct(D_and_T)

## PROJECT REQUIREMENT 1

## STEP 1 - Construct "plot1" - Global Active Power Histogram
hist(power$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red")

## STEP 2 - Save "plot1" to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()