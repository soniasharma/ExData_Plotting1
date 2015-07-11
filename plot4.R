library(utils)
library(graphics)

##Download the data and unzip the file

if (!file.exists("household_power_consumption.txt")){
  URL<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dataFile<-download.file(URL, destfile= "./ElectricData.zip" , method="curl")
  unzip(zipfile= "./ElectricData.zip")}

# read the data

myData<- read.table("household_power_consumption.txt", header=T, sep=";", na.strings=c("NA", "?"))
Data<-myData

#Convert the Date and Time varibales to the Date/Time Classes in R

Data$DateTime<-paste(Data$Date, Data$Time) # Combine Date and Time columns to form a new column
Data$Time<-strptime(Data$DateTime, format="%d/%m/%Y %H:%M:%S") # Convert this column to the date format and replace Time variable with it
Data$Time<-as.POSIXct(Data$Time) # Convert to a vector instead of a list
Data$Date<-strptime(Data$Date, format="%d / %m / %Y") # Convert the Date variable to POSIXlt Class
Data$Date<-as.POSIXct(Data$Date) # Convert to a vector instead of a list


# Subset the data by the two dates and then join them 
Data1<-Data[Data$Date=="2007-02-01",]
Data2<-Data[Data$Date=="2007-02-02",]
newData<-rbind(Data1,Data2)

# Check for missing values
sum(is.na(newData))


# Plot

png(file="plot4.png") # The default size is 480x480 px 

par(mfrow=c(2,2))

#plot1
plot(newData$Time, newData$Global_active_power, type= "l", main="", xlab="",ylab="Global Active Power")

#plot2
plot(newData$Time, newData$Voltage, type= "l", main="", xlab="datetime",ylab="Voltage")

#plot3
plot(newData$Time, newData$Sub_metering_1, type= "l", main="", xlab="", ylab="Energy sub metering")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", col=c("black", "red", "blue"), lty="solid")
lines(newData$Time,newData$Sub_metering_2, col="red")
lines(newData$Time,newData$Sub_metering_3, col="blue")

#plot4
plot(newData$Time, newData$Global_reactive_power, type= "l", main="", xlab="datetime",ylab="Global_reactive_power")

dev.off()