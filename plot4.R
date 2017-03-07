# load data and extract required lines
dat <- read.csv("household_power_consumption.txt", na.strings = '?', sep=';', 
                stringsAsFactors = FALSE)
ind1 <- (as.Date(dat$Date, "%d/%m/%Y") == as.Date("01/02/2007", "%d/%m/%Y"))
ind2 <- (as.Date(dat$Date, "%d/%m/%Y") == as.Date("02/02/2007", "%d/%m/%Y"))
dat <- rbind(dat[ind1, ], dat[ind2, ])
#
# convert date and time to POSIX format
dat$Time <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
#
#plot

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#topright
plot(dat$Time, dat$Global_active_power, type = "l", xlab=" ", ylab="Global Active Power")
#topleft
plot(dat$Time, dat$Voltage, type = "l", xlab="datetime", ylab="Voltage")
#bottomright
plot(dat$Time, dat$Sub_metering_1, type = "l", xlab=" ", 
     ylab="Energy sub metering")
lines(dat$Time, dat$Sub_metering_2, col="red")
lines(dat$Time, dat$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), lwd=c(1,1,1), bty = "n")
#bottomleft
plot(dat$Time, dat$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
