# file plot3.R to get and save the plot 3
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

# plot 3
# open a device file type png  and save as plot3.png
png(file = "./plot3.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "transparent")

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
       bty="y", 
       cex=.9,
       border="black")

# close the device
dev.off()

# restore the original working directory
setwd(curdir)

#######################
# end of file plot3.R
#######################
