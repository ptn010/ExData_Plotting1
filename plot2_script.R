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

#plot2
mydata$TimeStamp<-as.POSIXct(paste(mydata$Date, mydata$Time), "%d/%m/%Y %H:%M:%S",tz="GMT")
plot(mydata$TimeStamp, mydata$Global_active_power,  type="l", xlab="")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()



