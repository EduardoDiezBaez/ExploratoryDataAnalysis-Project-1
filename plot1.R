# file plot1.R to get and save the plot 1
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


# plot 1
# open a device file type png and save as plot1.png 
png(file = "./plot1.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "transparent")

# plot the histogram of Global_active_powe at color red
# and label the plot tittle and x axis 
x <- myworkingdata$Global_active_powe   
hist(x,
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# close the device
dev.off()

# restore the original working directory
setwd(curdir)

#######################
# end of file plot1.R
#######################

