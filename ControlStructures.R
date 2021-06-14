#Control Structures

#Control structures in R allow you to control the flow of an R program.
#And are very similar to the control structures
#that you might see in other types of programming languages.
#The basic constructs are things like, if else for testing logical conditions.
#The for for executing a loop a fixed number of times.
#While executes a loop while a condition is true.
#Repeat is a, is a construct that allows you to just simp,
#to immediately execute an infinite loop.
#Break allows you to break out of any type of loop.
#And next, skips to the iteration we will loop and 
#return allows you to exit a function. 
#So, most of these control structures are not things
#that you use in interactive sessions and not like,
#while you are typing at the command line in R.
#These are the kinds of things that typically
#you would use when you are writing a R program or
#an R function. It's a little bit more of a
#structured format.

# If-else
#This is a valid if/else structure
#if (x>3){
#  y=10
#} else{
#    y=0
#}

#So is this one

#y=if(x>3){
#  10
#  }else{
#    0
#  }

#Of course, the else clause is not necessary

#if (condition1){

#}

#if (condition2){

#}


# Control Structures-for loops

for (i in 1:10){
  print(i)
}

# for
# These three loops have the same behavior
x=c("a","b","c","d")
for (i in 1:4){
  print(x[i])
}

for (i in seq_along(x)){
  print(x[i])
}

for (letter in x){
  print(letter)
}

for (i in 1:4) print(x[i]) #if the for loop only has
# a single expression in its body, we can omit the
# curly braces and put everything on one line
# which may be useful sometimes because it's a little
# bit more compact

#Nested for loops
#for loops can be nested
x=matrix(1:6,2,3)
for (i in seq_len(nrow(x))){
  for (j in seq_len(ncol(x))){
    print(x[i,j])
  }
}

# While loops
count=0
while (count<10){
  print(count)
  count=count+1
}

# Sometimes, there will be more than one condition
# in the test

z=5
while (z>=3 && z<=10){
  print(z)
  coin=rbinom(1,1,0.5)
  if (coin==1) { # random walk
    z=z+1
  }
  else {
    z=z-1
  }
}

# repeat

# Repeat initiates an infinite loop; these are not commonly
# used in statistical applications but they do have
# their uses. The only way to exit a repeat loop is 
# to call break

x0=1
tol=1e-8
repeat {
  x1=x0/2 #for instance
  if (abs(x1-x0)<tol){
    break
  }
  else{
    x0=x1
  }
}

# next, return 

# next is used to skip an iteration of a loop

for (i in 1:100){
  if (i<=20){
    ##skip the first 20 iterations
    next
  }
  print(i) #we could do something else here
}

# return signals a function should exit
# and return a give value

#Control structures mentioned here are primarily useful
#for writing programs; for command-line interactive work
#the apply functions are more useful


