#Dates and Times in R

#R has developed a special representation of dates and times

#Dates are represented by the Date class

#Times are represented by the POSIXct or POSIXlt class

#Dates are stored internally as the number of days
#since 1970-01-01

#Times are stored internally as the number of seconds
#since 1970-01-01

#Dates in R
#Dates are represented by the Date class and can be
#coerced from a character string using the
#as.Date() function

x=as.Date("1970-01-01")
x
class(x)
unclass(x)
unclass(as.Date("1970-01-02"))

#Times in R
#Times are represented using the POSIXct or the POSIXlt
#class 

#POSIXct is just a very large integer under the hood
#it uses a useful class when you want to store times
#in something like a dataframe

#POSIXlt is a list underneath and it stores a bunch
#of other useful information like the day of the week
#day of the year, month, day of the month

#There are a number of generic functions that work
#on dates and times

#weekdays: give the day of the week
#months: give the month name
#quarters: give the quarter number ("Q1", "Q2", "Q3", or "Q4")

#Times can be coerced from a character string using
#the as.POSIXlt or as.POSIXct function

x=Sys.time()
x
p=as.POSIXlt(x)
names(unclass(p))
p$sec
p$min
p$hour
p$mday
p$mon
p$year
p$wday
p$yday
p$isdst
p$zone
p$gmtoff

#Finally, there is the strptime function in case your
#dates are written in a different format 

#To overcome errors
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
datestring=c("January 10, 2012 10:40","December 9, 2011 9:10")
x=strptime(datestring,"%B %d, %Y %H:%M")
x
?strptime

format(Sys.time(), "%a %b %d %X %Y %Z %e %x %W %w %p")
y=strptime("7/7/2021 23:09", "%d/%m/%Y %H:%M", tz="UTC")
y
class(x)

#Operations on Dates and Times
#You can use mathematical operations on dates and times
#Well, really just + and -. You can do comparions too
#ie(==, <=)
x=as.Date("2012-01-01")
y=strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y #will not work"
x=as.POSIXlt(x)
class(x)
class(y)
x
x-y

#Even keeps track of leap years, leap seconds,
#daylight savings, and time zones

x=as.Date("2012-03-01")
y=as.Date("2012-02-28")
x-y
x=as.POSIXct("2012-10-25 01:00:00")
y=as.POSIXct("2012-10-25 06:00:00", tz="GMT")
y-x

#Summary
#Dates and times have special classes in R that allow
#for numerical or statistical calculations
#Dates use the Date class
#Times use the POSIXct and POSIXlt class
#Character strings can be coerced to Date/Time classes
#using the strptime function or the as.Date, 
#as.POSIXlt or as.POSIXct

#