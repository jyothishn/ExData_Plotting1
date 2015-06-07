DownloadDataFile <- function()
{
  uri <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  # Download data
  if (!file.exists("../ExploratoryDataAnalysis/household_power_consumption.zip")) 
  {
    
    if (! (file.exists("../ExploratoryDataAnalysis/"))) {
      dir.create("../ExploratoryDataAnalysis/")
    }
    
    ## may need method="wget" on Mac. On my windows maching download works without that parameter
    download.file(url=uri,destfile="../ExploratoryDataAnalysis/household_power_consumption.zip")
    
  }
  
  # Unzip file to get data
  
  unzip(zipfile="../ExploratoryDataAnalysis/household_power_consumption.zip",)  
}

## This method loads the data
LoadData <- function(filePath)
{
  data <- read.table(filePath, sep=";", header=TRUE, na.strings="?")
  
  # Create a new "datetime" column - combining Date and Time columns in the data
  data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  
  # Strip data to the subset of dates given in the problem
  dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
  data[as.Date(data$datetime) %in% dates,]
}

## Download the data file
DownloadFile()

## The following script assumes that the file was downloaded by a call to DownloadFile method.
## If you modified that method, or if you didnt use that method to download, 
## make sure that the unzipped .txt file is at this location: ../ExploratoryDataAnalysis/household_power_consumption.txt

data <- LoadData("../ExploratoryDataAnalysis/household_power_consumption.txt")

png("Plot1.png", width=480, height=480)
## Draw the histogram. x-Axis: Global Active Power, y-Axis: Frequency
## change the x axis label per plot in the assignment, color = red
hist(data$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off
