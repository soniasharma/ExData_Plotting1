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



# Plot2

png(file="plot2.png") # The default size is 480x480 px 
plot(newData$Time, newData$Global_active_power, type= "l", main="", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
