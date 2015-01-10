#Step 1. Get file and unzip
    
if(!file.exists("household_power_consumption.txt")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}
file<-"household_power_consumption.txt"

#Step 2. Find data needed for analysis
startline=66638  #first line of 1/2/2007
endline=69517   #last line of 2/2/2007
myrows=endline-startline+1
#read only data needed
mydata <- read.table(file, header=T, sep=";", skip=startline-2, nrows=myrows)

#this fixes column names missed by using skip in previous command
data2<- read.csv(file, header=T, sep=";", nrows=2)                   
colnames(mydata)<-colnames(data2)

#Step 3. Plot

#plot4
mydata$TimeStamp<-as.POSIXct(paste(mydata$Date, mydata$Time), "%d/%m/%Y %H:%M:%S",tz="GMT")

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(mydata$TimeStamp, mydata$Global_active_power,  type="l", xlab="",ylab="Global Active Power")

plot(mydata$TimeStamp, mydata$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(mydata$TimeStamp, mydata$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
lines(mydata$TimeStamp, mydata$Sub_metering_2, col = "red",xlab="")
lines(mydata$TimeStamp, mydata$Sub_metering_3, col = "blue",xlab="")
legend("topright", paste("Sub_metering_", c(1,2,3)), col=c("black","red","blue"),lty=c(1,1),lwd=c(1,1),cex = 0.5) 

with(mydata,plot(mydata$TimeStamp, Global_reactive_power, type="l", xlab="datetime"))

dev.off()



