#------------Plot1.R---------------------------
#|  Input:  Input:  URL pointing to household power consumption zipped dataset.  
#|          In this exercise the server is at the cloud provider cloudfront.
#|  Output: a PNG graph showing Global Active Power  
#|  Nov 7 2014 
#|
#| Replace fileURL1 with URL pointer to server
#| Replace fileURL with URL pointing at the file
#| download the file, unzip it (using unz).  Data
#| fields are seperated by semicolons.  The useful
#| data os between dates 1/2/2007 and 2/2/2007, 
#| which is obtained through subsetting.  In order
#| to free space the download file is erased and
#| garbage collect is triggered (necessary on smaller laptops)
#| Note: The unzip operation can take up to a few moments
#| because of the large number of instances (rows) in the dataset
#| Note: cat command is used to print messages to the console
#|-------------------------------------------------



temp.zip<-tempfile()
fileURL1<-"http://d396qusza40orc.cloudfront.net/"
fileURL2<-"exdata/data/household_power_consumption.zip"
download.file(paste(fileURL1,fileURL2,sep=""),temp.zip)
zipfiledata<-unzip(temp.zip,list=TRUE)
cat("unzipping file.....this may take a few moments")
dftemp<-read.table(unz(temp.zip,as.character(zipfiledata$Name)),sep=";",header=TRUE,as.is=TRUE)
h.df<-subset(dftemp,Date=="1/2/2007"|Date=="2/2/2007")
rm(dftemp)
gc()

#--------------------------------------------------------------------
#| Plotting Section of Program
#| Convert global active power from character to numeric  
#|  use r basic histogram routine with time along x-axis
#| dev.copy transfers console plot to png device. dev.off shuts down png console.
#|--------------------------------------------------------------------
h.df$Global_active_power<-as.numeric(h.df$Global_active_power)
hist(h.df$Global_active_power, col="red", xlab="Global Active Power (killowatts)", main="Global Active Power")
dev.copy(png,file="Plot1.png") 
dev.off()
cat("\n\ndone")      