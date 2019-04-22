#############################################################################
# Description: plots Energy sub metering, Global Active Power, Voltage and
# Global reactive power across time.
# Note: 
#   1. Make sure you set the working directory to your local directory of the 
#       project ExData_Plotting1.
#   2. Create a 'data' folder in your local directory
#   3. Put a copy of the household_power_consumption.txt into the 'data'
# Author: Luis Silva
#############################################################################

library(data.table)
library(lubridate)

plot4 <- function(){
    
    
    #get global active power
    pathToData <- file.path(getwd(),"data")
    globalActivePower <- fread(file.path(pathToData,"household_power_consumption.txt"), header = TRUE, select = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?")
    
    #subset data between 2007-02-1 and 2007-02-02
    globalActivePower = subset(globalActivePower, dmy(Date) >= '2007-02-01' & dmy(Date) <= '2007-02-02')
    
    #create Date time character variable and convert to Date time object
    globalActivePower$DateTime = dmy_hms(paste(globalActivePower$Date, globalActivePower$Time))
    
    #configure device for 2 rows and 2 columns
    par(mfcol=c(2,2))
    
    #FIRST PLOT: plots Date time vs Global Active Power 
    with(globalActivePower, plot(DateTime, Global_active_power, type="n", ylab = "Global Active Power (kilowatts)"))
    lines(globalActivePower$DateTime, globalActivePower$Global_active_power)
    
    #SECOND PLOT: plots Date time vs Energy sub metering
    with(globalActivePower, plot(DateTime, Sub_metering_1, type="n", ylab = "Energy sub metering"))
    
    with(globalActivePower, lines(DateTime, Sub_metering_1))
    with(globalActivePower, lines(DateTime, Sub_metering_2, col = "red"))
    with(globalActivePower, lines(DateTime, Sub_metering_3, col = "blue"))
    
    #adding the legend
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.3)
    
    #THIRD PLOT: plots Date time vs Voltage
    with(globalActivePower, plot(DateTime, Voltage, type="n", ylab = "Voltage"))
    with(globalActivePower, lines(DateTime, Voltage))
    
    #FOUR PLOT: plots Date time vs Global reactive power
    with(globalActivePower, plot(DateTime, Global_reactive_power, type="n", ylab = "Global_reactive_power"))
    with(globalActivePower, lines(DateTime, Global_reactive_power))
    
    #copy the plot to a .png file
    dev.copy(png, file = "plot4.png", width = 480, height = 480)
    dev.off()
    
    #configure device to deafult 
    par(mfcol=c(1,1))
    
}
