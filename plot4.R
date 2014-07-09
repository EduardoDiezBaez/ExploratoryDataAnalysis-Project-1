# file plot4.R to get and save the plot 4
# save the actual directory to restore it at the end of the sesion
curdir <- getwd()

# set the pointer to the working directory where the original 
# dataset is alocated. Change it to fit your particular setting
workingdirectory <- "D:/Cursos/Hopkin/4-Exploratory Data Analysis/Project 1/"

# set the new working directory
setwd(workingdirectory)

# read the full dataset
myfulldataset <- read.csv("./household_power_consumption.txt", sep=";")

# subset to what we need and alacate it as  the workind dataset called "mydata"
mydata <- subset(myfulldataset, myfulldataset$Date=="1/2/2007" | myfulldataset$Date=="2/2/2007")

# create a new variable with the merge of the Date and the Time variables
# and alocate it as "myfulldates" as a factor ...
# Note: really, we do not need to transform the variable to date/time format

dates <- mydata$Date
times <- mydata$Time
myfulldates <- as.factor(paste(dates, times))

# combine the new variable into the working dataset 
mydata <- cbind(mydata, myfulldates)

# define the NA values
na.strings="?"

# remove the NAs if any
mydata <- na.omit(mydata)

# create labels at the bottom, at the dates we've selected
# to be used with function "axes" for the plots two, three and four
#
myThursdayAt <- which((mydata$myfulldates == "1/2/2007 00:00:00") == TRUE)
myFridayAt <- which((mydata$myfulldates == "2/2/2007 00:00:00") == TRUE)
mySaturdayAt <- length(mydata$myfulldates)
AT <- c(myThursdayAt, myFridayAt, mySaturdayAt)

# save the ampliated working dataset  at the local working directory
write.table(mydata, "./mydata.txt", sep="\t")

# and we load it to work with it
myworkingdata <- read.delim("./mydata.txt")


#######################
# end of the commond part for every plot
#######################

# plot 4
# open a device file type png  and save as plot4.png
png(file = "./plot4.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "transparent")

# set the output to 2x2 because there will be 4 plots
par(mfrow = c(2, 2))

####################
# plot the #1 or 1,1
#
# the plot is as the plot2.png with the only difference 
# that ylab=ylab="Global Active Power" rather than
# ylab=ylab="Global Active Power (kilowatts)" as in plot2.png

# plot formula Global_active_power in function of myfulldates
plot(myworkingdata$Global_active_power ~ myworkingdata$myfulldates, 
     type="o",
     ylab="Global Active Power",
     xlab="",  
     xaxt="n",
     lwd = 0.01)

# get the values x & y to be ploted with line as a density curve
xfit <- myworkingdata$myfulldates
yfit <- myworkingdata$Global_active_power

# add line and the custom x axis to the open plot
lines(xfit, yfit, lwd = 0.5) 
axis(1, AT, c("Thu", "Fri", "Sat"))

# end the #1 or 1,1
####################

####################
# plot the #2 or 1,2

# plot formula Voltage in function of myfulldates
plot(myworkingdata$Voltage ~ myworkingdata$myfulldates, 
     type="o",
     ylab="Voltage",
     xlab="datetime",  
     xaxt="n",
     lwd = 0.01)

# get the values x & y to be ploted with line as a density curve
xfit <- myworkingdata$myfulldates
yfit <- myworkingdata$Voltage

# add line and the custom x axis to the open plot
lines(xfit, yfit, lwd = 0.5) 
axis(1, AT, c("Thu", "Fri", "Sat"))

# end the #2 or 1,2
####################

####################
# plot the #3 or 2,1
#
# the plot is same as plot3.R with the only difference that
# the legend has not the borders
#
# plot formula Global_active_powe in function of myfulldates
plot(myworkingdata$Sub_metering_1 ~ myworkingdata$myfulldates,
     type="o",
     ylab="Energy sub metering",
     xlab="",  
     xaxt="n",
     col="black")

# get the values x & y to be ploted with line as the density first curve
xfit_1 <- myworkingdata$myfulldates
yfit_1 <- myworkingdata$Sub_metering_1

# add the first line and the custom x axis to the open plot
lines(xfit_1, yfit_1, lwd = 0.5, col="black") 
axis(1, AT, c("Thu", "Fri", "Sat"))

# get the values x & y to be ploted with line as the density secound curve
xfit_2 <- myworkingdata$myfulldates
yfit_2 <- myworkingdata$Sub_metering_2

# add the secound line and the custom x axis to the open plot
lines(xfit_2, yfit_2, lwd = 0.5, col="red") 

# get the values x & y to be ploted with line as the density last curve
xfit_3 <- myworkingdata$myfulldates
yfit_3 <- myworkingdata$Sub_metering_3

# add the last line and the custom x axis to the open plot
lines(xfit_3, yfit_3, lwd = 0.5, col="blue") 


# set the legend to be show
legend("topright", c("Sub_metering_1", 
                     "Sub_metering_2", 
                     "Sub_metering_3"), 
       lty=1,
       col=c("black","red","blue"), 
       bty="n", 
       cex=.9,
       border="black")

# end the #3 or 2,1
####################

####################
# plot the #4 or 2,2

# plot formula Global_reactive_power in function of myfulldates
plot(myworkingdata$Global_reactive_power ~ myworkingdata$myfulldates, 
     type="o",
     ylab="Global_reactive_power",
     xlab="datetime",  
     xaxt="n",
     lwd = 0.01)

# get the values x & y to be ploted with line as a density curve
xfit <- myworkingdata$myfulldates
yfit <- myworkingdata$Global_reactive_power

# add line and the custom x axis to the open plot
lines(xfit, yfit, lwd = 0.5) 
axis(1, AT, c("Thu", "Fri", "Sat"))

# end the #4 or 2,2
####################

# close the device
dev.off()

# restore the original working directory
setwd(curdir)

#######################
# end of file plot4.R
#######################
