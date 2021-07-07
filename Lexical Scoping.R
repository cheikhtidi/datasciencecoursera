# A Diversion on Binding Values to Symbol
#How does R know which value to assign to which symbol
#when I type?

lm=function(x){x*x}
lm

#How does R know what value to assign to the symbol
#lm? Why doesn't it give it the value of lm that is 
#in the stats package?
#When R tries to bind a value to a symbol, it searches
#through a series of environments to find the appropriate
#value. When you are working on the command line
#and need to retrieve the value of an R object. 
#The order is roughly
# 1. Search the global environment for a symbol named
# matching the one requested 
# 2. Search the namespaces of each of the packages on
# the search list

#The search list can be found by using the search function

search()

#Binding values to Symbol
#The global environment or the user's workspace
#is always the first element of the search list
#and the base package is always the last
#The order of the packages on the search list matters
#User's can't configure which packages get loaded 
#on startup so you cannot assume that there will be
#a list of packages available
#When a user loads a package with library the namespace
#of that package gets put in position 2 of the search
#list by default and everything else gets shifted down the list
#Note that R has separate namespaces for functions and
#and non-functions so it's possible to have an object
#named c and a function named c


#Scoping rules
#The scoping rules for R are the main feature that 
#make it different from the original S language
#The scoping rules determine how a value is associated
#with a free variable in a function
#R uses lexical scoping or static scoping. A common alternative
#is dynamic scoping.
#Related to the scoping rules is how R uses the search
#list to bind a value to a symbol
#Lexical scoping turns out to be particularly useful
#for simplifying statistical computations

#Lexical scoping
#Consider the following function
f=function(x,y){
  x^2+y/z
}
#This function has 2 formal arguments x and y. In the
#body of the function, there is another symbol z.
#In this case, z is called a free variable. The scoping
#rule of a language determine how values are assigned
#to free variables. Free variables are not formal arguments
#and are not local varibales(assigned inside the function body)

#Lexical Scoping
#Lexical scoping in R means that 
#the values of the variables are searched for in
#the environment in which the function was defined
#What is an environment?
#An environment is a collection of (symbol, value) pair
#ie x is a symbol and 3.14 might be its value
#Every environment has a parent environment, it is 
#possible for an environment to have multiple
#children.
#The only environment without a parent is the empty
#environment
#A function + an environment is = a closure or
#function closure

#Searching for the value of a free variable:
#If the value of a symbol is not found in the environment
#in which a function was defined, then the search is
#continued in the parent environment
#The search continues down the sequence of parent environments
#until we hit the top-level environment(workspace)
#or the namespace of a package
#After the top level environment, the search continues
#down the search list until we hit the empty environment
#If a value for a given symbol cannot be found once
#the empty environment is arrived at, then an error
#is thrown

#Lexical Scoping
#Why does all this matter?
#Typically, a function is defined in the global environment
#so that the values of free variables are just found
#in the user's workspace 
#This behavior is logical for most people and is 
#usually the right thing to do 
#However, in R you can have functions defined inside
#other functions 
#Languages like C don't let you do this
#Now, things get interesting-In this case the environment
#in which a function is defined is the body of another
#function

make.power=function(n){
  pow=function(x){
    x^n
  }
  pow
}
#This function returns another function as its value
cube=make.power(3)
square=make.power(2)
cube(3)
square(3)

#Exploring a Function closure

#What is a function environment?
ls(environment(cube))
get("n",environment(cube))
ls(environment(square))
get("n",environment(square))

#Lexical vs Dynamic Scoping
y=10
f=function(x){
  y=2
  y^2+g(x)
}

g=function(x){
  x*y
}

#What is the value of f(3)
f(3)

#So with lexical scoping, the value of Y and
#the function G is looked up in the environment
#in which the function was defined. 
#Which in this case was the global environment.
#So that the value of Y in the G function is 10.
#So with dynamic scoping the value of Y is looked up
#in the environment from which 
#the function was called; 
#sometimes called the calling environment. 
#So in the R the calling environment is known as 
#the parent frame.

#So, the one thing that, that, that will make 
#lexical scoping and dynamic scoping look the same
#is that when a function is defined in the global
#environment and is subsequently called from
#the global environment, then the defining 
#environment and the calling environment are exactly
#the same and so this can sometimes give the
#appearance of dynamic scoping even when
#It doesn't exist. 

g=function(x){
  a=3
  x+a+y
}
g(2)

y=3
g(2)

#Other languages that support lexical scoping
#Python, Scheme, Perl, Common Lisp

#Consequences of Lexical Scoping


#So, one of the main consequences of lexical scoping
#in R is that all the objects have to be stored
#in memory. So, if you're working with a programming
#language that has very small objects this generally
#speaking not a big problem but because of nature
#of the scoping rules and because of the complexity
#of the environment and the way they are all linked
#together, it's difficult to implement this type 
#of model outside of physical memory, and
#So the consequence was that, when R was originally
#designed. Everything was stored in memory.
#Things are getting complicated now, because of very
#large types of data sets. And, being able to read
#them into R. It is a challenge. Everything has to be
#stored in memory.
#Second now, so every function has a carrier pointer
#to its respect, to its defining environment and
#that defining environment could literally be 
#anywhere because there could be functions
#within functions if one function returns 
#another function,
#then there has to be a pointer to that piece
#of memory where the defining environment is stored.
#And so this makes the model a little bit more 
#complex but all the more useful. So, in S plus,
#which was kind of the original implementation
#of the S language, the free variable were always
#looked up in the workspace. Everything could be
#stored on the disk, because the defining
#environment of all the functions was the same.