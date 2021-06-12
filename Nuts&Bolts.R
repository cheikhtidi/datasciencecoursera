# Creating Vectors
#The c() function can be used to create vectors of objects

x=c(0.5, 0.6)       ## numeric
x=c(TRUE, FALSE)    ## logical
x=c(T,F)            ## logical
x=c("a","b", "c")   ## character
x=9:29              ## integer
x=c(1+0i,2+4i)      ## complex

# Using the vector function
x=vector("numeric", length=10)
x

#Explicit coercion

#Objects can be explicitly coerced from one class
# to another using the as.*functions, if available
x=0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
as.complex(x)

#Nonsensical coercion results in NAs
x=c("a","b","c")
as.numeric(x)

#lists
#Lists are a special type of vector that can contain elements
#of different classes. Lists are a very important data type in R
#and we should get to know them well
x=list(1,"a",TRUE, 1+4i)
x
#Matrices are vectors with a dimension attribute.
#The dimension attribute is itself an integer vector
#of length 2 (nrow, ncol)
m=matrix(nrow=2,ncol=3)
m
dim(m)
attributes(m)
#Matrices are constructed column-wise so entries can
#be thought of starting in the "upper-left" corner
#and running down the columns
m=matrix(1:6, nrow=2, ncol=3)
m
m=matrix(1:6, nrow=2, ncol=3,byrow=T)
m
#Matrices can also be created directly from
#vectors by adding a dimension attribute
m=1:10
m
dim(m)=c(2,5)
m

#Matrices can be created by column-binding or
#row-binding with cbind() and rbind()
x=1:3
y=10:12
cbind(x,y)
rbind(x,y)

#Factors
#Factors are used to represent categorical data
#Factors can be unordered or ordered. One can think
#of a factor as an integer vector where each integer
#has a label.
#Factors are treated specially by modelling functions
#like lm() and glm()
#Using factors with labels is better than using integers
#because facors are self-describing; having a variable
#that has values "Male" and "Female" is better than a variable
#that has values 1 and 2

x=factor(c("yes","yes","no","yes","no"))
x
table(x)
unclass(x)

#The order of the levels can be set using the levels
#argument to factor(). This can be important in linear
#modelling because the first level is used as the baseline level
x=factor(c("yes","yes","no","yes","no"), levels=c("yes","no"))
x

#Missing values
#Missing values are denoted by NA or NaN for undefined
#mathematical operations
# is.na() is used to test objects if they are NA
# is.nan() is used to test for NaN
# NA values have a class also, so there integer NA, character NA, etc.
# A NaN value is also NA but the converse is not true

x=c(1,2, NA, 10, 3)
is.na(x)
is.nan(x)
x=c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

# Data Frames
# Data frames are used to store tabular data
# They are represented as a special type of list
# where every element of the list has to have the same
# length
# Each element of the list can be thought of as a column
# and the length of each element in the list is the number
# of rows
#Unlike matrices, data frames can store different classes of objects in each column(just like lists)
#matrices must have every element be the same class
#Data frames also have a special attribute called row.names
#Data frames are usually created by calling read.table() or read.csv()
#Can be converted to a matrix by calling data.matrix()

x=data.frame(foo=1:4, bar=c(T,T,F,F))
x
nrow(x)
ncol(x)

#Names attribute
#R objects can also have names, which is very useful for writing readable code and self-describing objects
x=1:3
names(x)
names(x)=c("foo", "bar", "norf")
x
names(x)
#Lists can also have names
x=list(a=1,b=2,c=3)
x

#And matrices
m=matrix(1:4, nrow=2, ncol=2)
dimnames(m)=list(c("a","b"),c("c","d"))
m

#Reading Data
#There are a few principal functions reading data into R
#read.table, read.csv for reading tabular data
#readLines for reading lines of a text file
#source, for reading in R code files(inverse of dump)
#dget, for reading in R code files (inverse of dput)
#load, for reading in saved workspaces
#unserialized for reading simple R objects in binary form

# Writing Data
# There are analogous functions for writing data to files
#write.table
#writeLines
#dump
#dput
#save
#serialize

#Reading data Files with read.table
#The read.table function is one of the most commonly used
#functions for reading data. It has a few important
#arguments.
#.file, the name of a file or a connection
#.header, logical indicating if the file has a header line
#.sep, a string indicating how the columns are separated
#.colClasses, a character vector indicating the class of each column in the dataset
#.nrows, the number of rows in the dataset
#.comment.char, a character string indicating the comment character
#.skip, the number of lines to skip from the beginning
#.stringsAsFactors, should character variables be coded as Factors?

#read.csv is identical to read.table except that the default separator is a comma
#The default separator for read.table is a space
#read.csv always specifies the header to be True

# Calculating Memory Requirements
# I have a data frame with 1,500,000 rows and 120 columns
# all of which are numeric data. Roughly, how much memory
# is required to store this data frame?
#1,500,000*120*8bytes/numeric
#1440000000 bytes
#1440000000/2^20 bytes/MB
#1373.29 MB
#1.34GB
#You often need to have twice that capacity

