##reading the whole table
initial<-read.table("household_power_consumption.txt", header=TRUE, sep=";",
                    na.strings = "?", nrows=2075259, comment.char = "")

##converting Date column into a date class
initial$Date<-as.Date(initial$Date, format="%d/%m/%Y")

##subsetting - only the dates 2007-02-01 and 2007-02-02 are needed
startDate<-initial$Date=="2007-02-01"
endDate<-initial$Date=="2007-02-02"
selectDates<-startDate|endDate
data<-initial[selectDates,]

##converting Time and Date columns into one date/time class column
DateTime<-strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")
data<-data[,c(3:9)]
data<-cbind(DateTime, data)

##plotting the third plot
png(filename = "plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()