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

## PROJECT REQUIREMENT 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## STEP 1 - Construct Part 1 of "plot4" - Global Active Power Line Plot
with(power,plot(Global_active_power~D_and_T, type = "l", ylab = "Global Active Power", xlab = ""))

## STEP 2 - Construct Part 2 of "plot4" - Voltage Line Plot
with(power,plot(Voltage~D_and_T, type = "l", ylab = "Voltage (volt)", xlab = "datetime"))

## STEP 3A - Construct Part 3 of "plot4" - Energy Sub Metering Line Plot
with(power, 
     {
       plot(Sub_metering_1~D_and_T,type="l", ylab="Energy sub metering", xlab="", col = "black")
       lines(Sub_metering_2~D_and_T, ylab="Energy sub metering", xlab="", col = "red")
       lines(Sub_metering_3~D_and_T, ylab="Energy sub metering", xlab="", col = "blue")
     }
)

## STEP 3B - Create legend for the Energy Sub Metering Line Plot
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##STEP 4 - Construct Part 4 of "plot4" - Global Reactive Power Line Plot
with(power,plot(Global_reactive_power~D_and_T, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

## STEP 5 - Save "plot4" to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()