#Textual Formats
#dumping and dputing are useful because the resulting
#textual format is edit-able, and in the case of corruption
#potentially recoverable
#Unlike writing out a table or csv file, dump and dput 
#preserve the metadata(sacrificing some readability) so that
#another user doesn't have to specify it all over again
#Textual data can work much better with with version control
#programs like subversion or git which can only track changes
#meaningfully in text files
#Textual formats can be longer-lived; if there is corruption
#somewhere in the file, it can be easier to fix the problem
#Textual formats adhere to the "Unix philosophy"
#Downside: The format is not very space-efficient

#dput-ting R Objects
#Another way to pass data around is by deparsing the R object with dput
#and reading it back in using dget
y=data.frame(a=1,b="a")
dput(y)
dput(y, file="y.R")
new.y=dget("y.R")
new.y

#Dumping R objects
#Multiple objects can be deparsed using the dump function
#and read back in using source
x="foo"
y=data.frame(a=1,b="a")
dump(c("x","y"), file="data.R")
#rm(x,y)
source("data.R")

#Connections: Interfaces to the Outside Word
#Data are read in using connection interfaces. Connections
#can be made to files(most common) or to other more
#exotic things
#file, opens a connection to a file
#gzfile, opens a connection to a file compressed with gzip
#bzfile, opens a connection to a file compressed with bzip2
#url, opens a connection to a webpage

#File connections
str(file)
#description is the name of the file
#open is a code indicating
#"r" read only
#"w" writing (and initializing a new file)
#"a" appending
#"rb", "wb", "ab" reading, writing or appending in binary mode(Windows) 

# con=file("foo.txt", "r")
# data=read.csv(con)
# close(con)

  #is the same as

# data=read.csv("foo.txt")

# Reading Lines of a text file

# con=gzfile("words.gz")
# x=readLines(con, 10)
# x

# writeLines takes a character vector and writes each element
# one line at a time to a text file

#readLines can be used for reading in lines of webpages

##This might take time

#con=url("htttps...", "r")
#x=readLines(con)
#head(x)


# Subsetting

# There are a number of operations that can be used to
# extract subsets of R objects

# [ always returns an object of the same class as the original
# can be used to select more than one element(there is one exception)
# [[ is used to extract elements of a list or a data frame;
# it can only be used to extract a single element
# and the class of the returned object will not necessarily
# be a list or a data frame
# $ is used to extract elements of a list or a data frame by name
# is like [[

# Subsetting lists

x=list(foo=1:4, bar=0.6)
x[1]
x[[1]]
x$bar
x[["bar"]]
x["bar"]
x=list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)]

#Subsetting Nested elements of a list

#The [[ can take an integer sequence

x=list(a=list(10,12,14), b=c(3.14,2.81))
x[[c(1,3)]]
x[[1]][[3]]
x[[c(2,1)]]

# Subsetting a Matrix
x=matrix(1:6,2,3)
x
x[1,2]
x[2,1]

#Indices can also be missing
x[1,]
x[,2]

#By default, when a single element of a matrix is retrieved
#it is returned as a vector of length 1 rather than
#a 1*1 matrix. This behavior can be turned off by
#setting drop=FALSE
x[1,2]
x[1,2, drop=FALSE]
x[1,]
x[1,,drop=FALSE]

#Subsetting- Partial matching
#Partial matching of names is allowed with [[ and $
x=list(aardvark=1:5)
x$a
x[["a"]]
x[["a", exact=FALSE]]

#Subsetting

#Removing Missing values

#A common task is to remove missing values(NAs)
x=c(1,2,NA,4,NA,5)
bad=is.na(x)
x[!bad]

#What if there are multiple things
#and you want to take the subset with no missing values
x=c(1,2,NA,4,NA,5)
y=c("a","b",NA,"d",NA,"f")
good=complete.cases(x,y)
good
x[good]
y[good]

airquality[1:6,]
good=complete.cases(airquality)
airquality[good,][1:6,]


#Vectorized Operations
#Many Operations in R are vectorized making code
#more efficient, concise and easier to read
x=1:4;y=6:9
x+y
x>2
x>=2
y==8
x*y
x/y

#Vectorized matrix operations
x=matrix(1:4,2,2);y=matrix(rep(10,4),2,2)
x*y #element-wise multiplication
x/y
x%*%y  #true matrix multiplication
donnee=read.csv(unz("quiz1_data.zip", "hw1_data.csv"))
donnee
donnee[1:2,]
nrow(donnee)
tail(donnee,2)
donnee[47,"Ozone"]
sum(is.na(donnee$Ozone))
mean(donnee$Ozone[!is.na(donnee$Ozone)])
oztem=subset(donnee, Ozone>31 & Temp>90)
oztem
good=complete.cases(oztem)
oztemp=oztem[good,]
#oztemp=na.omit(oztem)
oztemp
mean(oztemp$Solar.R)

##Another solution
data.subO <- donnee[donnee$Ozone > 31, ,drop=FALSE]
data.subTO <- data.subO[data.subO$Temp > 90, ,drop=FALSE]
data.subTOO <- na.omit(data.subTO)
mean(data.subTOO$Solar.R)

donnee1=donnee[donnee$Month==6, , drop=F]
mean(na.omit(donnee1$Temp))
##Another solution
donnee2=subset(donnee,Month==6)
mean(na.omit(donnee2$Temp))

max(na.omit(subset(donnee, Month==5)$Ozone))
