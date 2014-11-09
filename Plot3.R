#------------Plot3.R---------------------------
#|  Input:  URL pointing to household power consumption zipped dataset.  
#|          In this exercise the server is at the cloud provider cloudfront. 
#|  Output: a PNG graph showing three types of Sub-metering
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
rm(dftemp); gc()

#------------Plotting Section-------------------------------------
#|Plot the three submetering data againt time
#|Using POSIX local time convert dates to data object for plotting
#|Convert submetering values to numeric from character
#|Using R basic plot routine plot the data as lines of different colors 
#| for each of the three submetering data. 
#| legend uses cex of .8 to fit characters
#|-----------------------------------------------------------------

m<-paste(h.df[,1],h.df[,2])
date<-as.POSIXlt(m,format="%d/%m/%Y %H:%M:%S")

h.df[,7]<-as.numeric(h.df[,7])
h.df[,8]<-as.numeric(h.df[,8])
h.df[,9]<-as.numeric(h.df[,9])

plot(y=h.df$Sub_metering_1,x=date ,type="n",ylab="Energy sub Metering")
lines(y=h.df$Sub_metering_1,x=date ,col="black")
lines(y=h.df$Sub_metering_2,x=date ,col="red")
lines(y=h.df$Sub_metering_3,x=date,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=c(2,2,2), cex=.8)
dev.copy(png,file="Plot3.png")
dev.off()
cat("\n\ndone ")