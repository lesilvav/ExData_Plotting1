#############################################################################
# Description: plots the Energy sub metering cross the time.
# Note: 
#   1. Make sure you set the working directory to your local directory of the 
#       project ExData_Plotting1.
#   2. Create a 'data' folder in your local directory
#   3. Put a copy of the household_power_consumption.txt into the 'data'
# Author: Luis Silva
#############################################################################

library(data.table)
library(lubridate)

plot3 <- function(){
    
    #get global active power
    pathToData <- file.path(getwd(),"data")
    globalActivePower <- fread(file.path(pathToData,"household_power_consumption.txt"), header = TRUE, select = c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?")
    
    #subset data between 2007-02-1 and 2007-02-02
    globalActivePower = subset(globalActivePower, dmy(Date) >= '2007-02-01' & dmy(Date) <= '2007-02-02')
    
    #create Date time character variable and convert to Date time object
    globalActivePower$DateTime = dmy_hms(paste(globalActivePower$Date, globalActivePower$Time))
    
    #plot the Date vs Energy sub metering
    with(globalActivePower, plot(DateTime, Sub_metering_1, type="n", ylab = "Energy sub metering"))

    with(globalActivePower, lines(DateTime, Sub_metering_1))
    with(globalActivePower, lines(DateTime, Sub_metering_2, col = "red"))
    with(globalActivePower, lines(DateTime, Sub_metering_3, col = "blue"))
    
    #adding the legend
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.8)
    
    #copy the plot to a .png file
    dev.copy(png, file = "plot3.png", width = 480, height = 480)
    dev.off()
    
}
