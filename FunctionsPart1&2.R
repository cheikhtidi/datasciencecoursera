#Functions
#Functions are created using the function ()
#directive and are stored as R objects just like anything
#else. In particular they are R objects of class "function"
#Functions are the first class objects, which means they
#can be treated  much like any other R object. Importantly

#Functions can be passed as arguments to other functions
#Functions can be nested, so that you can define a 
#function inside another function The return value
#of a function is the last expression in the function body
#to be evaluated


#Function arguments
#Functions have named arguments which potentially have
#default values 
#The formal arguments are the arguments included in
#the definition function
#The formals function returns a list of all the formal
#arguments of a function
#Not every function call in R makes uses of all the formal
#arguments
#Function arguments can be missing or might have default values

#Argument Matching
#R functions arguments can be matched positionally or
#by name. So the following calls to sd are all equivalent
mydata=rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata,na.rm=FALSE)
sd(na.rm=FALSE,x=mydata)
sd(na.rm=FALSE,mydata)

#Even though it is legal, I don't recommend messing around
#with the order of the arguments too much, since
#it can lead to some confusion

#Argument Matching
#You can mix positional matching with matching by name 
#it is "taken out" of the argument list and the remaining
#unnamed arguments are matched in the order that they
#are listed in the function definition

#args(lm)

#The following two calls are equivalent 
# lm(data=mydata, y~x, model=FALSE, 1:100)
# lm(y~x, mydata, 1:100, model=FALSE)

#Argument Matching
#Most of the time, named arguments are useful on the
#command line when you have a long argument list and
#you want to use the defaults for everything except for
#an argument near the end of the list
#Named arguments also help if you can remember the name 
#of the argument and not its position on the argument
#list (plotting is a good example)


#Function arguments can also be partially matched 
#which is useful for interactive work
#The order of operations when you give an argument is
# 1 check for exact match for a named argument
# 2 check for a partial match
# 3 check for a positional match


#Lazy Evaluation

#Arguments to functions are evaluated lazily, so they
#are evaluated only as needed

f=function(a,b){
  a^2
}
f(2)

#This function never actually uses the argument b
#so calling f(2) will not produce an error
#because the 2 gets positionnaly matched to a

f=function(a,b){
  print(a)
  print(b)
}
f(45)

#Notice that "45" got printed first before the error
#was triggered. This is because b did not have
#to be evaluated until after print(a)
#Once the function tried to evaluate print(b)
#it had to throw an error

#The "..." Argument

#The ... argument indicate a variable number of 
#arguments that are usually passed on to other functions
#... is often used when extending another function 
#and you don't want to copy the entire argument list
#of the original function

myplot=function(x,y, type="l",...){
  plot(x,y,type=type,...)
}

#Generic functions use ... so that extra arguments can
#be passed to other methods(more on this later)
mean

#The ... argument is also necessay when the number
#of arguments passed to the function cannot be known 
#in advance

args(paste)
args(mean)
args(cat)


#Arguments coming after the "..." Argument
#One catch with... is that any argument that appears after
#... on the argument list must be named explicitly
#and cannot be partially matched 
args(paste)
paste("a","b", sep=":")
paste("a","b",se=":")
