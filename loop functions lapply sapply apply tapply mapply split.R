#Looping on the command line
#Writing for, while loops is useful when programming 
# but not pariculary easy when working interactively
#on the command line. These are some functions which
#implement looping to make life easier

#lapply: Loop over a list and evaluate a function on each
#element 
#sapply: Same as lapply but try to simplify the result
#apply: Apply a function over the margins of an array
#tapply: Apply a function over subsets of a vector
#mapply: Multivariate version of lapply

#An auxiliary function split is also useful, particulary
#in conjunction with lapply

#lapply
#lapply takes three arguments: (1) a list x; (2)
#a function (or the name of a function) FUN;
#(3) other argument via its... argument. If x is 
#not a list, it will be coerced to a list using as.list

lapply

#The actual looping is done internally in C code

#lapply always returns a list, regardless of the class
#of the input
x=list(a=1:5,b=rnorm(10))
lapply(x,mean)
x=1:4
lapply(x,runif)
x=1:4
lapply(x,runif,min=0,max=10)

#lapply and friends make heavy use of anonymous functions
#Anonymous functions are some functions that don't
#have names, so you don't assign them a name
#of some sort but you can generate them on the fly

#An anonymous function for extracting the first column
#of each matrix


x=list(a=matrix(1:4,2,2),b=matrix(1:6,3,3))
x

lapply(x,function(elt) elt[,1])

#sapply

#sapply will try to simplify the result of lapply if possible
#If the result is a list where every element is length 1
#then a vector is returned
#If the result is a list where every element is a vector
#of the same length (>1), a matrix is returned
#If it can't figure things out, a list is returned

x=list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
lapply(x,mean)
sapply(x,mean)

#The apply function 
#apply is used to evaluate a function(often an anonymous one)
#over the margins of an array
#It is most often used to apply a function to the rows
#or columns of a matrix
#It can be used with general arrays, e.g. taking the
#average of an array of matrices
#It is not really faster than writing a loop, but
#it works in one line
str(apply)
#x is an array 
#MARGIN is an integer vector indicating which margins 
#should be "retained"
#FUN is a function to be applied 
#... is for other arguments to be passed to FUN

x=matrix(rnorm(200),20,10)
apply(x,2,mean)
apply(x,1,mean)
apply(x,1,sum)

#col/row sums and means 
#For sums and means of matrix dimensions, we have
#some shortcuts
rowSums=apply(x,1,sum)
rowMeans=apply(x,1,mean)
colSums=apply(x,2,sum)
colMeans=apply(x,2,mean)
#The shortcut functions are much faster but you
#won't notice unless you are using a large matrix 

#Other ways to Apply
#Quantiles of the rows of a matrix 
x=matrix(rnorm(200),20,10)
apply(x,1,quantile,probs=c(0.25,0.75))

#Apply
#Average matrix in an array
a=array(rnorm(2*2*10),c(2,2,10))
a
apply(a,c(1,2),mean)
rowMeans(a,dims=2)

#Mapply
#mapply is a multivariate apply of sorts which 
#applies a function in parallel over a set of
#arguments
str(mapply)
#FUN is a function to apply
#...contains arguments to apply over
#MoreArgs is a list of other arguments to FUN
#SIMPLIFY indicates whether the result should be
#simplified

#mapply
#the following is tedious to type
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))

#Instead we can do
mapply(rep,1:4,4:1)

#Vectorizing a function
noise=function(n,mean,sd){
  rnorm(n,mean,sd)
}
noise(5,1,2)
noise(1:5,1:5,2)
#Instant Vectorization
mapply(noise,1:5,1:5,2)

#which is the same as
list(noise(1,1,2),noise(2,2,2),noise(3,3,2),noise(4,4,2),noise(5,5,2))

#tapply
#tapply is used to apply a function over subsets of
#a vector
str(tapply)
#x is a vector
#INDEX is a factor or a list of factors(or else
#they are coerced to factors)
#FUN is a function to be applied
#... contains other arguments to be passed to FUN
#simplify, shoul we simplify the result

#tapply
#take group means
x=c(rnorm(10),runif(10),rnorm(10,1))
x
str(gl)
f=gl(3,10) #creating a factor variable
f
tapply(x,f,mean)

#Take group means without simplification
tapply(x,f,mean,simplify=F)

#Find group ranges
tapply(x,f,range)

#Loop functions split

#split takes a vector or other objects and splits it
#into groups determined by a factor or a list of 
#factors
str(split)
#x is a vector or list or data frame
#f is factor (or coerced to one) or a list of factors
#drop indicates whether empty factors levels should be
#dropped 
x=c(rnorm(10),runif(10),rnorm(10,1))
f=gl(3,10)
split(x,f)

#A common idiom is split followed by lapply
lapply(split(x,f),mean)

#Splitting a Data Frame
library(datasets)
head(airquality)
s=split(airquality,airquality$Month)
s
lapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm=T))

#Splitting on more than one level
x=rnorm(10)
f1=gl(2,5)
f2=gl(5,2)
f1
str(gl)
?gl
f2
interaction(f1,f2)

#Interactions can create empty levels
str(split(x,list(f1,f2)))
#empty levels can be dropped
str(split(x,list(f1,f2),drop=T))

