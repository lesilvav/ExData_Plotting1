#############################################################################
# Description: plots the Global Active Power cross the time.
# Note: 
#   1. Make sure you set the working directory to your local directory of the 
#       project ExData_Plotting1.
#   2. Create a 'data' folder in your local directory
#   3. Put a copy of the household_power_consumption.txt into the 'data'
# Author: Luis Silva
#############################################################################

library(data.table)
library(lubridate)

plot2 <- function(){
    
    #get global active power
    pathToData <- file.path(getwd(),"data")
    globalActivePower <- fread(file.path(pathToData,"household_power_consumption.txt"), header = TRUE, select = c("Date", "Time", "Global_active_power"), sep = ";", na.strings = "?")
    
    #subset data between 2007-02-1 and 2007-02-02
    globalActivePower = subset(globalActivePower, dmy(Date) >= '2007-02-01' & dmy(Date) <= '2007-02-02')
    
    #create Date time character variable and convert to Date time object
    globalActivePower$DateTime = dmy_hms(paste(globalActivePower$Date, globalActivePower$Time))

    #plot the Date vs Global Active Power 
    with(globalActivePower, plot(DateTime, Global_active_power, type="n", ylab = "Global Active Power (kilowatts)"))
    lines(globalActivePower$DateTime, globalActivePower$Global_active_power)
    
    #copy the plot to a .png file
    dev.copy(png, file = "plot2.png", width = 480, height = 480)
    dev.off()

}
