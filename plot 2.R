# Read Table
dat<-read.table("~/R/household_power_consumption.txt",sep = ";",header=TRUE,na.strings = "?",as.is=TRUE)

# Transform Date and Time 
library(lubridate)
dat$Date<-dmy(dat$Date)

# Subset Data to dates 2007-02-01 and 2007-02-02
start_date<-ymd("2007-02-01")
end_date<-ymd("2007-02-02")
dat_subset<-subset(dat,Date==start_date | Date==end_date)

#Create new variable DateTime
dat_subset$date_time=ymd_hms(paste(dat_subset$Date,dat_subset$Time))


#Generate plot 2 
png("Plot2.png", width = 480, height = 480, units = 'px')

with(dat_subset,plot(date_time,Global_active_power,type="l",ylab = "Global Active Power (kilowatts",xlab=""))

dev.off()
