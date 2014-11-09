#------------Plot4.R---------------------------
#|  Input:  URL pointing to household power consumption zipped dataset.  
#|          In this exercise the server is at the cloud provider cloudfront. 
#|  Output: a compound PNG graph with four graphs   showing Global Active Power,
#|          Voltage demand, three types of submetering, Global Reactive Power. 
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

#|--------------Plotting Section ---------------------------------------------
#|
#| This is a compound plot of four plots using the mfrow 2x2 style
#| The four plots use basic R plot package. Plot at position (0,0) and (0,1) are a basic
#| line plot, Plot at position (1,0) is three color line plot with legend.  The cex value
#| scaled the text characters to fit the smaller space available. The plot at location (1,1)
#| is a line plot.  The console copy was transfered to a png format as Plot4.png
#|-------------------------------------------------------------------------------

m<-paste(h.df[,1],h.df[,2])
date<-as.POSIXlt(m,format="%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))
plot(y=h.df$Global_active_power,x=date,type="l",ylab="Global Active Power")
plot(y=h.df$Voltage,x=date,ylab="Voltage",xlab="date/time",type="l")
plot(y=h.df$Sub_metering_1,x=date,type="n",ylab="Energy sub Metering")
lines(y=h.df$Sub_metering_1,x=date,col="black")
lines(y=h.df$Sub_metering_2,x=date,col="red")
lines(y=h.df$Sub_metering_3,x=date,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=c(1,1,1),cex=.4,bty="n")
plot(y=h.df$Global_reactive_power,x=date,ylab="Global_reactive_power",xlab="date/time",type="l")

dev.copy(png,file="Plot4.png")
dev.off()
cat("\n\ndone")
