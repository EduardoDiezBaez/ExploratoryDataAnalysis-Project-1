# file plot2.R to get and save the plot 2
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

# plot 2
# open a device file type png  and save as plot2.png
png(file = "./plot2.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "transparent")

# plot formula Global_active_power in function of myfulldates
plot(myworkingdata$Global_active_power ~ myworkingdata$myfulldates, 
    type="o",
    ylab="Global Active Power (kilowatts)",
    xlab="",  
    xaxt="n",
    lwd = 0.01)

# get the values x & y to be ploted with line as a density curve
xfit <- myworkingdata$myfulldates
yfit <- myworkingdata$Global_active_power

# add line and the custom x axis to the open plot
lines(xfit, yfit, lwd = 0.5) 
axis(1, AT, c("Thu", "Fri", "Sat"))

# close the device
dev.off()

# restore the original working directory
setwd(curdir)

#######################
# end of file plot2.R
#######################
