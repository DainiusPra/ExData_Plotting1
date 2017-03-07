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
png(filename = "plot1.png", width = 480, height = 480)
hist(dat$Global_active_power, xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", main = "Global Active Power", col = "red")
dev.off()
