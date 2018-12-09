## Read the Household Electricity consumptio data from 
## the data file household.txt with seperators = ";"

library(dplyr)
library(lubridate)
a<-  read.csv("household.txt", header= TRUE, sep = ";")

## dimensions of Data Table = 20,75,259*9
## names(a)
## [1] "Date"                  "Time"                  "Global_active_power"  
## [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
## [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"  

## Converting Date variable to Date/Time classes in R 
## using the as.date() function.
a <- select(a,1,2,7,8,9)
a$Date <- dmy(a$Date)

## We will only be using data from the dates 2007-02-01 and 2007-02-02.
a <- filter(a, (Date == "2007-02-01" | Date == "2007-02-02") )
## converting Global Active Power from factor to numeric
a$Sub_metering_1 <- as.numeric(as.character(a$Sub_metering_1))
a$Sub_metering_2 <- as.numeric(as.character(a$Sub_metering_2))

## Constructing a plot and saving it to a png file "plot2.png" with a 
## width of 480 pixels and a height of 480 pixelstoday

a<- mutate(a, dt2 = ymd_hms(paste(a$Date, sep = " ", a$Time)))
png(filename = 'plot3.png', width = 480, height = 480)

plot(a$dt2, a$Sub_metering_1, type = 'n', ylab = 'Energy sub meyering', 
     xlab = "")
points(a$dt2, a$Sub_metering_1, type = 'l')
points(a$dt2, a$Sub_metering_2, type = 'l', col ='red')
points(a$dt2, a$Sub_metering_3, type = 'l', col ='blue')
legend("topright", lty=1, col = c('black', 'red','blue'),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()