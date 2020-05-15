# Read Table
dat<-read.table("~/R/household_power_consumption.txt",sep = ";",header=TRUE,na.strings = "?",as.is=TRUE)

# Transform Date and Time 
library(lubridate)
dat$Date<-dmy(dat$Date)

# Subset Data to dates 2007-02-01 and 2007-02-02
start_date<-ymd("2007-02-01")
end_date<-ymd("2007-02-02")
dat_subset<-subset(dat,Date==start_date | Date==end_date)

# Generate Plot 1
png("Plot1.png", width = 480, height = 480, units = 'px')
hist(dat_subset$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
