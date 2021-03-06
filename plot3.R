plot3 <- function(){
     ## fread is the fastest way of reading the data selection
     ## the number of rows can be calculated manually (24x60x2)
     ## this might not work for other datasets, as a table cannot
     ## deal with all data classes
     require(data.table)
     data <- fread(input = "./household_power_consumption.txt", 
           header = FALSE,
           na.strings = "?",
           skip = "1/2/2007",
           nrows = 2880)
     
     ## the headers are still missing in the table, so we are
     ## loading them separately
     columnHeaders <- fread(input = "./household_power_consumption.txt", 
                            header = TRUE,
                            na.strings = "?",
                            nrows = 1)
     setnames(data, names(columnHeaders))
     ## To get the datetime axis, we merge the first two columns
     ## and convert the result into a POSIXlt vector using strptime
     Time <- strptime(paste(data[[1]], data[[2]], sep=" "),
                     format="%d/%m/%Y %H:%M:%S")
     
     
     ## and here we are plotting
     png(file="plot3.png")         ## open the device
     
     ## plot sub metering
     plot(Time,
          data$Sub_metering_1, 
          type="l",                ## line graph
          main="",                 ## no graph title
          xlab="",                 ## no x-axis label
          col="black",
          ylab="Energy sub metering")
     lines(Time,                   ## add line for sub_metering_2
           data$Sub_metering_2, 
           type="l",
           col="red")
     lines(Time,                   ## add line for sub_metering_3
           data$Sub_metering_3,
           type="l",
           col="blue")
     legend("topright",            ## draw legend
            names(data)[7:9],
            col=c("black","red","blue"),
            lty=1)
     
     dev.off()                ## and close the device again to write
}