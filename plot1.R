#############################################################################
# Description: plots the Global Active Power histogram.
# Note: 
#   1. Make sure you set the working directory to your local directory of the 
#       project ExData_Plotting1.
#   2. Create a 'data' folder in your local directory
#   3. Put a copy of the household_power_consumption.txt into the 'data'
# Author: Luis Silva
#############################################################################

library(data.table)
library(lubridate)

plot1 <- function(){
    
    #get global active power
    pathToData <- file.path(getwd(),"data")
    globalActivePower <- fread(file.path(pathToData,"household_power_consumption.txt"), header = TRUE, select = c("Date","Global_active_power"), sep = ";", na.strings = "?")
    
    #convert Date variable from string to date object
    globalActivePower$Date = dmy(globalActivePower$Date)
    
    #subset data between 2007-02-1 and 2007-02-02
    globalActivePower = subset(globalActivePower, Date >= '2007-02-01' & Date <= '2007-02-02')
    
    #plot the histogram of Global Active Power
    with(globalActivePower, hist(Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)"))
    
    #copy the plot to a .png file
    dev.copy(png, file = "plot1.png", width = 480, height = 480)
    dev.off()
    
}
