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

#Transform Data 
library(dplyr)
library(tidyr)
dat_subset2<-dat_subset %>%
  gather(Sub_category, Reading, -c(1:6,10))

#Open graphics Device
dev.cur()
png("Plot4.png", width = 480, height = 480, units = 'px')

#Generate plot 4
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(1,1,2,1))
with(dat_subset,{
  plot(date_time,Global_active_power,xlab="",ylab="Global Active Power", type="l")
  plot(date_time,Voltage,xlab="datetime", type="l")
})
with(dat_subset2,plot(date_time,Reading,type="n",ylab = "Energy Sub Metering",xlab=""))
with(subset(dat_subset2,Sub_category=="Sub_metering_1"),lines(date_time,Reading,type="l"))
with(subset(dat_subset2,Sub_category=="Sub_metering_2"),lines(date_time,Reading,type="l", col="red"))
with(subset(dat_subset2,Sub_category=="Sub_metering_3"),lines(date_time,Reading,type="l", col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(dat_subset, plot(date_time,Global_reactive_power,xlab="datetime", type="l"))
#Close graphics Device
dev.off()
